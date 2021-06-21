# Options
setopt no_clobber # let me overwrite files
setopt rm_star_silent # dont ask to delete
setopt chase_links # resolve symlinks
setopt extended_glob # better glob 
setopt glob_dots # glob include dotfiles


prependpath(){
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      export PATH="$1:${PATH:+$PATH}" 
  esac
}

appendpath(){
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      export PATH="${PATH:+$PATH}:$1" 
  esac
}


# better zsh completion
zstyle ':completion:*' menu select

# Environment Variabels
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'
export SHELL=$(which zsh)
export PAGER=$(which less)
export EDITOR=$(which nvim)
export GPG_TTY=$(tty)
export LC_ALL='en_US.UTF-8'
export FZF_DEFAULT_COMMAND='rg --files'

export GTK_THEME=Materia:dark
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=$HOME/.runtime

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/workspace/temp"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Photos"
export XDG_VIDEOS_DIR="$HOME/Videos/"

export S_WORKSPACE_DIR="$HOME/workspace"
export S_LOG_DIR="$S_WORKSPACE_DIR/log"
export S_CRON_DIR="$S_WORKSPACE_DIR/cron"
export S_ASSET_DIR="$S_WORKSPACE_DIR/asset"
export S_ASSET_temp="$S_WORKSPACE_DIR/temp"
export w=$S_WORKSPACE_DIR

# Load mold plugins
export MOLD_ROOT="$S_WORKSPACE_DIR"
export MOLD_SIGN='true'
prependpath "$MOLD_ROOT/exec:$PATH"
for plug in $MOLD_ROOT/plug/* ;do
  source $plug
done

# Load secret env
export SECRET_DIR="$S_WORKSPACE_DIR/hide"
for  secret in $SECRET_DIR/env/*.sh; do 
 source $secret
done

# 
# Custom Error Exit Status
#handle_error(){
  #echo "FAILED: status code $?"
#}
# TODO @slugbyte STOP THE TRAP FROM FIRING ON PROMPT PRECMD find_git*
#trap handle_error ERR

# set the window titile for the mold/exec/terminal script
print -n "\e]2;__XOXO__:$PWD"
precmd(){
  print -n "\e]2;__XOXO__:$PWD"
  }
}

