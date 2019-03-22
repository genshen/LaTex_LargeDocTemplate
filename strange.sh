#!/bin/sh
set -e
MAX_SEARCH_DEPTH=8
PREAMBLE_PATH="shared/preamble.sty"
PREAMBLE_PACKAGE="shared/preamble"
BIB_PATH="shared"
dir="./"

if [ "$1" != "" ]; then
    dir=$1
fi

base_path="$(cd "$dir" && pwd -P)"  # where is the project home

# Note that the simple example above will fail if the directory names contain whitespace or special characters.
# see: https://unix.stackexchange.com/questions/187167/traverse-all-subdirectories-in-and-do-something-in-unix-shell-script
for path in $(find $base_path -maxdepth $MAX_SEARCH_DEPTH -type d -not -path "*.git*"  )
do
    #Do something, the directory is accessible with $d:
    abs_path="$(cd "$path" && pwd -P)" #  relative path to absolute path
    has_tex_file=$(find "$abs_path" -maxdepth 1 -name "*.tex") # checkout each subdir contains *.tex file
    if [ ${#has_tex_file[@]} -gt 0 ]; then 
        cat > $abs_path/.strange.sty <<EOF
\ProvidesPackage{.strange}
\usepackage{$base_path/$PREAMBLE_PACKAGE}
EOF
    fi
done

# strange for project home
cat > $base_path/.strange.sty <<EOF
\ProvidesPackage{.strange}
\usepackage{$base_path/$PREAMBLE_PACKAGE}
EOF

# bib path
sed -i -e "s|@BIBPATH|$base_path/$BIB_PATH|g" $base_path/$PREAMBLE_PATH

echo "success"
