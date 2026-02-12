🦀 Arch Nvim

<div align="center">A fast, curated Neovim configuration that delivers an IDE-like experience — without sacrificing minimalism.

Modern languages. Clean UX. Zero bloat.

Stop configuring. Start coding.

  

🚀 Quick Start • 📸 Screenshots • ✨ Features

</div>
---

🖥️ The Everywhere IDE

Arch Nvim is designed to feel consistent across:

🐧 Linux

🍎 macOS

📱 Termux (mobile-first ready)


Same experience. Same speed. No compromises.

<div align="center"><!-- Screenshots -->     

</div>
---

🔤 Recommended Font

For the best experience, install JetBrains Mono Nerd Font.

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz

Termux Setup

mkdir -p ~/.termux/
mv ~/.termux/font.ttf ~/.termux/font.ttf.backup 2>/dev/null
cp JetBrainsMonoNerdFont-Medium.ttf ~/.termux/font.ttf
termux-reload-settings

> 💡 Refer to your distro’s documentation for changing terminal fonts.




---

🚀 Quick Start

> ⚠ Treesitter requires clang or gcc.



# Termux
pkg install clang

Install Arch Nvim

mkdir -p ~/.config/archn && cd ~/.config/archn
git clone --branch v2.0.1 --depth=1 https://github.com/visrust/arch-nvim.git .

echo "alias n='NVIM_APPNAME=archn nvim'" >> ~/.bashrc
echo "alias n='NVIM_APPNAME=archn nvim'" >> ~/.zshrc

source ~/.bashrc 2>/dev/null
source ~/.zshrc 2>/dev/null

Launch:

NVIM_APPNAME=archn nvim

> 📦 First install downloads ~200MB of plugins.
After setup, you can reuse ~/.local/share/nvim/lazy/ for faster setups elsewhere.




---

✨ Features

⚡ Performance

~250ms startup (desktop)

~300ms startup (Termux)

63 carefully selected plugins

Proper lazy-loading

No unnecessary abstractions



---

🦀 Modern Language Ready

Pre-configured LSP for:

Rust • Go • C/C++ • Python • Lua • TypeScript • JSON

Extended support (manual install):

Zig • Bash • Markdown • Docker • YAML • HTML • CSS • PHP • GDScript • Vim • ASM • CMake • Vale

No Mason.
You control your toolchain.


---

🎨 Curated Themes (Switch Instantly)

:SGT catppuccin-mocha
:SGT rose-pine
:SGT tokyonight-night
:SGT nightfox
:SGT gruvbox

Includes:

Catppuccin (4 variants)

Tokyo Night (4 variants)

Rose Pine (3 variants)

Nightfox (7 variants)

Gruvbox (2 variants)



---

📱 Termux Native

Built and optimized for mobile development:

Performance tuned

No desktop-only assumptions

Full feature parity



---

🧠 Smart Tooling

FzfLua (blazing fast fuzzy search)

Oil.nvim + Yazi (file management)

Blink.cmp (completion)

Leap.nvim (precision navigation)

Lazygit integration

Trouble diagnostics


Press <Space> to explore all keybindings via Which-Key.


---

🎯 Why Arch Nvim?

Arch Nvim	Typical Config

⚡ <400ms startup	🐌 2–5s startup
📱 Mobile ready	❌ Often broken
🎨 Curated themes	🎲 Random plugins
🦀 Rust-first setup	🔧 Manual config
🎯 63 intentional plugins	📦 100+ plugin sprawl
🚀 Ready to code	⏳ Endless tweaking



---

📦 Dependencies

Essential

fzf ripgrep fd yazi lazygit

Recommended

bat git-delta nodejs python3 gcc


---

<details>
<summary><b>Install Commands by OS</b></summary>Termux

pkg install fzf ripgrep fd yazi lazygit git bat git-delta nodejs python clang

Debian / Ubuntu

sudo apt install fzf ripgrep fd-find yazi lazygit git bat git-delta nodejs python3 build-essential

Arch Linux

sudo pacman -S fzf ripgrep fd yazi lazygit git bat git-delta nodejs python gcc

macOS

brew install fzf ripgrep fd yazi lazygit git bat git-delta node python

</details>
---

🏗 Architecture

lua/user
├── config
├── mini
├── other
├── profiler.lua
├── snippets
├── stages
├── sys
└── ui

Clean separation. Minimal magic.


---

🧹 Uninstall

rm -rf ~/.config/archn \
       ~/.local/share/archn \
       ~/.local/state/archn \
       ~/.cache/archn


---

🤝 Contributing

PRs welcome.

Ideas:

Improve docs

Add snippets

Extend LSP support

Performance optimizations

UX refinements



---

<div align="center">Built by developers who value speed and clarity.

Stop configuring. Start coding.

⭐ Star on GitHub • 🐛 Issues

</div>
---
