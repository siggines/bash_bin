mkdir -p PDFs


for d in */; do

[ "$d" = "PDFs/" ] && continue

cd "$d" || continue

mapfile -d '' files < <(find . -maxdepth 1 \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -print0 | sort -z -V)

if [ "${#files[@]}" -gt 0 ]; then
img2pdf "${files[@]}" -o "../PDFs/$(basename "$d").pdf"
fi

cd ..
done

