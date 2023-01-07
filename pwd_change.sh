#!/bin/bash
#
# Password change without interaction in bash 
# Used to change password in scripts without needing human interaction.
#

echo -e "yourpassword\nyourpassword\n" |passwd
