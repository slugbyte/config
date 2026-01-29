export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'

# custom dir shortcuts
export w="$HOME/workspace"
export drop="$HOME/Dropbox"
export code="$w/code"
export conf="$w/conf"
export play="$w/play"
export data="$drop/data"
export gang="$drop/gang"
export hide="$drop/hide"
export user="$drop/user"
export temp="$HOME/Downloads"
export image="$data/image"
export video="$data/video"
export trash="$HOME/.local/share/Trash/files"

# e is my editor
export EDITOR="$(which e)"
# use btop as my top command
export TOPER="$(which btop)"
# set my locale
export LC_ALL='en_US.UTF-8'
# page with less, without history, and with my workman keybinds
export PAGER="$(which less)"
export MANPAGER="$(which less)"
export LESSKEY="$HOME/.config/less/lesskey"
export LESSHISTFILE=-
# EZA lackluster theme
export EZA_COLORS='ex=38;2;120;153;120:fi=38;2;204;204;204:di=38;2;85;85;85:b0=38;2;215;0;0:or=38;2;215;0;0:ln=38;2;112;128;144:lp=38;2;112;128;144:lc=38;2;112;128;144:lm=38;2;112;128;144:bd=38;2;119;136;170:cd=38;2;119;136;170:pi=38;2;119;136;170:so=38;2;119;136;170:ur=38;2;122;122;122:uw=38;2;122;122;122:ux=38;2;122;122;122:ue=38;2;122;122;122:gr=38;2;122;122;122:gw=38;2;122;122;122:gx=38;2;122;122;122:tr=38;2;122;122;122:tw=38;2;122;122;122:tx=38;2;122;122;122:su=38;2;122;122;122:sf=38;2;122;122;122:xa=38;2;122;122;122:hd=38;2;68;68;68:bl=38;2;122;122;122:cc=38;2;122;122;122:da=38;2;122;122;122:in=38;2;122;122;122:xx=38;2;122;122;122:ga=38;2;120;153;120:gd=38;2;255;170;136:gm=38;2;119;136;170:gv=38;2;119;136;170:gt=38;2;119;136;170:df=38;2;122;122;122:ds=38;2;122;122;122:sb=38;2;85;85;85:sn=38;2;170;170;170:uu=38;2;85;85;85:un=38;2;85;85;85:gu=38;2;85;85;85:gn=38;2;85;85;85:sc=38;2;204;204;204:bu=38;2;204;204;204:cm=38;2;122;122;122:tm=38;2;122;122;122:co=38;2;122;122;122:do=38;2;122;122;122:cr=38;2;255;170;136:im=38;2;122;122;122:lo=38;2;122;122;122:mu=38;2;122;122;122:vi=38;2;122;122;122:mp=38;2;122;122;122'
# make rust panic with max verbosity
export RUST_BACKTRACE='full'
# cargo install will put binarys in ~/.local/bin
export CARGO_INSTALL_ROOT="$HOME/.local"
# cargo internal data location
export CARGO_HOME="$HOME/.local/share/cargo"
# rustup internal data location
export RUSTUP_HOME="$HOME/.local/share/rustup"
# go can store installed binarys here
export GOBIN="$HOME/.local/bin"
# go internal data location
export GOPATH="$HOME/.local/share/go"
# try can put its projects in $play
export TRY_PATH="$play"

# local/bin and $conf/bin need to be added to path
export PATH=$($conf/bin/path-prepend "$HOME/.local/bin")
export PATH=$($conf/bin/path-prepend "$conf/bin")
