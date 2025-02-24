# Examen de Seguridad Informática

Acabáis de ser contratados por una empresa de seguridad informática para realizar un plan de seguridad para una página web crítica que está desarrollada en Wordpress.

La empresa tiene dos servidores, uno de producción y otro de backup. Ambos servidores están en la misma red local con las siguientes IP.

| Hostname        | IP               | Sirve como |
|:----------------|:-----------------|:-----------|
| VM1             | `192.168.56.103` | Wordpress  |
| VM2             | `192.168.56.104` | Backup     |

Trabajaréis por equipos y **os podréis organizar como queráis**

El objetivo del examen es crear en vuestro grupo un sistema de seguridad completo en el menor tiempo posible. **El equipo que primero lo consiga obtendrá la calificación completa**. Los siguientes equipos irán acumulando una penalización de -0,5 puntos del total por cada equipo que vaya entregando. Por tanto, solo se podrá enviar una vez la respuesta. 

Estos son los equipos:


| Grupo 1                  |
|--------------------------|
| Algaba, Pablo            |
| Benítez, Alejandro       |
| Díaz, Darío              |
| Malaver, María           |
| Martín, Adrián           |

| Grupo 2                  |
|--------------------------|
| Chacón, Victor Manuel    |
| González, Claudia        |
| Muñoz, Adrián            |
| Ortega, Javier           |
| Rodríguez, Jesús         |

| Grupo 3                  |
|--------------------------|
| González, José Manuel    |
| Rivera, David            |
| Vega, Jonathan           |
| Zamora, Juan Carlos      |

| Grupo 4                  |
|--------------------------|
| Arana, Francisco Javier  |
| Bornay, Jose Manuel      |
| Gutiérrez, Román         |
| Millán, Javier           |


El ejercicio debe cumplir los siguientes requisitos:

## Objetivos

1. Crear un plan de copias de seguridad como se desarrolla en la sección de [Peridicidad de las Copias](#-periodicidad-de-las-copias)
2. Las copias de seguridad se deben hacer a horas no productivas en horario de España y siempre con un aviso de mantenimiento.
3. Sincronizar a una hora no productiva la carpeta de backup con el servidor VM2 a través de SSH sin necesidad de introducir clave.
4. Eliminar todos los archivos no existentes durante la sincronización.
5. Todos los ficheros deben estar comprimidos con contraseña exclusiva del grupo y deben tener la fecha y hora en la que se generó.
6. Las copias de la base de datos deben estar preparadas para eliminar las tablas existentes antes de restaurar.

## Material

Tenéis disponibles unas máquinas Vagrant listas para ser levantadas. 

```bash
# Levanta máquinas
vagrant up

# Recarga las máquinas
vagrant reload --provision
vagrant reload <vm> --provision

# Conectarse a una VM
vagrant ssh <vm>

# Conectarse a una VM
vagrant ssh <vm>

# Exportar un VM (tarda unos minutos)
# Donde "base" es el nombre que tiene la máquina en VirtualBox.
vagrant package --base Ejercicio202502_vm1_1739872421963_54425 --output ~/vm1.box
```

Podéis hacer libre uso de internet y de cuantas herramientas preciséis. ¡Pero recuerda cumplir con las exigencias de la empresa!


## ⏳ Periodicidad de las Copias

    Base de datos
        🕐 Cada hora (para minimizar pérdida de datos)
        🔁 Se almacenan copias de las últimas 24 horas

    Archivos de WordPress
        📅 Una vez al día
        🔁 Se almacenan los últimos 7 días

    Backups completos
        📆 Cada semana (archivos + base de datos)
        🔁 Se guardan las últimas 4 semanas

    Backups mensuales
        📆 Cada mes (archivos + base de datos)
        🔁 Se guardan los últimos 12 meses

    Backups anuales
        📆 Cada 1 de enero
        🔁 Se guardan indefinidamente o 3-5 años


## Rúbica de evaluación

1. Se separan las copias de seguridad (db, files, full, mensual, anual) en diferentes scripts. 
2. Se usa wp cli para la copia de seguridad de bases de datos con el modificador adecuado.
3. Se una una clave exclusiva del grupo para encriptar los ZIP y cada fichero debe ir con la fecha y hora en la que se generó.
4. Se sincronizan los ficheros de copias de seguridad con el modificador adecuado
5. Se conectan adecuadamente las VM entre sí
6. Se usa el modo mantenimiento.
7. Se han generado par de claves 
8. Se usa rsync sin necesidad de introducir claves
9. Se eliminan adecuadamente los ficheros de determinada antigüedad
10. Se ha configurado cron en ambas máquinas para ejecutarse periódicamente. 

## Entrega

Puedes hacer la entrega como prefiráis. O bien en un pendrive, o bien rellenando los scripts vm1.sh y vm2.sh, o un enlace compartido de forma segura...

El caso es que yo debo ser capaz de poder comprobar que vuestra solución funciona. 

## Enlaces útiles

[Documentación WP Cli](https://developer.wordpress.org/cli/commands/)

[CronGuru](https://crontab.guru/)

[Manual find](https://man7.org/linux/man-pages/man1/find.1.html)

[Manual rsync](https://linux.die.net/man/1/rsync)


Ref: 67bb7f71-4144-8012-a1fc-2189bb1b6d62