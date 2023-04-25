export RUST_HOME=$HOME/workspace/root/lang/rust
mkdir -p $RUST_HOME
export RUSTUP_HOME=$RUST_HOME/rustup
export CARGO_HOME=$RUST_HOME/cargo
export PATH="$CARGO_HOME/bin:$PATH"

alias cr="cargo run"
alias ct="cargo test"
alias ci="cargo install"
alias cb="cargo built"
alias ck="cargo check"
