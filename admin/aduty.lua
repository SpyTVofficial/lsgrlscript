local admindutyskin = 260
local admindutycar = 411
local clantagwithsquarebracket = false
local admindutyarray = {vehicles = {}, skins = {} }
local x, y, z = getElementPosition ( player )
local rx, ry, rz = getElementRotation ( player )
local name = getPlayerName ( player )

function adminDuty( player )
	if vioGetElementData ( player, "adminlvl" ) >= 7 then
		if not admindutyarray.skins[player] then
			executeCommandHandler ( "meCMD", player, "ist dem Admnduty beigetreten!")
			admindutyarray.skins[player] = getElementModel ( player )
			setElementModel ( player, admindutyskin )
			admindutyarray.vehicles[player] = createVehicle ( admindutycar, x+2, y, z, rx, ry, rz, name )
			setVehicleDamageProof ( admindutyarray.vehicles[player], 255, 255, 0 )
			addEventHandler( "onPlayerQuit", player, quitAdminDuty )
			addEventHandler( "onPlayerWeaponSwitch", player, dontHoldWeaponInAdminDuty )
		else
			triggetClientEvent ( player, "notInAdminDuty", player )
			executeCommandHandler ( "meCMD", player, "hat den Admnduty verlassen!")
			setElementModel ( player, admindutyarray.skins[player] )
			admindutyarray.skins[player] = nil 
			if admindutyarray.vehicles[player] and isElement ( admindutyarray.vehicles[player] ) then
				destroyElement ( admindutyarray.vehicles[player] )
				admindutyarray.vehicles[player] = nil
			end
			removeEventHandler( "onPlayerQuit", player, quitAdminDuty )
			removeEventHandler( "onPlayerWeaponSwitch", player, dontHoldWeaponInAdminDuty )
		end
	else
		infobox ( player, "Du bist \nnicht befugt!", 4000, 155, 0, 0 )
	end
end

function quitAdminDuty ( )
	if admindutyarray.skins[source] then
		admindutyarray.skins[source] = nil
	end
	if admindutyarray.vehicles[source] and isElement ( admindutyarray.vehicles[source] ) then
		destroyElement ( admindutyarray.vehicles[source] )
		admindutyarray.vehicles[source] = nil 
	end
end

function stopEnterTheAdminCar ( player, _, _, door )
	if door == 0 and player ~= getPlayerByAdminVehicle ( source ) then
		cancelEvent()
	end
end


function getPlayerByAdminVehicle ( vehicle )
	for player, veh in pairs ( admindutyarray.vehicles ) do
		if veh == vehicle then
			return player
		end
	end
	return false
end


function adminCarDestroyed ( )
	for key, vehicle in pairs ( admindutyarray.vehicles ) do
		if vehicle == source then
			admindutyarray.vehicles[key] = nil
		end
	end
end


function dontHoldWeaponInAdminDuty ( )
	setPedWeaponSlot ( source, 0 )
end

addCommandHandler ( "aduty", adminDuty)
