Primary aim of this repository is to provide a docker image of the scan upload script.

>> Build the docker image

    docker build -t armorcode-scan-upload .


>> Example of passing parameters to the script

    docker run -v "${PWD}":/data -e product="$PRODUCT" -e subProduct="$SUBPRODUCT" -e environment="$ENV" -e fileExtension="$EXTENSION" -e scanTool="$SCANTOOL" -e apiKey="$API_KEY" armorcode-scan-upload
