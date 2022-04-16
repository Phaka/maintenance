#!/bin/sh
HOST=$1
ssh -o IdentitiesOnly=yes -o StrictHostKeyChecking=no phaka@$HOST uname -a
ssh -o IdentitiesOnly=yes -o StrictHostKeyChecking=no phaka@$HOST rm -Rf scripts
scp -o IdentitiesOnly=yes -rp -o StrictHostKeyChecking=no scripts phaka@$HOST:~/
ssh -o IdentitiesOnly=yes -o StrictHostKeyChecking=no phaka@$HOST chmod u+x scripts/*.sh
ssh -o IdentitiesOnly=yes -o StrictHostKeyChecking=no phaka@$HOST sudo scripts/adduser.sh $AGENT_USR $AGENT_PSW
ssh -o IdentitiesOnly=yes -o StrictHostKeyChecking=no phaka@$HOST sudo scripts/maintenance.sh