---
created: 2026-01-25
tags: 
  - ssh
  - linux
---

## Basic Commands

| Command | Description |
| --- | --- |
| ssh user@host | Connect to a host |
| ssh host | Connect with current username |
| ssh -p 2222 user@host | Connect to a custom port |
| ssh user@host <command> | Execute a command on a remote host |
| ssh -v user@host | Run verbose mode |
| ssh -q user@host | Quiet mode |

## SSH Keys

| Command | Description |
| --- | --- |
| ssh-keygen | Generate a key pair |
| ssh-keygen -f <filename> -C <comment> | Generate key pair with unique filename and end comment |
| ssh-keygen -p -f ~/.ssh/id_ed25519 | Change the key passphrase |
| ssh-keygen -y -f ~/.ssh/id_ed25519 | Show the public key |
| ssh-keygen -R hostname | Remove host from known hosts |

## Copying Keys

| Command | Description |
| --- | --- |
| ssh-copy-id user@host | Copy key to remote host |
| ssh-copy-id -i ~/.ssh/key.pub user@host | Copy a specific key |
| ssh-copy-id -p 2222 user@host | Copy key using custom port |

## SSH Agent

Using an SSH can be made much easier by using a password manager like KeePassXC or Bitwarden desktop.

| Command | Description |
| --- | --- |
| eval "$(ssh-agent -s)" | Start the SSH agent |
| ssh-add | Add default key to agent |
| ssh-add ~/.ssh/id_ed25519 | Add a specific key |
| ssh-add -l | List keys in the agent |
| ssh-add -d ~/.ssh/id_ed25519 | Remove key from agent |
| ssh-add -D | Remove all keys |

## Secure Copy (SCP)

| Command | Description |
| --- | --- |
| scp file user@host:/path | Copy file to remote host |
| scp user@host:/path/file | Copy file from remote |
| scp -r dir user@host:/path | Copy a directory recursively |
| scp -P 2222 file user@host:/path | Copy on custom port |
| scp -C file user@host:/path | Copy with compression |
| scp -p file user@host:/path | Preserve timestamps |

## SFTP

| Command | Description |
| --- | --- |
| sftp user@host | Connect to host with SFTP |
| sftp -P 2222 user@host | Connect on custom port |
| get file | Download a file (in sftp) |
| put file | Upload a file (in sftp |
| ls, cd, pwd, mkdir | Navigate remote host (in sftp) |
| lls, lcd, lpwd, lmkdir | Navigate local host (in sftp) |

## SSH Tunneling

| Command | Description |
| --- | --- |
| ssh -L 8080:localhost:80 user@host | Local port forwarding |
| ssh -R 8080:localhost:80 user@host | Remote port forwarding |
| ssh -D 1080 user@host | SOCKS proxy (dynamic) |
| ssh -N -L 8080:localhost:80 user@host | Tunnel only (no shell) |
| ssh -f -N -L 8080:localhost:80 user@host | Background tunnel |

## SSH Config

| Command | Description |
| --- | --- |
| ~/.ssh/config | User config file |
| Host myserver | Define host alias |
| HostName 192.168.1.100 | Server address |
| User admin | Username |
| Port 2222 | Custom port |
| IdentityFile ~/.ssh/key | Private key path |

## Connection Options

| Command | Description |
| --- | --- |
| -p port | Custom port |
| -i keyfile | Identity file (private key) |
| -o option=value | Set config option |
| -F configfile | Custom config file |
| -J jumphost | Jump through host (ProxyJump) |
| -X | Enable X11 forwarding |
| -A | Enable agent fowarding |
