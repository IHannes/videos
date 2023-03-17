#/bin/bash

SELECTION=$( zenity --list  --text "Wo möchtest du Videos schauen/downloaden?" --hide-header --column "Select" 'Youtube anschauen' 'Youtube downloaden' 'Soap2Day downloaden' 'Soap2Day anschauen' 'Soap2Day downloaden funktioniert nicht')

if [ "$SELECTION" == "Soap2Day downloaden funktioniert nicht"  ]; then
        cd /home/frederik/
        rm -rf soap2day-dl/
        git clone https://github.com/KevCui/soap2day-dl
        cd soap2day-dl/bin/
        npm i puppeteer-core puppeteer-extra puppeteer-extra-plugin-stealth
        zenity --info --text="Fehler sollte behoben sein"
fi


case $SELECTION in
                "Youtube anschauen")
                        VIDEONAME=$(zenity --title="Videoname" --text "Wie heißt das Video?" --entry --width 380)
                        echo "Du willst $VIDEONAME auf $SELECTION"
                        terminal +sb -fg green -bg black  -fn "xft:Bitstream Vera Sans:pixelsize=30" -letsp -8 -e ytfzf $VIDEONAME
                        ;;
                "Youtube downloaden")
                        VIDEONAME=$(zenity --title="Videoname" --text "Wie heißt das Video?" --entry --width 380)
                        echo "Du willst $VIDEONAME auf $SELECTION"
                        terminal +sb -fg green -bg black  -fn "xft:Bitstream Vera Sans:pixelsize=30" -letsp -8 -e  ytfzf -d $VIDEONAME
                        ;;
                "Soap2Day downloaden")
                        VIDEONAME=$(zenity --title="Videoname" --text "Wie heißt das Video?" --entry --width 380)
                        echo "Du willst $VIDEONAME auf $SELECTION"
                        cd /home/frederik/soap2day-dl
                        terminal +sb -fg green -bg black  -fn "xft:Bitstream Vera Sans:pixelsize=30" -letsp -8 -e  sh soap2day-dl.sh -n "'"$VIDEONAME"'"
                        #cp /home/frederik/soap2day-dl/\'$VIDEONAME\' home/frederik/Videos/$VIDEONAME
                        ;;
                "Soap2Day anschauen")
                        VIDEONAME=$(zenity --title="Videoname" --text "Wie heißt das Video?" --entry --width 380)
                        echo "Du willst $VIDEONAME auf $SELECTION"
                        IFS=' ' read -ra array1 <<< "$VIDEONAME"
                        variable2=""
                        #Print the split string
                        for i in "${array1[@]}"
                        do
                        variable2=$variable2"%20"$i
                        done
                        variable3="${variable2:3}"
                    chromium soap2day.sh/search/keyword/$variable3
                    ;;
esac
