#############################################################################
#	Aliases
#############################################################################
#
# become root #
alias root='sudo -i'
alias su='sudo -i'

# un-shadow an aliased command #
alias noalias='command'

alias aliasg='alias | grep'
alias bold='echo -e "\033[1"'
alias bye='exit'
alias catl='cat -s'
alias clearb='printf "\ec\e[3J"'  #clear terminal buffer
alias cls='clear'
alias env='env | sort'
alias envg='env | grep'
alias envgi='env | grep -i'
alias f=finger
alias fastping='ping -c 100 -s.2' # Do not wait interval 1 second, go fast #
alias fileenc='file -I '
alias fkill='sudo pkill -9 '
alias func='declare -F'
alias genindex="tree -H '.' -L 1 --noreport --charset utf-8 > index.html"
alias grep='grep --color=auto'
alias h='history'
alias hsg='history | grep'
alias hsgi='history | grep -i'
alias j='jobs -l'
alias lctlg='launchctl list | grep'
alias lo=logout
alias psg='ps -A | grep'
alias m='less -a -i -P='
alias mank='man -k'
alias mano='openman '
alias manp='man -t "$@" | open -f -a "Preview" ;'
alias manx='open x-man-page://$@ ;'
alias mkdir='mkdir -p'
alias mount='mount | column -t'
alias norm='tput sgr0'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias nowtime=now
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5' # Stop after sending count ECHO_REQUEST packets #
alias ports='netstat -tulanp'
alias purgespace='echo "creating purge file: hit ctrl+c to terminate" ; dd if=/dev/random of=${HOME}/purgefile bs=15m'
alias set='set | sort'
alias setg='set | grep'
alias setgi='set | grep -i'
alias unbold='echo -e "\033[0"'
alias up='cd ..'
alias upenv='source ~/.zshrc'
alias wget='wget -c'  #resume wget by default
alias whence="whence -v"
alias zapf='rm -f *.~*~ .*.~*~ .*~ *~ #*#'
alias zapi='rm -i *.~*~ .*.~*~ .*~ #*#'
alias listfunc='declare -f'
alias setperms='find . -type f -exec chmod 644 {} \;; find . -type d -exec chmod 755 {} \;'
alias chx='chmod +x'

# brew stuff
alias upbrew='brew update && brew install'
alias brewgraph='brew graph --installed | fdp -Tpng -o$ADMIN_PATH/brew_graph.png; open $ADMIN_PATH/brew_graph.png'
alias brewdeps='brew deps --installed'
alias brewlsv='brew ls --verbose'

# Paragon NTFS for Mac command line tools
alias ntfsverify='/usr/local/sbin/fsck_ufsd_NTFS -n'
alias ntfsfix='/usr/local/sbin/fsck_ufsd_NTFS -y'

# Time Machine Maintenence
alias tmlist='tmutil listlocalsnapshots /'
alias tmdel='sudo tmutil deletelocalsnapshots '

# terminal list aliases
alias ls='ls -G'
alias ll='ls -lah'
alias lsg='ls | grep'
alias llg='ls -al | grep'
alias la='ls -1'
alias lll='ls -lahL'
alias lr='ls -lahR | more'
alias lsdir="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias lst='ls -lsth'
alias lt='ls -lath'
alias lth='ls -lath | head -20'
alias sl='ls'
alias tree='tree -CQ'
alias treea='tree --charset=ascii'
alias tsdir='tree -Ndl'

# getting around
alias cdd='\cd'
alias cd..='cd ..'  # Get rid of command not found
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

#alias ls='ls -Fb'
#alias wakeupnas01='/usr/bin/wakeonlan 00:11:32:11:15:FC' # Replace mac with your actual server mac address #
#alias zap='yes | purge ; ls'	# Yes doesn't terminate here
#alias rm='rm -I --preserve-root'  # do not delete / or prompt if deleting more than 3 files at a time #
# confirmation #
#alias mv='mv -i'
#alias cp='cp -i'
#alias ln='ln -i'
# Parenting changing perms on / #
#alias chown='chown --preserve-root'
#alias chmod='chmod --preserve-root'
#alias chgrp='chgrp --preserve-root'

