# Examen de Seguridad Informática

Acabáis de ser contratados por una empresa de seguridad informática para realizar un plan de seguridad para una página web crítica que está desarrollada en Wordpress.

La empresa tiene dos servidores, uno de producción y otro de backup. Ambos servidores están en la misma red local con las siguientes IP

| Hostname        | IP               | Sirve como |
|:----------------|:-----------------|:-----------|
| VM1             | `192.168.56.103` | Wordpress  |
| VM2             | `192.168.56.104` | Backup     |

Trabajaréis por equipos y os podréis organizar como queráis, siendo la distribución la siguiente:

| Miembro                    | Grupo | 
|:---------------------------|:-----:|
| Algaba, Pablo              |   1   |
| Benítez, Alejandro         |   1   |
| Díaz, Darío                |   1   |
| Malaver, María             |   1   |
| Martín, Adrián             |   1   |
| Chacón, Victor Manuel      |   2   |
| González, Claudia          |   2   |
| Rodríguez, Jesús           |   2   |
| Muñoz, Adrián              |   2   |
| Ortega, Javier             |   2   |
| Rivera, David              |   3   |
| Vega, Jonathan             |   3   |
| Zamora, Juan Carlos        |   3   |
| González, José Manuel      |   3   |
| Arana, Francisco Javier    |   4   |
| Bornay, Jose Manuel        |   4   |
| Gutiérrez, Román           |   4   |
| Millán, Javier             |   4   |

El objetivo del examen es crear en vuestro grupo un sistema de seguridad completo en el menor tiempo posible. **El equipo que primero lo consiga obtendrá la calificación completa**. Los siguientes equipos irán acumulando una penalización de -0,5 puntos del total por cada equipo que vaya entregando.

El ejercicio debe cumplir los siguientes requisitos:

## Objetivos

1. Crear un plan de copias de seguridad como se desarrolla en la sección de [Peridicidad de las Copias](#-periodicidad-de-las-copias)
2. Las copias de seguridad se deben hacer a horas no productivas en horario de España y siempre con un aviso de mantenimiento.
3. Sincronizar a una hora no productiva la carpeta de backup con el servidor VM2 a través de SSH sin necesidad de introducir clave.
4. Eliminar todos los archivos no existentes durante la sincronización.
5. Todos los ficheros deben estar comprimidos con contraseña exclusiva del grupo. 
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

1. Se separan las copias de seguridad (db, files, full, mensual, anual) en diferentes scripts
2. Se usa wp cli para la copia de seguridad de bases de datos con el modificador adecuado
3. Se una una clave exclusiva del grupo para encriptar los ZIP
4. Se sincronizan los ficheros de copias de seguridad con el modificador adecuado
5. Se conectan adecuadamente las VM entre sí
6. Se usa el modo mantenimiento.
7. Se han generado par de claves 
8. Se usa rsync sin necesidad de introducir claves
9. Se eliminan adecuadamente los ficheros de determinada antigüedad



## Enlaces útiles

[Documentación WP Cli](https://developer.wordpress.org/cli/commands/)

[CronGuru](https://crontab.guru/)