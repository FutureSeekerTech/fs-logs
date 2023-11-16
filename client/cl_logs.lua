local QBCore = exports['qb-core']:GetCoreObject()

-- OnPlayerLoad
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('fs-logs:server:playerLoaded')
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
      if QBCore.Functions.GetPlayerData() then
         TriggerServerEvent('fs-logs:server:playerLoaded')
      end
   end
end)