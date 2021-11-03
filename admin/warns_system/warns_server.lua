function getPlayerWarnCount ( name )
	local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "UID", "warns", "UID", playerUID[name] ), -1 )
	local count = 0
	if result and result[1] then
		count = #result
	end
	return count
end
