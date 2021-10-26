setServerPassword("29112005")

function spawnOnLogin()
    spawnPlayer(theplayer, x, y, z, 0, 137, 0, 0)
end
addEventHandler("onPlayerLogin", root, spawnOnLogin)