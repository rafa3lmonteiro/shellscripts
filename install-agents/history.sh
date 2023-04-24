#!/bin/bash


echo -e "HISTFILESIZE=10000
HISTSIZE=10000
HISTCONTROL=ignorespace
HISTTIMEFORMAT='%d/%m/%y %T '" >> /root/.bashrc

source /root/.bashrc
