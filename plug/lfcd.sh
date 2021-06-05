# got this idea from https://github.com/gokcehan/lf/blob/5d02b557d3ea694d8a51cc3918ab5ffda33387d9/etc/lfcd.sh#L24
lfcd(){
  tmp="$(mktemp)"
  lfrun $tmp $@
  if [ -f "$tmp" ]; then
      dir="$(cat "$tmp")"
      rm -f "$tmp"
      if [ -d "$dir" ]; then
          if [ "$dir" != "$(pwd)" ]; then
            cd "$dir" 
          fi
      fi
  fi
}
