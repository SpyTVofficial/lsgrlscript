function playerDeath(thePlayer)
    takePlayerMoney(thePlayer, tonumber(150))
    spawnPlayer
end
addEventHandler("playerDeath", isPlayerDead)