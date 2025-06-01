#!/bin/bash

#Per installare homebrew:    /bin/bash -c "$(curl -fsSL raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#Per installare jq:    brew install jq

usage() {
    echo "Usage: $0 [-h] [-s <script_number>] [-f]"
    echo "  -h  Show help"
    echo "  -s  Specify script number to run (1 to 10)"
    echo "  -f  Force option for script 0"
    exit 1
}

force=0
script_number=""

while getopts ":hs:f" opt; do
    case ${opt} in
        h)
            usage
            ;;
        s)
            script_number=$OPTARG
            ;;
        f)
            force=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" 1>&2
            usage
            ;;
        :)
            echo "Invalid option: -$OPTARG requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

if [ -z "$script_number" ]; then
    echo "Quale script eseguiamo: "
    echo "1) Pulisci progetto"
    echo "2) Genera icone e splash"
    echo "3) Build e deploy per web"

    read script_number
fi

function clean {
    flutter clean
    flutter pub get
    dart run build_runner build --delete-conflicting-outputs
    echo "🧹 Project cleaned 🧹"
}


#Faccio uno switch sui possibili valori
case $script_number in
    

    "1")
        clean
        ;;

    "2")
        clean
        dart run icons_launcher:create  --path=assets/icons/icons_launcher.yaml
        dart run flutter_native_splash:create  --path=assets/icons/flutter_native_splash.yaml
        echo "🎨 Icons and splash created 🎨"
        ;;

    "3")
        flutter build web --wasm #--web-renderer html 
        firebase deploy
        echo "🚀 App built 🚀"
        ;;

        
    *)
        echo "👻 You have entered an invalid value 👻"
        ;;
esac