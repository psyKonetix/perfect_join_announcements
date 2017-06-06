// Perfect Join Announcements
// By psyKonetix

local Enabled = CreateConVar("pja_enabled", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})
local SteamL = CreateConVar("pja_steamid_l", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})
local SteamC = CreateConVar("pja_steamid_c", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})
local SteamD = CreateConVar("pja_steamid_d", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})
local Loading = CreateConVar("pja_loading", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})
local Connected = CreateConVar("pja_connected", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})
local Disconnected = CreateConVar("pja_disconnected", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE})

local function pjaPrint(Message)
     print(Color(149, 26, 232), "[PJA] ", Message)
end

pjaPrint("Perfect Join Announcements has loaded.")

util.AddNetworkString("pjaMessageHandler")

local function Message(Colour, Name, Message)
     if Enabled:GetInt() == 0 then return end
     local Data = {Colour, Name, Message}
     net.Start("pjaMessageHandler")
     net.WriteTable(Data)
     net.Broadcast()
end

local function Load(Name)
     if Loading:GetInt() == 0 then return end
     if SteamL:GetInt() == 0 then
          Message(Color(151, 211, 255), Name, " is loading.")
          //pjaPrint(Name .. " is loading.")
     else
          Message(Color(151, 211, 255), Name, " is loading. (" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")")
          //pjaPrint(Name .. " is loading. (" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")")
end
hook.Add( "PlayerConnect", "pjaLoad", Connect)

local function Connect(Ply)
     if Connected:GetInt() == 0 then return end
     if SteamC:GetInt() == 0 then
          //Message(team.GetColor( Ply:Team()), Ply:Nick(), " connected.")
          timer.Simple( 0.2, function() Message(team.GetColor( Ply:Team()), Ply:Nick(), " connected.")end)
          //pjaPrint(Ply:Nick() .. " connected.")
     else
          //Message(team.GetColor( Ply:Team()), Ply:Nick(), " connected.(" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")")
          timer.Simple( 0.2, function() Message(team.GetColor( Ply:Team()), Ply:Nick(), " connected. (" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")")end)
          //pjaPrint(Ply:Nick() .. " connected. (" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")")
end
hook.Add( "PlayerInitialSpawn", "pjaConnect", Spawn)

local function Disconnect(Ply)
     if Disconnected:GetInt() == 0 then return end
     if SteamD:GetInt() == 0 then
          Message(team.GetColor( Ply:Team()), Ply:Nick(), " disconnected.")
          //pjaPrint(Ply:Nick() .. " disconnected.")
     else
          Message(team.GetColor( Ply:Team()), Ply:Nick(), " disconnected. (" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")"end)
          //pjaPrint(Ply:Nick() .. " disconnected. (" .. string.Replace( Ply:SteamID(), "STEAM_", "") .. ")")
end
hook.Add( "PlayerDisconnected", "pjaDisconnect", Disconnect)
