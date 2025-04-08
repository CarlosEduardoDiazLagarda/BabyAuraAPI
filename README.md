# Escenciales Git

Este proyecto utiliza un **FrontEnd** desarrollado en **Flutter** que se comunica con un **BackEnd** construido con **Java Spring Boot**. Las funciones de inicio de sesión (Login), registro de usuarios y otras acciones se gestionan mediante peticiones al **BackEnd**.

## Tecnologías Utilizadas

- **FrontEnd**: Flutter
- **BackEnd**: Java Spring Boot
- **Base de Datos**: MySQL Server
- **Servicio de Conexión**: ngrok

## Descripción

El proyecto está diseñado para facilitar la conexión entre el FrontEnd y el BackEnd. Para ello, utilizamos el servicio **ngrok** que permite exponer nuestra IP local a través de un servidor, permitiendo así que **Flutter** y **Java** se comuniquen correctamente.

Además, empleamos una base de datos **MySQL Server** para almacenar los datos y realizar pruebas en la aplicación.

## Estructura de la Base de Datos

La base de datos incluye una tabla para gestionar los usuarios. La estructura de la tabla `Users` es la siguiente:

```sql
CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100),
    usuario VARCHAR(50),
    contrasena VARCHAR(255) 
);
