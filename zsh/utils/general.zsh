# Import zsh configs if available
import() {
    [[ -f "$1" ]] && source "$1"
}

# Import all zsh files in a directory
source_from_dir() {
    local dir="$1"
    for file in "$dir"/*.zsh; do
        [[ -f "$file" ]] && source "$file"
    done
}
