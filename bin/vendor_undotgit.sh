#!/bin/bash

VENDOR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../vendor/src" && pwd )"
echo "Moving .checkout_git to .git for all dirs in $VENDOR"
find $VENDOR -type d -name .checkout_git | xargs -n1 -I DIR mv -v "DIR" "DIR/../.git"
