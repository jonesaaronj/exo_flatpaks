
grep -h -r --include="com.retro_exo.*.yaml" -e 'http.*.tar.gz' | grep -v 'url-template' | awk '{$1=$1};1' | cut -c 6- | sort

grep -h -r --include="com.retro_exo.*.json" -e 'http.*.tar.gz' | grep -v 'url-template' | sed 's/"url"://g' | sed 's/["|,]//g' | awk '{$1=$1};1' | sort

cat <(grep -h -r --include="com.retro_exo.*.yaml" -e 'http.*.tar.gz' | grep -v 'url-template' | awk '{$1=$1};1' | cut -c 6-) <(grep -h -r --include="com.retro_exo.*.json" -e 'http.*.tar.gz' | grep -v 'url-template' | sed 's/"url"://g' | sed 's/["|,]//g' | awk '{$1=$1};1') | sort
