function join()
    GUIEditor = {
        window = {},
        button = {},
        }
    
    GUIEditor.window[0] = guiCreateWindow(535,140,500,499,YOUR TITLE,false)
    GUIEditor.button[0] = guiCreateButton(347, 403, 72, 36, "Login", false, GUIEditor.window[0])
end
addEventHandler("onPlayerJoin", root, playerJoin)