#!/bin/bash

TODO=$1

# Drop commits not used
DROP_COMMITS="
THIS_IS_A_PLACEHOLDER, REPLACE WITH COMMIT DESCRIPTION ONCE THERE IS SOMETHING TO BE DROPPED!
"

IFS=$'\n'
for COMMIT in $DROP_COMMITS; do
  sed -i -E "s/^pick ([0-9a-f]+) (${COMMIT}.*)/drop \1 \2/g" $TODO
done

grep -E "^drop " $TODO > /tmp/dropped
sed -i -E "/^drop /d" $TODO
