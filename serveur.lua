ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local JoueurMax = 5
local ParticipantId = 0
local lastPart = nil

RegisterNetEvent("LS_EVENT:SendInfo")
AddEventHandler("LS_EVENT:SendInfo", function(startPos, endPos, desc, NombreJoueurs, _typeVeh, prix, ArgentPropre)
    ParticipantId = 0
    JoueurMax = NombreJoueurs
    local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name ~= 'police' then
			TriggerClientEvent("LS_EVENT:GetInfo", xPlayers[i], startPos, endPos, desc, NombreJoueurs, _typeVeh, prix, ArgentPropre)
		end
	end
    
end)


RegisterNetEvent("LS_EVENT:AddPlayer")
AddEventHandler("LS_EVENT:AddPlayer", function()
    if lastPart ~= source then
        lastPart = source
        ParticipantId = ParticipantId + 1
        if ParticipantId >= JoueurMax then
            TriggerClientEvent("LS_EVENT:MaxPlayerReach", -1)
        end
    end
end)



RegisterNetEvent("LS_EVENTS:Finish")
AddEventHandler("LS_EVENTS:Finish", function(prix, ArgentPropre)
    local xPlayer = ESX.GetPlayerFromId(source)
    if ArgentPropre then
        xPlayer.addMoney(prix)
    else
        xPlayer.addAccountMoney('black_money',prix)
    end
end)