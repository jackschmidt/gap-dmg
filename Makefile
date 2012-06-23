
# Where is a decent copy of GAP to stuff into the app?
# It should have a workspace compiled as bin/workspace.
# It should have its packages compiled.
GAPDIR=$(HOME)/svn/gap/4.5/gap4r5
#GAPDIR=gap4r5

all: GAP.dmg

GAP:
	mkdir -p -m 755 $@
	chmod 755 $@

GAP/GAP.app: open_gap.scpt
	osacompile -o $@ $<
	cp -a 2008_gap_icon.icns GAP/GAP.app/Contents/Resources/applet.icns

GAP/GAP.app/gap4r5: GAP/GAP.app
	rsync -a $(GAPDIR)/ $@

GAP/GAP.app/gap4r5/bin/workspace:
	echo 'SaveWorkspace("'$@'");' | GAP/GAP.app/gap4r5/bin/gap.sh

GAP/background.png: background.png
	cp -a $< $@

background.png: background.svg
	echo Hmm, I used Adobe Illustrator to convert it


ro-GAP.dmg: GAP GAP/background.png GAP/GAP.app GAP/GAP.app/gap4r5 GAP/GAP.app/gap4r5/bin/workspace
	hdiutil create -srcfolder GAP $@ -ov

rw-GAP.dmg: ro-GAP.dmg
	hdiutil convert $< -format UDRW -o $@ -ov

GAP.dmg: rw-GAP.dmg
	open rw-GAP.dmg
	sleep 5
	osascript dmg_background.scpt
	diskutil eject /Volumes/GAP
	hdiutil convert rw-$@ -format UDZO -imagekey zlib-level=9 -o $@ -ov

tidy:
	rm -f ro-GAP.dmg rw-GAP.dmg

tidy2: tidy
	rm -rf GAP

clean: tidy2
	rm -rf GAP.dmg
