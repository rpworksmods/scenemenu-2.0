function showNodes()

    local myPos = GetEntityCoords(PlayerPedId(), true)
    for i = 40, 1, -1 do
        local nodeId = GetNthClosestVehicleNodeId(myPos.x, myPos.y, myPos.z, i, 1, 0.0, 0.0);
        
        if IsVehicleNodeIdValid(nodeId) then
            local nodePos = GetVehicleNodePosition(nodeId)
            if (GetVehicleNodeIsSwitchedOff(nodeId)) then
                DrawMarker(0, nodePos.x, nodePos.y, nodePos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, 2, false, null, null, false)
            else
                DrawMarker(0, nodePos.x, nodePos.y, nodePos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, false, 2, false, null, null, false)
            end
        end
    end

end

function toggleNode()
    local coords = GetEntityCoords(PlayerPedId(), true)
    local nodeId = GetNthClosestVehicleNodeId(coords.x, coords.y, coords.z, 0, 1, 0.0, 0.0)
    if (IsVehicleNodeIdValid(nodeId)) then
        local nodePos = GetVehicleNodePosition(nodeId)
        if (Vdist(coords.x, coords.y, coords.z, nodePos.x, nodePos.y, nodePos.z) < 2.0) then
            local enabled = GetVehicleNodeIsSwitchedOff(nodeId)
            -- Disable/Enable node
            TriggerServerEvent("Server:ToggleNode", nodePos, enabled)
        end
    end

end

RegisterNetEvent("Client:ToggleNode")
AddEventHandler("Client:ToggleNode", function(nodePos, enabled)
	if not enabled then
		--AddRoadNodeSpeedZone(nodePos.x, nodePos.y, nodePos.z, 1.0, 0, false)
		SetRoadsInArea(nodePos.x + 0.5, nodePos.y + 0.5, nodePos.z + 0.5, nodePos.x - 0.5, nodePos.y - 0.5, nodePos.z - 0.5, false, false);
		SetIgnoreSecondaryRouteNodes(true);
	else
		SetRoadsBackToOriginal(nodePos.x + 0.5, nodePos.y + 0.5, nodePos.z + 0.5, nodePos.x - 0.5, nodePos.y - 0.5, nodePos.z - 0.5);
	end
end)