if [[ "$INPUT_TAG" == "continuous" ]]; then
	tag='continuous'
else
	tag=$INPUT_TAG
fi

echo "-- Using $tag as a release tag"


if [[ -z "$INPUT_ASSET" ]]; then
	if [[ -z "$INPUT_ARCH" ]]; then
		if [[ "$RUNNER_ARCH" == "X64" ]]; then
			arch="x86_64"
		elif [[ "$RUNNER_ARCH" == "ARM64" ]]; then
			arch="aarch64"
		else
			echo "::error::Unsupported runner ISA ($RUNNER_ARCH). Exiting"
			exit 1
		fi
	else # `$INPUT_ARCH` has a value
		if [[ "$INPUT_ARCH" == "x64" || "$INPUT_ARCH" == "amd64" ]]; then
			arch="x86_64"
		elif [[ "$INPUT_ARCH" == "arm64" || "$INPUT_ARCH" == "arm" ]]; then
			arch="aarch64"
		else
			echo "::error::Unknown ISA ($INPUT_ARCH). Exiting"
			exit 1
		fi
	fi

	asset="linuxdeployqt-continuous-$arch.AppImage"
else
	asset=$INPUT_ASSET
fi

echo "-- Using $asset as an asset"

readarray -t data < <(curl -sf -XGET "https://api.github.com/repos/probonopd/linuxdeployqt/releases/tags/$tag" | \
jq -r --arg file "$asset" '.assets[] | select(.name == $file) | .browser_download_url, (.digest | ltrimstr("sha256:"))')

link="${data[0]}"
hash="${data[1]}"

echo "-- Hash of the needed asset: $hash"
echo "-- Download link: $link"

echo "hash=$hash" >> $GITHUB_OUTPUT
echo "link=$link" >> $GITHUB_OUTPUT