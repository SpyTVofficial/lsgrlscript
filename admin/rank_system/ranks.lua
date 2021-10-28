local adminLevels = {
	["VIP"] = 1,
	["T-Supporter"] = 2,
	["Supporter"] = 3,
	["T-Moderator"] = 4,
    ["Moderator"] = 5,
    ["Sr. Moderator"] = 6,
	["Administrator"] = 7,
	["Projektleiter"] = 8
}

function adminlist ( player )
	outputChatBox ( "Momentan online:", player, 0, 100, 255 )
	local pl = {}
	local adm = {}
	local srmod = {}
	local mod = {}
	local tmod = {}
    local supp = {}
    local tsupp = {}


	for playeritem, rang in pairs (adminsIngame) do
		if rang == 8 then
			pl[playeritem] = true
		elseif rang == 7 then
			adm[playeritem] = true
		elseif rang == 6 then
			srmod[playeritem] = true
		elseif rang == 5 then
			mod[playeritem] = true
		elseif rang == 4 then
			tmod[playeritem] = true
        elseif rang == 3 then
			supp[playeritem] = true
        elseif rang == 2 then
			tsupp[playeritem] = true
		end
	end
	for playeritem,_ in pairs ( pl ) do 
		outputChatBox ( getPlayerName(playeritem)..", Projektleiter", player, 180, 0, 0 )
	end
	for playeritem,_ in pairs ( adm ) do 
		outputChatBox ( getPlayerName(playeritem)..", Administrator", player, 232, 174, 0 )
	end
	for playeritem,_ in pairs ( srmod ) do 
		outputChatBox ( getPlayerName(playeritem)..", Sr. Moderator", player, 0, 51, 255 )
	end
	for playeritem,_ in pairs ( mod ) do 
		outputChatBox ( getPlayerName(playeritem)..", Moderator", player, 0, 51, 255 )
	end
	for playeritem,_ in pairs ( tmod ) do 
		outputChatBox ( getPlayerName(playeritem)..", Probe-Moderator", player, 0, 51, 255 )
	end
    for playeritem,_ in pairs (supp) do
        outputChatBox ( getPlayerName(playeritem).. ", Supporter", player, 0, 0, 180 )
    end
    for playeritem,_ in pairs (tmod) do 
        outputChatBox ( getPlayerName(playeritem).. ", Probe-Supporter", player, 0, 0, 255)
    end
end

function ochat_func ( player, cmd, ... )
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isAdminLevel ( player, adminLevels["Probe-Supporter"] ) then
		if stringWithAllParameters == nil then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )	
		else
			local rang = vioGetElementData ( player, "adminlvl" )
			local rank = ""
			if rang == 2 then
				rank = "Probe-Supporter"
			elseif rang == 3 then
				rank = "Supporter"
			elseif rang == 4 then
				rank = "Probe-Moderator"
			elseif rang == 5 then
				rank = "Moderator"
			elseif rang == 6 then
				rank = "Sr. Moderator"
            elseif rang == 7 then
                rank = "Administrator"
            elseif rang == 8 then 
                rank = "Projektleitung"
			end
			outputChatBox ( "(( "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ))", getRootElement(), 255, 255, 255 )	
		end	
	else	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\n Teammitglied!", 5000, 125, 0, 0 )		
	end	
end

function achat_func ( player, cmd, ... )		
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isAdminLevel ( player, adminLevels["Ticketsupporter"] ) then
		if stringWithAllParameters == nil then		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )		
		else					
			local rang = vioGetElementData ( player, "adminlvl" )
			local rank = ""
			if rang == 2 then
				rank = "Probe-Supporter"
			elseif rang == 3 then
				rank = "Supporter"
			elseif rang == 4 then
				rank = "Probe-Moderator"
			elseif rang == 5 then
				rank = "Moderator"
			elseif rang == 6 then
				rank = "Sr. Moderator"
            elseif rang == 7 then
                rank = "Administrator"
            elseif rang == 8 then 
                rank = "Projektleitung"
			end
			for playeritem, index in pairs(adminsIngame) do 			
				if index >= 2 then
					outputChatBox ( "[ "..rank.." "..getPlayerName(player)..": "..stringWithAllParameters.." ]", playeritem, 99, 184, 255 )
				end				
			end		
		end	
	elseif vioGetElementData ( player, "adminlvl" ) == 1 then
		if stringWithAllParameters == nil then		
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )		
		else	
			for playeritem, index in pairs(adminsIngame) do 	
				if index == 1 then
					if not donatorMute[playeritem][getPlayerName(player)] or donatorMute[playeritem][getPlayerName(player)] == nil then
						outputChatBox ( "[ "..getPlayerName(player)..": "..stringWithAllParameters.." ]", playeritem, 99, 184, 255 )
					end
				end				
			end		
		end	
	else	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist\nkein Teammitglied!", 5000, 125, 0, 0 )		
	end	
end