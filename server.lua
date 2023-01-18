
Framework.Functions.CreateCallback('k9:searchPlayer', function(source, cb, serverid) 
    print('k9unit:playerSearch', serverid)
    serverid = tonumber(serverid)
    local src = source
    local Player = Framework.Functions.GetPlayer(serverid)
    local retval = false
    if Player ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if isPresentTable(v.name) then
                    retval = true
                    TriggerClientEvent('QBCore:Notify', src, "K9 found something suspicious in the pockets of ID : "..serverid)
                end
            end
        end
        cb(retval)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Invalid Player', 'errror')
    end
end)

function isPresentTable(name)
    for k, v in pairs(Config.Items) do
        if v == name then
            return true
        end
    end
    return false
end