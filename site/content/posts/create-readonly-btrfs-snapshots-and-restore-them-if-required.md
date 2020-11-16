---
title: Create readonly btrfs snapshots and restore them if required
date: 2020-11-16T09:43:17.748Z
categories:
  - private
---
### Mount btrfs volumes to disk:

`sudo mount /dev/mapper/luks-<TAB> /mnt/btrfs`

### Make a read-only snapshot:

`sudo btrfs subvolume snapshot -r /mnt/btrfs/system_fedora33 /mnt/btrfs/snapshots/system_fedora33/@snapshot_$(date '+%Y-%m-%d_%H-%M')`

### Rollback snapshot created:

1. Boot into an alternative operating system

2. Rename filesystem for safety:
   `sudo mv /mnt/btrfs/system_fedora33 /mnt/btrfs/system_fedora33_bak`

3. Reinstate snapshot as a read+write filesystem:
   `sudo btrfs subvolume snapshot /mnt/btrfs/snapshots/system_fedora33/@snapshot_2020-01-01_01-01 /mnt/btrfs/system_fedora33`

4. Delete the no longer required read-only snapshot:
   `sudo btrfs subvolume delete snapshot /mnt/btrfs/snapshots/system_fedora33/@snapshot_2020-01-01_01-01`

5. Remove original filesystem once restore is proven to work:
   `sudo btrfs subvolume delete /mnt/btrfs/system_fedora33_bak`