function playerJoin()
    local joinedPlayer = getPlayerName(source)
    outputChatBox(joinedPlayer .. "hat den Server betreten...", 125, 125, 125)
end

function playerLeave()
    local leftPlayer = getPlayerName(source)
    outputChatBox(leftPlayer ... "hat den Server verlassen...", 125, 125, 125)
end

function onPlayerChangeNicks()
    outputChatBox("Du darfst deinen Namen nicht ändern! Melde dich dazu bei einem Admin.", source, 255, 0, 0)
    cancelEvent()
end

addEventHandler("onPlayerJoin", root, playerJoin)
addEventHandler("onPlayerQuit", root, playerLeave)
addEventHandler("onPlayerChangeNick", root, onPlayerChangeNicks)