# iTerm2 preferences

iTerm2 does **not** read from `~/.config/iterm2` (that directory is just
runtime sockets). Real preferences live in
`~/Library/Preferences/com.googlecode.iterm2.plist`, and iTerm2 caches them
in memory, so symlinking the plist does not work reliably — iTerm2 can
overwrite your dotfiles copy when it flushes.

## One-time setup on a fresh mac

The canonical way to share iTerm2 prefs is iTerm2's built-in "load prefs from
a custom folder" feature:

1. Quit iTerm2 completely.
2. Copy the bundled plist into place so iTerm2 has something to read on first
   launch:

   ```bash
   cp ~/Projects/dotfiles/iterm2/com.googlecode.iterm2.plist \
      ~/Library/Preferences/com.googlecode.iterm2.plist
   defaults read com.googlecode.iterm2 >/dev/null   # nudge cfprefsd
   ```

3. Launch iTerm2 → **Settings → General → Settings**.
4. Check **"Load preferences from a custom folder or URL"** and point it at
   `~/Projects/dotfiles/iterm2`.
5. Choose **"Save changes to folder when iTerm2 quits"** if you want the
   dotfiles copy to stay in sync automatically.

From then on, iTerm2 will read/write
`~/Projects/dotfiles/iterm2/com.googlecode.iterm2.plist` on every launch/quit,
and you just commit the file when settings drift.

## Refreshing the committed plist manually

If you'd rather not use the "custom folder" feature, sync manually:

```bash
cp ~/Library/Preferences/com.googlecode.iterm2.plist \
   ~/Projects/dotfiles/iterm2/com.googlecode.iterm2.plist
```
