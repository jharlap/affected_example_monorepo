#!/bin/sh

if [ -n "$1" ]; then
  cd $1
fi

echo "Running gas in $(pwd)"
output=$(mktemp)
gas -out "$output" $(find . -name "*.go" | grep -v /vendor/ | grep -v '_test.go$')
issues=$(grep 'Issues: ' "$output" | cut -d: -f2)
cat "$output"
rm "$output"

if [ $issues -gt 0 ] ; then
  echo "Non-zero issues - failing"
  exit 1
fi

