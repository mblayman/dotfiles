# TODO: Make the profile so that it is not OS specific. uname == "Darwin"
CLICOLOR=1
EDITOR=vim
GEM_HOME=~/.gems
PATH="/usr/local/sbin:~/storybird/media/node_modules/.bin:$GEM_HOME/bin:$PATH"
export CLICOLOR EDITOR GEM_HOME PATH

test -f ~/.git-completion.bash && . $_
alias hcov="nosetests --with-coverage --cover-package=handroll"

source /usr/local/bin/virtualenvwrapper.sh
source ~/sbvenv/bin/activate
