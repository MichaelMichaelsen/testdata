#!/bin/bash
#
# run - control file for converting and adding BBR information to MU reservet testdata (based on bfe)
#
# Step 1 - 1.1 SFE - et jordstykke og en bygning
perl bbrgrund.pl   --input=testdata02-MU11.csv           --output=testdata02-MU11-husnummer.csv
perl bbrbygning.pl --input=testdata02-MU11-husnummer.csv --output=testdata02-MU11-husnr-byg.csv
#
# Step 2 - 1.2 SFE - et jordstykke og to bygninger
perl bbrgrund.pl   --input=testdata02-MU12.csv           --output=testdata02-MU12-husnummer.csv
perl bbrbygning.pl --input=testdata02-MU12-husnummer.csv --output=testdata02-MU12-husnr-byg.csv
