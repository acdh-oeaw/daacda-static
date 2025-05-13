# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/acdh-oeaw/daacda-data/archive/refs/heads/main.zip
unzip main

mv ./daacda-data-main/data/ .

rm main.zip
rm -rf ./daacda-data-main
add-attributes -g "./data/editions/*.xml" -b "https://daacda.acdh.oeaw.ac.at"
add-attributes -g "./data/meta/*.xml" -b "https://daacda.acdh.oeaw.ac.at"
add-attributes -g "./data/indices/*.xml" -b "https://daacda.acdh.oeaw.ac.at"

echo "fetch imprint"
./shellscripts/dl_imprint.sh
