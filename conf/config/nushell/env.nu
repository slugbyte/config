def create_left_prompt [] {
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)\n"
    } else {
        $"(ansi blue)($env.PWD)" ++ "\n"
    }

    ^echo $"(ansi blue)($env.PWD)(ansi reset)\n"
}

def create_right_prompt [] {
  null
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt

let-env PROMPT_INDICATOR = { "✿ " }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

let-env LANG = 'en_US.UTF-8'
let-env EMAIL = 'slugbyte@slugbyte.com'
let-env SHELL = '/home/slugbyte/workspace/root/lang/rust/cargo/bin/nu'
let-env TERM = 'xterm-256color'
let-env EDITOR = '/home/slugbyte/workspace/root/bin/nvim'
let-env MOLD-ROOT = '/home/slugbyte/workspace'
let-env TRASH_DIR = '/home/slugbyte/.local/share/Trash/files'
let-env EXA_COLORS = 'di=38;5;111:ln=38;5;167:so=32:pi=33:ex=38;5;36:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:da=38;5;58:uu=38;5;59:sn=38;5;111:sb=38;5;96::ur=38;5;137:uw=38;5;137:ux=38;5;137:ue=38;5;137:gr=38;5;137:gw=38;5;137:gx=38;5;137:tr=38;5;137:tw=38;5;137:tx=38;5;137:.git*=38;5;204:.bashrc=38;5;204:*.test.js=38;5;204:.env=38;5;204:.vimrc=38;5;204:Makefile=38;5;204:README.md=38;5;204'

# rust
let-env RUST_HOME = '/home/slugbyte/workspace/root/lang/rust'
let-env RUSTUP_HOME = $"($env.RUST_HOME)/rustup"
let-env CARGO_HOME = $"($env.RUST_HOME)/cargo"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/exec')
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/exec/ignore')
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/root/bin')
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/exec/ignore')
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/root/lang/zig')
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/root/lang/go/bin')
let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/slugbyte/workspace/root/lang/go/bin')
let-env PATH = ($env.PATH | split row (char esep) | prepend $"($env.CARGO_HOME)/bin")
