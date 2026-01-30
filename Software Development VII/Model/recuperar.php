<?php 
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;
    use PHPMailer\PHPMailer\SMTP;
    require_once('Mailer/Exception.php');
    require_once('Mailer/PHPmailer.php');
    require_once('Mailer/SMTP.php');

    class recuperar{
        
        public function __construct($valor){
            $this->valor = $valor;
        }

        public function validar(){
            include('Conexion.php');
            $sql = "SELECT email FROM usuarios WHERE email = '$this->valor';";
            $sql_email = mysqli_query($conexion,$sql);
            if(mysqli_num_rows($sql_email) > 0){
                $mail = new PHPMailer(true);

                try {
                    //Server settings
                    $mail->isSMTP();
                    $mail->Host       = 'smtp-mail.outlook.com';
                    $mail->SMTPAuth   = true;
                    $mail->Username   = 'ejemplo@outlook.com';
                    $mail->Password   = 'contraseña';
                    $mail->Port       = 587;

                    //Recipients
                    $mail->setFrom('ejemplo@outlook.com', 'Nombre');
                    $mail->addAddress($this->valor);

                    //Content
                    $mail->isHTML(true);
                    $mail->Subject = 'Recuperacion de contra';
                    $mail->Body    = 'Hola, Este mensaje es generado para solicitar tu recuperacion de contra. 
                    Por medio de este link puedes continuar con tu proceso de recuperacion.<br><a href="localhost/practica/index.php?m=recuperar2">Recuperar Contra</a>';
                    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

                    $mail->send();
                    session_start();
                    $_SESSION['email'] = $this->valor;
                    $_SESSION['time'] = time();
                    echo "<script> alert('Se ha enviado un mensaje al correo.'); location.href='index.php?m=iniciar';</script>";
                } catch (Exception $e) {
                    echo "<script> alert('El mensaje no pudo ser enviado...'); location.href='index.php?m=iniciar';</script>";
                }
                mysqli_close($conexion);
            }
            else{
                echo "<script> alert('El Email no existe'); location.href='index.php?m=recuperar';</script>";
                mysqli_close($conexion);
            }
        }

        public function guardar(){
            session_start();
            include('Conexion.php');
            $email = $_SESSION['email'];
            $contra = md5($this->valor);
            $sql = "UPDATE usuarios SET pass = '$contra' WHERE email = '$email';";
            try{
                mysqli_query($conexion, $sql);
                mysqli_close($conexion);
                session_destroy();
                echo "<script> alert('La contraseña se ha actualizado!'); location.href='index.php?m=iniciar';</script>";
            }
            catch(Exception $e){
                session_destroy();
                echo "<script> alert('Ocurrio un error al actualizar la contraseña...'); location.href='index.php?m=iniciar';</script>";
                
            }

        }
    }
?>