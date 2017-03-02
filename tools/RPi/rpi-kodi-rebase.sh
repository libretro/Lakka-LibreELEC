#!/bin/bash

TODO=$1

# Drop commits not used
DROP_COMMITS="
UNSTABLE\: This is a placeholder\. Commits after this point are considered experimental\.
MANUALLY REMOVE - \[cec\] Add settings for configuring button repeats
MANUALLY REMOVE - \[cec\] Don't discard buttons when repeat mode is enabled
ADSP: Hack - disable
"

IFS=$'\n'
for COMMIT in $DROP_COMMITS; do
  sed -i -E "s/^pick ([0-9a-f]+) (${COMMIT}.*)/drop \1 \2/g" $TODO
done

grep -E "^drop " $TODO > /tmp/dropped
sed -i -E "/^drop /d" $TODO
