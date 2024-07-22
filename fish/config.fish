if status is-interactive
  set fish_greeting ''
end

if test "$TERM" = "linux"
  setfont /usr/share/kbd/consolefonts/ter-p28b.psf.gz
end


alias ls "eza -lah --color=always --group-directories-first -F"
export QT_QPA_PLATFORMTHEME=gtk2
export GTK_THEME=Dracula
alias aur "xdg-open https://aur.archlinux.org"
alias files "fzf --preview='cat {}' | xargs nvim"
set JAVA_HOME "/usr/lib/jvm/java-22-openjdk"
set _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
set -U fish_user_paths $JAVA_HOME/bin $fish_user_paths

bind \ef accept-autosuggestion

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/adi/.ghcup/bin # ghcup-env

set -U fish_color_autosuggestion "#2c303a"