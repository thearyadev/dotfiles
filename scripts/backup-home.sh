#!/bin/bash
sudo btrfs subvolume snapshot -r /home ./home-snap.btrfs
sudo btrfs send ./home-snap | gzip > /mnt/critical/backups/btrfs-snapshots/home-snap.btrfs.gz





