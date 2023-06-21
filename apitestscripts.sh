# export NEWMAN="$(pwd)/node_modules/.bin/newman"

############## run on dev environment #################
# must add '--insecure' when run newman to ignore ssl certificate
# must add '-x' => report fail will hook to slack (missing it will ignore fail case)

############## run on local #################
#cd /Users/[]/Documents/AutoAPI/

currentDate=$(date '+%Y-%m-%d')
dir=test_report/$currentDate

if [ ! -d $dir ]; then
    mkdir -p $dir;
fi;

./lark_notifier.sh "------- Start Test -------"
./lark_notifier.sh "SBH - Pro Web Testing..."
for filename in ./proweb3/*.json; do
#  ./lark_notifier.sh $(basename $filename)
  logfile=$(basename $filename)
  logfile=${logfile%.json}
  # $NEWMAN run $filename -e config/sbh_dev.postman_environment.json --insecure -x >$dir/$logfile.log -r lark,cli
  newman run $filename -e config/sbh_stg.postman_environment.json --insecure -x >$dir/$logfile.log -r lark,cli
  ./lark_notifier.sh "Log here: $(pwd)/${dir}/${logfile}.log"
done

./lark_notifier.sh "SBH - App Testing..."
for filename in ./app/*.json; do
#  ./lark_notifier.sh $(basename $filename)
  logfile=$(basename $filename)
  logfile=${logfile%.json}
  # $NEWMAN run $filename -e config/sbh_dev.postman_environment.json --insecure -x >$dir/$logfile.log -r lark,cli
  newman run $filename -e config/sbh_stg.postman_environment.json --insecure -x >$dir/$logfile.log -r lark,cli
  ./lark_notifier.sh "Log here: $(pwd)/${dir}/${logfile}.log"
done

# #remove .log file
# for filename in ./test_report/*.log; do
#   rm $filename
# done

./lark_notifier.sh "------- End Test -------"