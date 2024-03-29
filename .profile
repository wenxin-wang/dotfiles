# .bash_profile

if [ -n "$HAS_MY_PROFILE" ]; then
    return
fi

for dir in ~/.profile.d; do
    if [ -d $dir ]
    then
        for profile in $dir/*.sh
        do
            . $profile
        done
    fi
done

export HAS_MY_PROFILE=1
