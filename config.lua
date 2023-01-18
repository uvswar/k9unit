Config = {}

Config.VehicleBone = "seat_pside_r" -- Set to vehicle seat bone you'd like your pooch to sit                          in when entering a vehicle. Default: Rear right seat.

Config.Framework = "new" -- new (qbcore) or leave it empty for old qbus frameworks (make sure you add your own trigger at bottom).

Config.OpenDoors = false -- true/false

Config.Items = { -- list of item that doggo will find suspicious 
    [1] = "packagedweed",             
    [2] = "weed_package",         
    [3] = "weed_brick",       
    [4] = "weed",          
    [5] =  "coke_raw",           
    [6] = "coke_pure",          
    [7] = "coke_figure",        
    [8] = "cokebaggy",        
    [9] = "meth",  
    [10] = "blue_meth",               
    [11] = "meth_sharp",         
    [12] = "meth_bag",              
    [13] = "meth_glass",     
    [14] = "heroin_1oz",          
    [15] = "heroinbaggy",              
    [16] = "morphine",       
    [17] = "crack_baggy",         
    [18] = "xtcbaggy",          
    [19] = "poppyplant",             
    [20] = "heroin",           
    [21] = "crack",          
    [22] = "oxy",
 
}

if Config.Framework == "new" then
    Framework = exports['qb-core']:GetCoreObject()
else
    Framework = nil 
    Citizen.CreateThread(function() 
        while Framework == nil do 
            TriggerEvent('QBCore:GetObject', function(obj) Framework = obj end) 
            Citizen.Wait(0) 
        end 
    end)
end
