## LVM

Creating paritions is inflexible, which is why Logical Volume Manager was created. Where it's not possible to dynamically expand disk space on partitions, it can be done with LVM. 

### LVM Architecture

LM archtecture is comprised of different layers. The lowest layer consists of storage devices. These can include full disks, partitions, or logical units (LUNs) on a storage-area network (SAN).

Storage devices must be flagged as physical volumes (PV), which then makes them available within an LVM environment. A storage device can be added to the volume group (VG), which is an abstraction of all the available storage. This also means that the VG can be resized when needed. If storage is low on a logical volume (LV), more space van be taken from the volume group.

on top of a volume group are the logical volumes. These don't work on disks directly, but acquire space from available space in the VG. This means that a logical volume may be made up of space from multiple physical volumes.

It's better to not allow logical volumes to span multiple physical volumes. If one of these breaks, all files on the LVM system become inaccessible. File systems are created on the logical voluems, meaning that they are flexible. In order to resize a file system, the FS must provide support for it.

### Features

LVM comes with many features. One of the most important is the ability to extend volume groups by adding more physical disks or dvices. It's also possible to reduce the size of a logical volume, by only if this action is supported by the file system in question.

- Ext4 supports growing and shrinking.
- XFS only supports growing.

Another important feature of LVM is the ability to create snapshots. Snapshots are created by copying logical volume metadata that describes the state of the files to a snapshot volume. As long as therea re no changes, the LVM metadata points to the original block, which are addressed.

When blocks are modified, the blocks containing the previous file state are copies over to the snapshot volume. This means that the exact state of the files as they were during the snapshot creation can be accessed. Due to the fact that the snapshot will grow, it's important that there will be enough disk space. Snapshots are meant to be temporary, and a snapshot should be removed once it has served its purpose.

LVM makes it easy to replace hardware. Should a disk start failing, data can be moved within a volume group by using the `pvmove` command. A failing disk can be removed from the volume group and a new one added dynamically wthout having to shut down the logical volume itself.

## Creating The LVM Archictecture

Creating logical volumes means creating 3 layers in the LVM archtecture.

1. Convert physical devices like disks or partitions inot physical volumes (PV).
2. Create the volume group (VG) and assign PVs to it.
3. Create the logical volume (LV).

### Creating Physical Volumes

We start the process by creating a partition on a device using either `fdisk` or `gdisk`. We need to make sure that the paritition type is LM, which is `8e00`. In `fdisk`, which can also be done by typing `lvm` as the partition type to use.

Once created and flagged as `lvm`, we use `pvcreate` to make it as a physical volume. This will write metadata to the partition, allowing it to be used in a volume group. We can use the `pvs` command to get a short overview of the available physical volumes within the LVM architecture and what devices are assigned to it. For a more detailed view of the physical volumes, use `pvdisplay` instead.

### Creating Volume Groups

Once a PV is created, we need to assign it to a volume group. It can be done by using the `vgcreate` command, followed by a chosen name for the volume group, and then the name of the physical device that we are adding to it. An example of this would be:

```bash
vgcreate vgvolume /dev/sda1
```

It's also possible to do all of this in one step with the `vgcreate` command. This is useful in particular when adding a complete disk device. To add the partition `/dev/sda1`, for example, type `vgcreate vgvolume /dev/sda` to create a volume group called `vgvolume`. When this is done on a device that has not already been marked as a PV, the `vgcreate` command will automatically flag it as a physical volume.

Physical extent size is used during the creation of volume groups. The **physical extent** size defines the size of the blocks that are used to create logical volumes. An LV is always a size which is a multiple of the physical extent size. To create a massive logical volume, it's more efficient to use a large physical extent size. The default size of an extent is 4 MiB if unless a different extent size is specified. The extent size is always specified as multiples of 2 MiB, with a max size of 128 MiB. The `vgcreate -s` command is used to choose an extent size.

The `vgs` command is used to get an overiew of a volume group. For more detailed information, use the `vgdisplay` command.

### Creating Logical Volumes & File Systems

