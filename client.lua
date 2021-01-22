ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    while true do
        ESX.PlayerData = ESX.GetPlayerData()
    Citizen.Wait(1000)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsControlJustReleased(0, Config.Key) then
            AbrirMenuPersonal()
        end
    end
end)

local job = ESX.PlayerData.job.label
local jobgrade = ESX.PlayerData.job.grade_label

local testjob = ESX.PlayerData.job.name

function AbrirMenuPersonal()
    ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu', {
		title    = _U('personal_menu'),
		align    = 'right',
		elements = {
			{label = "Trabajo", value = 'job_player'},
            {label = job .. " - " .. jobgrade, value = 'admin_admin'},
			{label = _U('jugador_admin'), value = 'jugador_admin'},
            {label = "jobmenu test", value = 'job_menu'}
        }}, function(data, menu)
        if data.current.value == 'job_menu' then
            if ESX.PlayerData.job.name ~= nil then
                if testjob == 'police' then
                    print(testjob)
                elseif testjob == 'ambulance' then
                    print('ems')
                elseif testjob == 'taxi' then
                    print('Monte es mas tonto')
                elseif testjob == 'mechanic' then
                    print('ACP MEJOR MEcanico bombay')
                end
            end
        end
    end)
end





