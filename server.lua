zones = {}

RegisterServerEvent("Server:addZone")
AddEventHandler("Server:addZone", function(speed, radius, x, y, z)
    radius = radius + 0.0
    speed = speed + 0.0
    table.insert(zones, {x, y, z, radius, speed})
    TriggerClientEvent("Client:addZone", -1, speed, radius, x, y, z)
end)

RegisterServerEvent("Server:deleteZone")
AddEventHandler("Server:deleteZone", function(selectedZone, zoneBlip, tableIndex, x, y, z)
    table.remove(zones, tableIndex)
    TriggerClientEvent("Client:deleteZone", -1, selectedZone, zoneBlip, tableIndex, x, y, z)
end)

RegisterServerEvent("Server:getZones")
AddEventHandler("Server:getZones", function()
    TriggerClientEvent("Client:sendZones", source, zones)
end)

RegisterServerEvent("Server:ToggleNode")
AddEventHandler("Server:ToggleNode", function(nodePos, enabled)
    TriggerClientEvent("Client:ToggleNode", -1, nodePos, enabled)
end)

RegisterServerEvent("Server:removeProp")
AddEventHandler("Server:removeProp", function(netId)

    local ent = NetworkGetEntityFromNetworkId(netId)

    local owner = NetworkGetEntityOwner(ent)
    if netId then
        TriggerClientEvent("Client:removeProp", owner, netId)
    else
        print("ERROR: Prop Net ID not detected!")
    end
end)