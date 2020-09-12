
function Create(self)
	for i = 1, math.random(1,3) do
		local poof = CreateMOSParticle(math.random(1,2) < 2 and "Tiny Smoke Ball 1" or "Small Smoke Ball 1");
		poof.Pos = self.Pos
		poof.Vel = Vector(self.Vel.X, self.Vel.Y):RadRotate(math.pi * RangeRand(-1, 1) * 0.05) * RangeRand(0.1, 0.9) * 0.4;
		poof.Lifetime = poof.Lifetime * RangeRand(0.9, 1.6) * 0.2
		MovableMan:AddParticle(poof);
	end
	for i = 1, math.random(1,2) do
		local poof = CreateMOSParticle("Tiny Smoke Ball 1");
		poof.Pos = self.Pos
		poof.Vel = (Vector(self.Vel.X, self.Vel.Y):RadRotate(math.pi * (math.random(0,1) * 2.0 - 1.0) * 0.5 + math.pi * RangeRand(-1, 1) * 0.15) * RangeRand(0.1, 0.9) * 0.3 + Vector(self.Vel.X, self.Vel.Y):RadRotate(math.pi * RangeRand(-1, 1) * 0.15) * RangeRand(0.1, 0.9) * 0.2) * 0.5;
		poof.Lifetime = poof.Lifetime * RangeRand(0.9, 1.6) * 0.2
		MovableMan:AddParticle(poof);
	end
	self.Vel = Vector(self.Vel.X, self.Vel.Y) * RangeRand(0.9,1.1)
	self.canTravel = true
	self.ricochetCount = 0
	self.ricochetCountMax = 1
	
	self.tracer = 3 * math.random(0,1)
	self.smoke = false
	
	self.alwaysTracer = self:NumberValueExists("AlwaysTracer") and self:GetNumberValue("AlwaysTracer") == 1
	self.noSmoke = self:NumberValueExists("NoSmoke") and self:GetNumberValue("NoSmoke") == 1
	self.noTracer = self:NumberValueExists("NoTracer") and self:GetNumberValue("NoTracer") == 1
	
	--if self.smoke then
	-- FANCY TRAIL BY FILIPEX2000
	self.trailM = 0; -- DONT TOUCH
	self.trailMTarget = RangeRand(-1,1);
	self.trailMProgress = 0; -- DONT TOUCH
	
	self.trailGProgress = 0; -- DONT TOUCH
	self.trailGLoss = -0.5; -- Trail lifetime offset (lower number, stays 100% longer)
	
	-- FINE TUNE!
	self.LifetimeMulti = 0.9; -- How long the particles stay alive
	self.TrailRandomnessMulti = 0.5; -- Wave modulation target speed
	self.TrailWavenessSpeed = 0.5; -- Wave modulation controller speed
	--end
	
	--self.soundLoop = math.random(0,100) < 50 and AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Bullet/Flyby/Loop"..math.random(2,4)..".wav", self.Pos, 0, -1, 100, 1, 500, false) or nil
	local light = "Sandstorm.rte/Effects/Sounds/Ammunition/Bullet/Flyby/Loop3.wav"
	local deep = "Sandstorm.rte/Effects/Sounds/Ammunition/Bullet/Flyby/Loop4.wav"
	--self.soundLoop = math.random(0,100) < 70 and AudioMan:PlaySound(math.random(0,100) < 20 and light or deep, self.Pos, 0, -1, 100, 1, 500, false) or nil
	self.soundLoop = nil -- Pawnis didn't like it >:-(
	self.soundPitch = RangeRand(0.8,1.2)
end

