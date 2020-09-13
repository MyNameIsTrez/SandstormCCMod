function Create(self)

	self.laserTimer = Timer();
	self.guideTable = {};

	self.projectileVel = 30;
	if self.Magazine ~= null and self.Magazine.RoundCount ~= 0 then
		self.projectileVel = self.Magazine.NextRound.FireVel;
	end

	self.maxTrajectoryPars = 35;

end

function Update(self)

	local actor = MovableMan:GetMOFromID(self.RootID);
	if not self:IsReloading() and MovableMan:IsActor(actor) and ToActor(actor):IsPlayerControlled() and ToActor(actor):GetController():IsState(Controller.AIM_SHARP) then
		if self.laserTimer:IsPastSimMS(25) then
			self.laserTimer:Reset();

			self.guideTable = {};
			self.guideTable[1] = Vector(self.MuzzlePos.X,self.MuzzlePos.Y);

			local actor = ToActor(actor);
			local guideParPos = self.MuzzlePos;
			local guideParVel = Vector(self.projectileVel * self.FlipFactor,0):RadRotate(self.RotAngle)
			--local guideParVel = Vector(self.projectileVel,0):RadRotate(actor:GetAimAngle(true));
			for i = 1, self.maxTrajectoryPars do
				guideParVel = guideParVel + SceneMan.GlobalAcc * TimerMan.DeltaTimeSecs;
				guideParPos = guideParPos + guideParVel * rte.PxTravelledPerFrame;
				-- No need to wrap the seam manually, primitives can handle out-of-scene coordinates correctly
				--if SceneMan.SceneWrapsX == true then
				--	if guideParPos.X > SceneMan.SceneWidth then
				--		guideParPos = Vector(guideParPos.X - SceneMan.SceneWidth,guideParPos.Y);
				--	elseif guideParPos.X < 0 then
				--		guideParPos = Vector(SceneMan.SceneWidth + guideParPos.X,guideParPos.Y);
				--	end
				--end
				if SceneMan:GetTerrMatter(guideParPos.X,guideParPos.Y) == 0 then
					self.guideTable[#self.guideTable+1] = guideParPos;
				else
					local hitPos = Vector(self.guideTable[#self.guideTable].X,self.guideTable[#self.guideTable].Y);
					SceneMan:CastStrengthRay(self.guideTable[#self.guideTable],SceneMan:ShortestDistance(self.guideTable[#self.guideTable],guideParPos,false),0,hitPos,3,0,false);
					self.guideTable[#self.guideTable+1] = hitPos;
					break;
				end
			end
		end
	else
		self.guideTable = {};
	end

	if #self.guideTable > 1 then
		--[[
		for i = 1, #self.guideTable-1 do
			PrimitiveMan:DrawLinePrimitive(self.guideTable[i],self.guideTable[i+1],120);
		end]]
		for i = 1, #self.guideTable do
			PrimitiveMan:DrawLinePrimitive(self.guideTable[i],self.guideTable[i],120);
		end
		PrimitiveMan:DrawCirclePrimitive(self.guideTable[#self.guideTable],4,120);
	end

end