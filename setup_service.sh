#!/usr/bin/env bash

mkdir -p ~/.config/systemd/user/

cat > ~/.config/systemd/user/emacs-daemon.service <<EOF
[Unit]
Description=Emacs text editor
Documentation=info:emacs man:emacs(1) https://gnu.org/software/emacs/

[Service]
Type=forking
ExecStart=/usr/bin/emacs --daemon
ExecStop=/usr/bin/emacsclient --eval "(kill-emacs)"
Restart=on-failure

[Install]
WantedBy=default.target
EOF

mkdir -p ~/.config/systemd/user/emacs.service.d
cat > ~/.config/systemd/user/emacs.service.d/override.conf << EOF
[Service]
Type=simple
EOF

systemctl --user daemon-reload
systemctl --user enable emacs-daemon --now
systemctl --user enable emacs --now
