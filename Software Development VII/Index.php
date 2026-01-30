<?php
    require_once("Controller/Controlador.php");
    require_once("Model/registrar.php");
    require_once("Model/login.php");
    require_once("Model/guardar.php");
    require_once("Model/perfil.php");
    require_once("Model/recuperar.php");
    $controlador = new controlador;
    if(isset($_GET['m'])){
        $opcion = $_GET['m'];

        if ($opcion == "iniciar"){
            $controlador->login();
        }   
        elseif($opcion == "registrar"){
            $controlador->registrar();
        }
        elseif($opcion == "recuperar"){
            $controlador->recuperar();
        }
        elseif($opcion == "recuperar2"){
            $controlador->recuperar2();
        }
        elseif($opcion == "Enviar"){
            if(isset($_POST['enviar'])){
                $recuperar = new recuperar($_REQUEST['email']);
                $recuperar->validar();
            }
            else{
                $recuperar = new recuperar($_REQUEST['pass']);
                $recuperar->guardar();
            }
        }
        elseif($opcion == "registrarUser"){
            $registrar = new registrar($_REQUEST['nombre'], $_REQUEST['apellido'],$_REQUEST['email'], $_REQUEST['pass'],$_REQUEST['pass2']);
            $registrar->registro();
        }
        elseif($opcion == "iniciarUser"){
            $iniciar = new login($_REQUEST['email'], $_REQUEST['pass']);
            $iniciar->iniciar();
        }
        elseif($opcion == "sesion"){
            $controlador->sesion();
        }
        elseif($opcion == "perfil"){
            $perfil = new perfil();
            $perfil->cargarDatos();
            $controlador->perfil();
        }
        elseif($opcion == "cerrar"){
            $controlador->cerrar();
        }
        elseif($opcion == "guardar"){
            if($_FILES['imagen']['tmp_name'] == ""){
                $foto = "";
                $guardar = new guardar($_REQUEST['nombre'], $_REQUEST['apellido'], $_REQUEST['provincia'], $foto);
                $guardar->guardarDatos();
            }
            else{
                $foto = addslashes(file_get_contents($_FILES['imagen']['tmp_name']));
                $guardar = new guardar($_REQUEST['nombre'], $_REQUEST['apellido'], $_REQUEST['provincia'], $foto);
                $guardar->guardarDatos();
            }
        }
    }
    else{
        $controlador->login();
    }
?>
        
    