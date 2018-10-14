while true
do
  echo 'running react tunnel'
  ssh -N -L 3001:localhost:3001 jeremyre@10.150.24.75
  sleep 5
done
