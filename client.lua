ESX = nil

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
