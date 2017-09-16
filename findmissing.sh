#!/system/bin/sh
find / -xdev >../tmpfilesroot

umask 0777

for f in $(cat ../tmpfilesroot); do
    if [[ "$f" == "/" ]]; then
        continue
    fi

    if [[ ! -e $1/$f ]]; then
        if [[ -L $f ]]; then
            #1. stat gives `link' -> `target'
            #2. sed remove bad charaters
            #3. cut just the target part
            target=$(stat -c '%N' $f | sed "s,[>'\`\-],,g" | cut -f2- -d' ')
            ln -vs $target $1/$f
        elif [[ -d $f ]]; then
            mkdir -vp $1/$f
        elif [[ -f $f ]]; then
            echo "file $1/$f is missing!!!"
            exit 3
        else
            echo "???? doesnt exist: $1/$f!"
            exit 2
        fi
    fi
done

