#!/usr/bin/env bash
# 產生蒐集冊用的小圖：images/<檔名>.jpg → images/thumbs/<檔名>.jpg
# 120x120，從上方裁切（對應蒐集冊 object-position: top center）
# 用法：bash tools/make-thumbs.sh        只補還沒有小圖的
#       bash tools/make-thumbs.sh --all  全部重做
# 需要 ImageMagick（magick 指令）
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p images/thumbs
for f in images/*.jpg; do
    out="images/thumbs/$(basename "$f")"
    if [[ "${1:-}" != "--all" && -f "$out" ]]; then continue; fi
    magick "$f" -resize '120x120^' -gravity north -extent 120x120 -strip -quality 75 "$out"
    echo "產生 $out"
done
