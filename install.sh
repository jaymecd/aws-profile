#!/bin/sh

REPOSITORY="https://raw.github.com/jaymecd/aws-profile/master"
DST_PATH=/usr/local/bin

for F in aws-profile aws-wrapper; do
    curl -sSL "${REPOSITORY}/$F" > "${DST_PATH}/$F"
    chmod +x "${DST_PATH}/$F"
done

cat <<"EOL"
# Update ~/.bashrc with this block:
# ---------------------------------
export PATH="/usr/local/bin:$PATH"

# Amazon AWS Service CLI
complete -C aws_completer aws
alias aws-profile="source aws-profile"
alias aws="aws-wrapper"
# ---------------------------------
EOL

echo "Done."
