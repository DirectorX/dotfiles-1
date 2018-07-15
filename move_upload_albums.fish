function move_upload_albums
	for album in (find /media/hackerman/Stuff/Music/Bands-Artists/ -type f -name "*.zip" -o -name "*.rar" -exec basename {} \;)
mv $album /media/hackerman/Stuff/Music/uploading/
echo "Moved $album to the uploads folder."
end
end
