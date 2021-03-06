
function Create(self)

	self.baseRTE = "Sandstorm.rte";
	
	-- Gear Light Armor
	-- less gibs, more damage, more realistic deaths
	local woundLimitMultiplier = 1.5
	local woundDamageMultiplier = 1.25
	self.DamageMultiplier = self.DamageMultiplier * woundDamageMultiplier
	self.GibWoundLimit = self.GibWoundLimit * woundLimitMultiplier
    for limb in self.Attachables do
        limb.GibWoundLimit = limb.GibWoundLimit * woundLimitMultiplier
	end
	
	self.movementSounds = {
	Land = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Land/Land",
	Jump = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Jump/Jump",
	Crawl = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Crawl/Crawl",
	Sprint = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Prone/Prone",
	Crouch = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Crouch/Crouch",
	Stand = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Stand/Stand",
	Throw = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Throw/Throw",
	throwStart = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/ThrowStart/ThrowStart",
	Fall = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Fall/Fall",
	walkPre = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Walk/Pre",
	walkPost = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Walk/Post",
	sprintPre = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Sprint/Pre",
	sprintPost = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/Gear/Heavy/Sprint/Post",
	Impact = 0,};
	
	self.movementSoundVariations = {Land = 5,
	Jump = 5,
	Impact = 5,
	Crawl = 5,
	Sprint = 5,
	Crouch = 5,
	Stand = 5,
	Throw = 4,
	throwStart = 4,
	Fall = 5,
	walkPre = 5,
	walkPost = 5,
	sprintPre = 5,
	sprintPost = 5};
	
	self.sprintMultiplier = 1.2;
	
	-- RANDOM ARMOR AND UNIFORM
	local skin = self:GetNumberValue("SkinTone")
	
	local legsSkin = 0
	local armsSkin = 0
	
	local rn = math.random(0, 4)
	self.Frame = rn
	armsSkin = rn * 3 + 2
	legsSkin = rn
	
	for limb in self.Attachables do
		if string.find(limb.PresetName, "Leg") then
			limb:SetNumberValue("Skin", legsSkin)
		elseif string.find(limb.PresetName, "Arm") then
			limb:SetNumberValue("Skin", armsSkin)
		end
	end
	
	--	self.Frame = math.random(0, self.FrameCount - 1);
	
	local torsoAttachable = CreateAttachable("Sandstorm Security Heavy Kevlar", "SandstormSecurity.rte");
	self:AddAttachable(torsoAttachable);
	
	for limb in self.Attachables do
		if string.find(limb.PresetName, "Leg") then
			local limbAttachable = CreateAttachable("Sandstorm Security Leg Pad", "SandstormSecurity.rte");
			limb:AddAttachable(limbAttachable);
		end
	end
	
	if self.Head then
		local mask = math.random(1, 10) < 5;
		if mask then
			local headAttachable = CreateAttachable("Sandstorm Security Heavy Helmet Mask", "SandstormSecurity.rte");
			self.Head:AddAttachable(headAttachable);
		end
		
		local glasses = math.random(1, 10) < 7;
		if glasses then
			local headAttachable = CreateAttachable("Sandstorm Security Heavy Helmet Visor", "SandstormSecurity.rte");
			self.Head:AddAttachable(headAttachable);
		end
		local headAttachable = (math.random(1, 10) < 7 and CreateAttachable("Sandstorm Security Heavy Helmet", "SandstormSecurity.rte") or CreateAttachable("Sandstorm Security Light Helmet", "SandstormSecurity.rte"))
		headAttachable.Frame = self.Frame
		self.Head:AddAttachable(headAttachable);
		
		if headAttachable and math.random(1,3) < 2 then
			local helmetAttachable = CreateAttachable("Sandstorm Security Helmet Detail", "SandstormSecurity.rte");
			headAttachable:AddAttachable(helmetAttachable);
		end
	end
	
	local backpack = CreateAttachable("Sandstorm Security Backpack", "SandstormSecurity.rte")
	self:AddAttachable(backpack);
	backpack.Frame = math.random(0,2) + ((rn == 1 or rn == 2) and 3 or 0)
	
end
