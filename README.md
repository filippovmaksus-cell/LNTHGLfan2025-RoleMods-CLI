# LNTHGLfan2025 RoleMods CLI v1.0.0

An interactive, terminal-based Command Line Interface (CLI) for managing roleplay game modifications and launching Scratch 3.0 (`.sb3`) projects natively or online.

## Features
* **11 Interactive Commands**: Fully functional navigation, configuration, and simulation commands using the `/` prefix.
* **Modern Terminal Layout**: Styled using ANSI escape code sequences for text color and clean layout rendering.
* **Crash Prevention**: Developed in pure Windows Batch using safe delayed variable expansion, preventing syntax crashes from special characters (e.g., `&`, `|`, `<`, `>`).
* **Scratch (.sb3) Player Integration**: Load and verify Scratch projects, with direct launching options for local default players or TurboWarp Web Integration.
* **No-Admin Installers**: Bundled with safe installers for both CMD (`install.bat`) and PowerShell (`install.ps1`) that register the app path to the User `PATH` environment variable without requiring UAC administrator privileges.

---

## Installation

### Prerequisites
* Windows 10 or Windows 11 (with Virtual Terminal support enabled).
* Git (optional, for cloning this repository).

### Step-by-Step Installation

1. **Download the Repository**  
   Download the repository as a ZIP file and extract it, or clone it using Git:
   ```bash
   git clone https://github.com/YOUR_GITHUB_USERNAME/LNTHGLfan2025-RoleMods.git
   cd LNTHGLfan2025-RoleMods
