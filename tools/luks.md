LUKS is the standard way of encrypting a disk partition on Linux.

## Prepare The Device

The first thing to do is to prepare the disk with the `dd` command, making it impossible to distinguish between encrypted data and unallocated disk space. This is not strictly necessary unless your threat model calls for it, but is worth doing on smaller drives, like a USB stick. Always make sure to identify the correct drive with the `lsblk` command.

```bash
sudo dd if=/dev/urandom of=/dev/sda bs=4M status=progress
```

Note that depending on the size of the disk, this can take a long time. Multiple-terabyte disks could potentially take hours to days. Once this has been done, the next step is to create a partition on the drive that will be encrypted, using tools like `fdisk` or `gdisk`.

## Setting Up LUKS

Once the partition is created, the following command will set up LUKS. Note that all data on the partition will be destroyed. 

```bash
sudo cryptsetup luksFormat /dev/sda1
```

Confirm the action by typing typing "YES" in all uppercaps, and a passphrase for the new encrypted container will be required.

Once finished, open the encrypted container with the following command:

```bash
sudo cryptsetup open /dev/sda1 secure_drive
```

Enter the passphrase set earlier, and the device is now available at `/dev/mapper/secure_drive`.

## Creating a File System

The device is not usable without a file system. Choose an appropriate file system for the device. For example, to make an Ext4 file system on the encrypted partition, use the following command:

```bash
sudo mkfs.ext4 -L "SecureDrive" /dev/mapper/secure_drive
```

Make sure to always format `/dev/mapper/secure_drive`, and never `/dev/sda1` as doing so will overwrite the LUKS headers. Once this has been done, the next step is to mount the mapped file system to an accessible directory.

## Mounting The File System

First start by creating a file system that the mapped partition will be mounted to. When doing this manually through the terminal, we typically use `/mnt`.

```bash
sudo mkdir -p /mnt/encrypted_drive
```

Once created, mount the encrypted drive to the newly-created directory:

```bash
sudo mount /dev/mapper/secure_drive /mnt/encrypted_drive
```

It's now possible to `cd` into `/mnt/encrypted` drive and use it like a normal directory.

## Unmounting and Locking

Once we are finished with the drive, the next steps are to unmount it and then lock it.

```bash
sudo umount /mnt/encrypted_drive
```

Next, let's lock it.

```bash
sudo cryptsetup close secure_drive
```

Once this is locked, the LUKS key is wiped from memory by the kernel.
