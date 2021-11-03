setServerPassword("")

winterzeit = 1

function spawnOnLogin( root )
    spawnPlayer(source, -1420, -294, 14, 0, 137, 0, 0)
	fadeCamera(source, true)
	setCameraTarget(source, source)
end

function spawnOnDeath( root )
    spawnPlayer(source, -1420, -294, 14, 0, 137, 0, 0)
	fadeCamera(source, true)
	setCameraTarget(source, source)
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


function noblur ( player )
    setPlayerBlurLevel ( player, 0 )
end

function getSecTime ( duration )

	if not duration then
		duration = 0
	end
	local time = getRealTime()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	
	local total = year * 365 * 24 * 60 + day * 24 * 60 + ( hour + duration ) * 60 + minute
	
	return total
end

function getMinTime ()

	return getSecTime ( 0 )
end

addEventHandler("onClientResourceStart", root, noblur)
addEventHandler("onClientResourceStart", root, spawnOnLogin)
addEventHandler("onClientResourceStart", root, spawnOnDeath)