#############################################################################
#	Functions
#############################################################################
#
######## TESTER ########
function tester {
	convert $1 \
	 \( +clone  -alpha extract \
	    -draw 'fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0' \
	    \( +clone -flip \) -compose Multiply -composite \
	    \( +clone -flop \) -compose Multiply -composite \
	 \) -alpha off -compose CopyOpacity -composite  ${1}.png
}

## Search for launchd plist files ##
findLaunchPlist () {
    LaunchctlPATHS=( \
        ~/Library/LaunchAgents \
        /Library/LaunchAgents \
        /Library/LaunchDaemons \
        /System/Library/LaunchAgents \
        /System/Library/LaunchDaemons \
    )

    for curPATH in "${LaunchctlPATHS[@]}"
    do
        grep -R "$curPATH" -e "$1"
    done
    return 0;
}

## Find the absolute path for running application by PID ##
findPIDPath () {
	which `ps -o comm= -p $1`
	return 0;
}

## Load/Unload Hog Launch Daemons ##
hogDaemonListLoadUnload () {
    LaunchctlPATHS=( \
		/Library/LaunchDaemons/com.malwarebytes.mbam.rtprotection.daemon.plist \
		/Library/LaunchDaemons/com.malwarebytes.mbam.settings.daemon.plist \
		/Library/LaunchDaemons/com.prosoftnet.idrivedaemon.plist \
		/Library/LaunchDaemons/com.prosoftnet.idsyncdaemon.plist \
		/Library/LaunchDaemons/com.prosoftnet.idwifimanager.plist \
		/Library/LaunchDaemons/com.teamviewer.Helper.plist \
		/Library/LaunchDaemons/com.teamviewer.teamviewer_service.plist \
		/Library/LaunchDaemons/com.avast.init.plist
	)

    for curPATH in "${LaunchctlPATHS[@]}"
    do
        sudo launchctl $1 "$curPATH"
    done
    return 0;
}

## Create large file to force cleaning of purgeable disk space
makeLargeFile () {
	dd if=/dev/random of="./~tempPurgeFile.img" bs=1024 count=0 seek=$[1024*$1]
#	rm "$TMPC/LargeTestFile.img"
}

##########################################
######## ENHANCED CD OPERATIONS ########
##########################################
# An enhanced 'cd' - push directories
# onto a stack as you navigate to it.
#
# The current directory is at the top
# of the stack.
#
function stack_cd {
    if [ $1 ]; then
        # use the pushd bash command to push the directory
        # to the top of the stack, and enter that directory
        pushd "$1" > /dev/null
    else
        # the normal cd behavior is to enter $HOME if no
        # arguments are specified
        pushd $HOME > /dev/null
    fi
}
# the cd command is now an alias to the stack_cd function
#
alias cd=stack_cd

# Swap the top two directories on the stack
#
function swap {
    pushd > /dev/null
}
# s is an alias to the swap function
alias s=swap
# Pop the top (current) directory off the stack
# and move to the next directory
#
function pop_stack {
    popd > /dev/null
}
alias p=pop_stack
# Display the stack of directories and prompt
# the user for an entry.
#
# If the user enters 'p', pop the stack.
# If the user enters a number, move that
# directory to the top of the stack
# If the user enters 'q', don't do anything.
#
function display_stack
{
    dirs -v
    echo -n "#: "
    read dir
    if [[ $dir = 'p' ]]; then
        pushd > /dev/null
    elif [[ $dir != 'q' ]]; then
        d=$(dirs -l +$dir);
        popd +$dir > /dev/null
        pushd "$d" > /dev/null
    fi
}
alias d=display_stack
#
###### END ENHANCED CD OPERATIONS ######

# enhanced 'ln -s': expands source args to absolute paths
# usage: lns <target> <source1> <source2> ... <source n>
function lns() {
  # expand any relative commmand line args to absolute paths needed
  # for running 'ln -s' in the applescript pfsymlinkToPF.sh
	args=""
	for arg in $@; do
		# convert relative arg to absolute path
		arg=$(print -r -- $arg:P)
		# recombine the args to a comma delimited list for handoff to the applescript
		args="${args}${args:+ }$arg"
	done
	echo "ln -s ${args}"
	#"${plugindir}/pfsymlinkToPF.sh" $args
}
