# Homebrew package management with arguments
ensure_brew_packages() {
    # Exit if no arguments provided
    if [[ $# -eq 0 ]]; then
        echo "Usage: ensure_brew_packages <package1> [package2] [package3] ..."
        return 1
    fi

    # Use provided arguments as package list
    local packages=("$@")
    local pids=()

    # Process each package in parallel
    for package in "${packages[@]}"; do
        # Run check and install in a subshell for parallel execution
        if [[ -z "$(which "$package")" ]]; then
            echo "Installing $package..."
            brew install "$package"
            echo "Finished installing $package"
        fi
    done
}
