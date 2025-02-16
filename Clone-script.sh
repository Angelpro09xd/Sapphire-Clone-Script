#!/bin/bash

# Ask user if they want to use SSH for GitHub
echo "Do you want to use SSH for GitHub repositories? (y/n)"
read -r use_ssh

if [[ "$use_ssh" == "y" ]]; then
    repo_prefix="git@github.com:"
else
    repo_prefix="https://github.com/"
fi

# Function to delete directories
delete_repos() {
    echo "Deleting repositories..."
    rm -rf hardware/qcom-caf/common
    rm -rf hardware/qcom-caf/sm6225/audio/agm
    rm -rf hardware/qcom-caf/sm6225/audio/pal
    rm -rf hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
    rm -rf hardware/qcom-caf/sm6225/dataipa
    rm -rf hardware/qcom-caf/sm6225/display
    rm -rf hardware/qcom-caf/sm6225/media
    rm -rf hardware/qcom-caf/sm6225/audio/primary-hal
    rm -rf hardware/xiaomi
    rm -rf device/xiaomi/sapphire
    rm -rf device/xiaomi/sapphire-kernel
    rm -rf vendor/xiaomi/sapphire
    rm -rf device/qcom/sepolicy_vndr/sm6225
    rm -rf device/xiaomi/sepolicy
    rm -rf device/xiaomi/miuicamera-sapphire
    rm -rf vendor/xiaomi/miuicamera-sapphire
}

# Ask user if they want to use --depth 1
echo "Do you want to use --depth 1 for cloning? (y/n)"
read -r use_depth
if [[ "$use_depth" == "y" ]]; then
    depth_flag="--depth 1"
else
    depth_flag=""
fi

# Function to clone repositories
clone_repos() {
    echo "Cloning repositories..."
    git clone $depth_flag -b lineage-22.1 ${repo_prefix}sapphire-sm6225/android_hardware_qcom-caf_common.git hardware/qcom-caf/common
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/vendor_qcom_opensource_agm.git hardware/qcom-caf/sm6225/audio/agm
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/vendor_qcom_opensource_arpal-lx.git hardware/qcom-caf/sm6225/audio/pal
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/vendor_qcom_opensource_data-ipa-cfg-mgr.git hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/vendor_qcom_opensource_dataipa.git hardware/qcom-caf/sm6225/dataipa
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/hardware_qcom_display.git hardware/qcom-caf/sm6225/display
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/hardware_qcom_media.git hardware/qcom-caf/sm6225/media
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/hardware_qcom_audio.git hardware/qcom-caf/sm6225/audio/primary-hal
    git clone $depth_flag -b 15 ${repo_prefix}sapphire-sm6225/hardware_xiaomi.git hardware/xiaomi
    git clone $depth_flag -b 15 ${repo_prefix}saroj-nokia/device_xiaomi_sapphire_backup.git device/xiaomi/sapphire
    git clone $depth_flag -b 15 ${repo_prefix}saroj-nokia/device_xiaomi_sapphire-kernel.git device/xiaomi/sapphire-kernel
    git clone $depth_flag -b 15 ${repo_prefix}saroj-nokia/vendor_xiaomi_sapphire.git vendor/xiaomi/sapphire
    git clone $depth_flag -b lineage-22.0-caf-sm6225 ${repo_prefix}sapphire-sm6225/device_qcom_sepolicy_vndr.git device/qcom/sepolicy_vndr/sm6225
    git clone $depth_flag -b 15 ${repo_prefix}sapphire-sm6225/device_xiaomi_sepolicy.git device/xiaomi/sepolicy
}

# Ask user for action
echo "Do you want to clone (c) or delete (d) repositories?"
read -r action

if [[ "$action" == "c" ]]; then
    clone_repos
    echo "Do you want to clone MIUI Camera? (y/n)"
    read -r miui_camera
    if [[ "$miui_camera" == "y" ]]; then
        git clone $depth_flag -b 15 ${repo_prefix}saroj-nokia/device_xiaomi_miuicamera-sapphire.git device/xiaomi/miuicamera-sapphire
        git clone $depth_flag -b 15 git@gitlab.com:kibria5/vendor_xiaomi_miuicamera-sapphire.git vendor/xiaomi/miuicamera-sapphire
    fi
elif [[ "$action" == "d" ]]; then
    delete_repos
else
    echo "Invalid input. Exiting."
    exit 1
fi

echo "Operation completed."
