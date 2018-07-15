function clean_windows_shit --description Removes\ the\ virus\ \'Thumbs.db\'\ from\ the\ folder\ given.
	for shit in (find $argv -type f -name "Thumbs.db")
echo "Shit found at $shit"
rm $shit
if status 
echo "Shit removed!"
else
echo "Oops, couldn't remove it. Exit code: $status"
end
end
end
