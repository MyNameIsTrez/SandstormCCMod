
dofile("Base.rte/Constants.lua")
require("AI/NativeHumanAI")  --dofile("Base.rte/AI/NativeHumanAI.lua")
package.path = package.path .. ";SandstormInsurgency.rte/?.lua";
require("Actors/InsurgencyAIBehaviours")

function Create(self)
	self.AI = NativeHumanAI:Create(self)
	--You can turn features on and off here
	self.armSway = true;
	self.automaticEquip = true;
	self.alternativeGib = true;
	self.visibleInventory = true;
	
	-- Start modded code --
	
	self.RTE = "SandstormInsurgency.rte";
	self.baseRTE = "Sandstorm.rte";	
	
	-- TERRAIN SOUNDS
	
	self.terrainImpactLightSounds = {[9] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Dirt/TerrainImpactDirt",
	[10] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Dirt/TerrainImpactDirt",
	[11] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Dirt/TerrainImpactDirt",
	[128] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Sand/TerrainImpactSand",
	[6] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Dirt/TerrainImpactDirt",
	[8] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Dirt/TerrainImpactDirt",
	[12] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Concrete/TerrainImpactConcrete",
	[177] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/Concrete/TerrainImpactConcrete",
	[178] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/SolidMetal/TerrainImpactSolidMetal",
	[182] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Light/SolidMetal/TerrainImpactSolidMetal"};
	
	self.terrainImpactLightSoundVariations = {[9] =	5,
	[10] =	5,
	[11] =	5,
	[128] =	5,
	[6] =	5,
	[8] =	5,
	[12] =	5,
	[177] =	5,
	[178] =	5,
	[182] =	5,};

	self.terrainImpactHeavySounds = {[9] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Dirt/TerrainImpactDirt",
	[10] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Dirt/TerrainImpactDirt",
	[11] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Dirt/TerrainImpactDirt",
	[128] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Sand/TerrainImpactSand",
	[6] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Dirt/TerrainImpactDirt",
	[8] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Dirt/TerrainImpactDirt",
	[12] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Concrete/TerrainImpactConcrete",
	[177] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/Concrete/TerrainImpactConcrete",
	[178] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/SolidMetal/TerrainImpactSolidMetal",
	[182] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/TerrainImpact/Heavy/SolidMetal/TerrainImpactSolidMetal"};
	
	self.terrainImpactHeavySoundVariations = {[9] =	5,
	[10] =	5,
	[11] =	5,
	[128] =	5,
	[6] =	5,
	[8] =	5,
	[12] =	5,
	[177] =	5,
	[178] =	5,
	[182] =	5,};
	
	self.terrainLandSounds = {[9] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Dirt/LandDirt",
	[10] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Dirt/LandDirt",
	[11] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Dirt/LandDirt",
	[128] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Sand/LandSand",
	[6] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Dirt/LandDirt",
	[8] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Dirt/LandDirt",
	[12] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Concrete/LandConcrete",
	[177] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/Concrete/LandConcrete",
	[178] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/SolidMetal/LandSolidMetal",
	[182] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Land/SolidMetal/LandSolidMetal"};
	
	self.terrainLandSoundVariations = {[9] =	5,
	[10] =	5,
	[11] =	5,
	[128] =	5,
	[6] =	5,
	[8] =	5,
	[12] =	5,
	[177] =	5,
	[178] =	5,
	[182] =	5,};
	
	self.terrainJumpSounds = {[9] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Dirt/JumpDirt",
	[10] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Dirt/JumpDirt",
	[11] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Dirt/JumpDirt",
	[128] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Sand/JumpSand",
	[6] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Dirt/JumpDirt",
	[8] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Dirt/JumpDirt",
	[12] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Concrete/JumpConcrete",
	[177] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/Concrete/JumpConcrete",
	[178] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/SolidMetal/JumpSolidMetal",
	[182] =	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Jump/SolidMetal/JumpSolidMetal"};
	
	self.terrainJumpSoundVariations = {[9] =	5,
	[10] =	5,
	[11] =	5,
	[128] =	5,
	[6] =	5,
	[8] =	5,
	[12] =	5,
	[177] =	5,
	[178] =	5,
	[182] =	5,};
	
	self.terrainProneSounds = {[9] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Dirt/ProneDirt",
	[10] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Dirt/ProneDirt",
	[11] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Dirt/ProneDirt",
	[128] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Sand/ProneSand",
	[6] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Dirt/ProneDirt",
	[8] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Dirt/ProneDirt",
	[12] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Concrete/ProneConcrete",
	[177] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/Concrete/ProneConcrete",
	[178] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/SolidMetal/ProneSolidMetal",
	[182] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Prone/SolidMetal/ProneSolidMetal"};
	
	self.terrainProneSoundVariations = {[9] =	4,
	[10] =	4,
	[11] =	4,
	[128] =	4,
	[6] =	4,
	[8] =	4,
	[12] =	4,
	[177] =	4,
	[178] =	4,
	[182] =	4,};
	
	self.terrainCrawlSounds = {[9] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Dirt/CrawlDirt",
	[10] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Dirt/CrawlDirt",
	[11] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Dirt/CrawlDirt",
	[128] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Sand/CrawlSand",
	[6] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Dirt/CrawlDirt",
	[8] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Dirt/CrawlDirt",
	[12] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Concrete/CrawlConcrete",
	[177] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/Concrete/CrawlConcrete",
	[178] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/SolidMetal/CrawlSolidMetal",
	[182] =
	self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Crawl/SolidMetal/CrawlSolidMetal"};
	
	self.terrainCrawlSoundVariations = {[9] =	5,
	[10] =	5,
	[11] =	5,
	[128] =	5,
	[6] =	5,
	[8] =	5,
	[12] =	5,
	[177] =	5,
	[178] =	5,
	[182] =	5,};
	
	self.miscSounds = {Impact = self.baseRTE.."/Actors/Shared/Sounds/ActorDamage/TerrainImpact/BoneBreak"};
	
	self.miscSoundVariations = {Impact = 5,};
	
	-- head and gender and voice management
	
	-- frame 0 idle
	-- frame 1 idle eyes closed
	-- frame 2 angry
	-- frame 3 angry mouth open
	-- frame 4 scared
	
	-- unfortunately hardcoded to our 3 options here with 15 heads total but this may change
	-- TODO unhardcode
	local skin = 0
	
	local headFrames = 5;
	
	self.Nationality = (2 and math.random(1, 100) < 20) or 1;
	
	if self.Nationality == 1 then -- Arab
		if math.random(1, 2) == 1 then		-- arab1
			skin = 0
			self.baseHeadFrame = headFrames * math.random(0, 5);
			if self.Head then
				self.Head.Frame = self.baseHeadFrame;
			end
		
			self.voiceSounds = {Death = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Death/Death",
			seriousDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Death/SeriousDeath",
			flameDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Death/FlameDeath",
			Incapacitated =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Death/Incapacitated",
			Suppressed =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Suppression/SuppressedByGunfire",
			SuppressedByExplosion =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Suppression/SuppressedByExplosion",
			Suppressing =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Suppressing/Suppressing",
			witnessDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/DeathReactions/FriendlyDown",
			witnessGruesomeDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/DeathReactions/FriendlyGibbed",
			inhaleLight =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/InhaleLight",
			inhaleMedium =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/InhaleMedium",
			inhaleHeavy =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/InhaleHeavy",
			exhaleLight =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/ExhaleLight",
			exhaleMedium =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/ExhaleMedium",
			exhaleHeavy =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/ExhaleHeavy",
			Exertion = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Exertion/Exertion",
			Pain =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Pain/Pain",
			burnPain =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Pain/BurnPain",
			Flashed =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Flashed/Flashed",
			Reload =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Reload/Reload",
			suppressedReload =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Reload/SuppressedReload",
			flashOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/FlashOut",		
			suppressedFlashOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedFlashOut",	
			fragOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/FragOut",		
			suppressedFragOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedFragOut",	
			incendiaryOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/IncendiaryOut",		
			suppressedIncendiaryOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedIncendiaryOut",	
			mineOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/MineOut",		
			suppressedMineOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedMineOut",	
			molotovOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/MolotovOut",		
			suppressedMolotovOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedMolotovOut",	
			remoteOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/RemoteOut",		
			suppressedRemoteOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedRemoteOut",	
			smokeOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SmokeOut",		
			suppressedSmokeOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Throw/SuppressedSmokeOut",
			Tossback = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Tossback/Tossback",
			spotGrenade =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Spot/SpotFrag",
			spotRemote =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Spot/SpotRemote",
			spotEnemy =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Spot/SpotEnemy",
			spotEnemyFar =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Spot/SpotEnemyFar",
			spotEnemyClose =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale1/Spot/SpotEnemyClose"};			
			
			self.voiceSoundVariations = {Death = 25,
			seriousDeath = 16,
			flameDeath = 6,
			Incapacitated = 11,
			Suppressed = 45,
			SuppressedByExplosion = 5,
			Suppressing = 5,
			witnessDeath = 8,
			witnessGruesomeDeath = 5,
			inhaleLight = 10,
			inhaleMedium = 10,
			inhaleHeavy = 8,
			exhaleLight = 10,
			exhaleMedium = 10,
			exhaleHeavy = 8,
			Exertion = 20,
			Pain = 15,
			burnPain = 5,
			Flashed = 5,
			Reload = 28,
			suppressedReload = 38,
			flashOut = 8,
			suppressedFlashOut = 7,
			fragOut = 8,		
			suppressedFragOut = 8,	
			incendiaryOut = 5,		
			suppressedIncendiaryOut = 5,	
			mineOut = 5,		
			suppressedMineOut = 5,	
			molotovOut = 5,		
			suppressedMolotovOut = 5,	
			remoteOut = 5,		
			suppressedRemoteOut = 5,	
			smokeOut = 8,		
			suppressedSmokeOut = 8,
			Tossback = 5,
			spotGrenade = 5,
			spotRemote = 5,
			spotEnemy = 10,
			spotEnemyFar = 8,
			spotEnemyClose = 8};				
		else
			skin = 0
			self.baseHeadFrame = headFrames * math.random(0, 5);
			if self.Head then
				self.Head.Frame = self.baseHeadFrame;
			end
			
			self.voiceSounds = {Death = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Death/Death",
			seriousDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Death/SeriousDeath",
			flameDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Death/FlameDeath",
			Incapacitated =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Death/Incapacitated",
			Suppressed =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Suppression/SuppressedByGunfire",
			SuppressedByExplosion =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Suppression/SuppressedByExplosion",
			Suppressing =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Suppressing/Suppressing",
			witnessDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/DeathReactions/FriendlyDown",
			witnessGruesomeDeath = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/DeathReactions/FriendlyGibbed",
			inhaleLight =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/InhaleLight",
			inhaleMedium =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/InhaleMedium",
			inhaleHeavy =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/InhaleHeavy",
			exhaleLight =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/ExhaleLight",
			exhaleMedium =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/ExhaleMedium",
			exhaleHeavy =
			self.RTE.."/Actors/Shared/Sounds/VO/Shared/Exertion/ExhaleHeavy",
			Exertion = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Exertion/Exertion",
			Pain =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Pain/Pain",
			burnPain =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Pain/BurnPain",
			Flashed =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Flashed/Flashed",
			Reload =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Reload/Reload",
			suppressedReload =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Reload/SuppressedReload",
			flashOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/FlashOut",		
			suppressedFlashOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedFlashOut",	
			fragOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/FragOut",		
			suppressedFragOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedFragOut",	
			incendiaryOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/IncendiaryOut",		
			suppressedIncendiaryOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedIncendiaryOut",	
			mineOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/MineOut",		
			suppressedMineOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedMineOut",	
			molotovOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/MolotovOut",		
			suppressedMolotovOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedMolotovOut",	
			remoteOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/RemoteOut",		
			suppressedRemoteOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedRemoteOut",	
			smokeOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SmokeOut",		
			suppressedSmokeOut =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Throw/SuppressedSmokeOut",
			Tossback = 
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Tossback/Tossback",
			spotGrenade =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Spot/SpotFrag",
			spotRemote =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Spot/SpotRemote",
			spotEnemy =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Spot/SpotEnemy",
			spotEnemyFar =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Spot/SpotEnemyFar",
			spotEnemyClose =
			self.RTE.."/Actors/Shared/Sounds/VO/InsArabMale2/Spot/SpotEnemyClose"};
			
			self.voiceSoundVariations = {Death = 30,
			seriousDeath = 14,
			flameDeath = 6,
			Incapacitated = 16,
			Suppressed = 47,
			SuppressedByExplosion = 6,
			Suppressing = 5,
			witnessDeath = 8,
			witnessGruesomeDeath = 5,
			inhaleLight = 10,
			inhaleMedium = 10,
			inhaleHeavy = 8,
			exhaleLight = 10,
			exhaleMedium = 10,
			exhaleHeavy = 8,
			Exertion = 30,
			Pain = 17,
			burnPain = 4,
			Flashed = 5,
			Reload = 39,
			suppressedReload = 37,
			flashOut = 8,
			suppressedFlashOut = 7,
			fragOut = 8,		
			suppressedFragOut = 8,	
			incendiaryOut = 5,		
			suppressedIncendiaryOut = 5,	
			mineOut = 5,		
			suppressedMineOut = 5,	
			molotovOut = 5,		
			suppressedMolotovOut = 5,	
			remoteOut = 5,		
			suppressedRemoteOut = 5,	
			smokeOut = 8,		
			suppressedSmokeOut = 8,
			Tossback = 5,
			spotGrenade = 10,
			spotRemote = 5,
			spotEnemy = 12,
			spotEnemyFar = 8,
			spotEnemyClose = 8};	
		end
	else	-- Russian
	
		-- blyat
		self.baseHeadFrame = headFrames * math.random(7, 9);
		if self.Head then
			self.Head.Frame = self.baseHeadFrame;
		end
		skin = 1
	
		self.voiceSounds = {Death = 
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Death/Death",
		seriousDeath = 
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Death/SeriousDeath",
		flameDeath = 
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Death/FlameDeath",
		Incapacitated =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Death/Incapacitated",
		Suppressed =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Suppression/SuppressedByGunfire",
		SuppressedByExplosion =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Suppression/SuppressedByExplosion",
		Suppressing =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Suppressing/Suppressing",
		witnessDeath = 
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/DeathReactions/FriendlyDown",
		witnessGruesomeDeath = 
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/DeathReactions/FriendlyGibbed",
		inhaleLight =
		"SandstormSecurity.rte/Actors/Shared/Sounds/VO/SecArabMale/Exertion/InhaleLight",
		inhaleMedium =
		"SandstormSecurity.rte/Actors/Shared/Sounds/VO/SecArabMale/Exertion/InhaleMedium",
		inhaleHeavy =
		"SandstormSecurity.rte/Actors/Shared/Sounds/VO/SecArabMale/Exertion/InhaleHeavy",
		exhaleLight =
		"SandstormSecurity.rte/Actors/Shared/Sounds/VO/SecArabMale/Exertion/ExhaleLight",
		exhaleMedium =
		"SandstormSecurity.rte/Actors/Shared/Sounds/VO/SecArabMale/Exertion/ExhaleMedium",
		exhaleHeavy =
		"SandstormSecurity.rte/Actors/Shared/Sounds/VO/SecArabMale/Exertion/ExhaleHeavy",
		Exertion =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Exertion/Exertion",
		Pain =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Pain/Pain",
		burnPain =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Pain/BurnPain",
		Flashed =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Flashed/Flashed",
		Reload =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Reload/Reload",
		suppressedReload =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Reload/SuppressedReload",		
		flashOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/FlashOut",		
		suppressedFlashOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedFlashOut",	
		fragOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/FragOut",		
		suppressedFragOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedFragOut",	
		incendiaryOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/IncendiaryOut",		
		suppressedIncendiaryOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedIncendiaryOut",	
		mineOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/MineOut",		
		suppressedMineOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedMineOut",	
		molotovOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/MolotovOut",		
		suppressedMolotovOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedMolotovOut",	
		remoteOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/RemoteOut",		
		suppressedRemoteOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedRemoteOut",	
		smokeOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SmokeOut",		
		suppressedSmokeOut =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Throw/SuppressedSmokeOut",
		Tossback = 
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Tossback/Tossback",
		spotGrenade =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Spot/SpotFrag",
		spotRemote =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Spot/SpotRemote",
		spotEnemy =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Spot/SpotEnemy",
		spotEnemyFar =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Spot/SpotEnemyFar",
		spotEnemyClose =
		self.RTE.."/Actors/Shared/Sounds/VO/InsRussianMale1/Spot/SpotEnemyClose"};
		
		self.voiceSoundVariations = {Death = 32,
		seriousDeath = 19,
		flameDeath = 5,
		Incapacitated = 10,
		Suppressed = 42,
		SuppressedByExplosion = 4,
		Suppressing = 5,
		witnessDeath = 9,
		witnessGruesomeDeath = 5,
		inhaleLight = 10,
		inhaleMedium = 10,
		inhaleHeavy = 8,
		exhaleLight = 10,
		exhaleMedium = 10,
		exhaleHeavy = 8,
		Exertion = 28,
		Pain = 25,
		burnPain = 5,
		Flashed = 11,
		Reload = 30,
		suppressedReload = 29,
		flashOut = 10,
		suppressedFlashOut = 8,
		fragOut = 8,		
		suppressedFragOut = 9,	
		incendiaryOut = 5,		
		suppressedIncendiaryOut = 5,	
		mineOut = 5,		
		suppressedMineOut = 5,	
		molotovOut = 6,		
		suppressedMolotovOut = 6,	
		remoteOut = 5,		
		suppressedRemoteOut = 5,	
		smokeOut = 9,		
		suppressedSmokeOut = 10,
		Tossback = 6,
		spotGrenade = 5,
		spotRemote = 5,
		spotEnemy = 10,
		spotEnemyFar = 8,
		spotEnemyClose = 13};	
		
	end
	self:SetNumberValue("SkinTone", skin)
	
	self.altitude = 0;
	self.wasInAir = false;
	
	self.moveSoundTimer = Timer();
	self.moveSoundWalkTimer = Timer();
	self.wasCrouching = false;
	self.wasMoving = false;
	
	self.Stamina = 100;
	self.Inhale = true;
	self.Suppression = 0;
	self.Suppressed = false;
	
	self.healthUpdateTimer = Timer();
	self.oldHealth = self.Health;
	
	-- chance upon any non-headshot death to be incapacitated for a while before really dying
	self.incapacitationChance = 10;
	
	self.Burning = false;
	
	self.staminaUpdateTimer = Timer();
	self.suppressionUpdateTimer = Timer();
	
	self.exertionSoundTimer = Timer();
	
	self.emotionTimer = Timer();
	self.emotionDuration = 0;
	
	self.reloadVoicelineTimer = Timer();
	self.reloadVoicelineDelay = 5000;
	
	self.suppressedVoicelineTimer = Timer();
	self.suppressedVoicelineDelay = 5000;
	
	self.gunShotCounter = 0;
	self.suppressingVoicelineTimer = Timer();
	self.suppressingVoicelineDelay = 15000;
	
	self.blinkTimer = Timer();
	self.blinkDelay = math.random(5000, 11000);
	
	self.ragdollTerrainImpactTimer = Timer();
	self.ragdollTerrainImpactDelay = math.random(200, 500);
	
	self.friendlyDownTimer = Timer();
	self.friendlyDownDelay = 5000;
	
	self.spotVoiceLineTimer = Timer();
	self.spotVoiceLineDelay = 15000;
	
	 -- in pixels
	self.spotDistanceClose = 175;
	self.spotDistanceMid = 520;
	--spotDistanceFar -- anything further than distanceMid
	
	 -- in MS
	self.spotDelayMin = 4000;
	self.spotDelayMax = 8000;
	
	 -- in percent
	self.spotIgnoreDelayChance = 10;
	self.spotNoVoicelineChance = 15;
	
	 -- burst fire
	self.burstFireDelayTimer = Timer()
	self.burstFireDelayMin = 150
	self.burstFireDelayMax = 300
	self.burstFireDelay = math.random(self.burstFireDelayMin,self.burstFireDelayMax)	
	
	-- experimental method for enhanced dying - don't let the actor actually die until we want him to.
	-- reason for this is because when the actor IsDead he will really want to settle and there's not much we can do about it.
	self.allowedToDie = false;
	
	-- fil walk/sprint/jump
	
    -- Leg Collision Detection system
    self.feetContact = {false, false}
    self.feetTimers = {Timer(), Timer()}
	self.footstepTime = 100 -- 2 Timers to avoid noise
	self.sprintFootstepTime = 75
	self.walkFootstepTime = 100
	
	-- Custom Jumping
	self.isJumping = false
	self.jumpTimer = Timer();
	self.jumpDelay = 500;
	self.jumpStop = Timer();
	self.jumpBoost = Timer();
	
	-- Spring
	self.isSprinting = false
	self.doubleTapTimer = Timer();
	self.doubleTapState = 0

	self.sprintPushForceDenominator = 1.2 / 0.8
	
	self.limbPathDefaultSpeed0 = self:GetLimbPathSpeed(0) * 0.8
	self.limbPathDefaultSpeed1 = self:GetLimbPathSpeed(1) * 0.8
	self.limbPathDefaultSpeed2 = self:GetLimbPathSpeed(2) * 0.8
	self.limbPathDefaultPushForce = self.LimbPathPushForce * 0.8
	
	-- footstep sounds
	
	self.terrainStepSounds = {
	Walk = {
	[9] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Dirt/WalkDirt",
	[10] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Dirt/WalkDirt",
	[11] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Dirt/WalkDirt",
	[128] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Dirt/WalkDirt",
	[6] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Sand/WalkSand",
	[8] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Dirt/WalkDirt",
	[12] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Concrete/WalkConcrete",
	[177] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/Concrete/WalkConcrete",
	[178] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/SolidMetal/WalkSolidMetal",
	[182] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Walk/SolidMetal/WalkSolidMetal"},
	Sprint = {
	[9] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Dirt/SprintDirt",
	[10] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Dirt/SprintDirt",
	[11] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Dirt/SprintDirt",
	[128] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Dirt/SprintDirt",
	[6] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Sand/SprintSand",
	[8] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Dirt/SprintDirt",
	[12] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Concrete/SprintConcrete",
	[177] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/Concrete/SprintConcrete",
	[178] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/SolidMetal/SprintSolidMetal",
	[182] = self.baseRTE.."/Actors/Shared/Sounds/ActorMovement/TerrainDependent/Footsteps/Sprint/SolidMetal/SprintSolidMetal"}	
	};
	
	self.terrainStepSoundVariations = {
	Walk = {
	[9] = 5,
	[10] = 5,
	[11] = 5,
	[128] = 5,
	[6] = 5,
	[8] = 5,
	[12] = 5,
	[177] = 5,
	[178] = 5,
	[182] = 5},
	Sprint = {
	[9] = 5,
	[10] = 5,
	[11] = 5,
	[128] = 5,
	[6] = 5,
	[8] = 5,
	[12] = 5,
	[177] = 5,
	[178] = 5,
	[182] = 5}	
	};
	
	--
	
	
	-- End modded code
end

-- Start modded code --

-- End modded code --

function OnCollideWithTerrain(self, terrainID)
	-- let Fall sounds know to play this
	self.terrainCollided = true;
	self.terrainCollidedWith = terrainID;
	--if self.Dying or self.Status == Actor.DEAD or self.Status == Actor.DYING then
	--	InsurgencyAIBehaviours.handleRagdoll(self)
	--end
end

function Update(self)

	self.controller = self:GetController();
	
	if self.alternativeGib then
		HumanFunctions.DoAlternativeGib(self);
	end
	if self.automaticEquip then
		HumanFunctions.DoAutomaticEquip(self);
	end
	if self.armSway then
		HumanFunctions.DoArmSway(self, (self.Health/self.MaxHealth));	--Argument: shove strength
	end
	if self.visibleInventory then
		HumanFunctions.DoVisibleInventory(self, false);	--Argument: whether to show all items
	end
	
	-- Start modded code--
	
	if (UInputMan:KeyPressed(26)) and self:IsPlayerControlled() then
		self.Health = self.Health -26
	end
	
	if UInputMan:KeyPressed(3) and self:IsPlayerControlled() then
		self.Health = self.Health -51
	end
	
	if (UInputMan:KeyPressed(24)) and self:IsPlayerControlled() then
		self.Health = self.Health -6
	end
	
	if self:IsPlayerControlled() then
		-- Debug
		local barValue = self.Stamina
		local barValueMax = 100
		local barOffset = Vector(0, 17)
		local barLength = 10
		-- Stamina
		for i = 0, 1 do
			-- Bar Background
			PrimitiveMan:DrawLinePrimitive(self.Pos + barOffset + Vector(-barLength, i), self.Pos + barOffset + Vector(barLength, i), 26);
			-- Bar Foreground
			local fac = math.max(math.min(barValue / barValueMax, 1), 0)
			PrimitiveMan:DrawLinePrimitive(self.Pos + barOffset + Vector(-barLength, i), self.Pos + barOffset + Vector(-barLength + (barLength * 2 * fac), i), 116);
		end
		-- Suppression
		barValue = self.Suppression
		barOffset = Vector(0, 20)
		for i = 0, 1 do
			-- Bar Background
			PrimitiveMan:DrawLinePrimitive(self.Pos + barOffset + Vector(-barLength, i), self.Pos + barOffset + Vector(barLength, i), 26);
			-- Bar Foreground
			local fac = math.max(math.min(barValue / barValueMax, 1), 0)
			PrimitiveMan:DrawLinePrimitive(self.Pos + barOffset + Vector(-barLength, i), self.Pos + barOffset + Vector(-barLength + (barLength * 2 * fac), i), 244);
		end
	end
	
	if self.voiceSound then
		if self.voiceSound:IsBeingPlayed() then
			self.voiceSound:SetPosition(self.Pos);
		end
	end
	if self.burnLoop then
		if self.burnLoop:IsBeingPlayed() then
			self.burnLoop:SetPosition(self.Pos);
		end
	end
	
	if (self.Dying ~= true) then
		
		InsurgencyAIBehaviours.handleLiveAirAndFalling(self);
		
		InsurgencyAIBehaviours.handleMovement(self);
		
		InsurgencyAIBehaviours.handleHealth(self);
		
		InsurgencyAIBehaviours.handleBurning(self);
		
		InsurgencyAIBehaviours.handleStaminaAndSuppression(self);
		
		InsurgencyAIBehaviours.handleAITargetLogic(self);
		
		InsurgencyAIBehaviours.handleVoicelines(self);
		
		InsurgencyAIBehaviours.handleHeadFrames(self);

	else
	
		InsurgencyAIBehaviours.handleMovement(self);
	
		InsurgencyAIBehaviours.handleHeadLoss(self);
		
		InsurgencyAIBehaviours.handleBurning(self);
		
		--InsurgencyAIBehaviours.handleDeadAirAndFalling(self);
		
		InsurgencyAIBehaviours.handleDying(self);
		
	end
	
	if self.Status == 1 or self.Dying then
		InsurgencyAIBehaviours.handleRagdoll(self)
	end
	
	-- clear terrain stuff after we did everything that used em
	
	self.terrainCollided = false;
	self.terrainCollidedWith = nil;
end
-- End modded code --

function UpdateAI(self)
	self.AI:Update(self)

end

function Destroy(self)
	self.AI:Destroy(self)
	
	-- Start modded code --
	
	if ActivityMan:ActivityRunning() then -- for some reason the game crashes if you switch activities (i.e. start a new one) while this actor is active
										  -- presumably it attempts to destroy this, which then tells it to do a buncha stuff and it just goes mad
										  -- this check is to see if the activity is running, since you have to be paused to switch activities. hopefully.
										  -- it is possible Void Wanderers switches activities without pausing. thus this may not work and induce a crash	
	
		if not self.ToSettle then -- we have been gibbed
			
			if (self.voiceSound) then
				if (self.voiceSound:IsBeingPlayed()) then
					self.voiceSound:Stop(-1);
					self.voiceSound = nil;
				end
			end
			--[[
			for actor in MovableMan.Actors do
				if actor.Team == self.Team then
					local d = SceneMan:ShortestDistance(actor.Pos, self.Pos, true).Magnitude;
					if d < 300 then
						local strength = SceneMan:CastStrengthSumRay(self.Pos, actor.Pos, 0, 128);
						if strength < 500 then
							actor:SetNumberValue("Sandstorm Friendly Down", 1)
							break;  -- first come first serve
						else
							if IsAHuman(actor) and actor.Head then -- if it is a human check for head
								local strength = SceneMan:CastStrengthSumRay(self.Pos, ToAHuman(actor).Head.Pos, 0, 128);	
								if strength < 500 then		
									actor:SetNumberValue("Sandstorm Friendly Down", 1)
									break; -- first come first serve
								end
							end
						end
					end
				end
			end]]
		end
		if self.headGibSound then
			if self.headGibSound:IsBeingPlayed() then
				self.headGibSound:Stop(-1)
			end
		end
		if self.burnLoop then
			if self.burnLoop:IsBeingPlayed() then
				self.burnLoop:Stop(-1)
				self.soundEffect = AudioMan:PlaySound("Sandstorm.rte/Actors/Shared/Sounds/ActorDamage/Burn/End1.ogg", self.Pos, -1, 0, 130, 1, 400, false);
			end
		end
		
	end
	
	-- End modded code --
	
end
