
function goto_func(player,command,tplayer)
	if isAdminLevel ( player, adminLevels["T-Supporter"] ) and ( not client or client == player ) then
		if tplayer then
			local target = findPlayerByName ( tplayer )	
			if not isElement(target) then
				outputChatBox ( "Der Spieler ist offline!", player, 125, 0, 0 )
				return
			end			
			local x, y, z = getElementPosition( target )	
			if getPedOccupiedVehicleSeat ( player ) == 0 then			
				setElementInterior ( player, getElementInterior(target) )
				setElementInterior ( getPedOccupiedVehicle(player), getElementInterior(target) )
				setElementPosition ( getPedOccupiedVehicle ( player ), x+3, y+3, z )
				setElementDimension ( getPedOccupiedVehicle ( player ), getElementDimension ( target ) )
				setElementDimension ( player, getElementDimension ( target ) )
				setElementVelocity(getPedOccupiedVehicle(player),0,0,0)
				setElementFrozen ( getPedOccupiedVehicle(player), true )
				setTimer ( setElementFrozen, 500, 1, getPedOccupiedVehicle(player), false )				
			else			
				removePedFromVehicle ( player )
				setElementPosition ( player, x, y + 1, z )
				setElementInterior ( player, getElementInterior(target) )
				setElementDimension ( player, getElementDimension ( target ) )				
			end			
			outputAdminLog ( getPlayerName ( player ).." hat sich zu "..getPlayerName ( target).." teleportiert!" )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nGebrauch:\n/tp NAME", 5000, 255, 0, 0 )
		end	
	else	
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )		
	end	
end

function ochat_func ( player, cmd, ... )
	local parametersTable = {...}
	local stringWithAllParameters = table.concat( parametersTable, " " )
	if isAdminLevel ( player, adminLevels["Supporter"] ) then
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
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\n Admin!", 5000, 125, 0, 0 )		
	end	
end


addCommandHandler ( "goto", goto_func )
addCommandHandler ( "ochat", ochat_func )

