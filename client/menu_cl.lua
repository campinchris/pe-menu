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

--Command/Opening Menu (START)
RegisterCommand(Config.Command, function()
    AbrirPersonalMenu()
end)

RegisterKeyMapping(Config.Command, Config.Suggestion, 'keyboard', Config.Key)
--Command/Opening Menu (END)

function AbrirPersonalMenu()
    ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu', {
		title    = _U('personal_menu'),
		align    = Config.Align,
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
                align    = Config.Align,
                elements = {
                    {label = _U('identity_label'), value = 'identity_label'},
                    {label = _U('job_label') .. ESX.PlayerData.job.label, value = 'job_label'},
                    {label = _U('job_grade_label') .. ESX.PlayerData.job.grade_label, value = 'job_grade_label'},
                    {label = _U('money_label') .. receivedData.money, value = 'money_label'},
                    {label = _U('bank_label') .. receivedData.bank, value = 'bank_label'},
                    {label = _U('black_label') .. receivedData.black, value = 'black_label'},
                    {label = _U('boss_label'), value = 'boss_label'}
                }}, function(data2, menu2)
                if data2.current.value == 'identity_label' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'identity_menu', {
                        title    = _U('identity_label'),
                        align    = Config.Align,
                        elements = {
                            {label = _U('real_name_label') .. receivedData.name, value = 'real_name_label'},
                            {label = _U('dob_label') .. receivedData.dob, value = 'dob_label'},
                            {label = _U('height_label', receivedData.height), value = 'height_label'},
                            {label = _U('sex_label') .. receivedData.sex, value = 'sex_label'},
                            {label = _U('phone_label') .. receivedData.phone, value = 'phone_label'} -- REMOVE THIS IF YOU DON't WANT A PHONE NUMBER
                        }}, function(data3, menu3)
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'job_label' then
                elseif data2.current.value == 'job_grade_label' then
                elseif data2.current.value == 'money_label' then
                elseif data2.current.value == 'bank_label' then
                elseif data2.current.value == 'black_label' then
                elseif data2.current.value == 'boss_label' and ESX.PlayerData.job.grade_name == 'boss' then
                ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_label', {
                        title    = _U('personal_menu'),
                        align    = Config.Align,
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
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'documents_menu', {
                title    = _U('documents_menu'),
                align    = Config.Align,
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
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                elseif data2.current.value == 'show_driving' then
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                    end
                elseif data2.current.value == 'view_gun' then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
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
                align    = Config.Align,
                elements = {
                    {label = _U('carry_total_label'), value = 'carry_total_label'},
                    {label = _U('hostage_label'), value = 'hostage_label'}
                }}, function(data2, menu2)
                if data2.current.value == 'carry_total_label' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'carry_menu', {
                        title    = _U('carry_menu'),
                        align    = Config.Align,
                        elements = {
                            {label = _U('carry1_label'), value = 'carry1_label'},
                            {label = _U('carry2_label'), value = 'carry2_label'},
                            {label = _U('carry3_label'), value = 'carry3_label'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'carry1_label' then
                            print(cb)
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
                align    = Config.Align,
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
                        align    = Config.Align,
                        elements = {
                            {label = _U('hospital1_gps'), value = 'hospital1_gps'},
                            {label = _U('hospital2_gps'), value = 'hospital2_gps'},
                            {label = _U('hospital3_gps'), value = 'hospital3_gps'},
                            {label = _U('hospital4_gps'), value = 'hospital4_gps'},
                            {label = _U('hospital5_gps'), value = 'hospital5_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'hospital1_gps' then
                            SetNewWaypoint(-448.0627, -368.7392)
                        elseif data3.current.value == 'hospital2_gps' then
                            SetNewWaypoint(287.4261, -1432.935)
                        elseif data3.current.value == 'hospital3_gps' then
                            SetNewWaypoint(294.7604, -584.6452)
                        elseif data3.current.value == 'hospital4_gps' then
                            SetNewWaypoint(1822.444, 3704.041)
                        elseif data3.current.value == 'hospital5_gps' then
                            SetNewWaypoint(-226.9244, 6311.925)
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'police_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_gps_menu', {
                        title    = _U('police_gps_menu'),
                        align    = Config.Align,
                        elements = {
                            {label = _U('police1_gps'), value = 'police1_gps'},
                            {label = _U('police2_gps'), value = 'police2_gps'},
                            {label = _U('police3_gps'), value = 'police3_gps'},
                            {label = _U('police4_gps'), value = 'police4_gps'},
                            {label = _U('police5_gps'), value = 'police5_gps'},
                        }}, function(data3, menu3)
                        if data3.current.value == 'police1_gps' then
                            SetNewWaypoint(396.0367, -987.3233)
                        elseif data3.current.value == 'police2_gps' then
                            SetNewWaypoint(-1135.616, -797.5247)
                        elseif data3.current.value == 'police3_gps' then
                            SetNewWaypoint(-552.7764, -148.75)
                        elseif data3.current.value == 'police4_gps' then
                            SetNewWaypoint(1862.641, 3673.064)
                        elseif data3.current.value == 'police5_gps' then
                            SetNewWaypoint(-422.0291, 6031.589)
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'mechanic_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_gps_menu', {
                        title    = _U('mechanic_gps_menu'),
                        align    = Config.Align,
                        elements = {
                            {label = _U('mechanic1_gps'), value = 'mechanic1_gps'},
                            {label = _U('mechanic2_gps'), value = 'mechanic2_gps'},
                            {label = _U('mechanic3_gps'), value = 'mechanic3_gps'},
                            {label = _U('mechanic4_gps'), value = 'mechanic4_gps'},
                            {label = _U('mechanic5_gps'), value = 'mechanic5_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'mechanic1_gps' then
                            SetNewWaypoint(-342.1648, -183.0016)
                        elseif data3.current.value == 'mechanic2_gps' then
                            SetNewWaypoint(-1121.156, -1979.522)
                        elseif data3.current.value == 'mechanic3_gps' then
                            SetNewWaypoint(-288.7803, -1306.617)
                        elseif data3.current.value == 'mechanic4_gps' then
                            SetNewWaypoint(1207.492, 2668.924)
                        elseif data3.current.value == 'mechanic5_gps' then
                            SetNewWaypoint(160.8258, 6616.02)
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'popular_gps' then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'popular_gps_menu', {
                        title    = _U('popular_gps_menu'),
                        align    = Config.Align,
                        elements = {
                            {label = _U('popular1_gps'), value = 'popular1_gps'},
                            {label = _U('popular2_gps'), value = 'popular2_gps'},
                            {label = _U('popular3_gps'), value = 'popular3_gps'},
                            {label = _U('popular4_gps'), value = 'popular4_gps'},
                            {label = _U('popular5_gps'), value = 'popular5_gps'}
                        }}, function(data3, menu3)
                        if data3.current.value == 'popular1_gps' then
                            SetNewWaypoint(238.1786, -828.3581)
                        elseif data3.current.value == 'popular2_gps' then
                            SetNewWaypoint(-1180.5, -1507.285)
                        elseif data3.current.value == 'popular3_gps' then
                            SetNewWaypoint(-1170.425, -893.6588)
                        elseif data3.current.value == 'popular4_gps' then
                            SetNewWaypoint(1987.305, 3069.15)
                        elseif data3.current.value == 'popular5_gps' then
                            SetNewWaypoint(-568.1664, 268.4626)
                        end
                    end, function(data3, menu3)
                        menu3.close()
                    end)
                elseif data2.current.value == 'cancel_gps' then
                    local blip = GetFirstBlipInfoId(8)
                    if (blip ~= nil and blip ~= 0) then
                        DeleteWaypoint()

                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'info',
                                message  =  _U('blip_no')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('blip_no'), false, false, 90)
                        end
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif data.current.value == 'car_info' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_menu', {
                title    = _U('car_menu'),
                align    = Config.Align,
                elements = {
                    {label = _U('veh_info'), value = 'veh_info'},
                    {label = _U('neons_info'), value = 'neons_info'},
                    {label = _U('seats_info'), value = 'seats_info'},
                    {label = _U('doors_info'), value = 'doors_info'},
                    {label = _U('windows_info'), value = 'windows_info'},
                    {label = _U('autopilot_label'), value = 'autopilot_label'}
                }}, function(data2, menu2)
                if data2.current.value == 'veh_info' then
                    if IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'veh_menu', {
                            title    = _U('veh_menu'),
                            align    = Config.Align,
                            elements = {
                                {label = _U('engine'), value = 'engine'},
                                {label = _U('lights'), value = 'lights'},
                                {label = _U('interior_lights'), value = 'interior_lights'}
                            }}, function(data3, menu3)
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                            if data3.current.value == 'engine' then
                                engine = not engine
                                if engine then
                                    SetVehicleEngineOn(vehicle, false, false, true)
                                elseif not engine then
                                    SetVehicleEngineOn(vehicle, true, false, true)
                                end
                            elseif data3.current.value == 'lights' then
                                lights = not lights
                                if lights then
                                    SetVehicleLights(vehicle, true)
                                elseif not lights then
                                    SetVehicleLights(vehicle, false)
                                end
                            elseif data3.current.value == 'interior_lights' then
                                int_lights = not int_lights
                                if int_lights then
                                    SetVehicleInteriorlight(vehicle, false)
                                elseif not int_lights then
                                    SetVehicleInteriorlight(vehicle, true)
                                end
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'error',
                                message  =  _U('notin_veh')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                        end
                    end
                elseif data2.current.value == 'neons_info' then
                    if IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'seats_menu', {
                            title    = _U('seats_menu'),
                            align    = Config.Align,
                            elements = {
                                {label = _U('neon_front'), value = 'neon_front'},
                                {label = _U('neon_back'), value = 'neon_back'},
                                {label = _U('neon_right'), value = 'neon_right'},
                                {label = _U('neon_left'), value = 'neon_left'},
                                {label = _U('neon_all'), value = 'neon_all'}
                            }}, function(data3, menu3)
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if data3.current.value == 'neon_front' then
                                front_neon = not front_neon
                                if front_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 2, false)
                                elseif not front_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 2, true)
                                end
                            elseif data3.current.value == 'neon_back' then
                                back_neon = not back_neon
                                if back_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 3, false)
                                elseif not back_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 3, true)
                                end
                            elseif data3.current.value == 'neon_right' then
                                right_neon = not right_neon
                                if right_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 1, false)
                                elseif not right_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 1, true)
                                end
                            elseif data3.current.value == 'neon_left' then
                                left_neon = not left_neon
                                if left_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 0, false)
                                elseif not left_neon then
                                    SetVehicleNeonLightEnabled(vehicle, 0, true)
                                end
                            elseif data3.current.value == 'neon_all' then
                                all_neon = not all_neon
                                if all_neon then
                                    DisableVehicleNeonLights(vehicle, true)
                                elseif not all_neon then
                                    DisableVehicleNeonLights(vehicle, false)
                                end
                            end
                            
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'error',
                                message  =  _U('notin_veh')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                        end
                    end
                elseif data2.current.value == 'seats_info' then
                    if IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'seats_menu', {
                            title    = _U('seats_menu'),
                            align    = Config.Align,
                            elements = {
                                {label = _U('seat_driver'), value = 'seat_driver'},
                                {label = _U('seat_passenger'), value = 'seat_passenger'},
                                {label = _U('seat_right_back'), value = 'seat_right_back'},
                                {label = _U('seat_left_back'), value = 'seat_left_back'}
                            }}, function(data3, menu3)
                            if data3.current.value == 'seat_driver' then
                                local ped = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn(ped, false)
                                if IsPedInVehicle(ped, vehicle, false) then
                                    if GetEntityBoneIndexByName(vehicle, 'seat_dside_f') ~= -1 then
                                        if IsVehicleSeatFree(vehicle, -1) then
                                            SetPedIntoVehicle(ped, vehicle, -1)
                                        else
                                            print('not free')
                                        end
                                    else
                                        print('no door')
                                    end
                                else
                                    print('not in vehicle')
                                end
                            elseif data3.current.value == 'seat_passenger' then
                                local ped = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn(ped, false)
                                if IsPedInVehicle(ped, vehicle, false) then
                                    if GetEntityBoneIndexByName(vehicle, 'seat_pside_f') ~= -1 then
                                        if IsVehicleSeatFree(vehicle, 0) then
                                            SetPedIntoVehicle(ped, vehicle, 0)
                                        else
                                            print('not free')
                                        end
                                    else
                                        print('no door')
                                    end
                                else
                                    print('not in vehicle')
                                end
                            elseif data3.current.value == 'seat_right_back' then
                                local ped = PlayerPedId()
                                vehicle = GetVehiclePedIsIn(ped, false)
                                if IsPedInVehicle(ped, vehicle, false) then
                                    if GetEntityBoneIndexByName(vehicle, 'seat_pside_r') ~= -1 then
                                        if IsVehicleSeatFree(vehicle, 2) then
                                            SetPedIntoVehicle(ped, vehicle, 2)
                                        else
                                            print('not free')
                                        end
                                    else
                                        print('no door')
                                    end
                                else
                                    print('not in vehicle')
                                end
                            elseif data3.current.value == 'seat_left_back' then
                                local ped = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn(ped, false)
                                if IsPedInVehicle(ped, vehicle, false) then
                                    if GetEntityBoneIndexByName(vehicle, 'seat_dside_r') ~= -1 then
                                        if IsVehicleSeatFree(vehicle, 1) then
                                            SetPedIntoVehicle(ped, vehicle, 1)
                                        else
                                            print('not free')
                                        end
                                    else
                                        print('no door')
                                    end
                                else
                                    print('not in vehicle')
                                end
                            end
                            
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'error',
                                message  =  _U('notin_veh')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                        end
                    end
                elseif data2.current.value == 'doors_info' then
                    if IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'doors_menu', {
                            title    = _U('doors_menu'),
                            align    = Config.Align,
                            elements = {
                                {label = _U('door_left'), value = 'door_left'},
                                {label = _U('door_right'), value = 'door_right'},
                                {label = _U('door_left_back'), value = 'door_left_back'},
                                {label = _U('door_right_back'), value = 'door_right_back'},
                                {label = _U('capo'), value = 'capo'},
                                {label = _U('maletero'), value = 'maletero'}
                            }}, function(data3, menu3)
                            local ped = PlayerPedId()
                            local vehicleped = GetVehiclePedIsIn(ped, false)

                            if data3.current.value == 'door_left' then
                                local doorleft = GetEntityBoneIndexByName(vehicleped, 'door_dside_f')
                                if vehicleped ~= 0 and GetPedInVehicleSeat(vehicleped, 0) then
                                    if doorleft ~= -1 then
                                        if GetVehicleDoorAngleRatio(vehicleped, 0) > 0 then
                                            SetVehicleDoorShut(vehicleped, 0, false)
                                        else 
                                            SetVehicleDoorOpen(vehicleped, 0, false)
                                        end
                                    else
                                        if Config.Tnotify then
                                            exports['t-notify']:Alert({
                                                style  =  'error',
                                                message  =  _U('door_no')
                                            })
                                        elseif Config.ESX then
                                            ESX.ShowNotification(_U('door_no'), false, false, 90)
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                            elseif data3.current.value == 'door_right' then
                                local dooright = GetEntityBoneIndexByName(vehicleped, 'door_pside_f')
                                if vehicleped ~= 0 and GetPedInVehicleSeat(vehicleped, 0) then
                                    if dooright ~= -1 then
                                        if GetVehicleDoorAngleRatio(vehicleped, 1) > 0 then
                                            SetVehicleDoorShut(vehicleped, 1, false)
                                        else 
                                            SetVehicleDoorOpen(vehicleped, 1, false)
                                        end
                                    else
                                        if Config.Tnotify then
                                            exports['t-notify']:Alert({
                                                style  =  'error',
                                                message  =  _U('door_no')
                                            })
                                        elseif Config.ESX then
                                            ESX.ShowNotification(_U('door_no'), false, false, 90)
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                            elseif data3.current.value == 'door_left_back' then
                                local doorleftback = GetEntityBoneIndexByName(vehicleped, 'door_dside_r')
                                if vehicleped ~= 0 and GetPedInVehicleSeat(vehicleped, 0) then
                                    if doorleftback ~= -1 then
                                        if GetVehicleDoorAngleRatio(vehicleped, 2) > 0 then
                                            SetVehicleDoorShut(vehicleped, 2, false)
                                        else 
                                            SetVehicleDoorOpen(vehicleped, 2, false)
                                        end
                                    else
                                        if Config.Tnotify then
                                            exports['t-notify']:Alert({
                                                style  =  'error',
                                                message  =  _U('door_no')
                                            })
                                        elseif Config.ESX then
                                            ESX.ShowNotification(_U('door_no'), false, false, 90)
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                            elseif data3.current.value == 'door_right_back' then
                                local doorrightback = GetEntityBoneIndexByName(vehicleped, 'door_pside_r')
                                if vehicleped ~= 0 and GetPedInVehicleSeat(vehicleped, 0) then
                                    if doorrightback ~= -1 then
                                        if GetVehicleDoorAngleRatio(vehicleped, 3) > 0 then
                                            SetVehicleDoorShut(vehicleped, 3, false)
                                        else 
                                            SetVehicleDoorOpen(vehicleped, 3, false)
                                        end
                                    else
                                        if Config.Tnotify then
                                            exports['t-notify']:Alert({
                                                style  =  'error',
                                                message  =  _U('door_no')
                                            })
                                        elseif Config.ESX then
                                            ESX.ShowNotification(_U('door_no'), false, false, 90)
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                            elseif data3.current.value == 'capo' then
                                local capo = GetEntityBoneIndexByName(vehicleped, 'bonnet')
                                if vehicleped ~= 0 and GetPedInVehicleSeat(vehicleped, 0) then
                                    if capo ~= -1 then
                                        if GetVehicleDoorAngleRatio(vehicleped, 4) > 0 then
                                            SetVehicleDoorShut(vehicleped, 4, false)
                                        else 
                                            SetVehicleDoorOpen(vehicleped, 4, false)
                                        end
                                    else
                                        if Config.Tnotify then
                                            exports['t-notify']:Alert({
                                                style  =  'error',
                                                message  =  _U('door_no')
                                            })
                                        elseif Config.ESX then
                                            ESX.ShowNotification(_U('door_no'), false, false, 90)
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                            elseif data3.current.value == 'maletero' then
                                local maletero = GetEntityBoneIndexByName(vehicleped, 'boot')
                                if vehicleped ~= 0 and GetPedInVehicleSeat(vehicleped, 0) then
                                    if maletero ~= -1 then
                                        if GetVehicleDoorAngleRatio(vehicleped, 5) > 0 then
                                            SetVehicleDoorShut(vehicleped, 5, false)
                                        else 
                                            SetVehicleDoorOpen(vehicleped, 5, false)
                                        end
                                    else
                                        if Config.Tnotify then
                                            exports['t-notify']:Alert({
                                                style  =  'error',
                                                message  =  _U('door_no')
                                            })
                                        elseif Config.ESX then
                                            ESX.ShowNotification(_U('door_no'), false, false, 90)
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'error',
                                message  =  _U('notin_veh')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                        end
                    end
                elseif data2.current.value == 'windows_info' then
                    if IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false) then
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'windows_menu', {
                            title    = _U('windows_menu'),
                            align    = Config.Align,
                            elements = {
                                {label = _U('wind_right'), value = 'wind_right'},
                                {label = _U('wind_left'), value = 'wind_left'},
                                {label = _U('wind_rightback'), value = 'wind_rightback'},
                                {label = _U('wind_leftback'), value = 'wind_leftback'},
                                {label = _U('windows'), value = 'windows'}
                            }}, function(data3, menu3)
                                local ped = PlayerPedId()
                                local veh = GetVehiclePedIsIn(ped, false)
                                if veh ~= 0 and GetPedInVehicleSeat(veh, 0) then
                                    if data3.current.value == 'wind_right' then
                                        local rightWindow = GetEntityBoneIndexByName(veh, 'window_lr')
                                        if rightWindow ~= -1 then
                                            wind_right = not wind_right
                                            if wind_right == true then
                                                RollDownWindow(veh, 1)
                                            elseif wind_right == false then
                                                RollUpWindow(veh, 1)
                                            end
                                        else
                                            if Config.Tnotify then
                                                exports['t-notify']:Alert({
                                                    style  =  'error',
                                                    message  =  _U('window_no')
                                                })
                                            elseif Config.ESX then
                                                ESX.ShowNotification(_U('window_no'), false, false, 90)
                                            end
                                        end
                                    elseif data3.current.value == 'wind_left' then
                                        local leftWindow = GetEntityBoneIndexByName(veh, 'window_lf')
                                        if leftWindow ~= -1 then
                                            wind_left = not wind_left
                                            if wind_left == true then
                                                RollDownWindow(veh, 0)
                                            elseif wind_left == false then
                                                RollUpWindow(veh, 0)
                                            end
                                        else
                                            if Config.Tnotify then
                                                exports['t-notify']:Alert({
                                                    style  =  'error',
                                                    message  =  _U('window_no')
                                                })
                                            elseif Config.ESX then
                                                ESX.ShowNotification(_U('window_no'), false, false, 90)
                                            end
                                        end
                                    elseif data3.current.value == 'wind_rightback' then
                                        local rightbackWindow = GetEntityBoneIndexByName(veh, 'window_rr')
                                        if rightbackWindow ~= -1 then
                                            wind_rightback = not wind_rightback
                                            if wind_rightback == true then
                                                RollDownWindow(veh, 3)
                                            elseif wind_rightback == false then
                                                RollUpWindow(veh, 3)
                                            end
                                        else
                                            if Config.Tnotify then
                                                exports['t-notify']:Alert({
                                                    style  =  'error',
                                                    message  =  _U('window_no')
                                                })
                                            elseif Config.ESX then
                                                ESX.ShowNotification(_U('window_no'), false, false, 90)
                                            end
                                        end
                                    elseif data3.current.value == 'wind_leftback' then
                                        local leftbackWindow = GetEntityBoneIndexByName(veh, 'window_rf')
                                        if leftbackWindow ~= -1 then
                                            wind_leftback = not wind_leftback
                                            if wind_leftback == true then
                                                RollDownWindow(veh, 2)
                                            elseif wind_leftback == false then
                                                RollUpWindow(veh, 2)
                                            end
                                        else
                                            if Config.Tnotify then
                                                exports['t-notify']:Alert({
                                                    style  =  'error',
                                                    message  =  _U('window_no')
                                                })
                                            elseif Config.ESX then
                                                ESX.ShowNotification(_U('window_no'), false, false, 90)
                                            end
                                        end
                                    elseif data3.current.value == 'windows' then
                                        local window1 = GetEntityBoneIndexByName(veh, 'window_lf')
                                        local window2 = GetEntityBoneIndexByName(veh, 'window_lr')
                                        local window3 = GetEntityBoneIndexByName(veh, 'window_rf')
                                        local window4 = GetEntityBoneIndexByName(veh, 'window_rr')
                                        if window1 ~= -1 or window2 ~= -1 or window3 ~= -1 or window4 ~= -1 then
                                            windows = not windows
                                            if windows == true then
                                                RollDownWindows(veh)
                                            elseif windows == false then
                                                RollUpWindow(veh, 0)
                                                RollUpWindow(veh, 1)
                                                RollUpWindow(veh, 2)
                                                RollUpWindow(veh, 3)
                                            end
                                        else
                                            if Config.Tnotify then
                                                exports['t-notify']:Alert({
                                                    style  =  'error',
                                                    message  =  _U('window_no')
                                                })
                                            elseif Config.ESX then
                                                ESX.ShowNotification(_U('window_no'), false, false, 90)
                                            end
                                        end
                                    end
                                else
                                    if Config.Tnotify then
                                        exports['t-notify']:Alert({
                                            style  =  'error',
                                            message  =  _U('notin_veh')
                                        })
                                    elseif Config.ESX then
                                        ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                                    end
                                end
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'error',
                                message  =  _U('notin_veh')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                        end
                    end
                elseif data2.current.value == 'autopilot_label' then
                    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
                        pilot = not pilot
                        local ped = PlayerPedId()
                        local veh = GetVehiclePedIsIn(ped, false)
                        local blip = GetFirstBlipInfoId(8)
                        if (blip ~= nil and blip ~= 0) then
                            if pilot == true then
                                local coord = GetBlipCoords(blip)
                                blipX = coord.x
                                blipY = coord.y
                                blipZ = coord.z
                                if Config.Tnotify then
                                    exports['t-notify']:Alert({
                                        style  =  'error',
                                        message  =  _U('destination_go')
                                    })
                                elseif Config.ESX then
                                    ESX.ShowNotification(_U('destination_go'), false, false, 90)
                                end
                                TaskVehicleDriveToCoordLongrange(ped, veh, blipX, blipY, blipZ, 24.0, 786603, 15.0)
                                moving = true
                                autopilot()
                            elseif pilot == false then
                                if Config.Tnotify then
                                    exports['t-notify']:Alert({
                                        style  =  'info',
                                        message  =  _U('destination_stop')
                                    })
                                elseif Config.ESX then
                                    ESX.ShowNotification(_U('destination_stop'), false, false, 90)
                                end
                                ClearPedTasks(ped)
                            end
                        else
                            if Config.Tnotify then
                                exports['t-notify']:Alert({
                                    style  =  'error',
                                    message  =  _U('destination_false')
                                })
                            elseif Config.ESX then
                                ESX.ShowNotification(_U('destination_false'), false, false, 90)
                            end
                            ClearPedTasks(ped)
                        end
                    else
                        if Config.Tnotify then
                            exports['t-notify']:Alert({
                                style  =  'info',
                                message  =  _U('notin_veh')
                            })
                        elseif Config.ESX then
                            ESX.ShowNotification(_U('notin_veh'), false, false, 90)
                        end
                    end
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end
	end, function(data, menu)
		menu.close()
	end)
