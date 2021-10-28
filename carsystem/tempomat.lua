curMaxSpeed = false

function limit_func ( cmd, amount )
	if vioClientGetElementData ( "imzugjob" ) or vioClientGetElementData ( "imtramjob" ) then return false end
	local amount = tonumber ( amount )
	if amount then
		local amount = math.abs ( amount )
		curMaxSpeed = amount
		curMaxSpeed = curMaxSpeed*0.00464
		if not isTimer ( curMaxSpeedTimer ) then
			curMaxSpeedTimer = setTimer ( fixSpeed, 50, 0 )
		end
		outputChatBox ( "Maximale Geschwindigkeit auf "..amount.." km/h gesetzt - tippe /stoplimit, um es zu entfernen.", 125, 0, 0 )
	else
		outputChatBox ( "Bitte gib eine gueltige km/h Zahl an!", 125, 0, 0 )
	end
end

function stoplimit_func ()

	if not curMaxSpeed then
		if not vioClientGetElementData ( "imzugjob" ) and not vioClientGetElementData ( "imtramjob" ) then
			outputChatBox ( "Du hast momentan den Tempomat nicht aktiviert - tippe /limit [km/h], um ihn zu aktivieren!", 125, 0, 0 )
		end
	else
		curMaxSpeed = false
		killTimer ( curMaxSpeedTimer )
		outputChatBox ( "Tempomat wurde entfernt!", 0, 125, 0 )
	end
end

function fixSpeed ()

	local veh = getPedOccupiedVehicle(lp)
	if veh then
		if isVehicleOnGround ( veh ) and getPedOccupiedVehicleSeat ( lp ) == 0 then
			local vx, vy, vz = getElementVelocity(veh)
			local speed = math.sqrt(vx^2 + vy^2 + vz^2)
			if speed > curMaxSpeed then
				setElementVelocity ( veh, vx*0.97, vy*0.97, vz*0.97 )
			end
		end
	end
end

addCommandHandler ( "limit", limit_func )
addCommandHandler ( "stoplimit", stoplimit_func )