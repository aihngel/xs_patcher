##See update notes at bottom of this file!

## xs_patcher - patches XenServer host with all released hotfixes

This script will retrieve and apply all of the latest hotfixes for Citrix XenServer.

## Supported Versions

	XenServer 6.0.0 (Boston)
	XenServer 6.0.2 (Sanibel)
	XenServer 6.1.0 (Tampa)
	XenServer 6.2.0 (Clearwater)

## Running

Drop the repo onto a XenServer and run:

	cd xs_patcher
	./xs_patcher.sh

## Adding new hotfixes

The hotfixes are stored in individual files per distro in the patches directory. To 
add new hotfixes, just add a line in the following format:

	patch name|uuid of patch|url of download|url of kb article
	
Make sure to keep the patch names sequential so they get applied in the right order.

## Disclaimer

Please use extreme caution before putting on a production server!!!

## Updates

9/1/2014

Added updated patches for Clearwater

Added temporary file Removal to keep from filling up root directory

Added reboot prompt and helpful information to user

Merged! ~ Remove patch zips and xsupdates as soon as they're no longer needed So that we don't fill up dom0 and run out of disk space.  Thank you dmsimard!
