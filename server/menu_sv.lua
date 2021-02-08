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

ESX.RegisterServerCallback("garage:fetchPlayerVehicles", function(source, callback, garage)
	local player = ESX.GetPlayerFromId(source)

	if player then
		local sqlQuery = [[
			SELECT
				plate, vehicle
			FROM
				owned_vehicles
			WHERE
				owner = @cid
		]]

		if garage then
			sqlQuery = [[
				SELECT
					plate, vehicle
				FROM
					owned_vehicles
				WHERE
					owner = @cid and garage = @garage
			]]
		end

		MySQL.Async.fetchAll(sqlQuery, {
			["@cid"] = player["identifier"],
			["@garage"] = garage
		}, function(responses)
			local playerVehicles = {}

			for key, vehicleData in ipairs(responses) do
				table.insert(playerVehicles, {
					["plate"] = vehicleData["plate"],
					["props"] = json.decode(vehicleData["vehicle"])
				})
			end

			callback(playerVehicles)
		end)
	else
		callback(false)
	end
end)