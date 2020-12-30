#############################################################################
#	Env
#############################################################################
#
export APPSCRIPTS="/Users/<username>/Library/Scripts/Applications"

#############################################################################
#	Aliases
#############################################################################
#
# Path Finder
alias uppft='source ~/.zshrc;source ~/Applications/bin/pfterm.kolo.zsh-theme; clear'
alias uppfm='source ~/.zshrc;source ~/Applications/bin/pfmod.kolo.zsh-theme; clear'
alias pfroot='sudo -b "/Applications/Path Finder.app/Contents/MacOS/Path Finder"'
# alias cdpf='cd "$(osascript $APPSCRIPTS/Path\ Finder/getPathFinderPath.scpt)"'

# Apple Mail
mailiaoff='defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes'
mailiaon='defaults write com.apple.mail DisableInlineAttachmentViewing -bool no'

# Campaign Cartographer
alias tflmaps='pushd "${HOME}/Cloud/Google Drive (<username>)/Writing/Projects/Fiction/The Final Lesson/Maps"'
alias cc3='pushd "${HOME}/AppData/CC3"'

#############################################################################
#	Functions
#############################################################################
#
## ImageMagick: To Gray Scale
function image2gray {
	for arg in "$@"; do
		dirname=$(dirname "$arg")
		filename=$(basename "$arg")
		fname="${filename%.*}"
		ext="${filename##*.}"
		gname=$dirname/${fname}_gray.${ext}
		convert $arg -colorspace Gray $gname
	done
}

## ImageMagick: Rounded Corners
function image2round {
	for arg in "$@"; do
		dirname=$(dirname "$arg")
		filename=$(basename "$arg")
		fname="${filename%.*}"
		ext="${filename##*.}"
		rname=$dirname/${fname}_rounded.${ext}
		convert $arg \
		 \( +clone  -alpha extract \
		    -draw 'fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0' \
		    \( +clone -flip \) -compose Multiply -composite \
		    \( +clone -flop \) -compose Multiply -composite \
		 \) -alpha off -compose CopyOpacity -composite  $rname

	done
}
