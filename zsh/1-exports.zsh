export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/dotfiles/scripts/utils/:$PATH"
export PATH="/media/zbengued/babel/.linuxbrew/bin:$PATH"
export PATH="/media/zbengued/babel/.linuxbrew/Homebrew/bin/:$PATH"
export PATH="/media/zbengued/babel/cargo/bin:$PATH"


export CARGO_HOME="/media/zbengued/babel/cargo"
export RUSTUP_HOME="/media/zbengued/babel/rustup"

# Homebrew (user-only)
export PKG_CONFIG_PATH="/media/zbengued/babel/.linuxbrew/lib/pkgconfig:/media/zbengued/babel/.linuxbrew/opt/fontconfig/lib/pkgconfig:$PKG_CONFIG_PATH"
export HOMEBREW_PREFIX="/media/zbengued/babel/.linuxbrew"
export HOMEBREW_CELLAR="/media/zbengued/babel/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/media/zbengued/babel/.linuxbrew/Homebrew"
export HOMEBREW_CACHE="/media/zbengued/babel/.linuxbrew/cache"
export PATH="/media/zbengued/babel/.linuxbrew/bin:$PATH"

export CARGO_HOME="/media/zbengued/babel/cargo"
export RUSTUP_HOME="/media/zbengued/babel/rustup"

export PATH="$CARGO_HOME/bin:$PATH"

export MAIL="zbengued@student.1337.ma"

export LS_COLORS="$(vivid generate tokyonight-custom)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

export KITTY_LISTEN_ON=unix:/tmp/mykitty
