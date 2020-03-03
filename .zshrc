##
# VCS info
##
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{green}%b%f'

##
# Prompt setup
##
hash -d gateways=~/Work/Gateways
hash -d icloud=~/Library/Mobile\ Documents/com~apple~CloudDocs
hash -d textastic=~/Library/Mobile\ Documents/M6HJR9W95L~com~textasticapp~textastic/Documents

setopt PROMPT_SUBST
PROMPT='%F{208}%n%f in %F{226}%~%f -> '
RPROMPT='${vcs_info_msg_0_}'
# RPROMPT='some test text'

##
# Aliases
##
alias resource='source ~/.zshrc'
alias editZsh='code ~/.zshrc'

killport() { kill $(lsof -ti tcp:$1); }

##
# Tooling
##
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

export PATH=$PATH:/usr/local/bin/custom/
