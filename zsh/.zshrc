# Suggestions automatiques
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
bindkey '^ ' autosuggest-accept

# Prompt : initialisé par le module NixOS (programs.starship)
# Aliases : gérés par le module NixOS (programs.zsh.shellAliases)

export TERM=xterm-256color
export PATH="$HOME/.local/bin:$PATH"
export PATH=$HOME/gbdk/bin:$PATH
export GBDKDIR=$HOME/gbdk/

# npm global
export PATH="$HOME/.npm-global/bin:$PATH"
