
ESX = nil
local cedulky = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerServerEvent("zde:giveme")
end)

function DrawText3D(coords, text)
	RegisterFontFile('russoone')
	fontId = RegisterFontId('Russo One')
	local x,y,z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	  local font = fontId
    
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 1000)
	  RegisterFontFile('russoone') 
	fontId = RegisterFontId('Russo One') 
	  SetTextFont(font)
  
    SetTextEntry("STRING")
    SetTextCentre(1)
	AddTextComponentString(text)
    local factor = (string.len(text)) / 120
    DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
    DrawText(_x,_y)
end

RegisterNetEvent("zde:update")
AddEventHandler("zde:update",function(newCedulky)
	cedulky = newCedulky
	for k,v in ipairs(cedulky) do
		Citizen.CreateThread(function()
			local a = tostring(cedulky)
			while a==tostring(cedulky) do
				Citizen.Wait(0)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if #(pos-v.pos)<15.0 then
					DrawText3D(v.pos, ' ' .. v.text)
				else
					Citizen.Wait(500)
				end
			end
			collectgarbage()
		end)
	end
	collectgarbage()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		TriggerServerEvent("zde:giveme")
	end
end)