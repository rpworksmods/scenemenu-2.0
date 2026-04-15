function showZone(range, speed)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local size = tonumber(range)
    size = size + .0

    DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, size, size, 2.0, 0, 255, 0, 255, false, false, 2, false, null, null, false)

end

function createZone(range, speed)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('Server:addZone', speed, range, pos.x, pos.y, pos.z)

end

function removeZone(selectedZone, zoneBlip, tableIndex, x, y, z)
    TriggerServerEvent('Server:deleteZone', selectedZone, zoneBlip, tableIndex, x, y, z)
end

RegisterNetEvent('Client:addZone')
AddEventHandler('Client:addZone', function(speed, radius, x, y, z)
    radius = radius + 0.0
    speed = speed + 0.0

    local blip = AddBlipForRadius(x, y, z, radius)
        SetBlipColour(blip,49)
        SetBlipAlpha(blip,80)
        SetBlipSprite(blip,9)
    local speedZone = AddRoadNodeSpeedZone(x, y, z, radius, speed, false)

    table.insert(zones, {x, y, z, speedZone, blip})

end)

RegisterNetEvent('Client:deleteZone')
AddEventHandler('Client:deleteZone', function(selectedZone, zoneBlip, tableIndex, x, y, z)

    local ppos = GetEntityCoords(GetPlayerPed(-1))
    if (Vdist(ppos.x, ppos.y, ppos.z, x, y, z) < 40) then
        RemoveRoadNodeSpeedZone(selectedZone)
        local blip = zones[tableIndex][5]
        RemoveBlip(blip)
        table.remove(zones, tableIndex)
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 255, 0},
            multiline = true,
            args = {"Scenemenu", "You are not within range of this zone."}
          })
    end

end)

RegisterNetEvent('Client:sendZones')
AddEventHandler('Client:sendZones', function(zonesArr)

    for _, zonedeets in ipairs(zonesArr) do
		
        local blip = AddBlipForRadius(zondeets.x, zondeets.y, zondeets.z, zondeets.radius)
            SetBlipColour(blip,49)
            SetBlipAlpha(blip,80)
            SetBlipSprite(blip,9)
        local speedZone = AddRoadNodeSpeedZone(zondeets.x, zondeets.y, zondeets.z, zondeets.radius, zondeets.speed, false)

        table.insert(zones, {x, y, z, speedZone, blip})

	end

end)