function toggleEngine ( thePlayer ) 
    local isOn = getVehicleEngineState ( getPlayerOccupiedVehicle(thePlayer) ) 
    if isPlayerInVehicle ( thePlayer ) then 
        if isOn == true then 
            setVehicleEngineState ( getPlayerOccupiedVehicle(thePlayer), false ) 
            outputChatBox ( "*Engine off*", thePlayer ) 
        elseif isOn == false then 
            setVehicleEngineState ( getPlayerOccupiedVehicle(thePlayer), true ) 
            outputChatBox ( "*Engine on*", thePlayer ) 
        end 
    end 
end 


function bindControls ( ) 
    bindKey ( thePlayer, "o", "down", toggleEngine ) 
end 
  
addEventHandler ( "onPlayerJoin", getRootElement(), bindControls ) 