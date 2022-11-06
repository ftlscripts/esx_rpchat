

ESX = nil

local onTimer       = {}
Config.WebHook = "https://discord.com/api/webhooks/929103931739607072/VpOJAxR3oIUZnaOxNynXQPxTU26weCfIfQZGv8HNZttd1dng3yv6gN7Im_bDkytVEvkq" -- Discord Webhook
Config.Name = "Evolution Roleplay.CZ" -- Jméno Serveru
Config.SteamApiKey = "" -- Steam WEBApiKey
Config.DiscordImage = "https://media.discordapp.net/attachments/836160745111945216/924077403406467114/evrp.gif" -- Discord Fotka
local DISCORD_WEBHOOK = Config.WebHook
local DISCORD_NAME = Config.Name
local STEAM_KEY = Config.SteamApiKey
local DISCORD_IMAGE = Config.DiscordImage -- FiveM Logo

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
  CancelEvent()
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> ERROR</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b> </b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;">Toto není platný příkaz </font></div>',
      args = {}
    })
end)


RegisterServerEvent('sendmetoall')
AddEventHandler('sendmetoall', function(message)
  local _source = source
  local name = GetRealPlayerName(_source)
  xPlayer = ESX.GetPlayerFromId(_source)

  TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, xPlayer.source, name, message, { 186, 0, 255 })
  TriggerClientEvent('3dme:triggerDisplay', -1, message, xPlayer.source)
end)


local function AutoAnnouncer()
	SetTimeout(Config.AnnounceMinutes*60*1000, function()
		local announenumber = 0
		for i, announce in ipairs(Config.Messages) do
			announenumber = announenumber+1
		end
		local announcerandom = math.random(1, announenumber)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border: 1px solid rgba(0, 0, 0, 0.79); border-right: 5px solid rgba(187, 255, 0); box-shadow: inset 0 0 0.5em 0 rgba(0, 0, 0, 0.79), 0 0 0.5em 0 rgba(0, 0, 0, 0.79);"><i class="fas fa-align-justify"></i> EVRP POMOCNÍK <br> {0}</div>',
			args = { Config.Messages[tonumber(announenumber)].message }
		})
		print('EVRP Development')		
		AutoAnnouncer()
	end)
end

AutoAnnouncer()

local function AutoAnnouncer2()
	SetTimeout(Config.AnnounceMinutes2*60*1000, function()
		local announenumber = 0
		for i, announce in ipairs(Config.Messages2) do
			announenumber = announenumber+1
		end
		local announcerandom = math.random(1, announenumber)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border: 1px solid rgba(0, 0, 0, 0.79); border-right: 5px solid rgba(255, 0, 0); box-shadow: inset 0 0 0.5em 0 rgba(0, 0, 0, 0.79), 0 0 0.5em 0 rgba(0, 0, 0, 0.79);"><i class="fab fa-discord"></i> DISCORD <br> {0}</div>',
			args = { Config.Messages2[tonumber(announenumber)].message }
		})
		print('EVRP Development')		
		AutoAnnouncer2()
	end)
end
	
AutoAnnouncer2()

-- BLACKMARKET
--[[RegisterCommand('bm', function(source, args, raw)
  local playerName = GetPlayerName(source)
--   local msg = rawCommand:sub(3)
  fal = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "blackmarket"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

if xPlayer.job.name ~= 'police' then
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border: 1px solid rgba(0, 0, 0, 0.79); border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-skull-crossbones"></i> Anonymous<br> {0}</div>',
   
      args = {toSay}
  })
end
PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
end, false)-]]



AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len('/')) ~= '/' then
    CancelEvent()
    --if Config.OnlyICNames then name = GetRealPlayerName(source) end
    TriggerClientEvent('esx_rpchat:sendLocalOOC', -1, source, name, message, {30, 144, 255});
  end
end)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if true then
			if false then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end


-- ME command
RegisterCommand('me', function(source, args, raw)
  if source == 0 then
    print('ME')
    return
  end

  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  local discordhookname = GetPlayerName(source)
  local command = "me"
  if Config.OnlyICNames then name = GetRealPlayerName(source) end

  TriggerClientEvent('esx_rpchat:sendMe', -1, source, name, args, { 196, 33, 246 })
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = discordhookname .. " - /" .. command .. "", content = args, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
end)


