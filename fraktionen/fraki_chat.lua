factionColours = {}
factionRankNames = {}
    local i = 0

    i = i + 1
    i = i + 1
	factionColours[i] = {}
		factionColours[i][1], factionColours[i][2], factionColours[i][3] = 50, 50, 255
	factionRankNames[i] = {}
		factionRankNames[i][0] = "Azubi"
		factionRankNames[i][1] = "Officer"
		factionRankNames[i][2] = "Sergeant"
		factionRankNames[i][3] = "Lieutenant"
		factionRankNames[i][4] = "Stellv. Polizeichef"
		factionRankNames[i][5] = "Polizeichef"
function teamchat_func ( player, cmd, ... )	
    local parametersTable = {...}
    local text = table.concat( parametersTable, " " )
    local Fraktion = vioGetElementData ( player, "fraktion" )
    local FRank = vioGetElementData ( player, "rang" )
    if Fraktion and Fraktion >= 1 then
        if not text then
            triggerClientEvent ( player, "infobox_start", getRootElement(), "\nBitte einen\nText eingeben!", 5000, 125, 0, 0 )
        else
            local red = 0
            local green = 0
            local blue = 0
            local title = "intern"
            if factionRankNames[Fraktion][FRank] then
                title = factionRankNames[Fraktion][FRank]
                red, green, blue = factionColours[Fraktion][1], factionColours[Fraktion][2], factionColours[Fraktion][3]
            end
                    
            for playeritem, index in pairs(fraktionMembers[Fraktion]) do 
            if isElement ( playeritem ) then
                outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.." ]", playeritem, red, green, blue )
            else
                fraktionMembers[Fraktion][playeritem] = nil
            end
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
    end
end

addCommandHandler ( "t", teamchat_func )