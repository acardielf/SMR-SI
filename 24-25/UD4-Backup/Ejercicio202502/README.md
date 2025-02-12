# Pending to write



## Preguntas frecuentes Vagrant

### ¿Como ejecutar rápidamente los scripts cuando le hacemos cambios?

```sh
## Este comando te va a venir muy bien

# para todas las máquinas
vagrant provision

# o solo para una maquina especifica
vagrant provision db
vagrant provision web
```

### ¿Como conectarnos por ssh a cada una de las máquinas?

```sh
vagrant ssh web
vagrant ssh db
```

### ¿Cómo eliminar las máquinas y empezar de cero?

```sh
vagrant destroy -f && vagrant up 
```

### Otros comandos útiles

```bash
# para levantar la/s maquina/s
vagrant up 

# para ver el estado de las máquinas
vagrant status 

# para apagar las maquinas
vagrant halt 

# para eliminar (desaprovisionar) las maquinas sin confirmación 
vagrant destroy -f 

# para refrescar la configuracion de las maquinas
vagrant reload --provision 

# para conectar por ssh a la maquina
vagrant ssh <maquina>
```
