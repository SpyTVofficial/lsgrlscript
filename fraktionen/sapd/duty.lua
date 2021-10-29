dutyIcon = createPickup ( 258.57006835938, 109.79203033447, 1002.7518310547, 3, 1247, 50, 0 )
dutyIconGarage = createPickup ( -1611.27, 679.38, -5.25, 3, 1247, 50, 0 )

function dutyhit ( player )
	if isCop ( player ) then
		infobox ( player, "Tippe /goduty, um in den\nDienst zu gehen.", 5000, 200, 200, 0 )
	end
end

function duty (player, cmd, skin)
    if vioGetElementData( player, "fraktion") == 1 then
        local x, y, z = getElementPosition (player)
        local px, py, pz = getElementPosition ( dutyIconGarage )
        if getDistanceBetweenPoints3D ( x, y, z, px3, py3, pz3 ) then
            setElementHealth ( player, 100 )
            setElementHunger ( player, 100 )
            if not isOnDuty(player) then
				-- Schlagstock
				local weapon = 3		
				local ammo = 1
				giveWeapon ( player, weapon, ammo, true )
            	-- Pistol ( 9mm )
				local weapon = 22
				local ammo = 102*2*2
				giveWeapon ( player, weapon, ammo, true )
				setElementModel ( player, 284)
            else
                triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bereits\nim Dienst!", 7500, 125, 0, 0 )
            end
            local armor = 100
            setPedArmor ( player, armor )
            bindKey ( player, "1", "down", tazer_func )
        else
            triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nan der Richtigen\nStelle", 7500, 125, 0, 0 )
        end
    else
        triggerClientEvent( player, "infobox_start", getRootElemen(), "\n Du bist kein\nPolizist!", 7500, 125, 0, 0)
end

addEventHandler ( "onPickupHit", dutyIcon, dutyhit )
addCommandHandler ( "goduty", duty )