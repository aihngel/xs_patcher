#!/bin/bash
## xs_patcher
## detects xenserver version and applies the appropriate patches
<<<<<<< HEAD
HOSTID=$(xe host-list --minimal)
HOSTNAME=$(hostname)
=======

HOSTID=`xe host-list --minimal`
HOSTNAME=`hostname`

>>>>>>> parent of f046d77... Standardize, cleanup, homogenize whitespace and indentation
function get_xs_version {
        get_version=`cat /etc/redhat-release | awk -F'-' {'print $1'}`
        case "${get_version}" in
                "XenServer release 6.0.0" )
                DISTRO="boston"
                ;;
<<<<<<< HEAD
            "XenServer release 6.0.2" )
                DISTRO="sanibel"
                ;;
            "XenServer release 6.1.0" )
                DISTRO="tampa"
                ;;
            "XenServer release 6.2.0" )
                DISTRO="clearwater"
                ;;
            * )
=======

                "XenServer release 6.0.2" )
                DISTRO="sanibel"
                ;;

                "XenServer release 6.1.0" )
                DISTRO="tampa"
                ;;

                "XenServer release 6.2.0" )
                DISTRO="clearwater"
                ;;

                * )
>>>>>>> parent of f046d77... Standardize, cleanup, homogenize whitespace and indentation
                echo "Unable to detect version of XenServer, terminating"
                exit 0
		;;

        esac
}
function apply_patches {
<<<<<<< HEAD
    if [ ! -d tmp ]; then
        mkdir -p tmp
    fi

    echo "Looking for missing patches on ${HOSTNAME} for ${DISTRO}..."

    for PATCH in $(cat patches/$DISTRO)
    do
        PATCH_NAME=$(echo $PATCH | awk -F'|' {'print $1'})
        PATCH_UUID=$(echo $PATCH | awk -F'|' {'print $2'})
        PATCH_URL=$(echo $PATCH | awk -F'|' {'print $3'})
        PATCH_KB=$(echo $PATCH | awk -F'|' {'print $4'})
        if [ -f /var/patch/applied/$PATCH_UUID ]; then
            echo "${PATCH_NAME} has been applied, moving on..."
        fi
        if [ ! -f /var/patch/applied/$PATCH_UUID ]; then
            echo "Found missing patch ${PATCH_NAME}, checking to see if it exists in cache..."
            if [ ! -f cache/$PATCH_NAME.xsupdate ]; then
                echo "Downloading from ${PATCH_URL}..."
                cd tmp
                wget -q $PATCH_URL
                unzip -qq $PATCH_NAME.zip
                mv $PATCH_NAME.xsupdate ../cache
                rm -f $PATCH_NAME.zip
                cd ..
            fi
            echo "Applying ${PATCH_NAME}... [ Release Notes @ ${PATCH_KB} ]"
            xe patch-upload file-name=cache/$PATCH_NAME.xsupdate
            xe patch-apply uuid=$PATCH_UUID host-uuid=$HOSTID
            rm -f cache/$PATCH_NAME.xsupdate
        fi
    done
    echo "Cleaning up temporary files"
    rm -rf cache/*
    rm -rf tmp/*
    echo "Temporary Files have been cleaned up!"
    echo "All Possible Patches have been applied!"
    echo "You should reboot and run again to apply and patches that needed prerequisites."
    echo "IF YOU'RE IN A PRODUCTION ENVIRONMENT BE MINDFUL HERE!"
    read -p "Do you want to reboot? Type y or n:" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        reboot
    fi
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "Looks like we're all done here!"
    fi
=======
	if [ ! -d tmp ] 
	then
    		mkdir -p tmp
	fi

        echo "Looking for missing patches on $HOSTNAME for $DISTRO..."

        for PATCH in `cat patches/$DISTRO`      
        do
	        PATCH_NAME=`echo $PATCH | awk -F'|' {'print $1'}`
        	PATCH_UUID=`echo $PATCH | awk -F'|' {'print $2'}`
                PATCH_URL=`echo $PATCH | awk -F'|' {'print $3'}`
		PATCH_KB=`echo $PATCH | awk -F'|' {'print $4'}`

                if [ -f /var/patch/applied/$PATCH_UUID ]
		then
			echo "$PATCH_NAME has been applied, moving on..."
		fi
	       
		if [ ! -f /var/patch/applied/$PATCH_UUID ]
        	then
			echo "Found missing patch $PATCH_NAME, checking to see if it exists in cache..."

			if [ ! -f cache/$PATCH_NAME.xsupdate ] 
			then
				echo "Downloading from $PATCH_URL..."
				cd tmp
				wget -q $PATCH_URL
				unzip -qq $PATCH_NAME.zip				
				mv $PATCH_NAME.xsupdate ../cache
				cd ..
			fi	

			echo "Applying $PATCH_NAME... [ Release Notes @ $PATCH_KB ]"
             		xe patch-upload file-name=cache/$PATCH_NAME.xsupdate
		        xe patch-apply uuid=$PATCH_UUID host-uuid=$HOSTID
	        fi

        done

	echo "Cleaning up temporary files"
	rm -rf cache/*
	rm -rf tmp/*
		echo "Temporary Files have been cleaned up!"
        echo "All Possible Patches have been applied!"
		echo "You should reboot and run again to apply and patches that needed prerequisites."
		echo "IF YOU'RE IN A PRODUCTION ENVIRONMENT BE MINDFUL HERE!"
	read -p "Do you want to reboot? Type y or n:" -n 1 -r
		echo    
		if [[ $REPLY =~ ^[Yy]$ ]]
			then
			reboot
			fi
		if [[ $REPLY =~ ^[Nn]$ ]]
			then
			echo "Looks like we're all done here!"
		fi
>>>>>>> parent of f046d77... Standardize, cleanup, homogenize whitespace and indentation
}
get_xs_version
apply_patches
