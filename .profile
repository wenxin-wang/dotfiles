# .bash_profile

for dir in ~/.profile.d ~/.bash_profile.d; do
    if [ -d $dir ]
    then
        for profile in $dir/*.sh
        do
            [ -x $profile ] && . $profile
        done
    fi
done

# Source .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
