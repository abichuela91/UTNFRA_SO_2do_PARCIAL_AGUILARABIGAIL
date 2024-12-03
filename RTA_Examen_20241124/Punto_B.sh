#!/bin/bash  

# Rutas  
usuario_origen_password="admin"  # Cambia aquí al usuario del cual obtendrás la clave  
ruta_lista_usuarios="/home/aguilarabigail/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt"  

# Validar parámetros  
if [ "$#" -ne 1 ]; then  
    echo "Uso: \$0 <usuario_origen_password>"  
    exit 1  
fi  

# Usuario origen  
usuario_origen_password=\$1  

# Comprobar si el archivo de lista de usuarios existe  
if [ ! -f "$ruta_lista_usuarios" ]; then  
    echo "Error: El archivo de lista de usuarios no existe en la ruta especificada."  
    exit 1  
fi  

# Leer el archivo de lista de usuarios y procesar cada línea  
while IFS=, read -r nombre_usuario grupo_principal directorio_home; do  
    # Crear el grupo si no existe  
    if ! getent group "$grupo_principal" > /dev/null; then  
        echo "Creando grupo: $grupo_principal"  
        sudo groupadd "$grupo_principal"  
    else  
        echo "El grupo $grupo_principal ya existe."  
    fi  

    # Crear el usuario si no existe  
    if ! getent passwd "$nombre_usuario" > /dev/null; then  
        echo "Creando usuario: $nombre_usuario"  
        sudo useradd -m -d "$directorio_home" -g "$grupo_principal" -s /bin/bash "$nombre_usuario"  
        # Asignar la misma clave que tiene el usuario origen  
        clave=$(getent shadow "$usuario_origen_password" | cut -d: -f2)  
        echo "$nombre_usuario:$clave" | sudo chpasswd  
    else  
        echo "El usuario $nombre_usuario ya existe."  
    fi  
done < "$ruta_lista_usuarios"  

echo "Proceso de creación de usuarios y grupos finalizado."
