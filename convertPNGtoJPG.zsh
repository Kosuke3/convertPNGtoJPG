#!/bin/zsh

# 使用方法　./convertPNGtoJPG /path/to/folder

# 引数チェック
if [[ -z "$1" ]]; then
 echo "使用方法：$0 変換フォルダのパス"
exit 1
fi

# 再帰的にPNGファイルを探してJPG画質80/100に変換
find "$1" -type f -iname '*.png' | while IFS= read -r pngfile; do
 jpgfile="${pngfile%.*}.jpg"
 echo "変換中：$pngfile→$jpgfile"
 
 if magick "$pngfile" -quality 80 "$jpgfile"; then
  echo "✅ 変換成功、削除: $pngfile"
  rm "$pngfile"
 else
  echo "❌️ 変換失敗：$pngfile"
 fi
done