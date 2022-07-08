rg_with() {
  rg $1 | cut -d : -f 1 | sort | uniq
}
