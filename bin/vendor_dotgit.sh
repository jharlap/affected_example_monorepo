#!/bin/bash

VENDOR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../vendor/src" && pwd )"
echo "Moving .git to .checkout_git for all dirs in $VENDOR"
find $VENDOR -type d -name .git | xargs -n1 -I DIR mv -v "DIR" "DIR/../.checkout_git"
