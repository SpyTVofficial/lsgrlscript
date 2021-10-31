function toggleEngine ( thePlayer ) 
    local isOn = getVehicleEngineState ( getPedOccupiedVehicle(thePlayer) ) 
    if isPedInVehicle ( thePlayer ) then 
        if isOn == true then 
            setVehicleEngineState ( getPedOccupiedVehicle(thePlayer), false ) 
        elseif isOn == false then 
            setVehicleEngineState ( getPedOccupiedVehicle(thePlayer), true ) 
        end 
    end 
end 

  
function toggleVehicleLights ( player, key, state )
	if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
		local veh = getPedOccupiedVehicle ( player )
		if getElementModel ( veh ) ~= 438 then
			if ( getVehicleOverrideLights ( veh ) ~= 2 ) then
				setVehicleOverrideLights ( veh, 2 )
				vioSetElementData ( veh, "light", true)
			else
				setVehicleOverrideLights ( veh, 1 )
				vioSetElementData ( veh, "light", false)
			end
		end
	end
end

function toggleVehicleTrunkBind ( player, key, state )

	local veh = getPedOccupiedVehicle ( player )
	if getPedOccupiedVehicleSeat ( player ) == 0 and vioGetElementData ( veh, "engine" ) then
		if vioGetElementData ( veh, "owner" ) then
			if vioGetElementData ( veh, "stuning1" ) then
				if vioGetElementData ( veh, "engine" ) then
					toggleVehicleTrunk ( veh )
					unbindKey ( player, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
					setTimer ( rebindTrunk, 750, 1, player )
				else
					outputChatBox ( "Der Motor muss laufen!", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Dieses Fahrzeug hat keinen Kofferraum!", player, 125, 0, 0 )
			end
		end
	end
end

function bindControls ( player ) 
    bindKey ( player, "o", "down", toggleEngine, "Motor an/aus" ) 
    bindKey ( player, "l", "down", toggleVehicleLights, "Licht an/aus")
    bindKey ( player, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
	outputChatBox("Keybinds neu angelegt!", source, 0, 255, 0)
end 

function vehexit ()
	unbindKey ( source, "l", "down", toggleVehicleLights, "Licht an/aus"  )
	unbindKey ( source, "o", "down", toggleVehicleEngine, "Motor an/aus" )
	unbindKey ( source, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
end

addCommandHandler ("rebind", bindControls)
addEventHandler ( "onPlayerJoin", getRootElement(), bindControls ) 