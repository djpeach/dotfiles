export VIRTENV_LOC="/Users/peachbook/.local/share/virtualenvs/" # add the path to your virtual environments here

# Custom terminal prompt:
# Special Characters:

# \h the hostname up to the first .
# \n newline
# \s the name of the shell
# \t the current time in 24-hour format
# \u the username of the current user
# \w the current working directory
# \W the basename of the current working directory

# Terminal (Colors) Customization
orange=$(tput setaf 166);
yellow=$(tput setaf 228);
green=$(tput setaf 71);
white=$(tput setaf 15);
red=$(tput setaf 124);
bold=$(tput bold);
reset=$(tput sgr0);

# PS1 (Prompt String 1) Customization with above colors
PS1="";
PS1+="\[${bold}\]\n";
PS1+="\[${orange}\]\u ";
PS1+="\[${white}\]on ";
PS1+="\[${yellow}\]\h ";
PS1+="\[${white}\]in ";
PS1+="\[${green}\]\W ";
PS1+="\n";
PS1+="\[${white}\]\$ ";
export PS1;

# Aliases
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias editBash="code ~/.bashrc"
alias editGit="code ~/.gitconfig"
alias django="python manage.py $@"
alias gif="git flow $@"
alias getIP="ifconfig | grep 'inet ' | grep -v 127.0.0.1"
alias pipfreeze="pip freeze --local | grep -v $@ > requirements.txt"
alias resource="source ~/.bashrc"


# Function to leave virtualenv, if in one
exit() {
  if [[ "$VIRTUAL_ENV" != "" ]]
  then
    deactivate
  fi
}

# Function to create environments
mkEnv()
{
  pipenv install $@;
}

# Function to add newline to activate in the Virt Env
nlEnv()
{
  origDir=$PWD;
  cd $VIRTENV_LOC/$1/bin/;
  sed -i '' 's/PS1="(/PS1="\\n(/' activate
  cd $origDir;
}

# Alias to list environments
alias lsEnv="ls $VIRTENV_LOC/"

# Function to change environments
cdEnv()
{
  source $VIRTENV_LOC/$@/bin/activate;
}

# Alias to leave environment
alias exitEnv="deactivate"

# Alias to delete environments
rmEnv()
{
  if [ $1 ]; then
    if [ -d $VIRTENV_LOC/$1/ ]; then
      deactivate;
      rm -rf $VIRTENV_LOC/$1/;
        echo "  ${green}$1 has been removed and your source has been reset${white}";
    else
      echo "  ${red}$VIRTENV_LOC/$1/ is not a valid environment${white}";
    fi
  else
    echo "  ${red}enter an environment to remove${white}";
  fi
}

# Function to autocomplete env based on the directories in VirtualEnvironments
_virtualEnvComplete()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local AUTO_COMPLETE_DIRS=$(ls $VIRTENV_LOC/)

    IFS=$'\n' COMPREPLY1=( $(compgen -W "$AUTO_COMPLETE_DIRS" -- $cur))
    COMPREPLY2=( "${COMPREPLY1[@]// /\ }" )
    COMPREPLY=($(printf "%q\n" "${COMPREPLY2[@]}"))

}
complete -F _virtualEnvComplete nlEnv
complete -F _virtualEnvComplete cdEnv
complete -F _virtualEnvComplete rmEnv

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

export PATH=$PATH:/usr/local/bin/custom;
export PATH=/Applications/CMake.app/Contents/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/custom
