script = nil

local Module			= 	{ }
local Blacklist			=	{ }

local CoreGui			=	game:GetService('CoreGui')
local Workspace			=	game:GetService('Workspace')
local Players			=	game:GetService('Players')
local StarterGui		=	game:GetService('StarterGui')

local Player			=	Players.LocalPlayer
local DetectPartsR6 	= {
	"Right Leg",
	"Left Leg",
	"Right Arm",
	"Left Arm"
}
local DetectPartsR15 	= {
	"RightUpperLeg",
	"LeftUpperLeg",
	"RightUpperArm",
	"LeftUpperArm"
}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Module.Anti_Exploit		= 	function()
	if Player then
		if Player.Character then
			local Animate			= Player.Character:FindFirstChild("Animate")
			local Humanoid			= Player.Character:FindFirstChild("Humanoid")
			local HumanoidRootPart 	= Player.Character:FindFirstChild("HumanoidRootPart")
			local Died				= false
			
			Workspace.ChildAdded:Connect(function(Part)
				if Part:IsA("Part") then
					Part.Touched:Connect(function(Hit)
						if Hit.Parent:FindFirstChild("Humanoid") then
							if Part.Position.X > 1000 or Part.Position.Y > 1000 or Part.Position.Z > 1000 then
								Player:Kick("Foreign Part detected.")
							end
						end
					end)
				end
			end)
			Player.Backpack.ChildAdded:Connect(function(Tool)
				if Tool:IsA("HopperBin") then
					if Tool.BinType == Enum.BinType.Clone or Tool.BinType == Enum.BinType.Hammer or Tool.BinType == Enum.BinType.Grab then
						Tool:Destroy()
						Player:Kick("Foreign Tools detected in Backpack.")
					end
				end
				if #Tool:GetChildren() == 0 then
					Tool:Destroy()
				else
					
				end
			end)			
			
			Player.Character.ChildRemoved:Connect(function(Tool)
				if Tool:IsA("Tool") then
					if Tool ~= nil then
						Instance.new("Accessory", Tool).Name = Player.Name
						for i,v in pairs(Players:GetPlayers()) do
							if v.Character then
								for _,x in pairs(v.Character:GetChildren()) do
									if x:FindFirstChild(Player.Name) then
										Player:Kick("Tool Exchange detected On Client.")
									end
								end
							end
						end
					end
				end
				for i,v in pairs(Player.Character:GetChildren()) do
					if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
						for i = 1, #DetectPartsR15 do
							if Player.Character:FindFirstChild(DetectPartsR15[i]) == nil then
								Player.Character:BreakJoints()
							end
						end
					else
						for i = 1, #DetectPartsR6 do
							if Player.Character:FindFirstChild(DetectPartsR6[i]) == nil then
								Player.Character:BreakJoints()
							end
						end
					end
				end
			end)
			
			Player.Character:WaitForChild("Humanoid").Died:Connect(function()
				Died = true
			end)
			
			Workspace.Changed:Connect(function(Property)
				if Property == "Gravity" then
					Player:Kick("Workspace Property Change detected on Client.")
				end
			end)
			Animate.Changed:Connect(function(Property)
				if Property == "Disabled" then
					Player:Kick("Property Changed in Roblox Character.")
				end
			end)
			Humanoid.Changed:Connect(function(Property)
				if Property == "Name" then
					Player:Kick("Property Changed in Roblox Character.")
				elseif Property == "PlatformStand" then
					if Humanoid.PlatformStand == true then
						Player:Kick("Property Changed in Roblox Character.")
					end
				elseif Property == "HipHeight" then
					if Humanoid.HipHeight > 0 then
						Player:Kick("Property Changed in Roblox Character.")
					end
				elseif Property == "WalkSpeed" then
					if Humanoid.WalkSpeed > 25 then
						Player:Kick("Property Changed in Roblox Character.")	
					end
				elseif Property == "JumpPower" then
					if Humanoid.JumpPower > 50 then
						Player:Kick("Property Changed in Roblox Character.")
					end
				end
			end)
			
			Humanoid.StateChanged:Connect(function(New, Old)
				if New == 11 then
					Player:Kick("Property Changed in Roblox Character.")
				end
			end)
			
			for i,v in pairs(Player.Character:GetChildren()) do
				if v:IsA("Part") then
					if v.Name == "Head" then
						v.ChildRemoved:Connect(function()
							if v:FindFirstChildOfClass("SpecialMesh") == nil then
								Player:Kick("Changed Detected in Roblox Character.")
							end	
						end)
					end
				 	v.Changed:Connect(function(Property)
						wait(1)
						if Property == "CanCollide" and Died == false then
							Player:Kick("Property Changed in Roblox Character.")
						elseif Property == "Anchored" then
							if v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso" then
								Player:Kick("Property Changed in Roblox Character.")
							end
						end
					end)
				elseif v:IsA("Accessory") then
					v.ChildRemoved:Connect(function(Handle)
						if Handle ~= nil then
							if Handle.Name == "Handle" then
								if Handle.Parent:IsA("Tool") then
									Player:Kick("Changed detected in Roblox Character.")
								end
							end
						end
					end)
					if v:FindFirstChild("Handle") then
						v.Handle.ChildRemoved:Connect(function(Mesh)
							for i,v in pairs(v.Handle:GetChildren()) do
								if v:FindFirstChildOfClass("FileMesh") == nil then
									Player:Kick("Changed detected in Roblox Character.")
								end
							end
						end)
					end
				end
			end
			
			while wait(.1) do
				local ToolsEquiped = { }
				if HumanoidRootPart == nil or Humanoid == nil then
					Player:Kick("RootParts not detected.")
				else
					if HumanoidRootPart:FindFirstChildOfClass("BodyAngularVelocity") or HumanoidRootPart:FindFirstChildOfClass("BodyGyro") or HumanoidRootPart:FindFirstChildOfClass("BodyVelocity") or HumanoidRootPart:FindFirstChildOfClass("BodyForce") or HumanoidRootPart:FindFirstChildOfClass("RocketPropulsion") then
						Player:Kick("Foreign Children detected in RootParts")
					end
				end
				for i,v in pairs(Player.Character:GetChildren()) do
					if v:IsA("Tool") then
						table.insert(ToolsEquiped, v.Name)
					end
				end
				if #ToolsEquiped > 1 then
					Player:Kick("Multiple Tools detected.")
				end
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Module.Anti_Exploit()

return Module
