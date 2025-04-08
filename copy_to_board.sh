#!/bin/sh
#Usage: ./copy_to_board.sh [IP of board to copy to]
#Example ./copy_to_board.sh [2001:db8:abcd:12:24c1:5eff:fe58:dd3a]
# set -x
if [ "$#" -ne 1 ]; then
    echo "Usage: ./copy_to_board.sh [IP of board to copy to]"
    echo "Example:"
    echo "./copy_to_board.sh 192.168.2.25"
    echo "./copy_to_board.sh [2001:db8:abcd:12:24c1:5eff:fe58:dd3a]"
    exit 1
fi
IP=$1
IP_SSH=$(echo ${IP} | tr -d '[]')

# path to the directory where the script itself is located
SRC_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT=$(basename ${SRC_DIR})

DST_DIR="/tmp"
USER="root"
rm -f ${SRC_DIR}/${PROJECT}.tar.gz
(cd ${SRC_DIR} && tar -czf ${PROJECT}.tar.gz --exclude='*venv*' --exclude='*__pycache__*' ./*)
#mv ${SRC_DIR}/${PROJECT}.tar.gz ${SRC_DIR}/
scp -p ${SRC_DIR}/${PROJECT}.tar.gz ${USER}@${IP_SSH}:${DST_DIR}
scp -p ${SRC_DIR}/untar_install.sh ${USER}@${IP_SSH}:${DST_DIR}
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "Files copied to board!"
echo "Now run the following commands on board as root:"
echo "cd ${DST_DIR} && ./untar_install.sh ${PROJECT}"
echo "python3 -m lmk05318"
exit 0
# End of snippet
