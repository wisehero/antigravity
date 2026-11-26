#!/usr/bin/env bash
# 이 저장소의 Antigravity 전역 설정을 ~/.gemini/config/ 에 심볼릭 링크로 연결한다.
# 기존 파일이 있으면 ~/.gemini/backups/ 아래로 백업한 뒤 연결한다.

set -u
shopt -s nullglob

ROOT="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel 2>/dev/null)"
SOURCE="$ROOT/config"
if [ -z "$ROOT" ] || [ ! -f "$SOURCE/GEMINI.md" ]; then
  echo "antigravity 저장소를 찾지 못했다. git clone 으로 받은 저장소 안의 install.sh 를 실행한다." >&2
  exit 1
fi

GEMINI_CONFIG="$HOME/.gemini/config"
BACKUP="$HOME/.gemini/backups/antigravity-install-$(date +%Y%m%d-%H%M%S)"
FAILED=0

link() {
  local source="$1" target="$2"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    echo "[유지] $target"
    return
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    local saved="$BACKUP${target#"$HOME"}"
    mkdir -p "$(dirname "$saved")"
    mv "$target" "$saved"
    echo "[옮김] $target -> $saved"
  fi
  if mkdir -p "$(dirname "$target")" && ln -s "$source" "$target"; then
    echo "[연결] $target -> $source"
  else
    echo "[실패] $target" >&2
    FAILED=1
  fi
}

echo "== 링크 (원본: $SOURCE)"
link "$SOURCE/GEMINI.md" "$GEMINI_CONFIG/GEMINI.md"

if [ -d "$SOURCE/skills" ]; then
  for skill in "$SOURCE"/skills/*/; do
    skill="${skill%/}"
    link "$skill" "$GEMINI_CONFIG/skills/$(basename "$skill")"
  done
fi

if [ "$FAILED" -ne 0 ]; then
  echo "== 링크를 걸지 못한 곳이 있다" >&2
  exit 1
fi
echo "== 끝"
