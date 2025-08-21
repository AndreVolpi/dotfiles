# Disable greeting
set fish_greeting

# Vi mode
fish_vi_key_bindings

# Load abbreviations
abbr -a gco 'git checkout'
abbr -a gst 'git status -sb'

# fuck function (integrating with thefuck)
function fuck --description "Correct your previous console command"
    set -l fucked_up_command $history[1]
    env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
    if test -n "$unfucked_command"
        eval $unfucked_command
        builtin history delete --exact --case-sensitive -- $fucked_up_command
        builtin history merge
    end
end

set fzf_history_time_format %d-%m-%y
set FZF_DEFAULT_COMMAND "fd --type f"
set FZF_DEFAULT_OPTS "--height 40% --border"

# Widgets
set FZF_CTRL_T_COMMAND "fd --type f"
set FZF_CTRL_T_OPTS "--preview 'file {}; head {}'"

set FZF_ALT_C_COMMAND "fd --type d"
set FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

set FZF_CTRL_R_OPTS "--sort --exact"

if test -f ~/.shell_aliases
    source ~/.shell_aliases
end

if type -q starship
    starship init fish | source
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
