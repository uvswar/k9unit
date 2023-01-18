k91 = nil
k91Name = nil
blipk91 = nil
selectedDogIndex = 1
currentDogIndex = 1
currentTypeIndex = 1
selectedTypeIndex = 1
animations = {
    ['Normal'] = {
        sit = {
            dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
            anim = "idle_b"
        },
        laydown = {
            dict = "creatures@rottweiler@amb@sleep_in_kennel@",
            anim = "sleep_in_kennel"
        },
        searchhit = {
            dict = "creatures@rottweiler@indication@",
            anim = "indicate_high"
        }
    }
}

function SearchPlayer(k91)
    local player, distance = Framework.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local ped = GetPlayerPed(player)
        local coords = GetEntityCoords(ped)
        local offsetOne = GetOffsetFromEntityInWorldCoords(ped, 1.0, -1.0, 0.0)
        TaskGoToCoordAnyMeans(k91, offsetOne.x, offsetOne.y, offsetOne.z, 5.0, 0, 0, 1, 10.0)
        Citizen.Wait(2000)
        local offsetTwo = GetOffsetFromEntityInWorldCoords(ped, 1.0, 1.0, 0.0)
        TaskGoToCoordAnyMeans(k91, offsetTwo.x, offsetTwo.y, offsetTwo.z, 5.0, 0, 0, 1, 10.0)
        Citizen.Wait(2000)
        local offsetThree = GetOffsetFromEntityInWorldCoords(ped, -1.0, 1.0, 0.0)
        TaskGoToCoordAnyMeans(k91, offsetThree.x, offsetThree.y, offsetThree.z, 5.0, 0, 0, 1, 10.0)
        Citizen.Wait(2000)
        local offsetFour = GetOffsetFromEntityInWorldCoords(ped, -1.0, -1.0, 0.0)
        TaskGoToCoordAnyMeans(k91, offsetFour.x, offsetFour.y, offsetFour.z, 5.0, 0, 0, 1, 10.0)
        Citizen.Wait(2000)
        local offsetFive = GetOffsetFromEntityInWorldCoords(ped, 0, -1.0, 0)
        TaskGoToCoordAnyMeans(k91, offsetFive.x, offsetFive.y, offsetFive.z, 5.0, 0, 0, 1, 10.0)
        Citizen.Wait(2000)
    
        TriggerServerEvent('k9unit:playerSearch', playerId)
    
        Framework.Functions.TriggerCallback('k9:searchPlayer', function(result)
            if result ~= nil then
                if result == true then
                    Framework.Functions.Notify(k91Name.." found something suspicious on player", "error", 7000)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "doggo", 0.3)
                    PlayAnimation(animations['Normal'].searchhit.dict, animations['Normal'].searchhit.anim)
                    Citizen.Wait(3000)
                    PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
                else
                    Framework.Functions.Notify(k91Name.." did not find anything in players pockets", "error", 7000)
                    PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
                end
            end
        end, playerId)
    end
end

