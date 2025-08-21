export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 40% --border"

# Widgets
export FZF_CTRL_T_COMMAND="fd --type f"
export FZF_CTRL_T_OPTS="--preview 'file {}; head {}'"

export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export FZF_CTRL_R_OPTS="--sort --exact"
