#!/bin/bash

# To enable cargo package installing for this user
sudo chmod 777 /usr/local/lib/rust/cargo
sudo chmod 777 /usr/local/lib/rust/cargo/bin

# Install oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# Install better tools
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall -y eza fd-find ripgrep bat
echo 'alias ls="eza"' >> ~/.bashrc

pushd /tmp
wget https://github.com/junegunn/fzf/releases/download/0.51.0/fzf-0.51.0-linux_amd64.tar.gz
tar xf fzf-0.51.0-linux_amd64.tar.gz
sudo mv fzf /usr/local/bin/
rm fzf-0.51.0-linux_amd64.tar.gz
popd
