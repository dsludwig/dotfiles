if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# added by Anaconda2 2.4.0 installer
export PATH="/Users/dludwig/anaconda/bin:$PATH"
# added by me! rust/cargo
export PATH="/Users/dludwig/.cargo/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# local::lib
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
source "$HOME/.cargo/env"
