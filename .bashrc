# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
if [ -f /usr/local/etc/bash_completion.d/hg-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/hg-completion.bash
fi
# NVM
export NVM_DIR="/home/jonathan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# Aliases for launching:
alias subl="open -a 'Sublime Text' $1"
# git radar
# export PS1="$PS1\$(git-radar --bash --fetch)"
export CLICOLOR=1
export DYLD_LIBRARY_PATH=/opt/oracle/instantclient:$DYLD_LIBRARY_PATH
export OCI_LIB_DIR=/opt/oracle/instantclient
export OCI_INC_DIR=/opt/oracle/instantclient/sdk/include
export OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include
alias lazygit="git add --all; git commit -m $1"
alias npminstallall='while true; do '$1' 2>&1 > /dev/null | grep Error: | sed "s/^.*Cannot find module '\(.*\)'$/\1/" | xargs npm install; sleep 2; done'
alias latestbranches="git for-each-ref --sort=-committerdate refs/heads/"
alias difflast="git log | grep -e commit | head -10 | sed -n '2p' | sed 's/commit//g' | xargs git diff"
alias eberror="eb logs | tail +0 | egrep -ia error"
alias differ="echo -ne '\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A############################ start ##################################\x0D\x0A\x0D\x0A\x0D\x0A\x0D\x0A' && git diff --color | diff-so-fancy"
source ~/.git-completion.bash
export GOPATH=$HOME
# eval "$(rbenv init -)"
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1
export PATH=$PATH:$HOME/terraform:/usr/local/terraform/bin
sshtun () {
  if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" || -z "$5" ]]; then
    echo "Usage: $0 local_port identity_file gateway_host target_host target_port"
  else
    ssh -o IdentitiesOnly=yes -o "UserKnownHostsFile /dev/null" -F /dev/null -i $2 -Nf -L $1:$4:$5 $3
  fi
}
aws_set_env () {
  aws configure --profile "$1"
  export AWS_DEFAULT_PROFILE="$1"
  export AWS_PROFILE="$1"
  export AWS_EB_PROFILE="$1"
}
_aws_set_env()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=()
    _get_comp_words_by_ref cur
    COMPREPLY=( $( compgen -W "$(grep -E '\[(.*)\]' ~/.aws/credentials | tr -d '[]' | xargs printf '%s ')" -- "$cur" ) )
    return 0
} &&
complete -F _aws_set_env aws_set_env
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh
export PATH="$HOME/.cargo/bin:$PATH"
export ANDROID_HOME=~/Library/Android/sdk
export HISTSIZE=5000
alias inoket='source ../sourceMe.sh && source venv/bin/activate && python application.py runserver'
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
export NODE_ENV='development'
export PATH=$PATH:/usr/local/m-cli
# source ~/src/github.com/jdxcode/gh/bash/gh.bash
_complete_gh ()
{
        COMPREPLY=()
        if [[ $COMP_CWORD -eq 1 ]]; then
          comp_arr=$(ls $HOME/src/github.com;\
            ls $HOME/src/github.com/$GITHUB)
        elif [[ $COMP_CWORD -eq 2 ]]; then
          local user=${COMP_WORDS[COMP_CWORD-1]}
          comp_arr=$(ls $HOME/src/github.com/$user)
        else
          return 0
        fi
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "${comp_arr}" -- $cur))
        return 0
}
complete -F _complete_gh gh
# Share history across shells
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
PYTHONDONTWRITEBYTECODE=1
alias gs="git status"
# Silently add my ssh key
ssh-add ~/.ssh/id_rsa_grimolddello &>/dev/null
# Django bash completion
_django_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   DJANGO_AUTO_COMPLETE=1 $1 ) )
}
complete -F _django_completion -o default django-admin.py manage.py django-admin
_python_django_completion()
{
    if [[ ${COMP_CWORD} -ge 2 ]]; then
        local PYTHON_EXE=${COMP_WORDS[0]##*/}
        echo $PYTHON_EXE | egrep "python([2-9]\.[0-9])?" >/dev/null 2>&1
        if [[ $? == 0 ]]; then
            local PYTHON_SCRIPT=${COMP_WORDS[1]##*/}
            echo $PYTHON_SCRIPT | egrep "manage\.py|django-admin(\.py)?" >/dev/null 2>&1
            if [[ $? == 0 ]]; then
                if [[ -z "${COMP_WORDS[*]:2}" ]]; then
                    comp_arr="$(python manage.py help | egrep '^\s' | tr -d ' ')"
                    cur="${COMP_WORDS[COMP_CWORD]}"
                    COMPREPLY=( $(compgen -W "${comp_arr}" -- $cur) )
                else
                    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]:1}" \
                                   COMP_CWORD=$(( COMP_CWORD-1 )) \
                                   DJANGO_AUTO_COMPLETE=1 ${COMP_WORDS[*]} ) )
                fi
            fi
        fi
    fi
}
# Support for multiple interpreters.
unset pythons
if command -v whereis &>/dev/null; then
    python_interpreters=$(whereis python | cut -d " " -f 2-)
    for python in $python_interpreters; do
        [[ $python != *-config ]] && pythons="${pythons} ${python##*/}"
    done
    unset python_interpreters
    pythons=$(echo $pythons | tr " " "\n" | sort -u | tr "\n" " ")
else
    pythons=python
fi
complete -F _python_django_completion -o default $pythons
unset pythons
# make ctrl+w/cmd+w stop on slashes etc.
stty werase undef
bind '\C-w:unix-filename-rubout'



export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export HISTSIZE=20000
export LC_CTYPE=en_US.UTF-8

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[ -f /home/jonathan/.yarn-cache/.global/node_modules/tabtab/.completions/yarn.bash ] && . /home/jonathan/.yarn-cache/.global/node_modules/tabtab/.completions/yarn.bash


#nvim=$(which nvim)
nvim=vim
EDITOR=$nvim
GIT_EDITOR=$nvim
alias nvim=$nvim

alias mix='source ../venv/bin/activate && python manage.py runserver localhost:8001 --settings=mixcloud.settings.jon'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export MIXCLOUD_SETTINGS_REACT="mixcloud.settings.jon_react"
export MIXCLOUD_SETTINGS_WWW="mixcloud.settings.jon"
export MIXCLOUD_SETTINGS_API="mixcloud.settings.jon"
export MIXCLOUD_SETTINGS_MOBILE="mixcloud.settings.jon_mobile"

alias pullin='git pull origin "$(git rev-parse --abbrev-ref HEAD)"'
alias pushback="git push origin HEAD"

export HISTSIZE=20000

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="/home/jonathan/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# alias ls="ls --color"
setxkbmap -option caps:escape
source ~/src/github.com/jdxcode/gh/bash/gh.bash
source ~/src/github.com/jdxcode/gh/completions/gh.bash
# export DJANGO_SETTINGS_MODULE=mixcloud.settings.dev.www
alias android-studio="/usr/local/android-studio/bin/studio.sh"
export PATH="$PATH:/usr/local/android-studio/bin"
export ANDROID_HOME="/home/jonathan/Library/Android/sdk"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export FLOW_WHITELIST='node_modules,playerWidget'

alias code='nvm use default; code'
