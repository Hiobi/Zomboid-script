# Zomboid-script
Manage your Project Zomboid server, start, stop, restart, save, update, status and reset.

## Required
* A steam account and steamcmd install
* A copy of Project Zomboid
* A Project Zomboid server

## Install
Download`zomboid.sh` and put it near your Zomboid server, `/home/steam/` for example.

## Configuration
|parameter|description|default|
|--- |--- |--- |
|**STEAM**|Define the absolute path where installed steamcmd|`/home/steam/steamcmd`|
|**INSTALL**|Define the installation directory of Zomboid, by default it is in that of steamcmd|`/home/steam/steamcmd/zomboid`|
|**DATA**|Define the absolute path of the directory (Zomboid) containing backups of the players, the map, the database and configuration|`/home/steam/Zomboid`|
|**IP**|Define listening IP|`0.0.0.0`|
|**ADMINPASSWORD**|Set admin password to access in game to admin console|`myawesomepassword`|

```shell
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
```

## Commands

|name|command|description|
|--- |--- |--- |
|**start**|`./zomboid.sh start`|Start server|
|**stop**|`./zomboid.sh stop`|Stop server|
|**restart**|`./zomboid.sh restart`|Restart server|
|**save**|`./zomboid.sh save`|Save server|
|**status**|`./zomboid.sh status`|Check if server is online or not|
|**update**|`./zomboid.sh update`|Update server|
|**reset**|`./zomboid.sh reset`|wipe server; map and players data will be reset|

### Details

* Deletes all `zombie_X_Y.bin` files so the zombies are reset to their intial numbers and placement.
* Deletes `map_t.bin so` the server's clock is reset.
* Deletes `map_meta.bin` so all the alarms are reset.  This also removes any custom zones that prevent too much fishing/foraging.
* Deletes `reanimated.bin` so any player zombies are removed.
* Deletes all zombie corpses, items on the ground, items in containers, and blood splatter.
    
Changes the server's ResetID in the `Zomboid\Servers\SERVERNAME.ini` file.  The causes the client to delete the map data when joining the server again, so it will be redownloaded from the server.  Player files are saved on the client in `map_p.bin` files; these files are not deleted when doing a soft reset.  There is no way for the server to remove `the map_p.bin` files, players must be deleted themselves their files to make a complete wipe.