end

-- Autopilot function
function autopilot()
    while true do
        Citizen.Wait(350)
        if moving then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local blip = GetFirstBlipInfoId(8)
            local dist = Vdist(coords.x, coords.y, coords.z, blipX, blipY, coords.z)
            if dist <= 15 then
                local vehicle = GetVehiclePedIsIn(ped, false)
                SetVehicleForwardSpeed(vehicle, 4.0)
                Citizen.Wait(150)
                SetVehicleForwardSpeed(vehicle, 0.0)
                if Config.Tnotify then
                    exports['t-notify']:Alert({
                        style  =  'success',
                        message  =  _U('destination_true')
                    })
                elseif Config.ESX then
                    ESX.ShowNotification(_U('destination_true'), false, false, 90)
                end
                moving = false
                ClearPedTasks(ped)
            end
        end
    end
end

--Seat Suffling
Citizen.CreateThread(function()
    while Config.SeatShuffle do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInAnyVehicle(ped, false) then
            if GetPedInVehicleSeat(vehicle, 0) == ped then
                if GetIsTaskActive(ped, 165) then
                    SetPedIntoVehicle(ped, vehicle, 0)
                end
            end
        end
    end
end)

--Updating the jobs and info
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

--Close menu on restart of script(prevention of bug)
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ESX.UI.Menu.CloseAll()
    end
end)