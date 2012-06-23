tell application "Finder"
    set diskname to "GAP"
    tell disk diskname
        open
	if get count of (alias files whose name is "Applications") = 0
	  make new alias at (POSIX file "/Volumes/GAP") to (path to applications folder as alias)
        end if
        set current view of container window to icon view
        set toolbar visible of container window to false
        set statusbar visible of container window to false
        set bounds of container window to {200, 100, 800, 300}
        set theViewOptions to the icon view options of container window
        set arrangement of theViewOptions to not arranged
        set icon size of theViewOptions to 100
        set text size of theViewOptions to 14
	do shell script "SetFile -a v /Volumes/" & quoted form of diskname & "/background.png"
        set background picture of theViewOptions to file "background.png"
	do shell script "SetFile -a V /Volumes/" & quoted form of diskname & "/background.png"
        set file_list to every file
        repeat with i in file_list
            if the name of i is "Applications" then
                set the position of i to {450, 100}
            else if the name of i ends with ".app" then
                set the position of i to {150, 100}
            else if the name of i ends with ".png" then
                set the position of i to {300, 100}
            end if
            set the label index of i to 0
        end repeat
        update without registering applications
        delay 4
	close
	open
    end tell
end tell
