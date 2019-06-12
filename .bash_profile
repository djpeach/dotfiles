if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

##
# Your previous /Users/daniel/.bash_profile file was backed up as /Users/daniel/.bash_profile.macports-saved_2019-02-22_at_14:52:58
##

# MacPorts Installer addition on 2019-02-22_at_14:52:58: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

