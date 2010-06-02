local Phrot = {}

--announces addon enabled--
if not (select(2,UnitClass("player")) == "PALADIN") then return end

----------------------------------------------------

--format for the messages-------------
local msg = "%s %s >>%s<<"
local ms = "%s %s %s %s"
local mssg = "%s %s %s >>%s<<"
local msgg = "%s %s %s"
------------------------------------------

--Spam No More.

local freq1 = 3
local anno1 = time()


----registers events for the addon to function---

local Phrot = CreateFrame("Frame")
Phrot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
print("|cffFF387AProtadin|r detected. |cffFF387APink Power|r |cffFF0000go!|r")

Phrot:SetScript("OnEvent", function(self, event, ...)
local event, source, dest, sourceName, destName, missType, id = select(2, ...), select(3, ...), select(4, ...), select(7, ...), select(12, ...)
------------------------------------------------------------------

local playerName = UnitName("player")		--used for the buff check
		
----------message output detairmins channels to use------
		
function Phrot:SpewMessage(spew)
        if (GetNumRaidMembers() > 0) then
			SendChatMessage(spew, "RAID")
        elseif (GetNumPartyMembers() > 0) then
			SendChatMessage(spew, "PARTY")
		else
			SendChatMessage(spew, "EMOTE")--
		end     
    end
		--Divine Protection--
   if event == "SPELL_AURA_APPLIED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 498 then
         local spew = format(msgg, GetSpellLink(id),"Used:", ShieldWall_Say)
         Phrot:SpewMessage(spew)
      end
	end
		--Divine Sacrifice--
   if event == "SPELL_AURA_APPLIED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 64205 then
		if ((anno1 + freq1) < time()) then
			anno1 = time()
         local spew = format(msgg, GetSpellLink(id),"Used:", Sac_Say)
         Phrot:SpewMessage(spew)
		end
      end
	end
	
	--Announce Fades--
   if event == "SPELL_AURA_REMOVED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 498 or id == 64205 then
		if ((anno1 + freq1) < time()) then
			anno1 = time()
         local spew = format(msg, GetSpellLink(id)," ", "FADED")
         Phrot:SpewMessage(spew)
		 end
      end 
	  end
	
	  --Missed Taunts?
	  
	if event == "SPELL_MISSED" and source == UnitGUID("player") then
		missType = select(12, ...)
		id = select(9, ...)
	if id == 62124 then
		if ((anno1 + freq1) < time()) then
			anno1 = time()
    local spew = format(mssg, GetSpellLink(id), "FAILED on:", sourceName, missType)
		Phrot:SpewMessage(spew)
		end
   end
   end

   --Divine Protection
   ShieldWallSay = {
	"-50% damage",
}

NumSaySW = table.getn( ShieldWallSay );
SNumSW = math.random( NumSaySW );
ShieldWall_Say = ShieldWallSay[SNumSW];

	--Divine Sacrifice
   SacSay = {
	"-30% Raid Damage",
}

NumSaySW = table.getn( SacSay );
SNumSW = math.random( NumSaySW );
Sac_Say = SacSay[SNumSW];
end)