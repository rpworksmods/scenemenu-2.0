objectsSpawned = {}


local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
  
Citizen.CreateThread(function()
  while true do
    for k,v in ipairs(objectsSpawned) do
      if DoesEntityExist(v) then
        checkIsPedNearObject(v)
      end
    end
    Wait(100)
  end
end)

function checkIsPedNearObject(object)

  local nearPeds = {}

  for ped in EnumeratePeds() do
    local pos = GetEntityCoords(ped)
    local obPos = GetEntityCoords(object)

    if Vdist(pos.x, pos.y, pos.z, obPos.x, obPos.y, obPos.z) <= 2.0 then
      if not IsPedAPlayer(ped) and not IsPedInAnyVehicle(ped, true) then
        local anim = Config.Anims[math.random(1, #Config.Anims)]
        playAnim(ped, anim.Dict, anim.Anim)
      end
    end
  end

end

function playAnim(ped, dict, anim)
  local isPlaying = false

  for _,v in ipairs(Config.Anims) do
    if IsEntityPlayingAnim(ped, v.Dict, v.Anim, 3) then
      isPlaying = true
    end
  end
  if not isPlaying then
    ClearPedTasksImmediately(ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(0)
    end
    if HasAnimDictLoaded(dict) then
      TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 9, 1.0, 0, 0, 0)
    end
  end
end

  --[[Usage:
  for ped in EnumeratePeds() do
    <do something with 'ped'>
  end
  ]]