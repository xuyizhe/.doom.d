#!/usr/bin/env bash
set -euo pipefail

main() {
	install_node
	install_sh
	install_json
	install_rust
	install_web
	install_solidity
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
	# lint
	brew install shellcheck
	# format
	brew install shfmt
	# lsp
	npm install -g bash-language-server
}

install_json() {
	echo "Installing dependencies for json..."
	brew install jq
}

install_rust() {
	echo "Installing dependencies for rust..."
	# rustup
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
}

install_web() {
	echo "Installing dependencies for web..."
	npm install -g \
		stylelint \
		prettier \
		js-beautify \
		eslint \
		typescript \
		tslint \
		typescript-language-server \
		vls
}

install_solidity() {
	echo "Installing dependencies for solidity..."
	npm install -g solc solium
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
