# -*- sh -*-

# Generic part of the configuration
[ -z "$HOME" ] && HOME="~"
[ -r $HOME/.bash_aliases ] && . $HOME/.bash_aliases

# System-dependent part of the configuration
PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin
export PATH

if [ "$(uname -s)" = Linux ]; then
    PATH=/usr/lib/ccache:$PATH && export PATH
    export PATH
    eval $(dircolors)
fi

if [ "$(uname -s)" = Darwin ]; then
    [ -r /sw/bin/init.sh ] && PATH=$PATH:/sw/bin:/sw/sbin && export PATH
    [ -r /usr/local/Cellar/ccache/3.1.4/libexec ] && PATH=/usr/local/Cellar/ccache/3.1.4/libexec:$PATH && export PATH
    eval $(dircolors)
fi

# Special post-configuration
if [ -d /var/qmail ]; then
    export PATH=/var/qmail/bin:$PATH
    export QMAILSUSER=rbrito
    export QMAILSHOST=ime.usp.br
    export QMAILUSER=$QMAILSUSER
    export QMAILHOST=$QMAILSHOST
    export QMAILINJECT=s
fi
[ -d $HOME/bin ] && export PATH=$HOME/bin:$PATH
[ -d /usr/hosts ] && export PATH=$PATH:/usr/hosts

# Generic variables
export PS1='\u@\h:\w\$ '
export HISTSIZE=1500
export HISTCONTROL=ignoredups
export GZIP=-9
export RSYNC_RSH=ssh
export CVS_RSH=ssh
export SVN_SSH=ssh
export PAPERSIZE=letter
export LANG=en_US.utf-8
export LC_CTYPE=pt_BR.utf-8
export LC_TIME=en_DK.utf-8
export TMPDIR=$HOME/tmp
export GTK2_RC_FILES=~/.gtkrc-2.0
#export GDK_NATIVE_WINDOWS=1
export LESSHISTFILE=/dev/null
export LESS="-R"
export CCACHE_COMPRESS=1

# Variables for TeX and friends
export TEXINPUTS=.:$HOME/tex:
export TEXEDIT="emacs +%d %s"
export BIBINPUTS=.:$HOME/doc/bib:

# Variables honored by Debian
export PAGER=less
export EDITOR=emacs
export VISUAL=emacs
export BROWSER=firefox:elinks:w3m
export DEBEMAIL="rbrito@ime.usp.br"
export DEBNAME="Rogério Brito"

umask 022
