#/bin/bash


SELECTION=$( zenity --list  --text "Wo möchtest du Videos schauen/downloaden?" --hide-header --column "Select" 'Youtube anschauen' 'Youtube downloaden' 'Soap2Day downloaden' 'Soap2Day anschauen')
VIDEONAME=$(zenity --title="Videoname" --text "Wie heißt das Video?" --entry --width 380)
PID=$$
exec &> >(zenity --display=:0 --text-info --title=$title; kill $PID)
echo "Du willst $VIDEONAME auf $SELECTION"
case $SELECTION in
                "Youtube anschauen")
                        ytfzf $VIDEONAME
                        ;;
                "Youtube downloaden")
                        ytfzf -d $VIDEONAME
                        ;;
                "Soap2Day downloaden")
                        cd /home/frederik/soap2day-dl
                        rm cookie.json
                        sh soap2day-dl.sh -n $VIDEONAME
                        ;;
                "Soap2Day anschauen")
                    IFS=' ' read -ra array1 <<< "$VIDEONAME"
                        variable2=""
                        for i in "${array1[@]}"
                        do
                        variable2=$variable2"%20"$i
                        done
                        variable3="${variable2:3}"
                    chromium soap2day.sh/search/keyword/$variable3
                    ;;
esac
