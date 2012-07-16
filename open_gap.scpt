set GAPDIR to (POSIX path of (path to me)) & "/gap4r5/"

tell application "Terminal"
	activate
	tell application "System Events" to tell process "Terminal"
		keystroke "t" using command down
	end tell
	repeat with w in every window
		try
			if frontmost of w is true then
				set myWindow to w
			end if
		end try
	end repeat
	set myTab to selected tab of myWindow
	tell myTab
		set custom title to "GAP"
		do script ("exec " & GAPDIR & "bin/*64/gap -l " & GAPDIR ) in myTab
	end tell
end tell
