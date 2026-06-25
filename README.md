# LNTHGLfan2025 RoleMods CLI v1.1.0

An interactive, terminal-based Command Line Interface (CLI) for managing roleplay game modifications, running Scratch 3.0 (`.sb3`) projects, and executing JavaScript packages via a custom package manager.

This release marks a minor version update featuring dynamic visual themes, native sound effects, an integrated Gemini AI assistant, multi-language localization, and local configuration storage.

## Key Features in v1.1.0
* **15 Active Commands**: Extended shell utility with custom functions prefixed by `/` (plus support for raw `hn` command input).
* **Multi-Language Support (Localization)**: Switch between English (`en`) and Ukrainian (`uk`) instantly using `/lang`. Cyrillic characters are rendered natively in UTF-8 mode (`chcp 65001`).
* **Persistent Local Storage**: Saves user settings (active theme and selected language) directly to `C:\Users\Admin\Desktop\RoleMods CLI\config.cfg`.
* **Zero-Latency Sound Effects**: Asynchronous audio feedback (success chimes, warning tones, error beeps) utilizing native Windows User32 API triggers.
* **Gemini Chat Assistant (`/talk`)**: Chat directly with `gemini-1.5-flash` in your console using the `GEMINI_API_KEY` system environment variable.
* **JavaScript Package Manager (`/hn`)**: Execute tasks via the "however number" (hn) engine with custom syntax `/hn <rolemods> <call> <number> <play>`.
* **Dynamic Custom Themes**: Toggle on the fly between Cyber Cyan, Matrix Green, Sunset Orange, and Classic White.

---

## Repository Structure
```text
LNTHGLfan2025-RoleMods/
├── rolemods.bat        # The main CLI application (Save as UTF-8)
├── install.bat         # The CMD installer
├── install.ps1         # The PowerShell installer
├── README.md           # This documentation file
└── LICENSE             # MIT License file
```

---

## Installation

### Prerequisites
* Windows 10 or Windows 11.
* A text editor that supports saving with **UTF-8 encoding** (to correctly process Cyrillic letters in the Ukrainian translation).

### Installation Steps
1. Download this repository as a `.zip` and extract it, or clone it using Git:
   ```bash
   git clone https://github.com/YOUR_GITHUB_USERNAME/LNTHGLfan2025-RoleMods.git
   cd LNTHGLfan2025-RoleMods
   ```
2. Double-click `install.bat` to run the native installer, or execute the PowerShell equivalent:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```
3. Open a new terminal window and type `rolemods` to start.

---

## Command Reference

| Command | Description |
| :--- | :--- |
| `/help` | Displays the interactive help menu with all 15 commands. |
| `/settings` | Opens the central configuration dashboard (Themes, API Keys, Language). |
| `/talk` | Launches a live chat session with the Gemini AI assistant. |
| `/hn [mod] [call] [n] [pl]` | Runs the 'however number' JavaScript package manager (yellow logs). |
| `/lang [en / uk]` | Switch the interface language profile between English and Ukrainian. |
| `/list` | Scans directory and lists active RoleMods. |
| `/update` | Checks for and simulates downloading mod updates with sound effects. |
| `/play` | Prompts for a path to an `.sb3` file, validates it, and launches it. |
| `/install [mod_name]` | Simulates the download and integration of a modification package. |
| `/theme` | Swaps the color scheme of the interface on the fly. |
| `/status` | Displays path diagnostics, active theme, language, and storage state. |
| `/cli` | Displays layout configurations and console dimensions. |
| `/cd [path]` | Navigates the current terminal working directory. |
| `/clear` | Clears the command output history to reset the view. |
| `/about` | View current developer credentials, release date, and version details. |
| `/exit` | Terminates the current command session safely. |

---

## Persistent Configuration (`config.cfg`)
Local storage is set up to save to:
`C:\Users\Admin\Desktop\RoleMods CLI\config.cfg`

If you want to pre-load configuration values, you can manually construct the file with:
```text
LANG=EN
THEME_NAME=Cyber Cyan
```

---

## Gemini AI Integration
To use the `/talk` command, obtain an API key from [aistudio.google.com](https://aistudio.google.com/) and either enter it when prompted inside the CLI or set it globally on your machine:

**In Command Prompt (CMD):**
```cmd
setx GEMINI_API_KEY "your_api_key_here"
```

**In PowerShell:**
```powershell
[Environment]::SetEnvironmentVariable("GEMINI_API_KEY", "your_api_key_here", "User")
```

---

## Author
* **LNTHGLfan2025**

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

---

### 2. Updated `LICENSE`

Create or replace the **`LICENSE`** file (no file extension) in your folder with this updated MIT license text, which lists the current development range of **2025-2026**
