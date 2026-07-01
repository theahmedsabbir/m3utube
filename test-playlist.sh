#!/usr/bin/env bash
# command examples: ./test-playlist.sh playlist.m3u or ./test-playlist.sh playlist.m3u 5 


PLAYLIST="${1:-}"
REPORT="report.txt"
SECONDS_TEST=3

if [[ -z "$PLAYLIST" || ! -f "$PLAYLIST" ]]; then
  echo "Usage: $0 playlist.m3u" >&2
  exit 1
fi

command -v ffmpeg >/dev/null || { echo "ffmpeg not found. Install: sudo apt install ffmpeg" >&2; exit 1; }

: > "$REPORT"

ok=0
fail=0
extinf=""

get_name() {
  local info="$1" name=""
  [[ -z "$info" ]] && { echo "Unknown"; return; }
  if [[ "$info" == *","* ]]; then
    name="${info##*,}"
    name="${name#"${name%%[![:space:]]*}"}"
    name="${name%"${name##*[![:space:]]}"}"
  fi
  if [[ -z "$name" && "$info" =~ tvg-name=\"([^\"]*)\" ]]; then
    name="${BASH_REMATCH[1]}"
    name="${name#"${name%%[![:space:]]*}"}"
    name="${name%"${name##*[![:space:]]}"}"
  fi
  [[ -z "$name" ]] && name="Unknown"
  echo "$name"
}

while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line%$'\r'}"

  if [[ "$line" == \#EXTINF* ]]; then
    extinf="$line"
    continue
  fi

  if [[ "$line" =~ ^https?:// ]]; then
    name=$(get_name "$extinf")

    if ffmpeg -v error -i "$line" -t "$SECONDS_TEST" -f null - 2>/dev/null; then
      printf '%-35s OK   %s\n' "$name" "$line" >> "$REPORT"
      ok=$((ok + 1))
    else
      printf '%-35s FAIL %s\n' "$name" "$line" >> "$REPORT"
      fail=$((fail + 1))
    fi
    extinf=""
  fi
done < "$PLAYLIST"

echo "--- OK: $ok | FAIL: $fail | Total: $((ok + fail)) ---" >> "$REPORT"
