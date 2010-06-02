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


----registers events for the addon to function---
local Phrot = CreateFrame("Frame")
Phrot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
print("|cffFF387AProtadin|r detected. |cffFF387APink Power|r |cffFF0000go!|r")
Phrot:SetScript("OnEvent", function(self, event, ...)
local event, source, dest, sourceName, destName, missType, id = select(2, ...), select(3, ...), select(4, ...), select(7, ...), select(12, ...)
------------------------------------------------------------------
  local playerName = UnitName("player")--used for the buff check
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
	 




	-------------------------------------------------------------
	 
		--Divine Protection--
   if event == "SPELL_AURA_APPLIED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 498 then
         local spew = format(msgg, GetSpellLink(id),"Used:", ShieldWall_Say)
         Phrot:SpewMessage(spew)
      end
	end
	----------------------------------------------------------------------------
		--Divine Sacrifice--
   if event == "SPELL_AURA_APPLIED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 64205 then
         local spew = format(msgg, GetSpellLink(id),"Used:", Sac_Say)
         Phrot:SpewMessage(spew)
      end
	end
	----------------------------------------------------------------------------	
		--survival instincts--
	--[[
	if event == "SPELL_AURA_APPLIED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 61336 then
         local spew = format(msgg, GetSpellLink(id),"Used:", LastStand_Say)
         Phrot:SpewMessage(spew)
      end
	end
]]
	
	--fade announses--
   if event == "SPELL_AURA_REMOVED" and source == UnitGUID("player") then
		id = select(9, ...)
      if id == 498 or id == 64205 then
         local spew = format(msg, GetSpellLink(id)," ", "FADED")
         Phrot:SpewMessage(spew)
      end 
	  end
	  
	  ----------------------------------------------------------------
	  
	  			--challanging shout used announcments--
		--[[
	if event == "SPELL_CAST_SUCCESS" and source == UnitGUID("player") then
      id = select(9, ...)
      if id == 5209 then
         local spew = format(msgg, GetSpellLink(id),"Used", ChallShout_Say)
         Phrot:SpewMessage(spew)
      end
	end
	  ]]
--------------------------------------------------	
	
	  --taunt, challanging shout and mocking blow resist announcements--
	  
	if event == "SPELL_MISSED" and source == UnitGUID("player") then
		missType = select(12, ...)
		id = select(9, ...)
	if id == 62124 then
    local spew = format(mssg, GetSpellLink(id), "FAILED on:", sourceName, missType)
		Phrot:SpewMessage(spew)
   end
   end
   
			--------------------------------------------------------------------


--interupt test work in progress--

--[[
    if event == "SPELL_INTERRUPT" and source == UnitGUID("player") then
	local spew = format(mssg, sourceName, "II", missType, "Сбил нах!")
		Phrot:SpewMessage(spew)
	end]]
----------------------------------------------------------------------------------------------------------
			
			--[[ to change annoouncments edit the text between "" e.g: "1", can be changed 
			to "2", or if you would like to add new coment just type after the last comment on a new line "exsample text",
			be sure to start with " end with ",						
			--]]



			---------------shield wall announcments---------------------------
   ShieldWallSay = {
	"-50% damage",
}

NumSaySW = table.getn( ShieldWallSay );
SNumSW = math.random( NumSaySW );
ShieldWall_Say = ShieldWallSay[SNumSW];


			---------------4t10--------------------------------------------------------
   SacSay = {
	"-30% Raid Damage",
}

NumSaySW = table.getn( SacSay );
SNumSW = math.random( NumSaySW );
Sac_Say = SacSay[SNumSW];

---------------------------------last stand announcments------------------------------------
	LastStandSay = {
	"+45% HP",
}

NumSayLS = table.getn( LastStandSay );
SNumLS = math.random( NumSayLS );
LastStand_Say = LastStandSay[SNumLS];

------------------------------------------------------------------------------------------



							--[[challanging shout announcments--

	ChallShoutSay = {
	"Mass Taunt",
}
NumSayCS = table.getn( ChallShoutSay );
SNumCS = math.random( NumSayCS );
ChallShout_Say = ChallShoutSay[SNumCS];]]

end)