function Update(self)
	self.Vel = Vector(self.Vel.X, self.Vel.Y) + SceneMan.GlobalAcc * TimerMan.DeltaTimeSecs
	
	if self.soundLoop then
		AudioMan:SetSoundPosition(self.soundLoop, self.Pos)
		AudioMan:SetSoundPitch(self.soundLoop, (self.soundPitch + 0.5) * 2.5)
		self.soundPitch = self.soundPitch / (1 + TimerMan.DeltaTimeSecs * 6.0) -- Pitch Shift
	end
	
	if self.canTravel then
		local travelVel = (Vector(self.Vel.X, self.Vel.Y) * rte.PxTravelledPerFrame)--:RadRotate(RangeRand(-1,1) * 0.05) -- Weird effect
		local travel = travelVel
		
		local endPos = Vector(self.Pos.X, self.Pos.Y); -- This value is going to be overriden by function below, this is the end of the ray
		self.ray = SceneMan:CastObstacleRay(self.Pos, travelVel, Vector(0, 0), endPos, 0 , self.Team, 0, 2)
		
		travel = SceneMan:ShortestDistance(self.Pos,endPos,SceneMan.SceneWrapsX)
		
		-- Tracer Trail
		
		if not self.noTracer and ((math.random(1,5) < 2 and self.tracer > 0 and self.ricochetCount < 1) or (self.alwaysTracer and math.random(1,5) <= 2)) then
			local maxi = travel.Magnitude/ FrameMan.PPM * 1.5
			for i = 0, maxi do
				--PrimitiveMan:DrawCirclePrimitive(self.Pos + travel / maxi * i, 2 + i / maxi * 3, 166);
				local particle = CreateMOPixel("Real Bullet Glow");
				particle.Pos = self.Pos + travel / maxi * i * RangeRand(1.1,0.9);
				--particle.Vel = travel:SetMagnitude(30)
				--particle.EffectRotAngle = self.RotAngle;
				particle.EffectRotAngle = self.Vel.AbsRadAngle;
				MovableMan:AddParticle(particle);
			end
			self.tracer = self.tracer - 1
			if not self.smoke then
				self.smoke = math.random(1,8) < 2
			end
		end
		
		--PrimitiveMan:DrawLinePrimitive(self.Pos, self.Pos + travel, 5);
		if self.ray > -1 then
			local canDamage = false
			local hitGFXType = 0-- 0 Default, 1 Flesh, 2 Concrete, 3 Dirt, 4 Sand, 5 Metal
			local hitGFX = {"Real Bullet Hit Effect Flesh", "Real Bullet Hit Effect Concrete", "Real Bullet Hit Effect Dirt", "Real Bullet Hit Effect Sand", "Real Bullet Hit Effect Metal"}
			self.Pos = endPos
			
			if self.soundLoop ~= nil then
				self.soundLoop:Stop()
				self.soundLoop = nil
			end
			
			self.Vel = self.Vel * 0.85
			local hitMO = false
			for i = -1, 1 do
				local checkOrigin = Vector(self.Pos.X, self.Pos.Y) + Vector(self.Vel.X,self.Vel.Y):SetMagnitude(i)
				local checkPix = SceneMan:GetMOIDPixel(checkOrigin.X, checkOrigin.Y)
				if checkPix and checkPix ~= rte.NoMOID and MovableMan:GetMOFromID(checkPix).Team ~= self.Team then
					local MO = ToMOSRotating(MovableMan:GetMOFromID(checkPix))
					local woundName = MO:GetEntryWoundPresetName()
					local woundNameExit = MO:GetExitWoundPresetName()
					hitMO = true
					if string.find(MO.Material.PresetName,"Flesh") or (woundName and string.find(woundName,"Flesh")) or (woundNameExit and string.find(woundNameExit,"Flesh")) then
						hitGFXType = 1
					elseif string.find(MO.Material.PresetName,"Metal") or (woundName and string.find(woundName,"Dent")) or (woundNameExit and string.find(woundNameExit,"Dent")) then
						hitGFXType = 5
					end
					break
				end
			end
			local hitVel = Vector(self.Vel.X, self.Vel.Y)
			if hitMO then-- check MOs first
				canDamage = true
				self.ToDelete = true
			else -- ricochet
				if self.ricochetCount < self.ricochetCountMax then
					-- Normal approximation by filipex2000
					-- Does magic stuff
					-- haxx
					--self.canTravel = false
					local detections = 0
					local maxi = 7
					local normal = Vector(0,0)
					local materialStrength = 0
					local materialID = 0
					for i = 0, maxi do
						local checkVec = Vector(3,0):RadRotate(math.pi * 2 / maxi * i)
						local checkOrigin = Vector(self.Pos.X, self.Pos.Y) + checkVec
						local checkPix = SceneMan:GetTerrMatter(checkOrigin.X, checkOrigin.Y)
						--[[
						if checkPix > 0 then
							PrimitiveMan:DrawLinePrimitive(self.Pos + checkVec, self.Pos + checkVec, 13);
						else
							PrimitiveMan:DrawLinePrimitive(self.Pos + checkVec, self.Pos + checkVec, 5);
							normal = (Vector(normal.X, normal.Y) + Vector(checkVec.X, checkVec.Y)) * 0.5
						end]]
						if checkPix == 0 then
							normal = (Vector(normal.X, normal.Y) + Vector(checkVec.X, checkVec.Y)) * 0.5
						else
							materialStrength = materialStrength + SceneMan:GetMaterialFromID(checkPix).StructuralIntegrity
							detections = detections + 1
							materialID = checkPix
						end
					end
					-- Compare Materials
					local material = SceneMan:GetMaterialFromID(materialID)
					if string.find(material.PresetName,"Flesh") then -- Lord have mercy
						hitGFXType = 1
					elseif string.find(material.PresetName,"Concrete") or string.find(material.PresetName,"Rock") then
						hitGFXType = 2
					elseif string.find(material.PresetName,"Dirt") or string.find(material.PresetName,"Soil") then
						hitGFXType = 3
					elseif string.find(material.PresetName,"Sand") then
						hitGFXType = 4
					elseif string.find(material.PresetName,"Metal") then
						hitGFXType = 5
					end
					
					if detections > 0 then
						materialStrength = math.min(materialStrength / maxi / 132, 1)
						normal = normal:SetMagnitude(1.0)
						normal = normal:RadRotate(RangeRand(-1,1) * 0.2) --Randomize normal to spice things up
						--PrimitiveMan:DrawLinePrimitive(self.Pos, self.Pos + normal * 5.0, 122); -- Debug
						local diff = normal - Vector(self.Vel.X, self.Vel.Y):SetMagnitude(1.0)
						self.Vel = (Vector(self.Vel.X, self.Vel.Y) * RangeRand(0.4,0.8) + normal:SetMagnitude(self.Vel.Magnitude) * RangeRand(0.1,0.4)) * RangeRand(0.5,1.0) * materialStrength
						
						self.ricochetCount = self.ricochetCount + 1
						self.smoke = math.random(1,2) < 2
						if self.Vel.Magnitude < 10 then
							self.ToDelete = true
							canDamage = true
						else
							canDamage = true
							if diff.Magnitude < 1.7 and ((self.smoke and math.random(1,4) <= 2) or self.alwaysTracer) then
								AudioMan:PlaySound("Sandstorm.rte/Effects/Sounds/Ammunition/Bullet/Ricochet/Ricochet"..math.random(1,10)..".wav", self.Pos);
							end
						end
					else
						canDamage = true
						self.ToDelete = true
					end
				else
					self.ToDelete = true
				end
			end
			
			if canDamage then
				local maxi = 1
				if self:NumberValueExists("Wounds") then
					maxi = self:GetNumberValue("Wounds");
				end
				for i = 1, maxi do
					local pixel = CreateMOPixel("Real Bullet Damage");
					pixel.Vel = Vector(hitVel.X, hitVel.Y) * 0.6;--Vector(self.Vel.X, self.Vel.Y) * 0.6;
					pixel.Sharpness = self.Sharpness
					pixel.Mass = self.Mass
					pixel.WoundDamageMultiplier = pixel.WoundDamageMultiplier * (self:NumberValueExists("WoundDamageMultiplier") and self:GetNumberValue("WoundDamageMultiplier") or 1.0)
					pixel.Pos = self.Pos - Vector(self.Vel.X,self.Vel.Y):SetMagnitude(2)--self.Pos - Vector(2, 0):RadRotate(self.RotAngle);
					pixel.Team = self.Team
					pixel.IgnoresTeamHits = true;
					MovableMan:AddParticle(pixel);
				end
				
				local effect = CreateMOSRotating(hitGFXType == 0 and "Real Bullet Hit Effect Default" or hitGFX[hitGFXType]);
				if effect then
					effect.Pos = self.Pos - Vector(self.Vel.X,self.Vel.Y):SetMagnitude(1)
					MovableMan:AddParticle(effect);
					effect:GibThis();
				end
			end
			
			if self.Vel.Magnitude < 10 then
				self.ToDelete = true
			end
		else
			self.Pos = endPos
		end
		
		-- Epic Trail
		
		if ((self.smoke) or self.alwaysTracer) and not self.noSmoke then
			local smoke
			local offset = travel
			local trailLength = math.floor((offset.Magnitude+0.5) / 5)
			for i = 1, trailLength do
				if RangeRand(0,1) < (1 - self.trailGLoss) then
					--smoke = CreateMOPixel("Real Bullet Micro Smoke Ball "..math.random(1,4));
					smoke = CreateMOPixel("Real Bullet Micro Smoke Ball "..math.random(1,4));
					if smoke then
						
						local a = 10 * self.TrailWavenessSpeed;
						local b = 5 * self.TrailRandomnessMulti;
						self.trailM = (self.trailM + self.trailMTarget * TimerMan.DeltaTimeSecs * a) / (1 + TimerMan.DeltaTimeSecs * a)
						self.trailMProgress = self.trailMProgress + TimerMan.DeltaTimeSecs * b;
						if self.trailMProgress > 1 then
							self.trailMTarget = RangeRand(-1,1);
							self.trailMProgress = self.trailMProgress - 1;
						end
						
						smoke.Pos = self.Pos - offset * (1 - (i/trailLength)) * RangeRand(0.9, 1.1);
						smoke.Vel = self.Vel * self.trailGProgress * 0.25 + Vector(0, self.trailM * 12  * RangeRand(0.9, 1.1) * self.trailGProgress):RadRotate(Vector(self.Vel.X, self.Vel.Y).AbsRadAngle);-- * RangeRand(0.5, 1.2) * 0.5;
						smoke.Lifetime = smoke.Lifetime * RangeRand(0.1, 1.9) * (1.0 + self.trailGProgress) * 0.3 * self.LifetimeMulti;
						smoke.GlobalAccScalar = RangeRand(-1, 1) * 0.15; -- Go up and down
						MovableMan:AddParticle(smoke);
						
						local c = 1;
						self.trailGProgress = math.min(self.trailGProgress + TimerMan.DeltaTimeSecs * c, 1.0)
						self.trailGLoss = math.min(self.trailGLoss + TimerMan.DeltaTimeSecs * 0.65, 1.0);
					end
				end
			end
		end
		
	end
end



function Destroy(self)
	if self.soundLoop ~= nil then
		self.soundLoop:Stop()
		self.soundLoop = nil
	end
end