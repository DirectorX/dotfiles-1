function zip_albums_recursive
	for bigfolder in (find . -maxdepth 1 -type d)
for folder in (find -maxdepth 2 -path "$bigfolder/(*)*")
zip -jr "$folder.zip" $folder/*
end
end
end
