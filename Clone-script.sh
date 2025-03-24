#!/bin/bash

set -e  # Detener el script si ocurre un error

# Preguntar si se usa SSH
read -rp "¿Quieres usar SSH para GitHub? (y/n): " use_ssh
repo_prefix=$([[ "$use_ssh" == "y" ]] && echo "git@github.com:" || echo "https://github.com/")

# Preguntar si se usa --depth 1
read -rp "¿Quieres usar --depth 1 al clonar? (y/n): " use_depth
depth_flag=$([[ "$use_depth" == "y" ]] && echo "--depth 1" || echo "")

# Definir repositorios en un array (repositorio, ruta destino, branch)
repos=(
    "sapphire-sm6225/android_hardware_qcom-caf_common hardware/qcom-caf/common lineage-22.1"
    "sapphire-sm6225/vendor_qcom_opensource_agm hardware/qcom-caf/sm6225/audio/agm lineage-22.0-caf-sm6225"
    "sapphire-sm6225/vendor_qcom_opensource_arpal-lx hardware/qcom-caf/sm6225/audio/pal lineage-22.0-caf-sm6225"
    "sapphire-sm6225/vendor_qcom_opensource_data-ipa-cfg-mgr hardware/qcom-caf/sm6225/data-ipa-cfg-mgr lineage-22.0-caf-sm6225"
    "sapphire-sm6225/vendor_qcom_opensource_dataipa hardware/qcom-caf/sm6225/dataipa lineage-22.0-caf-sm6225"
    "sapphire-sm6225/hardware_qcom_display hardware/qcom-caf/sm6225/display lineage-22.0-caf-sm6225"
    "sapphire-sm6225/hardware_qcom_media hardware/qcom-caf/sm6225/media lineage-22.0-caf-sm6225"
    "sapphire-sm6225/hardware_qcom_audio hardware/qcom-caf/sm6225/audio/primary-hal lineage-22.0-caf-sm6225"
    "sapphire-sm6225/hardware_xiaomi hardware/xiaomi 15"
    "saroj-nokia/device_xiaomi_sapphire device/xiaomi/sapphire 15"
    "saroj-nokia/device_xiaomi_sapphire-kernel device/xiaomi/sapphire-kernel 15"
    "saroj-nokia/vendor_xiaomi_sapphire vendor/xiaomi/sapphire 15"
    "sapphire-sm6225/device_qcom_sepolicy_vndr device/qcom/sepolicy_vndr/sm6225 lineage-22.0-caf-sm6225"
    "sapphire-sm6225/device_xiaomi_sepolicy device/xiaomi/sepolicy 15"
)

delete_repos() {
    echo "Eliminando repositorios..."
    for repo in "${repos[@]}"; do
        dir=$(echo "$repo" | awk '{print $2}')
        echo "Eliminando $dir..."
        rm -rf "$dir"
    done
    rm -rf device/xiaomi/miuicamera-sapphire
    rm -rf vendor/xiaomi/miuicamera-sapphire
}

clone_repos() {
    echo "Clonando repositorios..."
    for repo in "${repos[@]}"; do
        IFS=' ' read -r repo_name path branch <<< "$repo"
        echo "Clonando $path..."
        git clone $depth_flag -b "$branch" "${repo_prefix}${repo_name}.git" "$path"
    done

    # Preguntar si se quiere clonar MIUI Camera
    read -rp "¿Quieres clonar MIUI Camera? (y/n): " miui_camera
    if [[ "$miui_camera" == "y" ]]; then
        git clone $depth_flag -b 15 ${repo_prefix}saroj-nokia/device_xiaomi_miuicamera-sapphire.git device/xiaomi/miuicamera-sapphire
        git clone $depth_flag -b 15 git@gitlab.com:kibria5/vendor_xiaomi_miuicamera-sapphire.git vendor/xiaomi/miuicamera-sapphire
    fi
}

build_rom() {
    echo "Iniciando compilación en Crave.io..."
    source build/envsetup.sh
    export BUILD_USERNAME=@Angelpro09_Dev
    export BUILD_HOSTNAME=T800-machine
    export ALLOW_MISSING_DEPENDENCIES=true
    lunch aosp_sapphire-ap4a-user
    mka bacon
}

# Preguntar qué hacer
read -rp "¿Quieres clonar (c), eliminar (d) repos o compilar (b)? " action
case "$action" in
    c) 
        clone_repos 
        read -rp "¿Quieres compilar la ROM después de clonar? (y/n): " build_now
        [[ "$build_now" == "y" ]] && build_rom
        ;;
    d) delete_repos ;;
    b) build_rom ;;
    *) echo "Opción inválida. Saliendo..." && exit 1 ;;
esac

echo "Operación completada."
