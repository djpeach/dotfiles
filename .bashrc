export PATH

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

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
  cd /Users/daniel.peach/.local/share/virtualenvs/$1/bin/;
  sed -i '' 's/PS1="(/PS1="\\n(/' activate
  cd $origDir;
}

# Alias to list environments
alias lsEnv="ls /Users/daniel.peach/.local/share/virtualenvs/"

# Function to change environments
cdEnv()
{
  source /Users/daniel.peach/.local/share/virtualenvs/$@/bin/activate;
}

# Alias to leave environment
alias exitEnv="deactivate"

# Alias to delete environments
rmEnv()
{
  if [ $1 ]; then
    if [ -d /Users/daniel.peach/.local/share/virtualenvs/$1/ ]; then
      deactivate;
      rm -rf /Users/daniel.peach/.local/share/virtualenvs/$1/;
        echo "  ${green}$1 has been removed and your source has been reset${white}";
    else
      echo "  ${red}/Users/daniel.peach/.local/share/virtualenvs/$1/ is not a valid environment${white}";
    fi
  else
    echo "  ${red}enter an environment to remove${white}";
  fi
}

# Function to autocomplete env based on the directories in VirtualEnvironments
_virtualEnvComplete()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local AUTO_COMPLETE_DIRS=$(ls /Users/daniel.peach/.local/share/virtualenvs/)

    IFS=$'\n' COMPREPLY1=( $(compgen -W "$AUTO_COMPLETE_DIRS" -- $cur))
    COMPREPLY2=( "${COMPREPLY1[@]// /\ }" )
    COMPREPLY=($(printf "%q\n" "${COMPREPLY2[@]}"))

}
complete -F _virtualEnvComplete nlEnv
complete -F _virtualEnvComplete cdEnv
complete -F _virtualEnvComplete rmEnv

# Function to create a new Wordpress theme in the current director
newTheme() {
    echo "";
    theme_name="";
    while [[ -z $theme_name ]]
    do
    echo "(required)";
    read -p "Theme Name: " theme_name;
    done;
    read -p "Theme URI: " theme_uri;
    read -p "Author: " author;
    read -p "Author URI: " author_uri;
    read -p "Description: " description;
    read -p "Version (1.0): " version;
    read -p "License (GNU v2): " license;
    read -p "License URI (http://www.gnu.org/licenses/gpl-2.0.html): " license_uri;
    read -p "Text Domain: " text_domain;
    read -p "Tags: " tags;
    read -p "Folder Name: (${theme_name}): " folder_name
    if [[ -z $version ]]; then
    version="1.0"
    fi;
    if [[ -z $license ]]; then
    license="GNU v2"
    fi;
    if [[ -z $license_uri ]]; then
    license_uri="http://www.gnu.org/licenses/gpl-2.0.html"
    fi;
    if [[ -z $folder_name ]]; then
    folder_name=$theme_name
    fi;

    git clone https://github.com/djpeach/base_theme.git;
    rm -rf base_theme/.git;
    mv base_theme "./$folder_name/";

    cat >"./$folder_name/scss/style.scss" <<EOF
/*
    Theme Name: $theme_name
    Theme URI: $theme_uri
    Author: $author
    Author URI: $author_uri
    Description: $description
    Version: $version
    License: $license
    License URI: $license_uri
    Text Domain: $text_domain
    Tags: $tags
*/
// ================ ABSTRACTS ================ //
@import "abstracts/mixins";
@import "abstracts/variables";
// =================== BASE ================== //
@import "base/base";
@import "base/typography";
// ================= VENDORS ================= //
@import "vendors/bootstrap/bootstrap";
// ================ COMPONENTS =============== //
// ================== PAGES ================== //
@import "pages/front-page";
EOF
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
