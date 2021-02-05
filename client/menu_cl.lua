ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(12)
		if IsControlJustReleased(0, Config.Key) then 
			AbrirPersonalMenu()
		end 
	end
end)

function AbrirPersonalMenu()
    ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu', {
		title    = _U('personal_menu'),
		align    = 'bottom-right',
		elements = {
            {label = _U('personal_info'), value = 'personal_info'},
            {label = _U('documents_info'), value = 'documents_info'},
            {label = _U('actions_info'), value = 'actions_info'},
            {label = _U('gps_info'), value = 'gps_info'},
            {label = _U('car_info'), value = 'car_info'}
        }}, function(data, menu)
        if data.current.value == 'personal_info' then
        ESX.TriggerServerCallback('pe-menu:getData', function(receivedData)
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_info', {
                title    = _U('personal_info'),
                align    = 'bottom-right',
                elements = {
                    {label = _U('identity_label'), value = 'identity_label'},
                    {label = _U('job_label') .. ESX.PlayerData.job.label, value = 'job_label'},
                    {label = _U('job_grade_label') .. ESX.PlayerData.job.grade_label, value = 'job_grade_label'},
                    {label = _U('money_label') .. receivedData.money, value = 'money_label'},
                    {label = _U('bank_label') .. receivedData.bank, value = 'bank_label'},
                    {label = _U('boss_label'), value = 'boss_label'}
                }}, function(data2, menu2)
                if data2.current.value == 'identity_label' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'identity_menu', {
                        title    = _U('identity_label'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('real_name_label') .. receivedData.name, value = 'real_name_label'},
                            {label = _U('dob_label') .. receivedData.dob, value = 'dob_label'},
                            {label = _U('height_label', receivedData.height), value = 'height_label'},
                            {label = _U('sex_label') .. receivedData.sex, value = 'sex_label'}
                        }}, function(data3, menu3)
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'job_label' then
                elseif data2.current.value == 'job_grade_label' then
                elseif data2.current.value == 'money_label' then
                elseif data2.current.value == 'bank_label' then
                elseif data2.current.value == 'boss_label' and ESX.PlayerData.job.grade_name == 'boss' then
                ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_label', {
                        title    = _U('personal_menu'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('society_label') .. money, value = 'society_label'}
                        }}, function(data3, menu3)
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                
                end, ESX.PlayerData.job.name)
                else
                    if Config.Tnotify then
                        exports['t-notify']:Alert({
                            style  =  'error',
                            message  =  _U('no_bosst')
                        })
                    elseif Config.ESX then
                    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                        ESX.ShowAdvancedNotification(_U('no_company') .. ESX.PlayerData.job.label, _('no_player') .. receivedData.name, _U('no_boss'), mugshotStr, 2)
                        UnregisterPedheadshot(mugshot)
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end)
        elseif data.current.value == 'documents_info' then
        ESX.TriggerServerCallback('pe-menu:getData', function(receivedData)
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'documents_info', {
                title    = _U('documents_menu'),
                align    = 'bottom-right',
                elements = {
                    {label = _U('view_id'), value = 'view_id'},
                    {label = _U('show_id'), value = 'show_id'},
                    {label = _U('view_driving'), value = 'view_driving'},
                    {label = _U('show_driving'), value = 'show_driving'},
                    {label = _U('view_gun'), value = 'view_gun'},
                    {label = _U('show_gun'), value = 'show_gun'},
                }}, function(data2, menu2)
                local player, distance = ESX.Game.GetClosestPlayer()
                if data2.current.value == 'view_id' then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                elseif data2.current.value == 'show_id' then
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                    end
                elseif data2.current.value == 'view_driving' then
                    riggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                elseif data2.current.value == 'show_driving' then
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                    end
                elseif data2.current.value == 'view_gun' then
                    riggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                elseif data2.current.value == 'show_gun' then
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                    end
                end   
            end, function(data2, menu2)
                menu2.close()
            end) 
        end)
        elseif data.current.value == 'actions_info' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'actions_menu', {
                title    = _U('actions_menu'),
                align    = 'bottom-right',
                elements = {
                    {label = _U('carry_total_label'), value = 'carry_total_label'},
                    {label = _U('hostage_label'), value = 'hostage_label'}
                }}, function(data2, menu2)
                if data2.current.value == 'carry_total_label' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'carry_menu', {
                        title    = _U('carry_menu'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('carry1_label'), value = 'carry1_label'},
                            {label = _U('carry2_label'), value = 'carry2_label'},
                            {label = _U('carry3_label'), value = 'carry3_label'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'carry1_label' then
                        
                        elseif data3.current.value == 'carry2_label' then

                        elseif data3.current.value == 'carry3_label' then

                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'hostage_label' then

                end
            end, function(data3, menu2)
                menu2.close()
            end)
        elseif data.current.value == 'gps_info' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gps_menu', {
                title    = _U('gps_menu'),
                align    = 'bottom-right',
                elements = {
                    {label = _U('hospital_gps'), value = 'hospital_gps'},
                    {label = _U('police_gps'), value = 'police_gps'},
                    {label = _U('mechanic_gps'), value = 'mechanic_gps'},
                    {label = _U('popular_gps'), value = 'popular_gps'},
                    {label = _U('cancel_gps'), value = 'cancel_gps'}
                }}, function(data2, menu2)
                if data2.current.value == 'hospital_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'hospital_gps_menu', {
                        title    = _U('hospital_gps_menu'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('hospital1_gps'), value = 'hospital1_gps'},
                            {label = _U('hospital2_gps'), value = 'hospital2_gps'},
                            {label = _U('hospital2_gps'), value = 'hospital2_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'hospital1_gps' then
                            
                        elseif data3.current.value == 'hospital2_gps' then
                            
                        elseif data3.current.value == 'hospital3_gps' then
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'police_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_gps_menu', {
                        title    = _U('police_gps_menu'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('police1_gps'), value = 'police1_gps'},
                            {label = _U('police2_gps'), value = 'police2_gps'},
                            {label = _U('police2_gps'), value = 'police2_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'police1_gps' then
                            
                        elseif data3.current.value == 'police2_gps' then
                            
                        elseif data3.current.value == 'police3_gps' then
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'mechanic_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_gps_menu', {
                        title    = _U('mechanic_gps_menu'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('mechanic1_gps'), value = 'mechanic1_gps'},
                            {label = _U('mechanic2_gps'), value = 'mechanic2_gps'},
                            {label = _U('mechanic2_gps'), value = 'mechanic2_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'mechanic1_gps' then
                            
                        elseif data3.current.value == 'mechanic2_gps' then
                            
                        elseif data3.current.value == 'mechanic3_gps' then
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'popular_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'popular_gps_menu', {
                        title    = _U('popular_gps_menu'),
                        align    = 'bottom-right',
                        elements = {
                            {label = _U('popular1_gps'), value = 'popular1_gps'},
                            {label = _U('popular2_gps'), value = 'popular2_gps'},
                            {label = _U('popular2_gps'), value = 'popular2_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'popular1_gps' then
                            
                        elseif data3.current.value == 'popular2_gps' then
                            
                        elseif data3.current.value == 'popular3_gps' then
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'cancel_gps' then
                    SetWaypointOff()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif data.current.value == 'car_info' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_menu', {
                title    = _U('car_menu'),
                align    = 'bottom-right',
                elements = {
                    {label = _U('doors_label'), value = 'doors_label'},
                    {label = _U('keys_label'), value = 'keys_label'},
                    {label = _U('something_label'), value = 'something_label'},
                    {label = _U('cars_label'), value = 'popular_gps'}
                }}, function(data2, menu2)
                if data2.current.value == 'doors_label' then
                elseif data2.current.value == 'keys_label' then
                elseif data2.current.value == 'something_label' then
                elseif data2.current.value == 'cars_label' then
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end
	end, function(data, menu)
		menu.close()
	end)
end

--Updating the jobs and info
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
