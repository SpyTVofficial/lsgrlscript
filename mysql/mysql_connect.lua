local gMysqlHost = "192.168.1.1"
local gMysqlUser = "stdb_user_itsspytv_5242311"
local gMysqlPass = "fbb84a4f4543d2357617"
local gMysqlDatabase = "stdb_user_itsspytv_5242311"
handler = nil
playerUID = {}
playerUIDName = {}


function MySQL_Startup ( ) 
	handler = dbConnect ( "mysql", "dbname=".. gMysqlDatabase .. ";host="..gMysqlHost..";port=3306", gMysqlUser, gMysqlPass )
	if not handler then
		outputDebugString("[MySQL_Startup] Couldn't run query: Unable to connect to the MySQL server!")
		outputDebugString("[MySQL_Startup] Please shutdown the server and start the MySQL server!")
		return
	end	
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,?? FROM ??", "UID", "Name", "players" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["UID"] )
		local name = result[i]["Name"]
		playerUID[name] = id
		playerUIDName[id] = name
	end
	playerUIDName[0] = "none"
	playerUID["none"] = 0
endl
MySQL_Startup()


function saveEverythingForScriptStop ( )
	saveDepotInDB()
	updateBizKasse()
end
addEventHandler ( "onResourceStop", resourceRoot, saveEverythingForScriptStop )