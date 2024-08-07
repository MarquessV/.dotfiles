# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  docker-compose
  git
  fzf
  kubectl
  poetry
  python
  rust
  ripgrep
  yarn
  timer
  vi-mode
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Binaries
export PATH=$PATH:/usr/local/bin
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/llvm@13/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/mvaldez/bin:$PATH"
export PATH="/Users/mvaldez/.local/bin:$PATH"
export PATH="/Users/mvaldez/go/bin:$PATH"

# clang
export SDKROOT="$(xcode-select -p)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
export LIBRARY_PATH="$SDKROOT/usr/lib:/opt/homebrew/opt/llvm@13/lib"
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++
export CCFLAGS="-L/usr/local/lib"
export CXXFLAGS="-stdlib=libc++ -std=c++11"
export LDFLAGS="-L/opt/homebrew/opt/lapack/lib -L/opt/homebrew/opt/openblas/lib -L/opt/homebrew/opt/libffi/lib -L/opt/homebrew/opt/llvm@13/lib"
export CPPFLAGS="-I/opt/homebrew/opt/lapack/include -I/opt/homebrew/opt/openblas/include -I/opt/homebrew/opt/libffi/include"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin/

# java
export JAVA_HOME=$(sdk home java 11.0.2-open)> /dev/null 2>&1

# brew
export PATH="/opt/homebrew/bin:$PATH"

# bob
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# Aliases
alias vim=nvim
alias v='nvim .'
alias ls='exa'
alias l='exa -lah --git --icons'
alias lt='exa --tree --level=2 --long --icons --git'
alias srcz='source ~/.zshrc'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git pull'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Quick cd with zoxide
eval "$(zoxide init zsh)"
# Automatically load env vars from a .envrc in a directory using direnv
eval "$(direnv hook zsh)"

export TOOLING_PYTHONPATH=$HOME/dev/virtualenvs/global_tooling/bin/

alias activate='deactivate &>/dev/null & ; source .venv/bin/activate'

function pact () {
    deactivate &> /dev/null
    source $(poetry env info --path)/bin/activate
}


# Version managers
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
export NVM_DIR="$HOME/.nvm" # Node
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="/Users/mvaldez/.local/share/bob/nvim-bin:$PATH"
# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

export NVIM_APPNAME=nvim-lite
alias nvim-lite=NVIM_APPNAME=nvim-lite nvim

# Created by `pipx` on 2023-11-06 18:01:31
export PATH="$PATH:/Users/mvaldez/.local/bin"

# pnpm
export PNPM_HOME="/Users/mvaldez/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

alias ktrn="kitten @ set-tab-title $(basename $PWD)"
. "$HOME/.cargo/env"

alias condactivcate="$(/Users/mvaldez/miniforge3/bin/conda shell.zsh hook)"
