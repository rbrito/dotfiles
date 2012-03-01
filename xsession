#!/bin/sh
#
# X startup script
#

export LANG=en_US.utf-8
export LC_CTYPE=pt_BR.utf-8

[ -f $HOME/.Xdefaults ] && xrdb -merge -nocpp $HOME/.Xdefaults

xset dpms 360 720 1800 &
xsettingsd &

gkrellm -w &
urxvtd &
xconsole -file /dev/xconsole &
#eval $(gpg-agent --daemon)

exec fluxbox -log ~/.fluxbox/log
#exec enlightenment_start
