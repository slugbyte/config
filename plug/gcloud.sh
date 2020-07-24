# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/slugbyte/Downloads/google-cloud-sdk/path.bash.inc' ]; then 
  . '/Users/slugbyte/Downloads/google-cloud-sdk/path.bash.inc'; 
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/slugbyte/Downloads/google-cloud-sdk/completion.bash.inc' ]; then 
  . '/Users/slugbyte/Downloads/google-cloud-sdk/completion.bash.inc'; 
fi

kms_encrypt(){
  if (( $# == 0 ));then 
    echo "Usage: kms_encrypt <key_ring> <key> <value>"
    return 0
  fi

  if (( $# != 3 ));then 
    echo "Usage Error try: kms_encrypt <key_ring> <key> <value>"
    return 1
  fi

  local kms_key_ring="$1"
  local kms_key="$2"
  local value="$3"

  echo $value > _kms_encrypt.data.txt

  gcloud kms encrypt \
    --plaintext-file=_kms_encrypt.data.txt \
    --ciphertext-file=_kms_encrypt.data.enc \
    --location=global \
    --keyring="$kms_key_ring" \
    --key="$kms_key" || return 1

  base64 _kms_encrypt.data.enc |tr -d '\n'  | pbcopy

  rm _kms_encrypt*
}

kms_decrypt(){
  if (( $# == 0 ));then 
    echo "Usage: kms_encrypt <key_ring> <key> <value>"
    return 0
  fi

  if (( $# != 3 ));then 
    echo "Usage Error try: kms_encrypt <key_ring> <key> <value>"
    return 1
  fi

  local kms_key_ring="$1"
  local kms_key="$2"
  local value="$3"

  echo $value | base64 -D > _kms_encrypt.data.enc

  gcloud kms decrypt \
    --plaintext-file=_kms_encrypt.data.txt \
    --ciphertext-file=_kms_encrypt.data.enc \
    --location=global \
    --keyring="$kms_key_ring" \
    --key="$kms_key" || return 1

  cat _kms_encrypt.data.txt | tr -d '\n' | pbcopy

  rm _kms_encrypt*
}
