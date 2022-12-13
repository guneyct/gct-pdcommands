QBCore = exports['qb-core']:GetCoreObject()

local PlayerData = {}

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
  	local livery = tonumber(args[1])

  	SetVehicleLivery(Veh, livery) --CHANGE livery(id)
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

		SetVehicleEngineHealth(veh, 1000.0)
		SetVehicleBodyHealth(veh, 1000.0)
		SetVehicleFixed(veh)
	end, function()
			QBCore.Functions.Notify(Lang:t('error.repair_canceled'))
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

		TriggerEvent('qb-admin:client:maxmodVehicle')
	end, function()
			QBCore.Functions.Notify(Lang:t('error.repair_canceled'))
		end)
	end
end)