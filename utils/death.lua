function playerDeath(thePlayer)
    takePlayerMoney(thePlayer, tonumber(150))
end
addEventHandler("playerDeath", isPlayerDead)