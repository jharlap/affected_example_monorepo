#!/bin/bash

# Usage: make_shard.sh <shard> <num_shards> <commit..range> <target>
# Shard should be specified as 0-indexed integers up to num_shards-1
# Target should be a valid make target, such as test or image
# Exit code of this is the number of make commands that failed

SHARD=$1
NUM_SHARDS=$2
COMMIT_RANGE=$3
TARGET=$4

function is_file_in_shard {
	f_shard=$( cksum <( echo "$1" ) | cut -d' ' -f1 )
	f_shard=$( expr $f_shard % $NUM_SHARDS )
	test $f_shard -eq $SHARD
	return $?
}

echo "Processing shard ${SHARD}/${NUM_SHARDS} for range ${COMMIT_RANGE} with target ${TARGET}"

RETVAL=0
packages=""
if [[ "$COMMIT_RANGE" == *".."* ]]; then
	packages=$( affected $COMMIT_RANGE )
	ok=$?
	test "$ok" -eq 0 || echo "Failure running affected"
	let "RETVAL = $RETVAL + $ok"
else
	packages=$( go list ./private/src/... )
fi
echo "Affected packages:"
echo "$packages"

for d in $packages ; do
	d=./private/src/$d
	if [ ! -f $d/Makefile ] ; then
		# echo "Skipping $d: no Makefile"
		continue
	fi

	# including commit range to increase randomness in sharding
	if ! is_file_in_shard "$d $COMMIT_RANGE" ; then
		# echo "Skipping $d: not in shard"
		continue
	fi

	echo "Building $d"
	make -C $d $TARGET
	ok=$?
	test "$ok" -eq 0 || echo "Failure: $d"
	test "$ok" -eq 0 && echo "Success: $d"
	let "RETVAL = $RETVAL + $ok"
done

echo "Failed: ${RETVAL}"
exit $RETVAL
