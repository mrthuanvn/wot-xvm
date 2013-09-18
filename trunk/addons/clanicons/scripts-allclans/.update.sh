#!/bin/sh

[ "$host" = "" ] && exit

# main
main()
{
  id=$startclan
  mkdir -p ../icons/$dir/res_mods/xvm/res/clanicons/$dir/clan
  while [ $id -le $lastclan ]; do
    update $id
    id=$((id+1))
  done
  optimize
}

# update
# $1 - clanId
update()
{
  echo -n "$1 - "

  clan=`wget -q "http://$host/uc/clans/$1/" -O - 2>/dev/null | \
    grep "<title>" | \
    cut -d[ -f2 | \
    cut -d] -f1`
  if [ "$clan" = "" ]; then
    echo "EMPTY"
    return
  fi
  if [ "$clan" = "    <title>" ]; then
    echo "REMOVED"
    return
  fi

  echo -n "[$clan] => $clan.png"
  wget -qc http://cw.$host/media/clans/emblems/clans_${1:0:1}/$1/emblem_64x64.png -O ../icons/$dir/res_mods/xvm/res/clanicons/$dir/clan/$clan.png 2>/dev/null

  echo " OK"
}

optimize()
{
  echo "Optimizing PNGs..."
  (
    cd ../icons/$dir/res_mods/xvm/res/clanicons/$dir/clan
    pngoptimizer -file:*.png
  )
}