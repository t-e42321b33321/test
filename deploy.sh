#!/bin/bash
#set -x
check_command () {
  command -v $1 > /dev/null 2>&1
  if [ $? -ne 0 ]
    then
      printf "\e[01;31m $1 not installed\e[m\n"
      exit 1
  fi
}

check_command vagrant
check_command curl

vagrant up

echo -e "\n Testing the round robin setting on nginx \n"
vagrant ssh proxy -c 'for i in {1..4}; do curl localhost; echo; done'
echo

vagrant ssh proxy -c 'if [ ! -f ~/.ssh/id_rsa ]; then ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa; fi' > /dev/null
KEY=$(vagrant ssh proxy -c 'cat ~/.ssh/id_rsa.pub'|grep -v closed)

vagrant ssh app1 -c "echo $KEY >> ~/.ssh/authorized_keys;\
chmod 600 ~/.ssh/authorized_keys" > /dev/null
vagrant ssh app2 -c "echo $KEY >> ~/.ssh/authorized_keys;\
chmod 600 ~/.ssh/authorized_keys" > /dev/null

vagrant ssh proxy -c 'sed -i "s/Hi there/Post-commit hook trigered. Hi there/g" /vagrant/app.go; \
cd /vagrant;  git config --global user.email "test@abc.uk"; git config --global user.name "test"; \
git commit -m "testing the auto deploy after git commit" app.go' > /dev/null

sleep 5
echo -e "\n Testing if the post commit hook trigged the app deployment \n"
vagrant ssh proxy -c 'for i in {1..4}; do curl localhost; echo; done'
