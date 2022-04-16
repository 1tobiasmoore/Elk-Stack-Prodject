echo "Quick audit script"
echo "Machine name is"
echo $MACHTYPE
echo -e "Uname info : $(uname -a)"
echo "$(ip addr | grep inet | tail -2 | head -1)"
echo "Hostname $(hostname -s)"