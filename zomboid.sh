#!/bin/sh
# PROJECT ZOMBOID SCRIPT - by Hiob BJÖRN https://hiob.fr/zomboid
## Github: https://github.com/Hiobi/Zomboid-script
## Let's start, stop, check status, save, update and reset your Project Zomboid server !
## This script is licenced under GNU GPLv3 https://www.gnu.org/licenses/quick-guide-gplv3.html
## Thanks to Pymous <3 for his help !


# Set variables
## Steamcmd path; /home/steam/steamcmd
STEAM="/home/steam/steamcmd"

## Zomboid install path (in steamcmd?); /home/steam/steamcmd/zomboid
INSTALL="/home/steam/steamcmd/zomboid"

## Zomboid data path (settings and saves); /home/steam/Zomboid
DATA="/home/steam/Zomboid"

## Which IP listening?
IP="0.0.0.0"

## Set secretly your adminpassword
ADMINPASS="myawesomepassword"


    
    srv_start()
    {
        # Start server in a screen named "zomboid"
    	cd $INSTALL && /usr/bin/screen -dmS zomboid ./start-server.sh -adminpassword $ADMINPASS -ip $IP
    	echo '[ZOMBOID] Server start ! \033[0;32m[OK]\033[0m'
    }
    
    srv_stop()
    {
        # Server shutdown safely. Players and map saved
        screen -x zomboid -p 0 -X stuff "^Mquit^M"  
    	sleep 10 
    	echo "[ZOMBOID] Server stopped ! \033[0;32m[OK]\033[0m"
    }

    srv_save()
    {
        screen -x zomboid -p 0 -X stuff "^Msave^M"  
    	sleep 5 
    	echo "[ZOMBOID] Server saved ! \033[0;32m[OK]\033[0m"
    }

    srv_reset()
    {
        # change randomly ResetID 
        sed -i "/ResetID/c\ResetID=$(shuf -i 100000000-999999999 -n 1)" $DATA/Server/servertest.ini
        
        # delete server saves
        rm -rf $DATA/Saves/Multiplayer/servertest
                	
        sleep 10
        echo "[ZOMBOID] \033[0;32m...Server reset ! You can now start your server.\033[0m"            	
    }
    
    case "$1" in
        start)
    		if pgrep -f start-server >/dev/null; then
    		echo "[ZOMBOID] \033[0;32mServer already online\033[0m"
    		fi
    		srv_start
            ;;
            
        stop)
    		if pgrep -f start-server >/dev/null; then
    		    srv_save
    			  srv_stop
    		else
    			echo "[ZOMBOID] \033[0;31mNo server found\033[0m"
    		fi
            ;;
            
        restart)
    		if pgrep -f start-server >/dev/null; then
    		    srv_save
    			srv_stop
    		else
    			echo "[ZOMBOID] \033[0;31mNo server found\033[0m"
    		fi
    		    srv_start
            ;;
            
        status)
    		if pgrep -f start-server >/dev/null; then
    			echo "[ZOMBOID] \033[0;32mServer online\033[0m"
    		else
    			echo "[ZOMBOID] \033[0;31mServer offline\033[0m"
    		fi
            ;;
            
        save)
            if pgrep -f start-server >/dev/null; then
                srv_save
            else
    			echo "[ZOMBOID] \033[0;31mServer offline\033[0m"
    		fi
            ;;     
        
        update)
            if pgrep -f start-server >/dev/null; then
    		    srv_save
    			  srv_stop
    		else
    		    echo "[ZOMBOID] \033[0;32mUpdating...\033[0m"
    		
    		# let update zomboid in steam
    		cd $STEAM
    		./steamcmd.sh +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir $INSTALL +app_update 380870 validate +quit
    		echo "[ZOMBOID] \033[0;32mUpdate complete !\033[0m"
    		fi
            ;;
            
        reset)
            if pgrep -f start-server >/dev/null; then
                srv_stop
            sleep 5
                screen -X -S zomboid kill
                    echo "[ZOMBOID] \033[0;32mServer was online ...waiting for reset...\033[0m"
                srv_reset
            else
    			    echo "[ZOMBOID] \033[0;31mServer offline...waiting for reset...\033[0m"
    			srv_reset    
    		fi
            ;; 
        *)
            echo "Usage: ./zomboid.sh {start|stop|restart|status|save|update|reset}" >&2
            exit 1
            ;;
esac
    
exit 0
