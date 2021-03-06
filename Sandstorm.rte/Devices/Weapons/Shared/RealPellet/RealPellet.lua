
function Create(self)
	for i = 1, math.random(2,6) do
		local poof = CreateMOSParticle(math.random(1,2) < 2 and "Tiny Smoke Ball 1" or "Small Smoke Ball 1");
		poof.Pos = self.Pos
		poof.Vel = Vector(self.Vel.X, self.Vel.Y):RadRotate(math.pi * RangeRand(-1, 1) * 0.05) * RangeRand(0.1, 0.9) * 0.25;
		poof.Lifetime = poof.Lifetime * RangeRand(0.9, 1.6) * 0.3
		MovableMan:AddParticle(poof);
	end
	for i = 1, math.random(2,4) do
		local poof = CreateMOSParticle("Tiny Smoke Ball 1");
		poof.Pos = self.Pos
		poof.Vel = (Vector(self.Vel.X, self.Vel.Y):RadRotate(math.pi * (math.random(0,1) * 2.0 - 1.0) * 0.5 + math.pi * RangeRand(-1, 1) * 0.15) * RangeRand(0.1, 0.9) * 0.15 + Vector(self.Vel.X, self.Vel.Y):RadRotate(math.pi * RangeRand(-1, 1) * 0.15) * RangeRand(0.1, 0.9) * 0.2) * 0.5;
		poof.Lifetime = poof.Lifetime * RangeRand(0.9, 1.6) * 0.3
		MovableMan:AddParticle(poof);
	end
	
	self.pelletCount = 12
	self.pelletShotSpread = 1
	self.pelletShotVelMin = 0.85
	self.pelletShotVelMax = 1.1
	
	self.lastImpactCount = 0
	self.mainImpact = false
	
	self.debugColors = {5, 13, 223, 147, 122, 86, 194, 47, 38, 135, 99}
	
	self.pelletData = {}
	for i = 1, self.pelletCount do
		local vel = Vector(self.Vel.X, self.Vel.Y):DegRotate(RangeRand(-1,1) * self.pelletShotSpread) * RangeRand(self.pelletShotVelMin, self.pelletShotVelMax)
		local pos = Vector(self.Pos.X, self.Pos.Y)-- + Vector(RangeRand(-1,1), RangeRand(-1,1)) * math.random(0,3) * 0.33
		
		local pellet = {
			PosX = pos.X,
			PosY = pos.Y,
			
			VelX = vel.X,
			VelY = vel.Y,
			
			Tracer = math.random(1, 5) <= 2,
			Dead = false,
			
			Lethality = 300 * i / self.pelletCount + math.random(0,45),
			
			LethalityStopX = 0,
			LethalityStopY = 0,
			
			Color = self.debugColors[i % #self.debugColors + 1]
		}
		table.insert(self.pelletData, pellet)
	end
end

function Update(self)
	local deadCount = 0
	
	local impactCount = 0
	local impactPos = Vector()
	local impactGFXType = 0
	local hitGFX = {"Real Pellet Hit Effect Flesh", "Real Pellet Hit Effect Soft", "Real Pellet Hit Effect Hard", "Real Pellet Hit Effect Metal"}
	local hitGFXType = 0
	
	for i, pellet in ipairs(self.pelletData) do
		if pellet then
			if not pellet.Dead then
				local pos = Vector(pellet.PosX, pellet.PosY)
				local vel = Vector(pellet.VelX, pellet.VelY)--:RadRotate(RangeRand(-0.01,0.01))
				
				local lastPos = Vector(pos.X, pos.Y)
				
				local lethalityLoss = TimerMan.DeltaTimeSecs * vel.Magnitude * 9
				if pellet.Lethality - lethalityLoss < 0 and pellet.LethalityStopX == 0 and pellet.LethalityStopY == 0 then
					pellet.LethalityStopX = pos.X
					pellet.LethalityStopY = pos.Y
					
					pellet.Lethality = -1
				else
					pellet.Lethality = pellet.Lethality - lethalityLoss
				end
				--[[
				if not (pellet.LethalityStopX == 0 and pellet.LethalityStopY == 0) then
					PrimitiveMan:DrawCirclePrimitive(Vector(pellet.LethalityStopX, pellet.LethalityStopY), 1, 5);
				end]]
				
				-- Physics
				vel = vel + SceneMan.GlobalAcc * TimerMan.DeltaTimeSecs -- Gravity
				vel = vel / (1 + TimerMan.DeltaTimeSecs * 2.2) -- Friction
				
				local hit = false
				
				local travelVec = vel * GetPPM() * TimerMan.DeltaTimeSecs;
				
				local moCheck = rte.NoMOID
				if pellet.Lethality > 0 then
					moCheck = SceneMan:CastMORay(pos, travelVec, self.ID, self.Team, 0, false, math.random(5,6)); -- Raycast
				end
				if moCheck ~= rte.NoMOID then
					local rayHitPos = SceneMan:GetLastRayHitPos()
					
					local MO = ToMOSRotating(MovableMan:GetMOFromID(moCheck))
					if MO then
						local woundName = MO:GetEntryWoundPresetName()
						local woundNameExit = MO:GetExitWoundPresetName()
						if string.find(MO.Material.PresetName,"Flesh") or (woundName and string.find(woundName,"Flesh")) or (woundNameExit and string.find(woundNameExit,"Flesh")) then
							hitGFXType = 1
						elseif string.find(MO.Material.PresetName,"Metal") or (woundName and string.find(woundName,"Dent")) or (woundNameExit and string.find(woundNameExit,"Dent")) then
							hitGFXType = 4
						end
					end
					hit = true
					
					if impactPos.IsZero then
						impactPos = pos
					else
						impactPos = (impactPos + pos) * 0.5
					end
					
					pellet.Dead = true
					
					impactCount = impactCount + 1
				else
					local terrCheck = SceneMan:CastStrengthRay(pos, travelVec, 30, Vector(), 5, 0, SceneMan.SceneWrapsX)--SceneMan:CastStrengthSumRay(travelStart, travelPos, 2, 0); -- Raycast
					if terrCheck then
						local rayHitPos = SceneMan:GetLastRayHitPos()
						pos = Vector(rayHitPos.X, rayHitPos.Y)
						
						local checkPix = SceneMan:GetTerrMatter(rayHitPos.X, rayHitPos.Y)
						if checkPix ~= 0 then
							-- Compare Materials
							local material = SceneMan:GetMaterialFromID(checkPix)
							if string.find(material.PresetName,"Flesh") then -- Lord have mercy
								hitGFXType = 1
							elseif string.find(material.PresetName,"Dirt") or string.find(material.PresetName,"Soil") or string.find(material.PresetName,"Sand") then
								hitGFXType = 2
							elseif string.find(material.PresetName,"Concrete") or string.find(material.PresetName,"Rock") then
								hitGFXType = 3
							elseif string.find(material.PresetName,"Metal") then
								hitGFXType = 4
							end
						end
						
						local effect = CreateMOSRotating(hitGFXType == 0 and "Real Bullet Hit Effect Default" or hitGFX[hitGFXType]);
						if effect then
							effect.Pos = pos - Vector(vel.X,vel.Y):SetMagnitude(3)
							MovableMan:AddParticle(effect);
							effect:GibThis();
						end
						
						pellet.Dead = true
						
						if impactPos.IsZero then
							impactPos = pos
						else
							impactPos = (impactPos + pos) * 0.5
						end
						
						impactCount = impactCount + 1
						hit = true
					else
						pos = pos + travelVec -- Travel
					end
				end
				
				if hit then
					local pixel = CreateMOPixel("Real Pellet Damage");
					pixel.Vel = Vector(vel.X, vel.Y) * 0.6;--Vector(self.Vel.X, self.Vel.Y) * 0.6;
					pixel.Sharpness = self.Sharpness
					pixel.Mass = self.Mass
					pixel.WoundDamageMultiplier = pixel.WoundDamageMultiplier * (self:NumberValueExists("WoundDamageMultiplier") and self:GetNumberValue("WoundDamageMultiplier") or 1.0)
					pixel.Pos = pos - Vector(vel.X,vel.Y):SetMagnitude(2)--self.Pos - Vector(2, 0):RadRotate(self.RotAngle);
					pixel.Team = self.Team
					pixel.IgnoresTeamHits = true;
					MovableMan:AddParticle(pixel);
				end
				-- Save new/processed data
				pellet.PosX = pos.X
				pellet.PosY = pos.Y
				
				pellet.VelX = vel.X
				pellet.VelY = vel.Y
				
				
				if pellet.Tracer then
					local t = SceneMan:ShortestDistance(pos, lastPos, SceneMan.SceneWrapsX) * rte.PxTravelledPerFrame * 7--(vel * rte.PxTravelledPerFrame)
					local maxi = t.Magnitude * 0.05 * math.random(1,self.pelletCount) / self.pelletCount
					for i = 0, maxi do
						local particle = CreateMOPixel("Real Bullet Micro Smoke Ball "..math.random(1,4));
						particle.Pos = pos + t / maxi * i * RangeRand(1.1,0.9);
						particle.Vel = vel * RangeRand(1.1,0.9)
						particle.Lifetime = particle.Lifetime * RangeRand(0.1, 1.9) * 0.2
						particle.GlobalAccScalar = RangeRand(-1, 1) * 0.15
						MovableMan:AddParticle(particle);
					end
				end
				PrimitiveMan:DrawLinePrimitive(pos, pos, 171)
				--PrimitiveMan:DrawLinePrimitive(pos, (pos - vel * rte.PxTravelledPerFrame * 0.5), pellet.Color)
			else
				deadCount = deadCount + 1
			end
		end
	end
	if not self.mainImpact and (impactCount + self.lastImpactCount) >= (self.pelletCount * 0.4) then
		self.mainImpact = true
		if hitGFXType <= 2 then
			AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Buckshot/Impact/Soft/ImpactSoft"..math.random(1,14)..".ogg", impactPos);
		elseif hitGFXType == 3 then
			AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Buckshot/Impact/Hard/ImpactHard"..math.random(1,14)..".ogg", impactPos);
		elseif hitGFXType == 4 then
			AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Buckshot/Impact/Metal/ImpactMetal"..math.random(1,12)..".ogg", impactPos);
		end
	elseif impactCount > 0 and self.lastImpactCount < 1 then
		if hitGFXType <= 2 then
			AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Pellet/Impact/Soft/ImpactSoft"..math.random(1,5)..".ogg", impactPos);
		elseif hitGFXType == 3 then
			AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Pellet/Impact/Hard/ImpactHard"..math.random(1,5)..".ogg", impactPos);
		elseif hitGFXType == 4 then
			AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Pellet/Impact/Metal/ImpactMetal"..math.random(1,5)..".ogg", impactPos);
		end
	end
	
	self.lastImpactCount = impactCount
	
	if deadCount >= self.pelletCount then
		self.ToDelete = true
	end
end