## MBR and GPT Partitions

Partitions are needed in order to use a hard drive. Some operating systems use one parition, while others like Linux make use of multiple partitions at once. The latter is beneficial because:

- Easier to distinguish data types.
- It allows us to use specific mount options for the different partitions.
- It makes backup strategies easier.
- Filling up one partition does not make the rest of the system unstalbe. 

It's also possible to use LVM logic volumes or Startis file systems rather than multiple partitions.

### MBR 

The Master Boot Record (MBR) was created in the 1980s to define thelayout of hard disks. During this period, users could have multiple operating systems installed on their computer. MBR allowed the segmentation on the disk for each OS. The MBR used the first 512 bytes of the HDD, and the boot loader was present. 64 bytes were used for the partition table, and the MBR would allow no more than 4 partitions to be used at once. 

The maximum size a partition could be was 2 TiB. It was possible to created **extended partitions** as opposed to **primary partitions**. An extended partition allowed for the creation of up to 15 logical partitions.

### GPT

MBR is not suitable for modern drive sizes, so a new partition scheme was created. This partition scheme is the **GUID Partition Table** (GPT). Computers that use the **Unified Extensible Firmware Interface (UEFI)**, GPT partitions are the only options that are available for addressing disks.

The benefits of GUID include:

- Maximum partition size of 8 zebibytes.
- Maximum of up to 128 partitions.
- No need to distinguish between primary, extended, and logical partitions.
- GPT used 128-bit GUID to identify partitions.
- Be default, a backup GUID partition is created at the end of the disk. This solves the single point of failure issue that afflicted MBR partition tables.

## Storage Measurement Units

Different measurement units are utilised when it comes to storage. In some cases it may be a megabyte (MB), in others it might be a mebibyte (MiB). The difference between these two are:

- A megabyte is a multiple of 1000.
- A mebibyte is a multiple of 1024.

In the early days of computing, this difference was unimportant, but large storage sizes of the modern era have changed this. When it comes to Linux, the binary numbers - MiB, not MB - have become the standard. The following table captures the different measurement units:

| Symbol | Name | Value | Symbol | Name | Value |
| --- | --- | --- | --- | --- | --- |
| KB | Kilobyte | 1000^1^ | KiB | Kibibyte | 1024^1^ |
| MB | Megabyte | 1000^2^ | MiB | Mebibyte | 1024^2^ |
| GB | Gigabyte | 1000^3^ | GiB | Gibibyte | 1024^3^ |
| TB | Terabyte | 1000^4^ | TiB | Tebibyte | 1024^4^ |
| PB | Petabyte | 1000^5^ | PiB | Pebibyte | 1024^5^ |
| EB | Exabyte | 1000^6^ | EiB | Exbibyte | 1024^6^ |
| ZB | Zettabyte | 1000^7^ | ZiB | Zebibyte | 1024^7^ |
| YB | Yottabyte | 1000^8^ | YiB | Yobibyte | 1024^8^ |

## Managing File Systems and Parititions

Modern RHEL systems can use both MBR and GPT. The `fdisk` utility has been around for a long time and can be used for MBR and GPT. The `gdisk` utlity is used for GPT partitions. Another option is `parted`. `parted` is easier to use, but hides more advanced features.

First, we need to specify the name of the disk device to use as an argument, which can be done through the `lsblk` command. The following table shows common disk devices.

| Device | Description |
| --- | --- |
| `/dev/sda` | A disk that uses the SCSI driver. Used for both SCSI and SATA. |
| `/dev/nvmen1` | The first drive on the NVM express interface. |
| `/dev/hda` | Legacy IDE device type. |
| `/dev/vda` | Common disk drive for KVM virtual machines. |
| `/dev/xvda` | Disk in the Xen virtual macine that uses the Xen disk driver. |

Notice that almost all the devices end in an **a**. The reason for this is that it's the first disk found by the system. The second would be something with a **b** at the end, and going up to **z**, such as `/dev/sdz`. After this, the kernel will create names like `/dev/sdaa`, `/dev/sdab`. For NVMe devices, numbers are used instead of letters.

## MBR Extended and Logical Partitions

MBR does not allow the creation of more than 4 partitions. To go beyond this limit, we will need to create logical partitions with the extended partition function. All the logical partitions exist within the extended partition. This means that if there is an issue with the extended partition, it will affect all of the logical partitions.

If more than 4 separate allocation units are needed, consider using LVM instead. One a new disk, using GPT partitions may be a better idea. 

## GPT Partitions with `gdisk`

For disks that are larger than 2 TiB, or those that have already been configured with GPT, it's best to use the `gdisk` utility. It is very similar to `fdisk`, but with a few differences. For starters, it's only possible to decide on a partition type when initialising a new disk. Note that once MBR or GPT has been created, we can't change the type. While `gdisk` is the preferred utility for GPT partitions, `fdisk` can also initialise GPT with the `g` command. 

Don't ever use `gdisk` on a partition that was initially formatted with `fdisk`. `gdisk` will convert this partition to GPT automatically, and if this was originally an MBR partition, this will not allow the computer to boot.

Another option for working with partitions is the `parted` utility, but this lacks the advanced features found in `fdisk` and `gdisk`. 

## Creating File systems

Partitions are only useful once a file system has been assigned to them. The following table provides an overview of the common file systems.

