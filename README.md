# Práctica 8: Uso de Ansible para Automatizar Tareas en Servidores

Este proyecto utiliza **Docker** y **Docker Compose** para desplegar **5 servidores Ubuntu 22.04** con acceso SSH y el usuario `ansible` configurado con privilegios `sudo` sin contraseña, y luego emplea **Ansible** (desde WSL Ubuntu) para automatizar la administración y aprovisionamiento de los 5 servidores simultáneamente.

## 🚀 Requisitos Previos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y en ejecución.
- **WSL 2 (Ubuntu)** en Windows con **Ansible** y **sshpass** instalados:
  ```bash
  sudo apt update && sudo apt install -y ansible sshpass
  ```

## 📁 Estructura del Proyecto

```text
practica-docker-ansible/
├── Dockerfile           # Imagen Ubuntu 22.04 con openssh-server y usuario ansible (sudo NOPASSWD)
├── docker-compose.yml   # Definición de los 5 servidores Ubuntu (servidor1 a servidor5)
├── ansible.cfg          # Configuración de Ansible (inventario y desactivación de advertencia SSH)
├── inventario.ini       # Inventario con los 5 servidores, IPs/puertos, usuario y clave ansible
├── playbook.yml         # Playbook con las tareas de automatización solicitadas
├── .gitignore
└── README.md
```

## 🛠️ Tareas Automatizadas con el Playbook

El archivo `playbook.yml` automatiza en los 5 servidores:
1. **Actualizar los paquetes de APT** del sistema operativo (`apt update` y `upgrade`).
2. **Crear el usuario `itla`** en cada servidor (`/home/itla`).
3. **Crear la carpeta `app`** (`/app` y `/home/itla/app`).
4. **Crear el archivo `hola.txt`** dentro de la carpeta `app` en cada servidor.
5. **Instalar las aplicaciones `cowsay` y `htop`** en cada servidor.

## ▶️ Instrucciones de Ejecución

### 1. Levantar los 5 servidores Ubuntu con Docker Compose

```bash
docker compose up -d --build
```

### 2. Verificar que los 5 contenedores están corriendo

```bash
docker compose ps
```

### 3. Probar conectividad desde Ansible (en WSL)

```bash
ANSIBLE_CONFIG=./ansible.cfg ansible all -m ping
```

### 4. Ejecutar el Playbook de Ansible

```bash
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbook.yml
```

### 5. Verificar los cambios en los servidores

```bash
docker exec ubuntu-servidor1 id itla
docker exec ubuntu-servidor1 cat /app/hola.txt
docker exec ubuntu-servidor1 /usr/games/cowsay "Ansible en ITLA funcionando"
```

---
*Desarrollado para la Práctica 8 de DevOps / Tecnologías de Virtualización - ITLA.*
