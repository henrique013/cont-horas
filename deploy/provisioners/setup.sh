#!/usr/bin/env bash


echo "================================================================================================"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SETUP <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
echo "================================================================================================"


# update
apt-get update
apt-get dist-upgrade -y

# set locale
locale-gen pt_BR.UTF-8
update-locale LANG="pt_BR.UTF-8"
update-locale LANGUAGE="pt_BR:pt:en"