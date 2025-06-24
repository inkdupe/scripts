-- inf yield rj

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local JobId = game.JobId

if #Players:GetPlayers() <= 1 then
	Players.LocalPlayer:Kick("\nRejoining...")
	task.wait()
	TeleportService:Teleport(PlaceId, Players.LocalPlayer)
else
	TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
end
