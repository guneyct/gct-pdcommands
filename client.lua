QBCore = exports['qb-core']:GetCoreObject()

local PlayerData = {}

Config = {}
Config.coords = vector3(441.0, -988.6, 25.55)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterCommand('livery', function(source, args, rawCommand)
	if PlayerData.job.name ~= "police" then return end

	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local distance = #(pedCoords - Config.coords)

	if distance > 25 then return end

	local Veh = GetVehiclePedIsIn(ped)

	if GetVehicleClass(Veh) ~= 18 then
		QBCore.Functions.Notify(Lang:t('error.not_allowed'))
		return
	end

  	local livery = tonumber(args[1])

  	SetVehicleLivery(Veh, livery)
	QBCore.Functions.Notify(Lang:t('success.changed_livery'))
end)

RegisterCommand('pdfixcar', function(source, args, rawCommand)
	if PlayerData.job.name ~= "police" then return end

	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local distance = #(pedCoords - Config.coords)

	if distance > 25 then return end

	if IsPedInAnyVehicle(PlayerPedId()) and PlayerData.job.name == "police" then
		QBCore.Functions.Progressbar("repair_part", "Tamir Ediliyor..",
	4500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		local veh = GetVehiclePedIsIn(ped)
		if GetVehicleClass(Veh) ~= 18 then
			QBCore.Functions.Notify(Lang:t('error.not_allowed'))
			return
		end

		SetVehicleEngineHealth(veh, 1000.0)
		SetVehicleBodyHealth(veh, 1000.0)
		SetVehicleFixed(veh)
		QBCore.Functions.Notify(Lang:t('success.vehicle_fixed'))
	end, function()
			QBCore.Functions.Notify(Lang:t('error.action_canceled'))
		end)
	end
end)

RegisterCommand('pdmaxmods', function(source, args, rawCommand)
	if PlayerData.job.name ~= "police" then return end

	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local distance = #(pedCoords - Config.coords)

	if distance > 25 then return end

	if IsPedInAnyVehicle(PlayerPedId()) and PlayerData.job.name == "police" then
		QBCore.Functions.Progressbar("repair_part", "Parçalar takılıyor..",
	4500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		if GetVehicleClass(Veh) ~= 18 then
			QBCore.Functions.Notify(Lang:t('error.not_allowed'))
			return
		end
		TriggerEvent('qb-admin:client:maxmodVehicle')
		QBCore.Functions.Notify(Lang:t('success.full_mods'))
	end, function()
			QBCore.Functions.Notify(Lang:t('error.action_canceled'))
		end)
	end
end)