function SearchTrunkVehicle(k91)
    local searching = false
    local veh = Framework.Functions.GetClosestVehicle()
    local coordA = GetEntityCoords(GetPlayerPed(-1), true)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)

    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 7.5 then
        if not searching then
            if Config.OpenDoors then
                SetVehicleDoorOpen(veh, 3, 0, 0)
                local offsetOne = GetOffsetFromEntityInWorldCoords(veh, 2.0, -2.0, 0.0)
                TaskGoToCoordAnyMeans(k91, offsetOne.x, offsetOne.y, offsetOne.z, 5.0, 0, 0, 1, 10.0)
                Citizen.Wait(7000)
                SetVehicleDoorShut(veh, 3, 0, 0)
                SetVehicleDoorOpen(veh, 1, 0, 0)
                local offsetTwo = GetOffsetFromEntityInWorldCoords(veh, 2.0, 2.0, 0.0)
                TaskGoToCoordAnyMeans(k91, offsetTwo.x, offsetTwo.y, offsetTwo.z, 5.0, 0, 0, 1, 10.0)
                Citizen.Wait(7000)
                SetVehicleDoorShut(veh, 1, 0, 0)
                SetVehicleDoorOpen(veh, 0, 0, 0)
                local offsetThree = GetOffsetFromEntityInWorldCoords(veh, -2.0, 2.0, 0.0)
                TaskGoToCoordAnyMeans(k91, offsetThree.x, offsetThree.y, offsetThree.z, 5.0, 0, 0, 1, 10.0)
                Citizen.Wait(7000)
                SetVehicleDoorShut(veh, 0, 0, 0)
                SetVehicleDoorOpen(veh, 2, 0, 0)
                local offsetFour = GetOffsetFromEntityInWorldCoords(veh, -2.0, -2.0, 0.0)
                TaskGoToCoordAnyMeans(k91, offsetFour.x, offsetFour.y, offsetFour.z, 5.0, 0, 0, 1, 10.0)
                Citizen.Wait(7000)
                SetVehicleDoorShut(veh, 2, 0, 0)

                SetVehicleDoorOpen(veh, 5, 0, 0)
                local offsetFive = GetOffsetFromEntityInWorldCoords(veh, 0, -2.1, 0)
                TaskGoToCoordAnyMeans(k91, offsetFive.x, offsetFive.y, offsetFive.z, 5.0, 0, 0, 1, 10.0)
                Citizen.Wait(7000)
                SetVehicleDoorShut(veh, 5, 0, 0)

                SetVehicleDoorsShut(veh, 0)
            end

            Framework.Functions.TriggerCallback('k9:getInfo', function(result)
                if result ~= nil then
                    for k, v in pairs(result) do
                        if isPresentTable(v.name) then
                            Framework.Functions.Notify(k91Name.." found something suspicious in the trunk", "error", 7000)
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "doggo", 0.3)
                            PlayAnimation(animations['Normal'].searchhit.dict, animations['Normal'].searchhit.anim)
                            Citizen.Wait(3000)
                            PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
                        end
                    end
                end
            end, plate)
        end
    end
end

function isPresentTable(name)
    for k, v in pairs(Config.Items) do
        if v == name then
            return true
        end
    end
    return false
end


RegisterCommand('att', function(source, args, rawCommand)
    if k91 then
        DetachEntity(k91)
        if args[1] then
            local target = GetPlayerPed(GetPlayerFromServerId(tonumber(args[1])))
            ClearPedTasks(k91)
            if IsEntityAPed(target) then
                TaskCombatPed(k91, target, 0, 16)
                while not IsPedDeadOrDying(target, true) do
                    SetPedMoveRateOverride(k91, 1.25)
                    Citizen.Wait(0)
                end
            end
        elseif IsPlayerFreeAiming(PlayerId()) then
            local _, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
            ClearPedTasks(k91)
            if IsEntityAPed(target) then
                TaskCombatPed(k91, target, 0, 16)
                while not IsPedDeadOrDying(target, true) do
                    SetPedMoveRateOverride(k91, 1.25)
                    Citizen.Wait(0)
                end
            end
        else
            local target = GetPedInFront()
            ClearPedTasks(k91)
            if IsEntityAPed(target) then
                TaskCombatPed(k91, target, 0, 16)
                while not IsPedDeadOrDying(target, true) do
                    SetPedMoveRateOverride(k91, 1.25)
                    Citizen.Wait(0)
                end
            end
        end
    end
end, false)


RegisterKeyMapping('dsu', 'Open DSU Menu', 'keyboard', 'f10')
RegisterKeyMapping('att', 'Dog Attack', 'keyboard', 'LControl')


function Command_Sit(ped)
    ClearPedTasks(ped)
    RequestAnimDict("creatures@rottweiler@amb@world_dog_sitting@base")
    while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_sitting@base") do
        Citizen.Wait(1)
    end
    TaskPlayAnim(ped, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -4.0, -1, 1, 0.0)
