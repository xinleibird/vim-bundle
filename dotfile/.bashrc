# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ===============================
# Bash solarized ================

# Various variables you might want for your PS1 prompt instead
PS_Path="\w"
PS_User="♜ \u"

Color_Off="\[\033[0m\]"         # Text Reset
Color_Black="\[\033[0;30m\]"    # Black
Color_Green="\[\033[0;32m\]"    # Green
Color_Red="\[\033[0;91m\]"      # IRed
Color_Cyan="\[\033[0;36m\]"     # Cyan
Color_Yellow="\[\033[0;33m\]"   # Yellow

# PS1
if [ "$TERM" == "dumb" ]; then
    export PS1='\u@\h \W \$ '
    unalias ls
    unalias grep
else
    export PS1=$Color_Black$PS_User$Color_Off'$(git branch &>/dev/null;
    if [ $? -eq 0 ]; then
        echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1;
        if [ "$?" -eq "0" ]; then
            echo "'$Color_Green'"$(__git_ps1 " (%s)");
        else
            echo "'$Color_Red'"$(__git_ps1 " {%s}");
        fi) '$Color_Cyan$PS_Path$Color_Off' \$ ";
    else
        echo " '$Color_Yellow$PS_Path$Color_Off''$Color_Black' \$ '$Color_Off'";
    fi)'
fi

# ===============================
# Solarized gnome-terminal ======
eval `dircolors /home/xinlei/.ls-colors-solarized/dircolors`


# ===============================
# PATH ==========================

# Add /opt/bin to PATH
export PATH="/opt/bin:$PATH"

# Add .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# ===============================
# ENV ===========================

# Nvm
source ~/.nvm/nvm.sh

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export LD_LIBRARY_PATH="$PYENV_ROOT/versions/2.7.5/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$PYENV_ROOT/versions/3.3.2/lib:$LD_LIBRARY_PATH"

# Rbenv
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# LLVM and Clang
export LLVM_ROOT="/opt/llvm"
export PATH="$LLVM_ROOT/bin:$PATH"
export LD_LIBRARY_PATH="$LLVM_ROOT/lib:$LD_LIBRARY_PATH"
