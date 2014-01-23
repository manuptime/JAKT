pushd .
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUTPUT_DIR=$DIR/../webapp-build
cd $DIR/../scripts/
rm -rf $OUTPUT_DIR
node $DIR/r.js -o app.build.$1.js
java -jar $DIR/compiler.jar --js $OUTPUT_DIR/unlockable.js --language_in ECMASCRIPT5 --js_output_file $OUTPUT_DIR/unlockable-min.js
cd ../
mkdir -p $OUTPUT_DIR
cp -r media/ $OUTPUT_DIR
cp -r sounds/ $OUTPUT_DIR
cp -r fonts/ $OUTPUT_DIR
cp -r css/ $OUTPUT_DIR
python $DIR/move_client_to_s3.py --bucket="unlockable-$1"
popd
