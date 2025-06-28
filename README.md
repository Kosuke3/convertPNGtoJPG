# convertPNGtoJPG
zshスクリプト：指定フォルダ内にあるPNG画像をJPGに変換し、PNGファイルを削除（要ImageMagickインストール）

macのシェルスクリプト（zsh）にて、指定フォルダ内にあるPNG画像をJPGに変換して元のPNGファイルを削除するスクリプト。ImageMagick 7以降が必要。（未インストールの場合はHomebrewにてbrew install imagemagick）

使用方法：./convertPNGtoJPG.zsh path/to/directory（変換したいPNGファイルをを含むディレクトリー）
指定したい階層内を再帰的にPNGファイルを検索
