function createObject(object_model, ped_stop)
    local in_pos = false
    Citizen.CreateThread(function()
        RequestModel(object_model)
        local iter_for_request = 1
        while not HasModelLoaded(object_model) and iter_for_request < 5 do
            Citizen.Wait(500)				
            iter_for_request = iter_for_request + 1
        end
        if not HasModelLoaded(object_model) then
            SetModelAsNoLongerNeeded(object_model)
        else
            local ped = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(ped))
            local created_object = CreateObject(object_model, x, y, z, true, true, false)
            SetEntityHeading(created_object, GetEntityHeading(ped))
            PlaceObjectOnGroundProperly_2(created_object) 
            FreezeEntityPosition(created_object,true)
            SetModelAsNoLongerNeeded(object_model)
            SetEntityAsMissionEntity(created_object, false, false)

            if ped_stop then
                table.insert(objectsSpawned, created_object)
            end
        end
    end)
end

function removeNearestProp()
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))

    for _,v in pairs(Config.Props) do 
        local hash = GetHashKey(v.Prop)
        if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, hash, true) then
            local object = GetClosestObjectOfType(x, y, z, 0.9, hash, false, false, false)
            SetEntityAsMissionEntity(object, true, true)
            local netId = NetworkGetNetworkIdFromEntity(object)
            print("NetID = " .. netId)
            TriggerServerEvent("Server:removeProp", netId)
           -- DeleteObject(object)
            --Citizen.InvokeNative( 0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized( object ) )
        end
    end
end

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

RegisterNetEvent("Client:removeProp")
AddEventHandler('Client:removeProp', function(netId)

    local object = NetworkGetEntityFromNetworkId(netId)
    DeleteObject(object)
end)