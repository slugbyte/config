rgf() {
  rg $@ |cat | cut -d ':' -f 1 |sort  |uniq
}
