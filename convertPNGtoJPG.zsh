#!/bin/zsh

# 使用方法　./convertPNGtoJPG /path/to/folder

# 引数チェック
if [[ -z "$1" ]]; then
 echo "使用方法：$0 変換フォルダのパス"
exit 1
fi

# 再帰的にPNGファイルを検索
find "$1" -type f -iname '*.png' | while IFS= read -r pngfile; do
 jpgfile="${pngfile%.*}.jpg"
 
 # PNGをJPGへ変換し、量ファイルのサイズを比較
 magick "$pngfile" -quality 80 "$jpgfile"
 
 if [[ -f "$jpgfile" ]]; then
  pngsize=$(stat -f%z "$pngfile")
  jpgsize=$(stat -f%z "$jpgfile")
  
  # 画面表示用ファイルサイズを変換
  png_human=$(awk -v s="$pngsize" 'BEGIN {
      if (s < 1024) printf "%.0f butes", s;
      else if (s < 1048576) printf "%.1f kB", s/1024;
      else printf "%.2f MB", s/1048576;
  }')
  
  jpg_human=$(awk -v s="$jpgsize" 'BEGIN {
      if (s < 1024) printf "%.0f bytes", s;
      else if (s < 1045576) printf "%.1f kB", s/1024;
      else printf "%.2f MB", s/1048576;
  }')
  
   # 容量の小さいファイルを残し、大きなファイルを削除する
   if (( jpgsize < pngsize)); then
    deletefile="$pngfile"
    else
    deletefile="$jpgfile"
   fi
   
   echo "📊変換結果：$pngfile ${png_human} 　$(basename "$jpgfile") ${jpg_human} bytes → $(basename "$deletefile")を削除"
   rm "$deletefile"
 else
  echo "⚠️ JPG生成失敗：$jpgfile"
 fi
done