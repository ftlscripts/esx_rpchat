
ESX = nil
local cedulky = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("zde:giveme")
AddEventHandler("zde:giveme",function()
    TriggerClientEvent("zde:update",source,cedulky)
end)

RegisterCommand('zde', function(source, args, rawCommand)
	if #args<2 then
		TriggerClientEvent('chat:addMessage', source, {
		  template = '<div style="padding: 0.45vw; margin: 0.05vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px;">Špatné použití. Použij: /zde 1-119 text!</div>',
		  args = {}
		})
		return
	end
	local cas = tonumber(args[1])
	if not cas or cas<1 or cas>120 then
		TriggerClientEvent('chat:addMessage', source, {
		  template = '<div style="padding: 0.45vw; margin: 0.05vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px;">Špatné použití. Čas musí být mezi 1 minutou a 119 minutami!</div>',
		  args = {}
		})
		return
	end
	table.remove(args,1)
	local text = table.concat(args," ")
	local _source = source
    local time = cas % 120
    table.insert(cedulky,{pos=GetEntityCoords(GetPlayerPed(_source)),text=text,time=os.time()+time*60})
    TriggerClientEvent("zde:update",-1,cedulky)
end, false)

RegisterCommand('stopzde', function(source, args, rawCommand)
    local _source = source
    local pos = GetEntityCoords(GetPlayerPed(_source))
    for k,v in ipairs(cedulky) do
        if #(v.pos-pos) < 2.0 then
            table.remove(cedulky,k)
            TriggerClientEvent("zde:update",-1,cedulky)
            break
        end
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local zmena = false
        for k,v in ipairs(cedulky) do
            if v.time<os.time() then
                zmena = true
                table.remove(cedulky,k)
            end
        end
        if zmena then
            TriggerClientEvent("zde:update",-1,cedulky)
        end
    end
end)