RegisterCommand('mluvit', function(source, args, raw)
  if source == 0 then
    print('MLUVÍ')
    return
  end

  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  local discordhookname = GetPlayerName(source)
  local command = "mluvit"
  if Config.OnlyICNames then name = GetRealPlayerName(source) end

  TriggerClientEvent('esx_rpchat:sendMluvit', -1, source, name, args, { 196, 33, 246 })
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = discordhookname .. " - /" .. command .. "", content = args, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
end)



RegisterCommand('do', function(source, args, raw)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  local discordhookname = GetPlayerName(source)
  local command = "do"
  if Config.OnlyICNames then name = GetRealPlayerName(source) end

  TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, args, { 255, 198, 0 })
  TriggerClientEvent('3ddo:triggerDisplay', -1, args, source)
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = discordhookname .. " - /" .. command .. "", content = args, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
end)


-- TWEET 
if Config.EnableTweet then 
   RegisterCommand('tweet', function(source, args, rawCommand)
  local playerName = GetRealPlayerName(source)
  local msg = rawCommand:sub(6)
  local command = "tweet"
  fal = GetRealPlayerName(source)

  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.79); border-radius: 10px; border-right: 5px solid rgba(0, 0, 0, 0.79);"><i class="fab fa-twitter"></i> | {0}:<br> {1}</div>',
    
      args = { fal, msg }
  })
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = msg, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
end, false)
end


RegisterCommand('doc', function(source, args, raw)

  -- Timer
  local xPlayer = ESX.GetPlayerFromId(source)
  if onTimer[source] and onTimer[source] > GetGameTimer() then
		local timeLeft = (onTimer[source] - GetGameTimer()) / 1000
		TriggerClientEvent('chatMessage', xPlayer.source, _U('doc_cooldown', tostring(ESX.Math.Round(timeLeft))))
		return
  end
  
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  if args == nil then
  print('source .. args .. rawCommand')
  return
  end
  args = table.concat(args, ' ')
  local name = GetRealPlayerName(source)
  if Config.OnlyICNames then name = GetRealPlayerName(source) end
  local counter_doc = 0
  local pocetOpakovani = tonumber(args)
  if pocetOpakovani == nil then
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border: 1px solid rgb(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgb(187, 255, 0);"> <font style="background-color:rgba(52, 52, 53, 0); font-size: 0px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> ERROR</b></font></font> <font style="font-weight: bold; font-size: 15px;"> Nenapsal jsi validní počet DOC např. /doc 1-10 </font></div>',
      args = {}
    })
    return
  end
  if pocetOpakovani < 11 then
    while counter_doc < pocetOpakovani do
        counter_doc = counter_doc + 1 
        TriggerClientEvent('esx_rpchat:sendDoc', -1, source, name, counter_doc .. "/" .. pocetOpakovani , { 255, 198, 0 })
        TriggerClientEvent('3ddoa:triggerDisplay', -1, counter_doc .. "/" .. pocetOpakovani, source)
        onTimer[source] = GetGameTimer() + (6 * 1000)
        Citizen.Wait(2000)
    end
  end
end)
 

RegisterCommand('inzerat', function(source, args, rawCommand)
  local playerName = GetRealPlayerName(source)
  local msg = rawCommand:sub(3)
  fal = GetRealPlayerName(source)

  TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgb(187, 255, 0);"><i class="fas fa-ad"></i> Reklama: {0}<br> {1}</div>',
      args = { fal, msg }
  })
end, false)--]]


RegisterCommand('zlodej', function(source, args, rawCommand)
  local playerName = GetRealPlayerName(source)
  local msg = rawCommand:sub(7)
  fal = GetCharacterName(source)

  TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(66, 66, 66, 1); border-radius: 10px; border-right: 5px solid rgb(0, 0, 0, 0.79);"><i class="fas fa-money-check-alt"></i> Vykradajici:<br> {1}</div>',
      args = { fal, msg }
  })
end, false)


RegisterCommand('lsc', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
--    local msg = rawCommand:sub(7)
  local xPlayer = ESX.GetPlayerFromId(source)
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' ' -- Concats two strings together
end

  if xPlayer.job.name == 'mechanic' then 
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(50, 71, 202, 0.9); border-radius: 10px; border-right: 5px solid rgb(0, 0, 0, 0.79);"><i class="fas fa-wrench"></i> LSC: {0}</div>',
          args = {toSay}
      })
      else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-exclamation"></i>  Musíš pracovat u LSC pro možnost použít /lsc <i class="fas fa-exclamation"></i></div>',
      args = {}
    })
  end
end, false)


