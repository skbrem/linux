## Different User Types

On Linux, there are privileged users and there are unprivileged users. The default privileged user is root. On many modern distros like RHEL, the root user is disabled by default. There are two ways of going about setting up admin access on a new install.

1. When creating a regular user, it's possible to make this user an administrator.
2. When wanting to be able to use the true root account, it's possible to set a root password.

Use the `id` command in order to get more information about a user account.

The root account, also known as the superuser, is able to perform any task on a Linux system. All tasks that need direct access to devices on the system will require root permissions.

It's not recommended to use the root account for performing management tasks on a system. Rather, it's a better idea to use one of the following:

| Method | Function |
| --- | --- |
| `su` | Opens subshell as different user and commands are executed as root while in the subshell. |
| `sudo` | This provides administrative privileges to users who are authorised. |
| PolicyKit | This allows graphical tools to run with administrative privileges. |

## `su`

Using the `su` command will open a root subshell. The root privileges are only available within this subshell. In order to open a subshell, a password is needed. Typing `su` on its own implies that the username root will be used, but it's possible to specify a user by using `su <name>`.

The `su` command creates a subshell environment but where no environmental settings have been set for the user that is using the subshell. In order to get access of the environment of that account, use the `su -` command. 

## `sudo`

Using the `sudo` command is much more secure in general because the privilege that `sudo` provides is only temporary to the task at hand. When setting up users during the installation phrase, it's possible to grant a user administrative permissions, which will allow them to make use of the `sudo` command.

It's also possible to do something similar by making the user a member of the group wheel. It can be done easily by doing the following:

1. Use `usermod -aG wheel user`.
2. Type visudo and check that the line `%wheel ALL=(ALL) ALL` is included.

`visudo` can also be used to edit the /etc/sudoers config file and give users access to specific commands. For example, the following line could be added:

**fred ALL=/usr/bin/useradd, /usr/bin/passwd**

Which would then allow the user fred to only run the `useradd` and `passwd` commands.

When `sudo` is used, a token is created that is based on this password. By default, this token lasts around 5 minutes, and when it ends, the user will be prompted to type in their password again. The following line in the /etc/sudoers file can be added to extend the lifespan of the token:

**Defaults timestamp_timeout=240**

If a user has privileges on the `passwd` command, the user is allowed to also change the password for the root account. It's easy to fix this issue by including the following line:

**fred ALL=/usr/bin/useradd, /usr/bin/passwd, ! /usr/bin/passwd root**

Once included, fred is still able to change passwords for every other user except for root.

While it's possible to make changes to the /etc/sudoers file, it's better practise to instead make a new file and add it to the /etc/sudoers.d folder. It contains the same contents as the changes that would be made to the /etc/sudoers file except that it acts as a separation from the standard settings on the system.

> [!tip]
> By default, it's not possible to use pipes with `sudo` commands. This can be solved by using the `sudo sh -c` command. For example: `sudo sh -c "rpm -qa | grep ssh"`.

## PolicyKit

Most graphical programs that require administrative access will use PolicyKit. If ever losing access to the `sudo` command, using the `pkexec` command is an alternative.

## Creating & Management of User Accounts


