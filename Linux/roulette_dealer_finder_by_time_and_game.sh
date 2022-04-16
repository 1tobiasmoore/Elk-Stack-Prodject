#!/bash/bin
cat $1_Dealer_schedule |grep $2|grep $3| grep $4|
{ if $4 = BlackJack then awk '{print $1,$2,$3,$4}'
elseif $4 = Roulette
awk '{print $1, $2, $5, $6}'
elseif $4 = Texas_Hold_Em
awk '{print $1, $2, $7, $8}'}