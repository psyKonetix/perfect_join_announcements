AddCSLuaFile()
if not CLIENT then return end

local function pjaPrint(Message)
     print(Color(149, 26, 232), "[PJA] ", Message)
end

pjaPrint("Perfect Join Announcements Message Handler has loaded.")

net.Receive("pjaMessageHandler", function(len)
	local Data = net.ReadTable()
	local Colour = Data[1]
	local Name = Data[2]
	local Message = Data[3]
	chat.AddText(Colour,Name,Color(255,255,255),Message)
end)
