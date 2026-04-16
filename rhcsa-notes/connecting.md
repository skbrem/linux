## Local Consoles

It's important to know the difference between a **console** and a **terminal**. 

- A **console** is the environment that the user is viewing; in order words, it's what the user sees when looking at their computer's screen.
- A **terminal** is an environment that is opened on the console and provides access to a shell like Bash. The terminal is the command line environment that the user can then use to type desired commands.

### Logging Into Local Consoles

It's typically bad practise to log into an environment with the root account. Rather, it's better to set up and use user accounts, and then rely on the tool **sudo** in order to gain the necessary privileges. Some of the reasons that the root user should be avoided include:

- It makes making errors that much more dangeorus.
- Most of the time root permissions are not needed.
- It makes it difficult for attackers to gain deeper control of the system.
- `sudo -i` can be used to open the root shell, but this can only be used if the user has been given root privileges. A similar thing can be done with `su -`, allowing the user to work with the root shell for as long as needed, and then exiting with **exit**. Note that `sudo -i` only works for users who are authorised and does not require using the root password, which makes it a more secure way of accessing the root shell.

## Multiple Terminals in a Text Environment

Linux makes use of the concept of virtual terminals. This makes it possible to open up to six different terminal windows from the same console at the same time. In order to do, a combination of Alt and an F key can be used, ranging from **Alt-F1** to **Alt-F6**.

- **F1**: Provides access to the main graphical login terminal.
- **F2**: Provides access to current graphical console.
- **F3**: Gives access back to the current graphical session.
- **F4-F6**: Provides access to consoles that are nongraphical.

An alternative to this is to use the `chvt` command. It enables the user to switch from a different virtual environment to the current one.

- **`chvt4`** can be used to open a login prompt on virtual environment 4.
- **`chvt3`** can be used to then switch back to the current graphical environment.
- **`chvt1`** is used to switch to the graphical login prompt.

The first of the virtual consoles is known as the default console, and is commonly called **virtual console tty1**. It has a linked device in `/dev` that has the name of `dev/tty1`. This is similar to other virtual consoles that are numbered `/dev/tty1` to `/dev/tty6`.

## Pseudo Terminals

Every terminal has a device that is associated with it. Terminal windows that are started within the graphical environment are called pseudo terminals.

These are referred to with numbers within the `/dev/pts` directory. The first terminal window would then be `/dev/pts/1`, and the second would be `/dev/pts/2`.

## Booting, Rebooting, Shutting Down

Rebooting a server is not often necessary, although there are times when rebooting can help, including:

- Recovering from serious issues like kernel panics and server hangs. 
- Applying updates to the kernel.
- Applying change to kernel modules that are currently in use and cannot be easily reloaded.

It's obviously never a good idea to shut down a server by pulling out the plug, because it has not had the time to write the data from the memory buffers to disk.

To issue a reboot, the Systemd process needs to be alerted. The following commands can be used to reboot/shutdown a server:

- `systemctl reboot` or `reboot`
- `systemctl halt` or `halt`
- `systemctl poweroff` or `poweroff`

The difference between `halt` and `poweroff` is that `poweroff` talks to the power management on the machine to stop power, and this does not occur with `halt`.

If none of these commands successfully shutdown/reboot the computer, there is an emergency reset option. From a root shell, type the following:

`echo b > proc/sysrq-trigger`

This will immediately reset the machine without saving any changes. This should only be used as a last resort.

## SSH And Similar Tools

SSH is offered by default over port 22, and should not be blocked by the firewall for anyone wanting to access it.

The `ssh` command is used to access the device remotely. It will attempt to reach the device first on port 22, but if a different port has been configured, using `ssh -p <port-number>` will be necessary.

Accessing a Linux machine can be done by typing `ssh` followed by the name or IP address of the targeted machine. After this, a password will be asked for.

By default, SSH will try to use the user account the user is logged in with on their local machine when connecting to remote machine. In order to change this, make sure to specify the username by using the `user@server` format.

If you have any issues when connecting with SSH, try using the `-v` option, which starts SSH in verbose made, and provides more information about the connection process.

When connecting to a server for the first time, a public key fingerprint is stored within the file `~/.ssh/known_hosts`. When logging into the server again at a later stage, this fingerprint is checked against the key that was sent over by the server, and if everything matches, there won't by any warnings or errors. 

Sometimes if the sshd service has been deleted and reinstalled, the fingerprints will have been lost. A mismatch like this can be fixed by removing the key fingerprint in the known_hosts file on the client computer, which is easy to do with `sed`. 

`sed -i -e '20d' ~/.ssh/known_hosts`.

This removes line 20 from the known_hosts file if this is the line that holds the mismatching key.

## SSH Graphical Environments

By default, SSH won't allow the user to start a graphical application from the session due to security.

The way to allow the display of graphical displays by using the `-Y` option with `ssh`. For example: 

`ssh -Y user@server`

## Common SSH Command Options 

| Option | Function |
| --- | --- |
| `-v` | **Verbose**:, shows more detail when a connection is being established. |
| `-Y` | Enables the option to use graphical applications. |
| `-p <port>` | Used to connect to an SSH service that is not listening on the default port 22. |

## Transferring Files Securely

The `scp` can be used to transfer files between two systems, and `rsync` is used to synchronise the file instead. The `sftp` is another command provided by SSH that enables secure transfers over the FTP protocol.

### Using `scp`

`scp` is similar to `cp` but has a few more options with working with remote hosts. To copy the `/etc/hosts` file from the first server to the second server's `/tmp` folder, the following command can be used: 

`scp /etc/hosts second-server:/tmp`

In order to connect to the user root to copy the `/etc/passwd` file to the home directory of the local server:

`scp root@second-server:/etc/passwd ~`

Use the `-r` option to copy a whole subdirectory structure. 

`scp -r second-server:/etc/ /tmp`

When using `scp` to connect using the nondefault port number, the `-P` option must be used followed by the port number.

## Using `sftp`

Using `sftp` means opening an FTP client session to the remote host. The client session uses typical FTP commands, like `put` for uploading a file and `get` for downloading a file.

Even when connected to a remote machine, it's important to remember that the user is still also working alongside the local directory. 

## Using `rsync`

`rsync` makes use of SSH in order to synchronise files between a local and a remote directory. Synchronising is different in that it only uploads the changes that are made rather than an entire file or directory. 

### Common `rsync` options

| Option | Function |
| --- | --- |
| `-r` | Synchronises a whole directory tree |
| `-l` | Copies symbolic links as symbolic links |
| `-p` | Preservers any permissions |
| `-n` | Performs a dry run - nothing is synchronised |
| `-a` | Uses **archive mode**, that makes sure the subdirectory tree and all the file properties will be synchronised properly |
| `-A` | Uses archive mode and also Synchronises ACLs |


## SSH Key-Based Authentication

It's possible to use public key cryptography to generate a private and a public key. The public key can be handed over to other hosts, and when logging in with SSH, the public key will be matched against the private key. 

### Passphrases

Maximum security can be achieved by assigning a passphrase to a private key, but this also makes it more inconvenient. It's possible to bypass this but it's imperative to make sure the private key is as secure as possible, as anyone that gets a hold of the key will then be able to access any linked remote hosts.

### Creating a key pair

Use the `ssh-keygen` command. Then use the `ssh-copy-id` command to copy the public key to the target machine. 
