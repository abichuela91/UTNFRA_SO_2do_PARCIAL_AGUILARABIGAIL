#!/bin/bash
# ver las información de los discos y sus nombres
sudo fdisk -l
#se crea la partciona disco de 2G
sudo fdisk /dev/sdb
n
p
1
enter
enter
t 
L
8E
p
w
#se crean las particiones del disco de 1G
sudo fdisk /dev/sdc
n
p
enter
enter
+512M
n
p
enter
enter
enter
t
1
L
8E
t
2
8E
p
w
# se limpian las particiones
sudo wipefs -a /dev/sdb1 /dev/sdc1 /dev/sdc2
#se crean los PV
sudo pvcreate /dev/sdb1 /dev/sdc1 /dev/sdc2
sudo pvs
#creacion de los VG
sudo vgcreate vg_datos /dev/sdb1
sudo vgcreate vg_temp /dev/sdc1 /dev/sdc2
sudo vgs
#creacion de LV
sudo lvcreate -L 5M vg_datos -n lv_docker
sudo lvcreate -L 1.5G vg_datos -n lv_workareas
sudo lvcreate -L 512M vg_temp -n lv_swap
sudo lvs
sudo fdisk -l
#se formatea y se monta el swap
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap
# se formatean y se los monta el resto de los lvm
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo ls -l /var/lib/dockers/ # se busca si la carpeta de directorio esta creada
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/Docker
sudo ls -l /work/
sudo mkdir -p /work # se crea el directorio, verificando q no existe.
sudo mount /dev/mapper/vg_datos-lv_workareas
# se completa el la tarea designada
