ESX = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

openMenu = function()
    table.insert(elements, {label = 'Carry', value = 'ponerhud'})
    table.insert(elements, {label = 'Carry2', value = 'ponerhud'})
    table.insert(elements, {label = 'Ocultar HUD', value = 'hud'})


    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_menu', {
        title = 'Menu de Acciones',
        align = 'bottom-right',
        elements = elements
    }, function(data, menu)

        local val = data.current.value

        if val == 'Cargar' then
            ExecuteCommand(Config.ComandoCargar1) 
        elseif val == 'Caballito' then
            ExecuteCommand(Config.ComandoCargar2)
        elseif val == 'Rehen' then
            ExecuteCommand(Config.ComandoRehen)

        end
    end, function(data, menu) menu.close() end)