When creating a logical volume, a volume name and size must be chosen. The size can be specified as an absolute value with the `-L` option. For example, `-L 10` will create a volume that is a size of 10 GiB. Using the `-l` option is for relative size, such as `-l 50%FREE`, which will use half of the available disk space. The `-l` option can also be used to choose the number to extents that you want the logical volume to be.

The volume group must be specified, and we use the `-n` option to choose a name for the logical volume. For example:

```bash
lv create -n lvvolme -l 100 vgvolume
```

This command will create a logical volume with the name **lvvvolme** and a size of 100 extents, which will be added to the **vgvolume**. Once created, we can use the `mkfs` tool to create a file system on top of it.

### LVM Device Naming

To use a logical volume, we need its name, and this can be found in a number of ways. One of the most straightfoward is to address the device as '/dev/vgname/lvname`. Having created a volume with the name `lvvolume`, which gets its disk space from `vgvolume`, the device name would be `/dev/vgvolume/lvvolume`. This is a symlink to the device mapper name.

The device mapper (dm) is an interface that the kernel uses to address storage devices. Devices are generated on detection using names that are created during boot. The dm creates symlinks to the `/dev/mapp` directory pointing to device names. The symlink follows the naming structure of `/dev/mapper/vgname/lvname`. The device `/dev/vgvolume` would also be known as `/dev/mapper/vgvolume-lvvolume`.

## LVM Summary Table

| Command | Description |
| --- | --- |
| `pvcreate` | Create physical volume |
| `pvs` | Summary of physical volumes |
| `pvdisplay` | List of physical volumes and their properties |
| `pvremove` | Remove PV signature from a block device |
| `vgcreate` | Create volume group |
| `vgs` | Summary of volume groups |
| `vgdisplay` | List of VGs and thir properties |
| `vgremove` | Removes volume group |

## Resizing Logical Volumes

If using XFS, a volume can only be increased, while others like Ext4 support increasing and decreasing. An Ext4 FS needs to be offline for this to work, meaning that it must be unmounted before resizing.

### Resizing Volume Groups

The `vgextend` command adds storage to a volume group. The `vgreduce` command removes physical volumes from the group. The following steps are used to add storage to a volume group:

1. Check that the device or PV is available to be added to the volume group.
2. Use `vgextend` to extend the VG. The new disk capacity will immediately be displayed.

Once extended, use the `vgs` command to verify the expansion of the volume group

### Resizing Logical Volumes & File Systems

Logical volumes can be extended with the `lvextend` command. The command has a useful switch, `-r`, that will also extend the file system on the VG at the same time. It's recommended to use this option rather than doing these operations separately.

To expand the logical volume size, use either the `lvextend` or `lvresize` commands, followed by the `-r` option. Next, specify the size of that the bolume should be resized to. The best way to do this is with the `-L` option followed by the `+` sign and the amount of space to be allocated. An example of this would be:

```bash
lvresize -L +1G -r /dev/vgvolume/lvvolume
```

An alternative to use is the `-l` option,. This is followed by the number of extents of by the absolute/relative percentage of extents in the VG. Here are some examples:

1. 

```bash
lvresize -r -l 75%VG /dev/vgvolume/lvvolume
```

This resizes he logical volume so it takes 75% of the total disk space in the VG. If the LV is using more than 75% of the VG disk space, the command will attempt to reduce the LV size.

2.

```bash
lvresize -r -l +75%VG /dev/vgvolume/lvvolume
```

This command attempts to add 75% of the total size of the volume group disk space. This only works if at least 75% of the VG is unused.

3.

```bash
lvresize -r -l +75%FREE /dev/vgvolume/lvvolume
```

This adds 75% of the total free disk space to the logical volume.

4.

```bash
lvresize -r -l 75%FREE /dev/vgvolume/lvvolume
```

This resizes the LV to a size that equals 75% of the amount of free space, which could result in a reduction of LV size.

A **logical extent** is the logical block used for logical volumes, and maps to a physical extent. All resize actions must match logical extents.

### Reducing Volume Groups

It's possible to remove a PV from a the VG if the remaining VGs have enough free space to allocate the extents its using. It will not work if the remaining PVs are already fully used. First, use the `pvmove` command to move extents from the PV being removed to the remaining PVs. Then we use the `vgreduce` command to complete the remove process.
