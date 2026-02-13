#!/bin/sh

# This script installs a list of VS Code extensions.
# It is intended to be run once by chezmoi.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions ---

# Function to check if a command exists in the system's PATH.
# Outputs 0 if the command is found, 1 otherwise.
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# --- Main Script ---

# Check if the 'code' command-line tool is available.
# This is the command-line interface for VS Code.
if ! command_exists code; then
    echo "VS Code 'code' command not found in PATH. Skipping extension installation."
    # Exit with success because not having VS Code is not a failure of the script.
    exit 0
fi

# A list of VS Code extensions to be installed.
# Add or remove extension IDs from this list as needed.
# You can find the extension ID on its marketplace page.
EXTENSIONS="
aaron-bond.better-comments
alefragnani.project-manager
christian-kohler.path-intellisense
clinyong.vscode-css-modules
dbaeumer.vscode-eslint
donjayamanne.githistory
dsznajder.es7-react-js-snippets
eamodio.gitlens
esbenp.prettier-vscode
formulahendry.auto-rename-tag
hbenl.vscode-test-explorer
HookyQR.beautify
ms-azuretools.vscode-docker
ms-dotnettools.csdevkit
ms-python.python
ms-vscode.cpptools
ms-vscode.powershell
ms-vsliveshare.vsliveshare
oderwat.indent-rainbow
PKief.material-icon-theme
redhat.java
redhat.vscode-yaml
ritwickdey.liveserver
scala-lang.scala
streetsidesoftware.code-spell-checker
stylelint.vscode-stylelint
Telerik.fiddler-everywhere
VisualStudioExptTeam.intellicode-api-usage-examples
VisualStudioExptTeam.vscodeintellicode
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-maven
WallabyJs.quokka-vscode
wix.vscode-import-cost
"

# Loop through the list of extensions and install each one.
# The --force flag ensures that already installed extensions are updated.
echo "Installing VS Code extensions..."
for extension in $EXTENSIONS; do
    if [ -n "$extension" ]; then # Ensure the line is not empty
        echo "Installing $extension..."
        code --install-extension "$extension" --force
    fi
done

echo "VS Code extension installation complete."

exit 0