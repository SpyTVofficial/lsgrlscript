gLabels = { }

function infobox ( text, tts, r, g, b )

	infobox_start_func ( text, tts, r, g, b )
end

--[[function showInfoText_func ()
	
	if not gLabels["InfoTextForum"] then
		gLabels["InfoTextForumShadow"] = guiCreateLabel(10, screenheight-20+1, screenwidth+1, screenheight,"Forum: "..forumURL..", Hilfemenue: F1, Karte: F11",false)
		gLabels["InfoTextForum"] = guiCreateLabel(10, screenheight-20, screenwidth, screenheight,"Forum: "..forumURL..", Hilfemenue: F1, Karte: F11",false)
		guiLabelSetColor(gLabels["InfoTextForum"],125,20,20)
		guiLabelSetColor(gLabels["InfoTextForumShadow"],0,0,0)
		guiSetFont(gLabels["InfoTextForum"],"default-bold-small")
		guiSetFont(gLabels["InfoTextForumShadow"],"default-bold-small")
	end
end
addEvent ( "showInfoText", true )
addEventHandler ( "showInfoText", getRootElement(), showInfoText_func )]]

function infobox_start_func ( text, timetoshow, r, g, b )

	infoboxText = text
	-- DEV --
	while string.sub ( infoboxText, 1, 2 ) == "\n" do
		infoboxText = string.sub ( infoboxText, 3, #infoboxText )
	end
	while string.sub ( infoboxText, #infoboxText-1, #infoboxText ) == "\n" do
		infoboxText = string.sub ( infoboxText, 1, #infoboxText-2 )
	end
	-- DEV --
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
		infoboxIMG = guiCreateStaticImage(x/2-140,5,280,160,"images/black.png",false)
		guiSetAlpha(infoboxIMG, 0.95)
	end
	
	playSoundFrontEnd ( 42 )
	ChatBoxTimer1 = setTimer ( removeInfoboxDraw, timetoshow, 1 )
	ChatBoxTimer2 = setTimer ( destroyElement, timetoshow, 1, infoboxIMG )
end
addEvent ( "infobox_start", true )
addEventHandler ( "infobox_start", getRootElement(), infobox_start_func )

function removeInfoboxDraw ()

	removeEventHandler ( "onClientRender", getRootElement(), infoboxRender )
end

function _CreateInfobox ()
	local x, y = guiGetScreenSize()
	--infoboxText = guiCreateTabPanel ( 4, 4, 135, 90, false )
	infoboxText = guiCreateStaticImage ( x/2-150, 5, 280, 160, "images/black.png", false )
	infoboxTextLabel = guiCreateLabel ( 10,10,122,78,"", false )
	guiLabelSetColor ( infoboxTextLabel, 255, 255, 125 )
	guiSetAlpha ( infoboxText, 1 )
	guiSetAlpha ( infoboxTextLabel, 1 )
	guiSetVisible(infoboxText, false)
	guiSetVisible(infoboxTextLabel, false)
	guiSetFont ( infoboxTextLabel, "default-bold-small" )
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		_CreateInfobox()
	end
)

function showDrawnText_func ( text, timeToShow, r, g, b )

	curDrawedText = text
	curDrawedTextR = tonumber ( r )
	curDrawedTextG = tonumber ( g )
	curDrawedTextB = tonumber ( b )
	addEventHandler ( "onClientRender", getRootElement(), showDrawnText_render )
	setTimer ( function () removeEventHandler ( "onClientRender", getRootElement(), showDrawnText_render ) end, timeToShow, 1 )
end
addEvent ( "showDrawnText", true )
addEventHandler ( "showDrawnText", getRootElement(), showDrawnText_func )

function showDrawnText_render ()

	dxDrawText ( curDrawedText, screenwidth/2-3-200, screenheight/2-3, screenwidth, screenheight, tocolor ( 0, 0, 0, 255 ), 2.5, "pricedown" )
	dxDrawText ( curDrawedText, screenwidth/2-200, screenheight/2, screenwidth, screenheight, tocolor ( curDrawedTextR, curDrawedTextG, curDrawedTextB, 255 ), 2.5, "pricedown" )
end

function infoboxRender ()
	local x, y = guiGetScreenSize()
	dxDrawText(infoboxText,0,5,x,160,tocolor(infoboxR,infoboxG,infoboxB,255),1.4,"default-bold","center","center",false,false,true)
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