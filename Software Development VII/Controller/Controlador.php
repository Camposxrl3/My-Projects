<?php

    class controlador{
        public function login(){
            require_once("View/Login_vista.php");
        }

        public function registrar(){
            require_once("View/Registrar_vista.php");
        }

        public function sesion(){
            require_once("View/Panel_vista.php");
        }
    
        public function perfil(){
            require_once("view/Perfil_vista.php");
        }

        public function recuperar(){
            require_once("View/Recuperar_vista.php");
        }

        public function recuperar2(){
            require_once("View/RecuperarContra_vista.php");
        }
        
        public function cerrar(){
            session_start();
            session_destroy();
            header("location:index.php?m=iniciar");
        }
    }
    
?>