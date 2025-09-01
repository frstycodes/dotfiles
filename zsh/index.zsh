source ~/zsh/utils/general.zsh # For the source_from_dir function

source_from_dir ~/zsh/utils

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Define Homebrew path first
export HOMEBREW_PATH=/opt/homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# Initialize Homebrew (needs to happen early)
if [[ -x "$HOMEBREW_PATH/bin/brew" ]]; then
  eval "$($HOMEBREW_PATH/bin/brew shellenv)"
else
    echo "Error: Homebrew is not installed or not in PATH."
    echo "Please install Homebrew from https://brew.sh"
    return 1
fi

# Setup Packages - only run if brew is available
if command -v brew &>/dev/null; then
  ensure_brew_packages zoxide fzf node git nvm
fi


# Path
export BUN_INSTALL=$HOME/.bun
export PNPM_HOME="$HOME/Library/pnpm"
export GO_INSTALL=$HOME/go
# Add basic paths (note: removed undefined NPM_INSTALL variable)
export PATH=$BUN_INSTALL/bin:$GO_INSTALL/bin:$PNPM_HOME/bin:$PATH

# Bun Completions (only if bun exists)
[ -s $BUN_INSTALL/_bun ] && source $BUN_INSTALL/_bun

# PYENV integrations (only if pyenv exists)
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

# NVM Setup (Homebrew) - only if nvm exists
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PATH/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PATH/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$HOMEBREW_PATH/opt/nvm/nvm.sh.completion" ] && \. "$HOMEBREW_PATH/opt/nvm/nvm.sh.completion"  # This loads nvm bash_completion


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10K
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History Opts
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls="ls --color"
alias zshe="zed ~/.zshrc"
alias dev="npm run dev"
alias b=bun
alias z=zed

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
export PATH=$HOME/.local/bin:$PATH


# phpMyAdmin aliases
alias phpmyadmin-start="cd ~/Downloads/php-my-admin && ./start.sh"
alias phpmyadmin-stop="pkill -f \"php -d error_reporting=E_ERROR -S localhost:8080\""

source_from_dir ~/zsh/completions
source_from_dir ~/zsh/config