| File System | Description |
| --- | --- |
| XFS | The default FS for RHEL |
| Ext4 | The default FS for many distros |
| Ext3 | Pervios versioin of Ext4 |
| Ext2 | Basic FS developed in the 1990s |
| BtrFs | Relatively new FS |
| NTFS | Windows-compatible FS |
| VFAT | Compatible with Windows and MacOS |

The `mkfs` command is used to format a partition. Specify the type of FS with the `-t` option. Alternatively, it's possible to use a specific tool such as `mkfs.ext4`.

## Altering File System Properties

There are different tools and properties that are specific to the different file systems.

### Ext4 FS Properties

The generic tool for managing Ext4 is `tune2fs`. Start with `tune2fs -l` which provides further information about the Ext4 system. The following are common ways to alter Ext4 properties:

- `tune2fs -o` to set default FS mount options.
- `tune2fs -O` to turn on a file system feature. Use `^` in front of a feature name to turn it off.
- `tune2fs -L` to set a label on the system. It's possible also do with this with the `e2label` utility.

### XFS Properties

It's possible to change some properties on an XFS file system using the `xfs_admin` command. An example of this would be:

```bash
xfs_admin -L labelname
```

## Adding Swap Partitions

Swap space is usually allocated on a disk device, which can be a partition or an LVM logical volume. It's also possible to use a file to extend swap space.

If there is a shortage of memory on Linux, non-recently used memory pages can be moved to swap, making more RAM available to other programs. Swap should be monitored closely and should not present a long-term solution to a memory shortage.

### Adding Swap Files

If disk space is low, consider creating a swap file instead. To add a swap file, start wiht the command:

```bash
dd if=/dev/zero of=/swapfile bs=1M count=100
```

This adds 100 blocks with a size of 1MiB from the `/dev/zero` device (which generates 0s) to the `/swapfile` file. This creats a 100MiB file that can be configured as swap. To do so, we uses the `mkswap /swapfile` and then the `swapon /swapfile` commands to active the file. Finally, add it to the `/etc/fstab` file so that it starts automatically when the machine is booted. Add this line to `/etc/fstab`:

```
/swapfile none swap defaults 0 0
```

## Mounting File Systems

A partition needs to be mountedbeforeit can be used. 

### Manual Mounting

This is done with the `mount` command. To disconnect a mounted file system, use the `umount` command. For example, to mount the `/dev/sda1` partition to `/mnt`, use the following command:

```bash
sudo mount /dev/sda1 /mnt
```

Disconnecting the mounted file system could be done either with `umount /dev/sda` or `umount /mnt`.

### Device Names, UUIDs, Disk Labels
Using `/dev/sda1` may not always be ideal as the path/name may change after a reboot. To address this, we can instead rely on **universally unique IDs (UUIDs)**. Every file system has a UUID associated with it. Use the `blkid` command to get an overview of the current file systems on the machine and associated UUIDs.

Before UUIDs file systems often worked with labels. These can be set with `e2label`, `xfs_admin -L`, or `mkfs.xxxx -L` commands. Using labels has become uncommon in recent versions of Linux.

To mount a file system with the UUID, use the following command:

```bash
sudo mount UUID="xxxx" /mnt
```

Mounting a file system with a label can be done with `mount LABEL=labelname /mnt` that will be temporarily mount the drive.

### Automating File System Mounting

The classical way to automatically mount a file system is by altering the `/etc/fstab` file. Every line has 6 fields as displayed in the following table:

| Field | Description |
| --- | --- |
| Device | The device being mounted. Use device name, UUID, or label |
| Mount Point | Te directory or kernel interface where the device is mounted |
| File System | The type of file system |
| Dump Support | Use 1 to enable to support for `dump` utility |
| Automatic Check | Specifies whether the FS should be checked when booting. 0=Disabled, 1=Check root FS, 2=Check other files systems |

Not all file systems in Mount Point use a directory, and some systems devices like swap are mounted on a kernal interface. When a kernel interface is used, the name will not start with a /.

The Mount Options defines mount options to be used. If none are needed, the line will show "defaults". The following table shows various mount options.

| Option | Description |
| --- | --- |
| auto/noauto | Does/Not mount automatically |
| acl | Support for FS access control lists |
| uzer_xattr | Support for user-extended attributes |
| ro | Mounts FS in read-only mode |
| atime/noatime | Enables/disables access time modifications |
| noexec/exec | Denies/allows execution of program files |

The `dump` utility was used for file system integrity. 0 is for not checking the file system, 1 is if it's the root FS that myst be checked before anything else, and 2 if it's a non-root FS that must be checked.

Use the following commands to check `/etc/fstab` for any errors:

- `findmnt --verify`: Verifies `/etc/fstab` syntax and checks for issues.
- `mount -a`: Mounts all file systems that are in `/etc/fstab` but aren't currently mounted.

### Systemd Mounts

The `/etc/fstab` file has been used since the earliest days of UNIX. In more recent versions of RHEL, it's used an input file to create systemd mounts as systemd is responsible for mounting file systems.

It's possible to find the files generated by `/etc/fsta` in teh `/run/systemd/generator` directory. We can also use the directory to create mount files, but they must meet the following requirements:

- The name of the file is the same as the directory where the device is to be mounted. For example, to mount on `/data` the file must be `data.mount`.
- The file must contain a [Mount] section that contains **What**, **Where**, and **Type** lines.
- There is an [Install] section containing `WantedBy=some.target`. This section is necessary for the mount to be enabled.
