## Systemd Targets

There are 4 targets that can be used for booting:

- `emergency.target`: Only a minimal amount of units are started, used primarily in case a "safe" mode is needed.
- `rescue.target`: Starts all units required for a full operating system. Does not start nonessential services.
- `multi-user.target`: Often the default target that a server starts in. Commonly used on servers and starts with everything needed for full functionality.
- `graphical.target`: Also commonly used. Starts with everything needed along with a graphical interface.

### Working With Targets

There are 3 common tasks that are associated with working with targets:

- Adding units to be started automatically.
- Setting a default target.
- Running a nondefault target for troubleshooting.

### Target Units

A target's config consists of:

- The target's unit file.
- The "wants" directory. This contains all unit files that need to be loaded.

Targets themselves may have dependencies to other targets, defined within the target unit file. A target is a group of units, and there are many different targets. Some define a state that the system needs to enter. Others bundle a group of units together.

### Wants

In systemd, wants are which units that Systemd wants when selecting a target. Wants are created when units are enabled with `systemctl enable`, which creats a symlink to `/etc/systemd/system`. Every target has a subdirectory here, which contains wants as symlinks to the services to be started.

### Managing Targets

The `systemctl enable` and `systemctl disable` commands are used for starting and stopping services. The [Install] section in the unit specifies what the services need in terms of which targets must be started, and a want is automatically created in that target when the service is enabled.

#### Isolating Targets

Some targets have a unique role as they can be isolated. These targets can be set as the targets to get into after the system has booted. Isolating a target means starting that target with all its dependencies. Only targets with the **isolate** option enabled are able to be isolated.

To get a list of all targets, use the `systemctl --type=target` command. This may include the needed dependencies if running a graphical environment. NOte this only lists active targets, and not all the targets on the system. To see all the targets, use the `systemctl -t target --all` command instead.

A few targets have an important function because they can be started (isolated) in order to determine the state in which the server starts in. These are targets that can be set as default targets. These contain the line `AllowIsolate=yes`, meaning that it's possible to switch the state of the machine to one of these targets using the `systemctl isolate` command.

### Setting Default Targets

It's possible to see the current default target with the `systemctl get-default` command, and to use the `systemctl set-default` to set a specific target.

## GRUB2

Sometimes an admin will need to make modifcations to the GRUB2 boot loader config. GRUB2 is installed in the boot sector of the server's drive, and loads the following:

- The Linux kernel.
- The initramfs, consisting of the drivers that are needed to start the system. It consists of a mini file system, which has kernel modules needed for the remainder of the boot procedure. Changes to GRUB2 are made in `/etc/default/grub` primarily.

### GRUB2 Configuration

A A main configuration file is generated based on the previous config files. On BIOS, the file is `/boot/grub2/grub.cfg`. ON UEFI, this depends on the distro. When changes are made to the GRUB2 config, the maon config file will need to be regenerated, which can be done with `grub2-mkconfig` on RHEL.

### GRUB2 Boot Options

The most important line in `/etc/default/grub` is `GRUB_CMDLINE_LINUX`, which determines how the kernel is started. Some common options that are removed include **rhgb** and **quiet**. These two options tell the kernel to hide the output while booting. This is nice for end users, but admins will want to see the whole boot process. It's a good idea to remove these during the exam.

Another parameter is `GRUB_TIMEOUT`. This is the amount of time that is available for an admin to access the GRUB2 boot menu before the rest of the boot process commences. It's also worth knowing about kernel boot arguments. The command `man 7 bootparam` provides a man page for more information about the different boot parameters that may be used with the kernel.

The `grub2-mkconfig` command is used to make changes to the main GRUB2 config file. The output of this command needs to be directed to the correct place. On a BIOS system, this would mean using the `grub2-mkconfig -o /boot/grub2/grub.cfg` command, and for UEFI, the command would be `grub2-mkconfig -o /boot/EFI/redhat/grub.cfg`.
