dogBreeds = {'Rottweiler', 'Husky', 'Retriever', 'Shepherd'}
dogBHash = {'a_c_rottweiler', 'a_c_husky', 'a_c_retriever', 'a_c_shepherd'}
dogTypes = {'Search', 'General Purpose'}

RegisterCommand('dsu', function()
    -- add police checks here
    if Framework.Functions.GetPlayerData().job.name == "police" or Framework.Functions.GetPlayerData().job.name == "sasp" then
        WarMenu.OpenMenu('maink9')
    else
        Framework.Functions.Notify("Not authorized", "error")
    end
end, false)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('maink9', 'K9 Unit')
    WarMenu.SetSubTitle('maink9', "by TIBUSRP")
    while true do
        if WarMenu.IsMenuOpened('maink9') then
            if k91 == nil then
                local lmao = k91Name ~= nil and k91Name or 'Set Name'
                if WarMenu.Button('K9 Name', lmao) then
                    local dialog = exports['qb-input']:ShowInput({
                        header = 'K9 Unit Name',
                        submitText = "",
                        inputs = {
                            {
                                type = 'text',
                                isRequired = true,
                                name = 'dogname',
                                text = 'Example : Tommy'
                            }
                        }
                    })
                    if dialog then
                        if not dialog then return end
                        k91Name = dialog.dogname
                    else
                        Framework.Functions.Notify("Type in something", "error", 3000)
                    end
                elseif WarMenu.ComboBox('Breed', dogBreeds, currentDogIndex, selectedDogIndex, function(currentIndex, selectedIndex) currentDogIndex = currentIndex selectedDogIndex = selectedIndex end) then

                elseif WarMenu.Button('Spawn K9') then
                    if not k91Name then
                        AdvancedNotification('CHAR_FLOYD', 'uber', 7, "~g~XDDev", "K9 Unit", "Must set dog name!")
                    else

                        RequestModel(GetHashKey(dogBHash[currentDogIndex]))
                        while not HasModelLoaded(GetHashKey(dogBHash[currentDogIndex])) do
                            Citizen.Wait(1)
                        end

                        local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
                        local heading = GetEntityHeading(GetPlayerPed(-1))
                        local _, groundZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z, false);

                        k91 = CreatePed(28, GetHashKey(dogBHash[currentDogIndex]), pos.x, pos.y, groundZ + 1, heading, true, true)

                        GiveWeaponToPed(k91, GetHashKey('WEAPON_ANIMAL'), true, true)
                        TaskSetBlockingOfNonTemporaryEvents(k91, true)
                        SetPedFleeAttributes(k91, 0, false)
                        SetPedCombatAttributes(k91, 3, true)
                        SetPedCombatAttributes(k91, 5, true)
                        SetPedCombatAttributes(k91, 46, true)

                        blipk91 = AddBlipForEntity(k91)
                        SetBlipAsFriendly(blipk91, true)
                        SetBlipDisplay(blipk91, 2)
                        SetBlipShowCone(blipk91, true)
                        SetBlipAsShortRange(blipk91, false)
                        
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(k91Name)
                        EndTextCommandSetBlipName(blipk91)

                        Command_Follow(k91)
                    end
                end
            else
                if IsPedDeadOrDying(k91, true) then
                    AdvancedNotification('CHAR_FLOYD', 'uber', 7, "~g~XD", "K9 Unit", k91Name .. " has been killed!")
                    k91 = nil
                    k91Name = nil
                    blipk91 = nil
                    RemoveBlip(blipk91)
                end

                if WarMenu.Button('Sit/Stay') then
                    Command_Sit(k91)
                elseif WarMenu.Button('Follow/Recall') then
                    Command_Follow(k91)
                elseif WarMenu.Button('Bark') then
                    Command_Bark(k91)
                elseif WarMenu.Button('Lay Down') then
                    Command_Lay(k91)
                elseif WarMenu.Button('Track') then
                    local id = KeyboardInput("Target Player's ID", "", 2)
                    Command_StartTrack(k91, id)
                elseif WarMenu.Button('Enter Vehicle') then
                    EnterVehicle(k91)
                elseif WarMenu.Button('Exit Vehicle') then
                    ExitVehicle(k91)
                elseif WarMenu.Button('Dismiss') then
                    DismissDog(k91)
                end

                if WarMenu.Button('Search Vehicle\'s Trunk') then
                    SearchTrunkVehicle(k91)
                end   
                if WarMenu.Button('Search Person') then
                    SearchPlayer(k91)
                end             
            end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)