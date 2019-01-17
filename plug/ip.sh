i(){
  echo -n 'local:  '
  ifconfig en0 inet | tail -n 1 | cut -d ' ' -f 2
  echo -n 'public: '
  curl ipinfo.io/ip
}
