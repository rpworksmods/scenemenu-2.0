--[[ MAIN MENU ]]--
	local SceneMenu = RageUI.CreateMenu("", "Scene Menu v2.0",0,0,"dhcore","dragonhive");
	SceneMenu.EnableMouse = false;
--

--[[ Create submenus ]]--
	local objectPlace = RageUI.CreateSubMenu(SceneMenu, "", "Scene Menu v2.0")
	local editNodes = RageUI.CreateSubMenu(SceneMenu, "", "Scene Menu v2.0")
	local controlZones = RageUI.CreateSubMenu(SceneMenu, "", "Scene Menu v2.0")
		local zonesExist = RageUI.CreateSubMenu(controlZones, "", "Scene Menu v2.0")
		local zoneAdd = RageUI.CreateSubMenu(controlZones, "", "Scene Menu v2.0")
--

--[[ Global Variables ]]--
	local ListIndex = 1;
	local ListIndex2 = 1;
	local displayNames = {}

	zones = {}
	local zoneRange = "5"
	local zoneSpeed = "30"
--

--[[ Create New Arrays for objects ]]--
	for _, arr in ipairs(Config.Props) do
		table.insert(displayNames, arr.Display)
	end
--

--[[ MENU POOL ]]--
	function RageUI.PoolMenus:Example()
		SceneMenu:IsVisible(function(Items)

			Items:AddButton("Place Objects", "Place cones, barriers and tape", { IsDisabled = false }, function(onSelected) 
			end, objectPlace)
			Items:AddButton("Edit Nodes", "Edit the traffic nodes", { IsDisabled = false }, function(onSelected) 
			end, editNodes)
			Items:AddButton("Control Zones", "Set speed or avoidance zones", { IsDisabled = false }, function(onSelected) 
			end, controlZones)

		end, function() end)
	--[[ OBJECT PLACING MENU ]]--
		objectPlace:IsVisible(function(Items)
			Items:AddList("Object", displayNames, ListIndex, nil, { IsDisabled = false }, function(Index, onSelected, onListChange)
				if (onListChange) then
					ListIndex = Index;
				end
				if (onSelected) then
					createObject(Config.Props[Index]['Prop'], Config.Props[Index]['stopPeds'])
				end
			end)

			-- DELETE NEAREST OBJECT
			Items:AddButton("Delete Closest", "Remove the closest object", {IsDisabled = false}, function(onSelected)
				if (onSelected) then
					removeNearestProp()
				end
			end)

		end, function() end)



	--[[ EDIT NODES ]]--
		editNodes:IsVisible(function(Items)
			-- Show all nodes in radius.
			showNodes()

			-- Toggle Nearest Node Button
			Items:AddButton("Toggle Nearest", "Toggle the nearest node on/off", {IsDisabled = false}, function(onSelected)
				if onSelected then
					toggleNode()
				end
			end)
			
		end, function() end)
	--[[ CONTROL ZONES ]]--
		controlZones:IsVisible(function(Items)
			Items:AddButton("Add Zone", "Add a new control zone", { IsDisabled = false }, 
			function(onSelected) 
				
			end, zoneAdd)

			Items:AddButton("Existing Zones", "Edit or remove existing zones", { IsDisabled = false }, 
			function(onSelected) 
			
			end, zonesExist)

		end, function() end)

		zonesExist:IsVisible(function(Items)
			for id, values in ipairs(zones) do
				Items:AddButton("Zone #"..id, "REMOVE the selected zone", {IsDisabled = false}, function(onSelected)
					if onSelected then
						removeZone(values[4], values[5], id, values[1], values[2], values[3])
					end
				end)
			end
		end, function() end)

		zoneAdd:IsVisible(function(Items)

			showZone(zoneRange, zoneSpeed)

			Items:AddButton("Range: " .. zoneRange, "Change the size of the radius", { IsDisabled = false }, 
			function(onSelected) 
				if onSelected then
					zoneRange = KeyboardInput("Enter Range (1-125)", zoneRange, 3)
				end
			end)

			Items:AddButton("Speed: " .. zoneSpeed, "Change the speed within the radius", { IsDisabled = false }, 
			function(onSelected) 
				if onSelected then
					zoneSpeed = KeyboardInput("Enter Speed (0-120)", zoneSpeed, 3)
				end
			end)
			
			Items:AddButton("Create", "Create the zone", { IsDisabled = false }, 
			function(onSelected) 
				if onSelected then
					createZone(zoneRange, zoneSpeed)
				end
			end)
			
		end, function() end)

	end
------

--[[ OPENING MENU ]]--
	Keys.Register(Config.MenuKey, Config.MenuKey, "Scenemenu", function()
		if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			RageUI.Visible(SceneMenu, not RageUI.Visible(SceneMenu))
		end
	end)

	RegisterCommand("scenemenu", function(source, args, rawCommand)
		-- normal function handling here
	end, true) -- set this to false to allow anyone.

--[[ GLOBAL FUNCTIONS ]]--

	function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

		-- TextEntry		-->	The Text above the typing field in the black square
		-- ExampleText		-->	An Example Text, what it should say in the typing field
		-- MaxStringLenght	-->	Maximum String Lenght

		AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
		blockinput = true --Blocks new input while typing if **blockinput** is used

		while (UpdateOnscreenKeyboard() == 0) do --While typing is not aborted and not finished, this loop waits
			DisableAllControlActions(0);
			Citizen.Wait(0)
		end
			
		if UpdateOnscreenKeyboard() ~= 2 then
			local result = GetOnscreenKeyboardResult() --Gets the result of the typing
			Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
			blockinput = false --This unblocks new Input when typing is done
			return result --Returns the result
		else
			Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
			blockinput = false --This unblocks new Input when typing is done
			return nil --Returns nil if the typing got aborted
		end
	end

	local firstSpawn = true

	AddEventHandler('playerSpawned', function() -- Triggered when a player is spawned
		if firstSpawn then
			TriggerServerEvent('Server:getZones')
		else
			firstSpawn = false
		end
	end)