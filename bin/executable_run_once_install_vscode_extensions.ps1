<#
.SYNOPSIS
This script installs a list of VS Code extensions.
It is intended to be run once by chezmoi.
#>

# --- Helper Functions ---

# Function to check if a command exists in the system's PATH.
function Test-CommandExists {
    param(
        [string]$command
    )
    # The 'Get-Command' cmdlet returns an object if the command is found.
    # If not found, it throws an error. We suppress the error and check if the result is null.
    return (Get-Command $command -ErrorAction SilentlyContinue) -ne $null
}

# --- Main Script ---

# Check if the 'code.cmd' command-line tool is available.
# This is the command-line interface for VS Code on Windows.
if (-not (Test-CommandExists "code.cmd")) {
    Write-Output "VS Code 'code.cmd' command not found in PATH. Skipping extension installation."
    # Exit with success because not having VS Code is not a failure of the script.
    exit 0
}

# A list of VS Code extensions to be installed.
# Add or remove extension IDs from this list as needed.
$extensions = @(
    "aaron-bond.better-comments",
    "alefragnani.project-manager",
    "christian-kohler.path-intellisense",
    "clinyong.vscode-css-modules",
    "dbaeumer.vscode-eslint",
    "donjayamanne.githistory",
    "dsznajder.es7-react-js-snippets",
    "eamodio.gitlens",
    "esbenp.prettier-vscode",
    "formulahendry.auto-rename-tag",
    "hbenl.vscode-test-explorer",
    "HookyQR.beautify",
    "ms-azuretools.vscode-docker",
    "ms-dotnettools.csdevkit",
    "ms-python.python",
    "ms-vscode.cpptools",
    "ms-vscode.powershell",
    "ms-vsliveshare.vsliveshare",
    "oderwat.indent-rainbow",
    "PKief.material-icon-theme",
    "redhat.java",
    "redhat.vscode-yaml",
    "ritwickdey.liveserver",
    "scala-lang.scala",
    "streetsidesoftware.code-spell-checker",
    "stylelint.vscode-stylelint",
    "Telerik.fiddler-everywhere",
    "VisualStudioExptTeam.intellicode-api-usage-examples",
    "VisualStudioExptTeam.vscodeintellicode",
    "vscjava.vscode-java-debug",
    "vscjava.vscode-java-dependency",
    "vscjava.vscode-java-pack",
    "vscjava.vscode-java-test",
    "vscjava.vscode-maven",
    "WallabyJs.quokka-vscode",
    "wix.vscode-import-cost"
)

# Loop through the list of extensions and install each one.
# The --force flag ensures that already installed extensions are updated.
Write-Output "Installing VS Code extensions..."
foreach ($extension in $extensions) {
    if (-not [string]::IsNullOrWhiteSpace($extension)) {
        Write-Output "Installing $extension..."
        # Use 'code.cmd' to ensure compatibility on Windows
        code.cmd --install-extension $extension --force
    }
}

Write-Output "VS Code extension installation complete."

exit 0