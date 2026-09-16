if status is-interactive
    set fish_greeting ''
end

function fish_command_not_found
    echo fish: $argv[1]: command not found
end

alias nvim="~/nvim-macos-arm64/bin/nvim"
alias ls="eza --color=always --icons"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias matlab="/Applications/MATLAB_R2025b.app/bin/matlab"
alias pw="vim -c ':Creds'"
export LANG=en_US.UTF-8
export ANI_CLI_PLAYER=mpv

# Gruvbox Dark color scheme
set -g fish_color_normal "#ebdbb2"
set -g fish_color_command "#fabd2f"
set -g fish_color_param "#ebdbb2"
set -g fish_color_redirection "#fe8019"
set -g fish_color_comment "#928374"
set -g fish_color_error "#fb4934"
set -g fish_color_status "#fb4934"
set -g fish_color_cancel "#fb4934"
set -g fish_color_search_match "--background=#504945"
set -g fish_color_selection "--background=#504945" "--foreground=#ebdbb2"
set -g fish_color_operator "#fe8019"
set -g fish_color_escape "#d3869b"
set -g fish_color_cwd "#b8bb26"
set -g fish_color_cwd_root "#fb4934"
set -g fish_color_valid_path "#83a598"
set -g fish_color_autosuggestion "#928374"
set -g fish_color_history_current "#fabd2f"
set -g fish_color_host "#d3869b"
set -g fish_color_host_remote "#b8bb26"
set -g fish_color_user "#83a598"
set -g fish_color_user_root "#fb4934"

# Gruvbox variables
set -g fish_pager_color_progress "#928374"
set -g fish_pager_color_background "#282828"
set -g fish_pager_color_prefix "#fabd2f"
set -g fish_pager_color_completion "#ebdbb2"
set -g fish_pager_color_description "#928374"
set -g fish_pager_color_match_background "#504945"
set -g fish_pager_color_selected_prefix "#fabd2f"
set -g fish_pager_color_selected_completion "#ebdbb2"
set -g fish_pager_color_selected_description "#928374"
set -g fish_pager_color_selected_background "--background=#504945"

# echo "Week 3/13"

alias addv="cd ~/ADDV/verilog2ipxact/verilog2ipxact/08SEP2026 && source setup_env.fish"
alias kactus="cd ~/ADDV/kactus2/kactus2dev/executable && set -gx DYLD_LIBRARY_PATH . && ./kactus2.app/Contents/MacOS/kactus2"
