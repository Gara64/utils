#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$'
#PS1='${PWD//\/\\\}/ $'
MonPrompt='${PWD//\/\\\}>'

alias ppa-add='echo "sudo add-apt-repository";sudo add-apt-repository '
alias ppa-remove='echo "sudo add-apt-repository --remove"; sudo add-apt-repository --remove '

alias test='uname & lsb_release -a;lsb_release -a; uname -a;tput setaf 1;echo "test vidéo";tput sgr0;/usr/lib/nux/unity_support_test -p;'

alias reboot='echo "sudo reboot"; sudo reboot'
alias update='echo "sudo apt-get update"; sudo apt-get update'
alias install='echo "sudo apt-get install"; sudo apt-get install'
alias upgrade='echo "*** sudo apt-get; sudo apt-get dist-upgrade"; sudo apt-get update; sudo apt-get dist-upgrade; echo "Terminée"'
alias dist-upgrade='echo "*** sudo apt-get; sudo apt-get dist-upgrade"; sudo apt-get update; sudo apt-get dist-upgrade; echo "Terminée"'
alias autoremove='echo "sudo apt-get autoremove --purge"; sudo apt-get autoremove --purge'
alias remove='echo "sudo apt-get autoremove --purge"; sudo apt-get autoremove --purge'

alias pause='tput setaf 1;echo "Pressez la touche Entrer pour continuer";tput sgr0;read pause'



# Add colors
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias persos
alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias ensiie='ssh paul.tran-van@lunix121.ensiie.fr'
alias ensiie2='ssh paul.tran-van@lunix122.ensiie.fr'
alias perso='ssh tranvan2010@perso.iiens.net'
alias dodo='sudo shutdown -h now'
alias ptitlu='echo "Je suis un très petit facho !"'
alias pingg='ping google.fr'
alias coucou='while [ 1 ]; do echo coucou; sleep 1; done'
alias luminosite='~/scripts/brightness.sh'
alias pdf='evince'
alias version='lsb_release -a'