RegisterCommand('inzerat', function(source, args, rawCommand)
  local characterName = GetCharacterName(source)
--  local msg = rawCommand:sub(8)
  local xPlayer = ESX.GetPlayerFromId(source)
  local characterName = GetCharacterName(source)
  local phoneNumber = GetCharacterPhoneNumber(source)
  local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' -- Concats two strings together
  end

  if xPlayer.get('money') >= 250 then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.3vw 0.8vw; margin: 0.5vw 0.5vw 0.5vw 0; border-radius:10px; background-color: rgba(67,142,94, 0.6); border-radius: 10px; border-right: 5px solid rgba(0, 0, 0, 0.79);"><strong style="font-size: 11pt;">[Inzerát] {0} (tel.číslo: {1}):</strong><br><p style="padding-top: .3vw">{2}</p></div>',
          args = { characterName, phoneNumber, toSay }
      })

    xPlayer.removeMoney(250)

    TriggerClientEvent('chat:addMessage', source, {
      template = '^0[^1PLATBA^0] Za inzerát ste zaplatili 250$',
      args = {}
    })
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '^0[^1VAROVANIE^0] Nemáte dostatok financii­ na zaplatenie inzerátu (250$)',
      args = {}
    })
  end
end, false)--]]


RegisterCommand('doj', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local toSay = ''
  for i=1,#args do
    toSay = toSay .. args[i] .. ' '
  end

  if xPlayer.job.name == 'vlada' then 
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw;border-radius:10px; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px; border-right: 5px solid rgba(0, 0, 0, 0.79);"><i class="fas fa-flag-usa"></i> VlĂˇda: {0}</div>',
          args = {toSay}
      })
      PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' }) 
      else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.9); background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-exclamation"></i>  Musíš pracovat u doj pro možnost použití /doj <i class="fas fa-exclamation"></i></div>',
      args = {}
    })
  end
end, false)


RegisterCommand('police', function(source, args, raw)
    local playerName = GetPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local command = "police"
    local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' 
  end

    if xPlayer.job.name == 'police' then 
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgb(28, 160, 242);"><i class="fas fa-shield-alt"></i> LSPD<br> {0}</div>',
    
          args = {toSay}
      })
      PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-exclamation"></i>  Musíš Pracovat ako LSPD aby si mohl použit /police <i class="fas fa-exclamation"></i></div>',
     
      args = {}
    })
  end
end, false)


RegisterCommand('sasp', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "sasp"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' ' 
end

  if xPlayer.job.name == 'sasp' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgb(29, 0, 214);"><i class="fas fa-shield-alt"></i> State Police<br> {0}</div>',
  
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-exclamation"></i>  Musíš Pracovat ako sasp aby si mohl použit /sasp <i class="fas fa-exclamation"></i></div>',
   
    args = {}
  })
end
end, false)

RegisterCommand('sheriff', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "sheriff"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'sheriff' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgb(230, 161, 0);"><i class="fas fa-paw"></i> Sheriff Department <br> {0}</div>',
  
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-exclamation"></i>  Musíš Pracovat ako sheriff aby si mohl použit /sheriff <i class="fas fa-exclamation"></i></div>',
   
    args = {}
  })
end
end, false)

RegisterCommand('ems', function(source, args, raw)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local command = "ambulance"
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' '
end

  if xPlayer.job.name == 'ambulance' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgb(230, 0, 0);"><i class="fas fa-shield-alt"></i> EMS<br> {0}</div>',
        args = {toSay}
    })
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = playerName .. " - /" .. command .. "", content = toSay, avatar_url = DISCORD_IMAGE, tts = false}), { ['Content-Type'] = 'application/json' })
else 
  
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.79); border-radius: 10px; border-right: 5px solid rgba(255, 0, 0);"><i class="fas fa-exclamation"></i>  Musíš Pracovat u EMS aby si mohl použit /ems <i class="fas fa-exclamation"></i></div>',
    args = {}
  })
end
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end

function GetCharacterJobName(source) 
  local result = MySQL.Sync.fetchAll('SELECT job FROM users WHERE identifier = @identifier', {
    ['@identifier'] = GetPlayerIdentifiers(source)[1]
  })

  if result[1] and result[1].job then
    return result[1].job
  end

  return nil
end

function GetCharacterPhoneNumber(source)
  local result = MySQL.Sync.fetchAll('SELECT phone_number FROM users WHERE identifier = @identifier', {
    ['@identifier'] = GetPlayerIdentifiers(source)[1]
  })

  if result[1] and result[1].phone_number then
    return result[1].phone_number
  end

  return nil
end


function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "mw_rpchat",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end