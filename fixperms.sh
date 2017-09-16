#!/system/bin/sh

if [ -z "$1" ]; then
    echo "Must specify path on new root"
fi

echo "Fix Perms: $1"

cd $1

# the find/xargs on my phone are not standard
find . \! -type l >/data/local/tmp/tmpfiles

for f in $(cat /data/local/tmp/tmpfiles); do
    if [ "$f"  == "." ]; then
        continue
    fi
    ISDIR=""
    if [ -d $f ]; then
        ISDIR="d"
    fi
    echo ">> $f"
    eval "$(stat -c "chmod %a ${1}/%n" /$f)"
    eval "$(stat -c "chown %u:%g ${1}/%n" /$f)"
    #eval "ls -Z$ISDIR /$f"
    eval "lsresults=($(ls -Z$ISDIR /$f))"
    context="${lsresults[3]}"
    chroot $1 chcon $context /$f
done


cd -

