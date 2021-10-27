function sendMessageToNearbyPlayers ( message, messageType )
	local pname = getPlayerName ( source )
	
	if messageType == 0 and chatAble ( source ) then
		if tonumber(vioGetElementData ( source, "muted" )) == 0 then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			if vioGetElementData ( source, "isLive" ) then
				if isReporter ( source ) then name = "Reporter "..getPlayerName(source).." : " else name = "Gast "..getPlayerName(source).." : " end
				outputChatBox ( name..message, getRootElement(), 200, 150, 0 )
			else
				local x1, y1, z1 = getElementPosition ( source)
				for i = 1, 3 do
					if isElement( _G["Wanze"..i] ) then
						local x2, y2, z2 = getElementPosition ( _G["Wanze"..i] )
						local x3, y3, z3 = getElementPosition ( FederalBoxville )
						local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
						if distance then
							if distance <= 10 then
								if getDistanceBetweenPoints3D ( x3, y3, z3, x2, y2, z2 ) <= wanzenrange then
									local msg = "Wanze "..i.." - "..getPlayerName(source)..": "..message
									sendMSGToBoxville ( msg )
								end
							end
						end
					end
				end
				outputLog ( pname.. " sagt: " ..message, "Chat" )
				for i=1, #nearbyPlayers do
					local nearbyPlayer = nearbyPlayers[i]
					local x2, y2, z2 = getElementPosition ( nearbyPlayer )
					local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
					local rgb = 15 * distance - 125
					local rgb = math.abs ( rgb - 255 ) + 125
					if getElementDimension ( source ) == getElementDimension ( nearbyPlayer ) then
						if vioGetElementData ( source, "call" ) then
							if isElement ( nearbyPlayer ) then
								outputChatBox ( pname.. " (Handy) sagt: " ..message, nearbyPlayer, rgb, rgb, rgb )
							end
						else
							if vioGetElementData ( source, "callswithpolice" ) == true then
								local taeter = getPlayerFromName ( message )
								if taeter then
									outputChatBox ( "Wir werden der Sache nachgehen.", source, 0, 0, 200 )
									crime = "none"
									if vioGetElementData ( taeter, "lastcrime" ) == "mord" then
										crime = "Mord"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "drogen" then
										crime = "Drogennehmen"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "drugdealing" then
										crime = "Drogenhandel"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "mats" then
										crime = "Waffenhandel"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "violance" then
										crime = "Körperverletzung"
									end
									if crime ~= "none" then
										outputChatBox ( "Du hast ein Verbrechen begangen: "..crime..", gemeldet von: "..getPlayerName(source), taeter, 0, 0, 150 )
										if vioGetElementData ( taeter, "wanteds" ) <= 5 then
											vioSetElementData ( taeter, "wanteds", vioGetElementData ( taeter, "wanteds" ) + 1 )
											setPlayerWantedLevel ( taeter, vioGetElementData ( taeter, "wanteds" ) )
										end
										vioSetElementData ( taeter, "lastcrime", "none" )
									end
								else
									outputChatBox ( "Es tut uns Leid Sir, der Täter ist uns unbekannt.", source, 0, 0, 200 )
								end
								vioSetElementData ( source, "callswithpolice", false )
							elseif vioGetElementData ( source, "callswithmedic" ) == true then
								vioSetElementData ( source, "callswithmedic", false )
								sendMSGForFaction ( "[ACHTUNG] "..getPlayerName(source).." braucht Hilfe: "..message, 10, 0, 255, 0 )
								sendMSGForFaction ( "Ihr könnt helfen mit \"/komme NAME\".", 10, 0, 255, 0 )
								outputChatBox ( "Bitte warten Sie an ihrer Position!", source, 200, 200, 200 )
								local x, y, z = getElementPosition ( source )
								chatHelpBlipMedic[source] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999, nil)
								setElementVisibleTo ( chatHelpBlipMedic[source], getRootElement(), false )
								for playeritem, key in pairs (fraktionMembers[10]) do
									setElementVisibleTo ( chatHelpBlipMedic[source], playeritem, true )
								end
								vioSetElementData ( source, "needhelpmedic", true )
								if isTimer(playerHelpBlipTimerMedic[source]) then
									killTimer ( playerHelpBlipTimerMedic[source] )
									if isElement(chatHelpBlipMedic[source]) then
										destroyElement ( chatHelpBlipMedic[source] )
									end
								end
								playerHelpBlipTimerMedic[source] = setTimer ( function(player) if isElement(chatHelpBlipMedic[player]) then destroyElement(chatHelpBlipMedic[player]) end end, 3*60*1000, 1, source )
							elseif vioGetElementData ( source, "callswithmechaniker" ) == true then
								vioSetElementData ( source, "callswithmechaniker", false )
								sendMSGForFaction ( "[ACHTUNG] "..getPlayerName(source).." braucht Hilfe: "..message, 11, 0, 255, 0 )
								sendMSGForFaction ( "Ihr könnt helfen mit \"/komme NAME\".", 11, 0, 255, 0 )
								outputChatBox ( "Bitte warten Sie an ihrer Position!", source, 200, 200, 200 )
								local x, y, z = getElementPosition ( source )
								chatHelpBlipMechaniker[source] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999, nil)
								setElementVisibleTo ( chatHelpBlipMechaniker[source], getRootElement(), false )
								for playeritem, key in pairs (fraktionMembers[11]) do
									setElementVisibleTo ( chatHelpBlipMechaniker[source], playeritem, true )
								end
								vioSetElementData ( source, "needhelpmechaniker", true )
								if isTimer(playerHelpBlipTimerMechaniker[player]) then
									killTimer ( playerHelpBlipTimerMechaniker[player] )
									if isElement(chatHelpBlipMechaniker[player]) then
										destroyElement ( chatHelpBlipMechaniker[player] )
									end
								end
								playerHelpBlipTimerMechaniker[source] = setTimer ( function(player) if isElement(chatHelpBlipMechaniker[player]) then destroyElement(chatHelpBlipMechaniker[player]) end end, 3*60*1000, 1, source )
							else
								outputChatBox ( pname.. " sagt: " ..message, nearbyPlayer, rgb, rgb, rgb )
							end
						end
					end
				end
			end
			if isElement ( vioGetElementData(source,"callswith") ) then
				local target = vioGetElementData(source,"callswith")
				outputChatBox ( pname.." am Handy: "..message, target, 200, 200, 50 )
			end
		else
			outputChatBox ( "Du bist gemuted und kannst deshalb nicht sprechen!", source, 125, 0, 0 )
		end
	else
		if messageType == 2 then
			executeCommandHandler ( "t", source, message )
		elseif messageType == 1 then
			if tonumber(vioGetElementData ( source, "muted" )) == 0 then
				local posX, posY, posZ = getElementPosition( source )
				local chatSphere = createColSphere( posX, posY, posZ, 20 )
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				destroyElement( chatSphere )
				for i=1, #nearbyPlayers do
					local pname = getPlayerName ( source )
					outputChatBox ( pname.." "..message, nearbyPlayers[i], 100, 0, 200 )
				end
				outputLog (  pname.." "..message, "Chat" )
			else
				outputChatBox ( "Du bist gemuted und kannst deshalb nicht sprechen!", source, 125, 0, 0 )
			end
		end
	end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )