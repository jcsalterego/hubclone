#!/bin/bash
#
# hubclone.sh - Clones GitHub repositories by username
#

API_ROOT="http://github.com/api/v2/yaml";

function usage ()
{
    echo "$0 <user> [-n|--dry-run]";
}

function main ()
{
    OPT_DRYRUN=no;
    for arg in $@; do
        case "$arg" in
            "-n")
                OPT_DRYRUN=yes;
                ;;
            "--dry-run")
                OPT_DRYRUN=yes;
                ;;
            *)
                ;;
        esac
    done

    if [ -z "$1" ]; then
        usage;
        exit 1;
    else
        user="$1";
    fi

    output="$(curl -s $API_ROOT/repos/show/$user)";
    repos="$(echo "$output" | awk '/:name:/ { print $2 }' | sort)";

    if [ -z "$repos" ]; then
        echo "No repositories found. Aborting";
        exit 1;
    fi

    if [ "$OPT_DRYRUN" == "yes" ]; then
        echo "mkdir -p $user;";
    else
        mkdir -p $user;
    fi

    for repo in $repos; do
        if [ -d "$user/$repo" ]; then
            if [ "$OPT_DRYRUN" == "yes" ]; then
                echo "pushd $user/$repo";
                echo "git pull";
                echo "popd";
            else
                pushd "$user/$repo";
                git pull;
                popd;
            fi
        else
            if [ "$OPT_DRYRUN" == "yes" ]; then
                echo -n "git clone http://github.com/$user/$repo.git "
                echo    "$user/$repo";
            else
                git clone "http://github.com/$user/$repo.git" \
                    "$user/$repo";
            fi
        fi
    done

    exit 0;
}

main $@