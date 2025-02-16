# Sapphire Clone Script

![Sapphire Clone Script](https://img.shields.io/badge/Bash-Script-green.svg)

## 📜 Description
Sapphire Clone Script is a Bash script that allows users to easily clone or delete repositories related to the Sapphire project. The script also provides options to use SSH or HTTPS for cloning and allows users to choose whether to use `--depth 1` for shallow cloning.

## 🚀 Features
- ✅ Clone or delete repositories with a simple choice.
- 🔐 Option to use SSH or HTTPS for GitHub.
- ⚡ Supports `--depth 1` for faster cloning.
- 📸 Option to include MIUI Camera repositories.

## 📌 Usage
1. **Give execute permission to the script:**
   ```bash
   chmod +x sapphire_clone.sh
   ```
2. **Run the script:**
   ```bash
   ./sapphire_clone.sh
   ```
3. **Follow the prompts:**
   - Choose whether to clone or delete repositories (`c/d`).
   - Select SSH or HTTPS for cloning (`y/n`).
   - Decide whether to use `--depth 1` (`y/n`).
   - Choose whether to clone MIUI Camera (`y/n`).

## 🔄 Updating the Script
If you have already cloned the repository and want to update to the latest version, run the following commands:
```bash
git init  # Initialize Git if not already initialized
git remote add origin https://github.com/Angelpro09xd/Sapphire-Clone-Script
git fetch origin
git reset --hard origin/main  # Or the branch you are using
```

## 📂 Repositories Used
This script uses repositories from the following sources:
- [sapphire-sm6225](https://github.com/sapphire-sm6225)
- [saroj-nokia](https://github.com/saroj-nokia)
- [kibria5](https://gitlab.com/kibria5)

## 👥 Credits
This script was created by **Angelpro09xd**. Special thanks to the maintainers of the repositories used in this script.

## 📝 License
This project is open-source and available under the MIT License.

