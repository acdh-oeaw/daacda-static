# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/acdh-oeaw/daacda-data/archive/refs/heads/main.zip
unzip main

mv ./daacda-data-main/data/ .

rm main.zip
rm -rf ./daacda-data-main

echo "fetch imprint"
./shellscripts/dl_imprint.sh
