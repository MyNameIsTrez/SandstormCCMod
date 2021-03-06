function Create(self)
	
	self.lifeTimer = Timer();
	self.fuseTime = math.random(600, 800);
	
	self.impactTimer = Timer();
	self.impactCooldown = 0;
	
	self.lastVel = Vector(0, 0)
	
	self.checkTimer = Timer();
	self.checkDelay = 1000;
	self.checkI = 0
	
	local dir = "Sandstorm.rte/Devices/Weapons/Shared/Sounds/Bomb/"
	
	self.concreteHit = {["IDs"] = {[12] = "Exists", [177] = "Exists"},
	["Hit"] = nil};
	self.concreteHit.Hit = {["Variations"] = 3,
	["Path"] = dir.."M19/ImpactConcrete"};
	
	--
	
	self.dirtHit = {["IDs"] = {[9] = "Exists", [10] = "Exists", [11] = "Exists", [128] = "Exists"},
	["Hit"] = nil};
	self.dirtHit.Hit = {["Variations"] = 3,
	["Path"] = dir.."M19/ImpactDirt"};
	
	--
	
	self.sandHit = {["IDs"] = {[8] = "Exists"},
	["Hit"] = nil};
	self.sandHit.Hit = {["Variations"] = 3,
	["Path"] = dir.."M19/ImpactSand"};
	
	--
	
	self.solidMetalHit = {["IDs"] = {[178] = "Exists", [182] = "Exists"},
	["Hit"] = nil};
	self.solidMetalHit.Hit = {["Variations"] = 3,
	["Path"] = dir.."M19/ImpactSolidMetal"};
	
end

function OnCollideWithTerrain(self, terrainID)	

	if self.PinStrength > 0 then return end
	
	if self.impactSoundAllowed ~= false then
		self.impactSoundAllowed = false;
		if self.workingTravelImpulse.Magnitude > 5 then
			if self.dirtHit.IDs[terrainID] ~= nil then
				self.hitSound = AudioMan:PlaySound(self.dirtHit.Hit.Path .. math.random(1, self.dirtHit.Hit.Variations) .. ".ogg", self.Pos, -1, 0, 130, 1, 170, false);
			elseif self.sandHit.IDs[terrainID] ~= nil then
				self.hitSound = AudioMan:PlaySound(self.sandHit.Hit.Path .. math.random(1, self.sandHit.Hit.Variations) .. ".ogg", self.Pos, -1, 0, 130, 1, 170, false);
			elseif self.concreteHit.IDs[terrainID] ~= nil then
				self.hitSound = AudioMan:PlaySound(self.concreteHit.Hit.Path .. math.random(1, self.concreteHit.Hit.Variations) .. ".ogg", self.Pos, -1, 0, 130, 1, 170, false);
			elseif self.solidMetalHit.IDs[terrainID] ~= nil then
				self.hitSound = AudioMan:PlaySound(self.solidMetalHit.Hit.Path .. math.random(1, self.solidMetalHit.Hit.Variations) .. ".ogg", self.Pos, -1, 0, 130, 1, 170, false);
			else -- default to concrete
				self.hitSound = AudioMan:PlaySound(self.concreteHit.Hit.Path .. math.random(1, self.concreteHit.Hit.Variations) .. ".ogg", self.Pos, -1, 0, 130, 1, 170, false);
			end
		end
	end
end

function Update(self)
	self.ToSettle = false
	self:NotResting()
	
	if self.Age > 360000 then
		self.ToDelete = true
	end
	
	self.workingTravelImpulse = (self.Vel - self.lastVel) / TimerMan.DeltaTimeSecs * self.Vel.Magnitude * 0.1
	self.lastVel = Vector(self.Vel.X, self.Vel.Y)

	if self.impactTimer:IsPastSimMS(self.impactCooldown) then
		self.impactSoundAllowed = true;
		self.impactTimer:Reset();
		self.impactCooldown = 300; -- increase impact cooldown from first 0
	end

	if self.checkTimer:IsPastSimMS(self.checkDelay) and self.Vel.Magnitude < 5 then
		self.checkDelay = 100;
		self.checkTimer:Reset();
		
		self.checkI = self.checkI % 2 + 1
		
		local checkOrigin = Vector(self.Pos.X, self.Pos.Y) + Vector((self.checkI - 1) * 3, - 5)--:RadRotate(self.RotAngle)
		local checkPix = SceneMan:GetMOIDPixel(checkOrigin.X, checkOrigin.Y)
		PrimitiveMan:DrawLinePrimitive(checkOrigin, checkOrigin, 5)
		
		local stepper = nil
		if checkPix ~= 255 then
			stepper = MovableMan:GetMOFromID(checkPix);
		end
		
		--
		--[[
		local rayVector = Vector(0, -5):RadRotate(self.RotAngle);
		local ray1 = SceneMan:CastMORay(self.Pos + Vector(-3, -1):RadRotate(self.RotAngle), rayVector, self.ID, -2, 0, true, 1); -- -2 = no team ignored, self.ID = ignore self
		PrimitiveMan:DrawLinePrimitive(self.Pos + Vector(-3, -1):RadRotate(self.RotAngle), self.Pos + Vector(-3, 0):RadRotate(self.RotAngle) + rayVector, 5)
		local ray2 = SceneMan:CastMORay(self.Pos + Vector(3, -1):RadRotate(self.RotAngle), rayVector, self.ID, -2, 0, true, 1);
		PrimitiveMan:DrawLinePrimitive(self.Pos + Vector(3, -1):RadRotate(self.RotAngle), self.Pos + Vector(3, 0):RadRotate(self.RotAngle) + rayVector, 5)
		local ray3 = SceneMan:CastMORay(self.Pos, rayVector, self.ID, -2, 0, true, 1);
		PrimitiveMan:DrawLinePrimitive(self.Pos, self.Pos + rayVector, 5)
		if ray1 ~= nil then
			self.object = MovableMan:GetMOFromID(ray1);
		end
		if ray2 ~= nil then
			self.object = MovableMan:GetMOFromID(ray2);
		end
		if ray3 ~= nil then
			self.object = MovableMan:GetMOFromID(ray3);
		end]]
		
		if stepper then
			stepperParent = MovableMan:GetMOFromID(stepper.RootID); -- get the torso/base part
			if (stepperParent and stepperParent.Mass > 10) or stepper.Mass > 10 then -- if its heavy enough
				self:EraseFromTerrain()
				self:GibThis();
			end
		end
	end
	
end
