start=${1:-2020-08-24}
end=${2:-2020-08-28}
for x in $(ls); do
  if [ -d $x/.git ]; then
  (
    CDPATH= cd $x;
    git --no-pager log --all --since $start --until $end --author derek.s.ludwig
  );
  fi
done
