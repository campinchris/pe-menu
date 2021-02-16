ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pe-menu:getData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cbData = {
        name    = xPlayer.getName(),
        money   = xPlayer.getMoney(),
        bank    = xPlayer.getAccount('bank').money,
        black   = xPlayer.getAccount('black_money').money,
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


ESX.RegisterServerCallback('phone', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result =  MySQL.Async.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    })

    if result[1] ~= nil then
        phone = result[1]['phone_number']
    else
        phone = result[1]['phone_number']
    end
    
end)
