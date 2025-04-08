Este proyecto funciona gracias a un FrontEnd desarrollado en Flutter, el cual realiza peticiones a un BackEnd construido con Java Spring Boot. Las funciones de inicio de sesión (Login), registro de usuarios y otras acciones se gestionan a través de peticiones que se consultan al BackEnd.

Para facilitar la conexión entre el FrontEnd y el BackEnd, utilizamos el servicio "ngrok" para montar un servidor que permita la comunicación entre ambos. Además, empleamos una base de datos tradicional, "MySQL Server", para realizar pruebas a la aplicación.

Para que la aplicación funcione correctamente, es necesario exponer nuestra IP local a través de "ngrok", lo que permite montar un servidor y posibilita que Flutter se comunique con Java. La base de datos se puede construir de la siguiente manera:

CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100),
    usuario VARCHAR(50),
    contrasena VARCHAR(255) 
);

Los pasos para ejecutar el proyecto son los siguientes:

1. Inicia el servicio de Java Spring Boot.
2. Luego, inicia "ngrok".
3. Es recomendable realizar pruebas en "Postman" para verificar que, al ejecutar el servidor Tomcat en Spring Boot, este pueda recibir y enviar datos correctamente.
4. Una vez verificado, podrás ejecutar Flutter.
