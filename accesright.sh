#!/bin/bash

while IFS="," read -r id prenom nom mdp role

do
  mdpc=$(perl -e 'print crypt($ARGV[0], "salt")', $mdp)
  sudo useradd -m -p "$mdpc" "$prenom" -u "$id" -s /bin/bash

  if [[ "$role" =~ .*Admin.* ]]; then
    sudo adduser "$prenom" sudo
  fi

  sudo chown $prenom /home/$prenom && sudo chmod u+rwx /home/$prenom

done < <(tail -n +2 Shell_Userlist.csv)
