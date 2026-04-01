<?php
// Script para configurar mi aplicación web
// Establece las variables que indican los directorios de las clases
// Establece las variables para hacer la conexión a la base de datos

// Obtiene la instancia del objeto que guarda los datos de configuración
$config = Config::singleton();

// Carpetas para los Controladores, los Modelos y las Vistas
$config->set('controllersFolder', 'controllers/');
$config->set('modelsFolder', 'models/');
$config->set('viewsFolder', 'views/');

/* // Parámetros de conexión a la BD
$config->set('dbhost', 'localhost');
$config->set('dbname', 'bditems');
$config->set('dbuser', 'root');
$config->set('dbpass', ''); */

$config ->set('url_apirest','http://localhost/DWES/mvc_apirest/apirestitems/');
