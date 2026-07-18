It's relatively simple to mount and unmount devices that are plugged into a Linux device. Plug the device in and then get a list of the different devices with `lsblk`.

## Finding the Right Device

For a USB or SSD device, `lsblk` will list something like:

- `sda`: This is the physical device
    - `sda1`: This is the partition on the device. This is what we want to mount
- `sdb`
    - `sdb1`

## Create the Mount Point

Start by creating a directory for the external partition to be mounted to. In this case:

```sh
sudo mkdir /mnt/usb
```

## Mounting

Now we mount the device using the partition name that we got from `lsblk`. Remember that we are wanting to mount the partition and not the device itself. Also make sure to mount the correct device, it's not that hard to accidentally try and mount the computer's main storage SSD or HDD.

```sh
sudo mount /dev/sdb1 /mnt/usb
```

If there are no errors, then the device has been successfully mounted, and we can `cd` to the filesystem on the device with `cd /mnt/usb`.

## Unmounting

It's never a good idea to just pull out a device without unmounting, as Linux may still have important data in the cache that it has not written to the device.

To unmount, make sure to first leave the mounted directory with `cd ~`. Then we use the `umount` command to safely unmount the device from Linux:

```sh
sudo umount /mnt/usb
```

While not strictly necessary, it might be worth removing the `/mnt/usb` directory that's been created.

```sh
rmdir /mnt/usb
```

### Unmounting Issues

#### Permission Issues

Sometimes we can see the files but are unable to write to them, and this is often because the external device is formatted as exFAT or NTFS, or the write permission belongs to root. It's possible to grant this permission with the following command:

```sh
sudo mount -o uid=$(id -u),gid=(id -g) /dev/sdb1 /mnt/usb
```

### Device Busy Issue

If `umount` fails to unmount the device because it's busy, there is a terminal window or program that is still accessing it, which we can see with `lsof /mnt/usb`.

## Mounting Encrypted Drives

If a device is encrypted with LUKS, the locked partition will first need to be found, and then a mapped virtual device is created. It's this virtual device that is then mounted. Start with `lsblk`. If that does not show the encrypted volume, instead use `lsblk -f`. Under the `TYPE colum, `crypto_LUKS` will be shown for the encrypted volume. 

### Unlock The LUKS Container

In order to unlock the encrypted volume, we use the `cryptsetup` command. This unlocked state will also need a temporary name. For instance: `secure_ssd`. Here is the full command to unlock an encrypted external SSD:

```sh
sudo cryptsetup open /dev/sdb1 secure_ssd
```

### Verify The Device

Once it has unlocked, the unencrypted virtual device will be mapped to `/dev/mapper`. It's possible to verify that it worked by using `lsblk` again. In this case, it should show: `secure_ssd` underneath `sdb1`

### Mounting the Unlocked Device

Now that is has been unlocked, we mount the mapper device rather than mounting `/dev/sdb1`. First we start by creating a directory that will be mounted to:

```sh
sudo mkdir -p /mnt/secure_drive
```

And then we mount the device:

```sh
sudo mount /dev/mapper/secure_ssd /mnt/secure_drive
```

We can now use `cd /mnt/secure_drive` to see the unencrypted contents of the drive.

### Safely Unmount and Lock

Start by moving out of the directory with `cd ~`. Unmount the filesystem with:

```sh
sudo umount /mnt/secure_drive
```

Now we lock the LUKS container:

```sh
sudo cryptsetup close secure_ssd
```

The device will once again be locked.
