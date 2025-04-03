#!/bin/sh
PROJECT=$1
rm -rf ./${PROJECT}
mkdir ./${PROJECT}
tar -xzf ${PROJECT}.tar.gz -C ./${PROJECT}
cd ./${PROJECT}
python3 ./setup.py install
exit 0
# End of snippet
