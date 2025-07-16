for f in *.cbz *.cbr *.cb7; do
  [[ -e "$f" ]] || continue

  name="${f%.*}"
  mkdir -p "$name"
  tmpdir=$(mktemp -d)

  # Detect actual file type
  type=$(file -b --mime-type "$f")

  case "$type" in
    application/zip)
      unzip -qq "$f" -d "$tmpdir" ;;
    application/x-rar*|application/vnd.rar)
      unrar x -inul "$f" "$tmpdir/" ;;
    application/x-7z-compressed)
      7z x -y -o"$tmpdir" "$f" >/dev/null ;;
    *)
      echo "Unknown archive format: $f (mime type: $type), skipping."
      rm -r "$tmpdir"
      continue ;;
  esac

  i=1
  find "$tmpdir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort | while read -r img; do
    ext="${img##*.}"
    printf -v newname "%03d.%s" "$i" "$ext"
    mv "$img" "$name/$newname"
    ((i++))
  done

  rm -r "$tmpdir"
done
