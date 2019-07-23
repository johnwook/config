function gprune
  g checkout master;
  g pull;
  g branch -D $argv;
  g remote prune origin;
end
