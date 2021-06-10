MWU_SCRIPT_DIR=$( dirname "$0" )

echo 'bootstrap'
echo "$MWU_SCRIPT_DIR"
for file in $MWU_SCRIPT_DIR/scripts/*; do
  source $file
done
