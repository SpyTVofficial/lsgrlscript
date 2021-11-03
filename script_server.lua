setServerPassword("29112005")

function spawnOnLogin()
    spawnPlayer(source, -1420, -294, 14)
	fadeCamera(source, true)
	setCameraTarget(source)
end

function spawnOnDeath()
    spawnPlayer(thePlayer, -1420, -294, 14, 0, 137, 0, 0)
end

function checkLogout ()

	local x, y, z = getElementPosition ( lp )
	logoutRuns = logoutRuns + 1
	if x == logoutX and y == logoutY and z == logoutZ and not isPedDead ( lp ) then
		if logoutRuns == 60 then
			triggerServerEvent ( "logoutPlayer", lp, x, y, z, getElementInterior ( lp ), getElementDimension ( lp ) )
		elseif logoutRuns/10 == math.floor ( logoutRuns/10+.01 ) then
			outputChatBox ( "[System] Du wirst in "..((60-logoutRuns)/2).." Sekunden ausgeloggt!", 150, 150, 0 )
		end
	else
		outputChatBox ( "Logout abgebrochen!", 125, 0, 0 )
		killTimer ( logoutTimer )
	end
end

addEventHandler("onClientResourceStart", root, spawnOnLogin)