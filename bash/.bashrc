# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

#-------------------------------------
# Set prompt look
#-------------------------------------
#export PS1="[\u@\h \w]$ "
if [[ $HOSTNAME == steven-work-macbook* || $HOSTNAME == ltksup37594mac* ]]; then
  export PS1="[local \W]$ "
fi

#-------------------------------------
# Backup function
#-------------------------------------
backup() {
    [ -f "$1" ] || return 1
    cp -pv "$1" "$1.$(date +%Y-%m-%d.%H%M%S)"
}

#--------------------------------------
# Pull info from cht.sh
#--------------------------------------
cht() {
    curl -s cht.sh/$1?style=bw | less -R
}

#---------------------------------------
# This function should be able to
# extract almost anything
#---------------------------------------
extract() {
    if [ "$#" -lt "1" ]; then
        echo "Usage: extract FILE"
        return 1
    fi

    if [ -f "$1" ]; then
        case "$1" in
            *.7z)        7z x "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.rpm)       rpm2cpio "$1" | cpio -idmv ;;
            *.tar.bz2)   tar xvjf "$1" ;;
            *.tar.gz)    tar xvzf "$1" ;;
            *.tar)       tar xvf "$1" ;;
            *.tbz2)      tar xvjf "$1" ;;
            *.tgz)       tar xvzf "$1" ;;
            *.zip)       unzip "$1" ;;
            *.Z)         uncompress "$1" ;;
            *)           echo "'$1' cannot be extracted via 'extract'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#---------------------------------------
# Remove the specified line from the
# known_hosts file
#---------------------------------------
rmhost() {
    if [ "$#" -lt "1" ]; then
        echo "Usage: rmhost LINE_NUMBER"
        return 1
    fi

    sed -i'' -e "$1 d" $HOME/.ssh/known_hosts
}

#---------------------------------------
# Path
#
# Add $HOME/bin to the path in order to
# use custom applications
#---------------------------------------
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

#---------------------------------------
# Other aliases
#---------------------------------------
alias h='history | less'
alias j='jobs -l'
alias less='less -R'
alias mirror='rsync --verbose --archive --hard-links --numeric-ids --delete --delete-after --delay-updates --rsh=ssh'
alias mnt='mount | column -t'
alias ns='nslookup'
alias psg='ps aux | grep '
# alias rpmqa='rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n"'
alias timestamp='date +%Y-%m-%d.%H%M%S'
alias tree='tree -C --charset en_US.UTF-8'
