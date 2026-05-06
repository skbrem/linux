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

There are typically two types of users on a Linux system. The first are the normal users who need to work on the server, and will have their own password that they need in order to access the server and its resources. Secondly, there are system accounts that make use of server services.

- **Username**: A unique name for every user. These are used to match a user to their unique password, which are stored in the /etc/shadow file. Linux does not allow spaces to be used in the username, and it's good practise to use lowercase letters for the username.
- **Password**: All passwords on modern Linux systems are hashed and then stored in the /etc/shadow file.
- **UID**: Every user is assigned a unique user ID, known as a UID. It's a numeric ID that is used to determine that the user is able to do. The UID 0 is reserved exclusively for the root. UIDs that go up to 999 are typically used for system accounts, while those from 1000 onward are for user accounts.
- **GID**: Each user is a member of at least one group. This group is known as the primary group, and it plays an important role in how permissions are manaed. It's possible for users to members of more than one group, administered by the /etc/group file.
- **Commend Field**: The commend field is used to add comments to user accounts, and is optional. It can be helpful to add information about a user account and why it was created.
- **Directory**: The directory that a user is placed in when they log in, and is also known as the *home directory*. The home directory is where a user stores their personal files and their applications. For system accounts, this environment is where the service is able to keep files that are needed during operation.
- **Shell**: The program started when a user successfullly connects to a server, and for most users this will be /bin/bash, which is the default shell on Linux. The shell for system users will be a shell such as /sbin/nlogin. The `/sbin/nologin` command is a command that denies access to users as a layer of protection against intruders attempting to gain access to a shell.

Some user properties are kept in the /etc/passwd file, which another part is kept in the /etc/shadow file. Only the user root and any process that is running as root have access to the /etc/shadow file.

- **Login name**: /etc/shadow does not contain UIDs, but usernames instead.
- **Password**: What's needed to store passwords securely. An empty field means that there is no password that has been set and the user is unable to login. An exclamation mark at the start of the field means that the account is not permitted to log in.
- **Days since last password change**: On Linux, this starts on January 1, 1970, and is also known as epoch.
- **Days before password change**: Allows for a stricter password change policy. A user is unable to change back to their original password after making a change. By default this is set to a value of 0.
- **Days after which password needs changing**: The field that contains how long a password is value for. By default it's set to 99,999.
- **Days before password expiration where user is warned**: Used to give a warning to user to alert them that they will be forced to change their passowrd. The default is 7 days.
- **Days beofore an account is disabled due to password expiration**: Used to enforce a password change. After the expirry has passed, the user will no longer be allowd to log in. Set in days but by default is not set.
- **Days since January 1, 1970 that account has been disabled**: It's possible to set this field to disable on account on chosen date.

### User Creation

Creating users can be done in many different ways. One way is to edit the /etc/shadow config files with an editor by using the `vipw` command. A more common option is to use the `useradd` command. To remove users, the `userdel` command is used, and `userdel -r` removes the user as well as their environment.

### Configuration files

The `vipw` command allows for the editing of the /etc/passwed and the /etc/shadow files, where lines can be added in order to add a new user. Using this method is not recommended as making an error can make it impossible for anyone to log into the system.

To modify the /etc/shadow file, `vipw -s` is used. To edit the /etc/group file, `vigr` is used.

### `useradd`

The most common utility for adding new users. For example, the command `useradd -m -u 1150 -G website,accounting fred` will create a user named fred who is a part of the account and website groups, and who has been assigned a UID of 1150, and has also been given a home account.

### Home Directories

All users are given a home directory, and it's where personal files are kept. When a home directory is created, the content of the "skeleton" directory is then copied to the new user's home directory. The skeleton directory is /etc/skl, and contains files that are copied over upon user creation. By default, the skeleton directory is mostly made up of configuration files that are used to determine how the environment for the user is set up.

### Default Shell

The default shell for most users is set to /bin/bash. System users on the other hand will default to /sbin/nologin. In order to change the default shell using `useradd` or `usermod`, the `-s` option is used. For example, `useradd steve -s /sbin/nologin` will ensure that the user steve is not able to log in.

Modifying the properties for a user is done with the `usermod` tool. It's able to set properties in both /etc/shadow and /etc/passwd, as well as some other things. It's worth noting that it does not set passwords well. Instead, it's better to use the `passwd` command.

### Config Files for User Management

Certain default properties are assumed when working with tools like `useradd`. These values are set in the following config files:

- /etc/login.defs
- /etc/default/useradd

