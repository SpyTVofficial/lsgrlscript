function pay_func ( player, cmd, target, money )

	local money = tonumber ( money )
	if target and getPlayerFromName ( target ) then
		local target = getPlayerFromName ( target )
		if target and money then
			money = math.abs ( math.floor ( money + 0.5 ) )
			local pmoney = vioGetElementData ( player, "money" )
			if pmoney >= money then
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( target )
				if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
					if vioGetElementData ( player, "playingtime" ) >= noobtime then
						if not vioGetElementData ( player, "gotdamoney" ) then
							takePlayerSaveMoney ( player, money )
							givePlayerSaveMoney ( target, money )
							meCMD_func ( player, "meCMD", "steckt "..getPlayerName ( target ).." ein paar Scheine zu..." )
							infobox ( target, "Du hast von\n"..getPlayerName ( player ).." "..money.." $\nerhalten!", 5000, 0, 200, 0 )
							infobox ( player, "Du hast \n"..getPlayerName ( target ).." "..money.." $\ngegeben!", 5000, 0, 200, 0 )
						else
							infobox ( player, "Du darfst\nnoch kein Geld\ngeben!!", 5000, 150, 0, 0 )
						end
					else
						infobox ( player, "\nErst ab 3\nSpielstunden moeglich!", 5000, 150, 0, 0 )
					end
				else
					infobox ( player, "\nDu bist zu\nweit entfernt!", 5000, 150, 0, 0 )
				end
			else
				infobox ( player, "\nSoviel Geld hast\ndu nicht!", 5000, 150, 0, 0 )
			end
		else
			infobox ( player, "\nGebrauch:\n/pay [Name] [Summe]", 5000, 150, 0, 0 )
		end
	end
end
addCommandHandler ( "pay", pay_func )