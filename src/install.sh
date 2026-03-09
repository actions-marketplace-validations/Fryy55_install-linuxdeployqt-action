if [[ "$CACHE_HIT" == "true" ]]; then
	echo '-- Cache hit. Skipping installation'
else
	if [[ "$INPUT_CACHE" == "true" ]]; then
		echo "-- Cache miss. Downloading to $INSTALL_PATH"
	else
		echo "-- Ignoring cache. Downloading to $INSTALL_PATH"
	fi

	mkdir -p $INSTALL_PATH
	cd $INSTALL_PATH

	wget -q $DOWNLOAD_LINK
	mv ./*.AppImage linuxdeployqt
	chmod 777 ./linuxdeployqt
fi

echo "-- Adding $INSTALL_PATH to PATH"
echo $INSTALL_PATH >> $GITHUB_PATH

echo '-- Successfully installed linuxdeployqt'