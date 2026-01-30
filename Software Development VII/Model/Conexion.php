<?php
    try{
        $conexion = mysqli_connect("localhost", "estudiante", "utp2022", "practica1");

    }catch(Exception $e){
        die("Error". $e->getmessage());
        echo "Linea del error". $e->getline();
    }
            
?>