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
    local id = GetPlayerServerId(PlayerId())
    local elements = {}
    local ped = GetPlayerPed(-1)
    local trabajoActual = PlayerData.job.label
    local JobGrade = PlayerData.job.grade_label
    local JobGradeName = PlayerData.job.grade_name
    local name = GetPlayerName(PlayerId())
    
    table.insert(elements, {label = 'Carry', value = 'carry'})
    table.insert(elements, {label = 'Caballito', value = 'carry2'})
    table.insert(elements, {label = 'Rehen', value = 'th'})

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
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.Key) then
            openMenu()
        end
    end
end)


