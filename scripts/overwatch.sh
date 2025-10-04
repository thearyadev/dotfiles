#!/bin/bash

export __GL_SYNC_TO_VBLANK=0
export vblank_mode=0
export DXVK_HUD=compiler

# Base cache directory
STEAMCACHE_BASE="~/.steamcache/Overwatch"

# Make sure cache directories exist
mkdir -p "$STEAMCACHE_BASE"/{AMDv1,DXVK_state_cache,nvidiav1,fozmediav1,fozpipelinesv6,mesa}

# Steam & Proton cache settings
export AMD_VK_PIPELINE_CACHE_FILENAME=steamapp_shader_cache
export AMD_VK_PIPELINE_CACHE_PATH="$STEAMCACHE_BASE/AMDv1"
export AMD_VK_USE_PIPELINE_CACHE=1

export DXVK_STATE_CACHE_PATH="$STEAMCACHE_BASE/DXVK_state_cache"

export MESA_GLSL_CACHE_DIR="$STEAMCACHE_BASE/mesa"
export MESA_SHADER_CACHE_DIR="$STEAMCACHE_BASE/mesa"
export MESA_SHADER_CACHE_MAX_SIZE=5G

export STEAM_COMPAT_MEDIA_PATH="$STEAMCACHE_BASE/fozmediav1"
export STEAM_COMPAT_TRANSCODED_MEDIA_PATH="$STEAMCACHE_BASE"
export STEAM_FOSSILIZE_DUMP_PATH="$STEAMCACHE_BASE/fozpipelinesv6/steamapprun_pipeline_cache"

export __GL_SHADER_DISK_CACHE_PATH="$STEAMCACHE_BASE/nvidiav1"
export __GL_SHADER_DISK_CACHE_SIZE=15000000000
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_APP_NAME=steamapp_shader_cache
export __GL_SHADER_DISK_CACHE_READ_ONLY_APP_NAME="steam_shader_cache;steamapp_merged_shader_cache"

export STEAM_BASE_FOLDER=/home/arya/.local/share/Steam
export STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/arya/.local/share/Steam
export STEAM_COMPAT_DATA_PATH=/home/arya/.local/share/Steam/steamapps/compatdata/3677945618
export STEAM_COMPAT_APP_ID=0
export STEAM_COMPAT_PROTON=1

# Launch Battle.net through Proton
/home/arya/.steam/steam/compatibilitytools.d/GE-Proton10-15/proton run \
  "/home/arya/.steam/steam/steamapps/compatdata/3677945618/pfx/drive_c/Program Files (x86)/Battle.net/Battle.net.exe"
