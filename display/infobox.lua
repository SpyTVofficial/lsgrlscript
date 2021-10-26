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
addEvent ( "infobox_start", true )
addEventHandler ( "infobox_start", getRootElement(), infobox_start_func )