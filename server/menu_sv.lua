ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pe-menu:getData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cbData = {
        name    = xPlayer.getName(),
        money   = xPlayer.getMoney(),
        bank    = xPlayer.getAccount("bank").money,
        dob     = xPlayer.get('dateofbirth'),
        sex     = xPlayer.get('sex'),
        height  = xPlayer.get('height')
    }
    
    if xPlayer.get('sex') == 'm' then 
        cbData.sex = 'male' 
    else cbData.sex = 'female' 
    end
    
    cb(cbData)
end)
