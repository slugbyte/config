# brave

- Source: <https://github.com/badlogic/pi-skills/tree/main/brave-search>
- Local path: `other/pi/skills/brave`
- Notes:
  - Vendored from `badlogic/pi-skills`, then adapted to the local `brave` CLI
  - Uses `BRAVE_API_KEY` from your shell environment
  - Local runtime now lives in `~/workspace/code/brave`

## Setup

1. Create a Brave Search API account at <https://api-dashboard.search.brave.com/register>.
2. Create a subscription and API key.
3. Export the key in your shell environment, for example in `~/.config/slugbyte/secrets.sh`:
   ```sh
   export BRAVE_API_KEY="your-api-key-here"
   ```
4. Build and install the CLI:
   ```bash
   cd ~/workspace/code/brave
   ./install.sh
   ```

This installs a compiled `brave` binary into `~/workspace/conf/bin/brave`.

## Local files

- `SKILL.md` contains agent-facing usage guidance only.
- `README.md` contains setup notes for this local installation.
- The actual CLI source now lives in `~/workspace/code/brave`.
