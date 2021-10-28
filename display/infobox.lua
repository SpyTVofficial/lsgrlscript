function infobox_start_func ( text, timetoshow, r, g, b )

	infoboxText = text
	while string.sub ( infoboxText, 1, 2 ) == "\n" do
		infoboxText = string.sub ( infoboxText, 3, #infoboxText )
	end
	while string.sub ( infoboxText, #infoboxText-1, #infoboxText ) == "\n" do
		infoboxText = string.sub ( infoboxText, 1, #infoboxText-2 )
	end
	if r == nil then
		r = 200
	end
	if g == nil then
		g = 200
	end
	if b == nil then
		b = 200
	end
	infoboxR = r
	infoboxG = g
	infoboxB = b
	
	if isTimer ( ChatBoxTimer1 ) then
		killTimer ( ChatBoxTimer1 )
		killTimer ( ChatBoxTimer2 )
	else
		local x, y = guiGetScreenSize()
		addEventHandler ( "onClientRender", getRootElement(), infoboxRender )
		infoboxIMG = guiCreateStaticImage(x/2-140,5,280,160,"images/infoboxbg.png",false)
		guiSetAlpha(infoboxIMG, 0.95)
	end
	
	playSoundFrontEnd ( 42 )
	ChatBoxTimer1 = setTimer ( removeInfoboxDraw, timetoshow, 1 )
	ChatBoxTimer2 = setTimer ( destroyElement, timetoshow, 1, infoboxIMG )
end

-- #383838══════ #FFD700LSG-RL Info #383838══════
-- ═════════════════════════

function news1 ()
	outputChatBox ( "#383838══════ #FFD700LSG-RL Info #383838══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "╔ Bei Fragen und Problemen benutzt /report", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Um einer Fraktion beizutreten, melde dich im Teamspeak³.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Teamspeak: 151.80.196.135:1578", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╚ Forum: Ultimate-RL.de", getRootElement(), 255, 215, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news2, 600000, 1 )
end
function news2 ()
	outputChatBox ( "#383838══════ #FFD700LSG-RL Info #383838══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "╔ Bei Fragen und Problemen benutzt /report, für alle Admins online /admins.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Nutze /save, um deine Position und deine Waffen zu sichern.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Service Nummern: Polizei - 110 | Sanitäter - 112 | Mechaniker - 300", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╚ Shader kannst du per /shader aktivieren.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news3, 600000, 1 )
end
function news3 ()
	outputChatBox ( "#383838══════ #FFD700LSG-RL Info #383838══════", getRootElement(), 56, 56, 56, true )
	outputChatBox ( "╔ Mit /admins seht ihr, welcher Admin momentan online ist.", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╠ Beim gelben Punkt kannst du dir Scheine kaufen und dich über Jobs informieren.", getRootElement(), 255 , 215, 0 )
	outputChatBox ( "╠ Teamspeak: 151.80.196.135:1578", getRootElement(), 255, 215, 0 )
	outputChatBox ( "╚ Forum: Ultimate-RL.de", getRootElement(), 255, 215, 0 )
	outputChatBox ( "═════════════════════════", getRootElement(), 56, 56, 56 )
	setTimer ( news1, 600000, 1 )
end
setTimer ( news1, 600000, 1 )

function infobox ( player, text, time, r, g, b )

	if isElement ( player ) then
		triggerClientEvent ( player, "infobox_start", getRootElement(), text, time, r, g, b )
	end
end

addEvent ( "infobox_start", true )
addEvent ( "deActivateCustomRadar", true )
addEventHandler ( "infobox_start", getRootElement(), infobox_start_func )