end

function Command_Follow(ped)
    ClearPedTasks(ped)
    DetachEntity(ped)

    TaskFollowToOffsetOfEntity(ped, GetPlayerPed(-1), 0.5, 0.0, 0.0, 7.0, -1, 0.2, true)
end

function Command_Bark(ped)
    ClearPedTasks(ped)
    RequestAnimDict("creatures@retriever@amb@world_dog_barking@base")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5.0, "doggo", 0.1)
    while not HasAnimDictLoaded("creatures@retriever@amb@world_dog_barking@base") do
        Citizen.Wait(1)
    end
    TaskPlayAnim(ped, "creatures@retriever@amb@world_dog_barking@base", "base", 8.0, -4.0, -1, 1, 0.0)
end

function Command_Lay(ped)
    ClearPedTasks(ped)
    RequestAnimDict("creatures@rottweiler@amb@sleep_in_kennel@")
    while not HasAnimDictLoaded("creatures@rottweiler@amb@sleep_in_kennel@") do
        Citizen.Wait(1)
    end
    TaskPlayAnim(ped, "creatures@rottweiler@amb@sleep_in_kennel@", "sleep_in_kennel", 8.0, -4.0, -1, 1, 0.0)
end

function Command_StartTrack(dog, player)
    local target = GetPlayerPed(GetPlayerFromServerId(tonumber(player)))
    TaskFollowToOffsetOfEntity(dog, target, 0.5, 0.0, 0.0, 6.0, -1, 0.2, true)
end

function EnterVehicle(ped)

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        ClearPedTasks(ped)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local vehHeading = GetEntityHeading(vehicle)
        TaskGoToEntity(ped, vehicle, -1, 0.5, 100, 1073741824, 0)
        TaskAchieveHeading(ped, vehHeading, -1)
        RequestAnimDict("creatures@rottweiler@in_vehicle@van")
        RequestAnimDict("creatures@rottweiler@amb@world_dog_sitting@base")
        while not HasAnimDictLoaded("creatures@rottweiler@in_vehicle@van") or not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_sitting@base") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, "creatures@rottweiler@in_vehicle@van", "get_in", 8.0, -4.0, -1, 2, 0.0)
        Citizen.Wait(700)
        ClearPedTasks(ped)
        AttachEntityToEntity(ped, vehicle, GetEntityBoneIndexByName(vehicle, Config.VehicleBone), 0.0, 0.0, 0.25)
        TaskPlayAnim(ped, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -4.0, -1, 2, 0.0)
    else
        AdvancedNotification('CHAR_FLOYD', 'uber', 7, "~g~XD", "K9 Unit", "You must be inside a vehicle!")
    end
end

function ExitVehicle(ped)
    local vehicle = GetEntityAttachedTo(ped)
    local vehPos = GetEntityCoords(vehicle)
    local forwardX = GetEntityForwardVector(vehicle).x * 3.7
    local forwardY = GetEntityForwardVector(vehicle).y * 3.7
    local _, groundZ = GetGroundZFor_3dCoord(vehPos.x, vehPos.y, vehPos.z, 0)
    ClearPedTasks(ped)
    DetachEntity(ped)
    SetEntityCoords(ped, vehPos.x - forwardX, vehPos.y - forwardY, groundZ)
    Command_Follow(ped)
end

function DismissDog(ped)
    ClearPedTasks(ped)
    DeletePed(ped)
    blipk91 = nil
    k91 = nil
    k91Name = nil
    RemoveBlip(blipk91)
end

function AdvancedNotification(icon1, icon2, type, sender, title, text) -- Function to display a notification with image.
    Framework.Functions.Notify(text)
    --[[Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        SetNotificationMessage(icon1, icon2, true, type, sender, title, text)
        DrawNotification(false, true)
        Citizen.Wait(60000)
    end)]]
end

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 2.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

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

function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, GetPlayerPed(-1), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function TablePrint(t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            TablePrint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end

function PlayAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(k91, dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end