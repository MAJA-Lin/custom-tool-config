# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Custom aliases
alias l='ls -a'
alias ll='ls -l'
alias la='ls -la'
alias ra='sudo service apache2 restart'
alias rn='sudo service nginx restart'
alias rp='sudo service php7.0-fpm restart'
alias rb='sudo service beanstalkd restart'
alias rs='sudo service supervisor restart'

# Here should be your project dir
alias goto='cd /var/www/html/app'
# Here is a lazy shell script.
alias lazy='sh ~/tools/lazy.sh'


# Setup colors
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# Setup grep
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export TERM=xterm

# Add timestamp for history
export HISTTIMEFORMAT="<%Y/%b/%d %T %z> "


# enable git to show which the branch you are at and
# the last time you commit
#
function git_branch {
ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
echo "("${ref#refs/heads/}") ";
}

function git_since_last_commit {
now=`date +%s`;
last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
seconds_since_last_commit=$((now-last_commit));
minutes_since_last_commit=$((seconds_since_last_commit/60));
hours_since_last_commit=$((minutes_since_last_commit/60));
minutes_since_last_commit=$((minutes_since_last_commit%60));
echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

#random color
function random_color {
NUMBER=$[ ( $RANDOM % 4 )  + 1 ]

COLOUR_1='\e[1;31m'
COLOUR_2='\e[1;35m'
COLOUR_3='\e[0;37m'
COLOUR_4='\e[0;36m'

colour=COLOUR_${NUMBER}
echo "${!colour}";
}


# Final setting for shell prompt
# [compelete dir] (git branch) last_commit_time $
# PS1="[\[\033[1;32m\]\w\[\033[0m\]] \[\033[0m\]\[\033[1;36m\]\$(git_branch)\[\033[0;33m\]\$(git_since_last_commit)\[\033[0m\]$ "

# Same as above, but using variable
# PS1="[\[\033[${COLOR_LIGHT_GREEN}\]\w\[\033[${COLOR_NC}\]] \[\033[${COLOR_NC}\]\[\033[${COLOR_LIGHT_CYAN}\]\$(git_branch)\[\033[COLOR_BROWN\]\$(git_since_last_commit)\[\033[${COLOR_NC}\]$ "

# username@hostname: [compelete dir] (git branch) last_commit_time $
PS1="\[\033[$COLOR_YELLOW\]\u\[${COLOR_NC}\]@\[\033[${COLOR_PURPLE}\]\h\[${COLOR_NC}\]: [\[\033[${COLOR_LIGHT_GREEN}\]\w\[\033[${COLOR_NC}\]] \[\033[${COLOR_NC}\]\[\033[${COLOR_LIGHT_CYAN}\]\$(git_branch)\[\033[${COLOR_BROWN}\]\$(git_since_last_commit)\[\033[${COLOR_NC}\]$ "
