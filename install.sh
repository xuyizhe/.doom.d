#!/usr/bin/env bash
set -euo pipefail

main() {
	install_node
	install_sh
	install_json
	install_rust
	install_web
	install_solidity
	install_latex
	install_org
	install_lookup
	install_youdao
	install_wakatime
	sync_doom
}

sync_doom() {
	~/.emacs.d/bin/doom env
}

install_node() {
	echo "Installing dependencies for nodejs..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
	nvm install lts/erbium
}

install_sh() {
	echo "Installing dependencies for shell..."
	brew install shellcheck
	brew install shfmt
	npm install -g bash-language-server
}

install_json() {
	echo "Installing dependencies for json..."
	brew install jq
}

install_rust() {
	echo "Installing dependencies for rust..."
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
	echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>~/.zshrc
	rustup toolchain add nightly
	rustup default nightly
	# completion
	cargo +nightly install racer
	rustup component add rust-src
	echo 'export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"' >>~/.zshrc
	# Old rust version (Select automatically in config.el)
	# echo 'export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"' >>~/.zshrc
	cargo install cargo-edit
	cargo install cargo-audit
	# lint
	rustup component add clippy
	# format
	rustup component add rustfmt
	npm i -g prettier-plugin-toml
}

install_web() {
	echo "Installing dependencies for web..."
	brew install tidy-html5

	npm install -g typescript
	npm install -g eslint
	# npm install -g tslint
	npm install -g typescript-eslint
	npm install -g prettier
	# npm install -g prettier-plugin-svelte

	# web-mode
	npm install -g stylelint
	npm install -g js-beautify

	# lsp
	npm install -g vscode-html-languageserver-bin
	npm install -g vscode-css-languageserver-bin
	npm install -g typescript-language-server
	# npm install -g vls
	# npm install -g svelte-language-server
}

install_solidity() {
	echo "Installing dependencies for solidity..."
	npm install -g solc solium prettier-plugin-solidity
}

intsall_latex() {
	brew cask install mactex
}

install_org() {
	brew install sqlite
}

install_lookup() {
	brew install ripgrep
	# brew install wordnet
}

install_youdao() {
	echo "Installing dependencies for youdao..."
	brew install mpg123
}

install_wakatime() {
	echo "Installing dependencies for wakatime..."
	pip install wakatime
	# oh-my-zsh
	git clone https://github.com/wbingli/zsh-wakatime.git ~/.oh-my-zsh/custom/plugins/zsh-wakatime
}

main

exit
