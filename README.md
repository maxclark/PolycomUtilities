# Polycom Utilities

Utility scripts to manage Polycom phones

## Extract Firmware

`$ extract_firmware.sh <filename> <version>`

Extract the Polycom split file, rename the sip.ld files for upload to a provisioning server.

## Create Directory

`$ create_directory.pl -f <filename>`

Read a supplied CSV file for name and extension and create a directory.xml file for delivery to a phone.
