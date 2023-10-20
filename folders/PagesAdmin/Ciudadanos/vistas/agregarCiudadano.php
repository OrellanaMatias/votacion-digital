<?php

require_once '../../../layouts/layout.php';
require_once '../../../helpers/FileHandler/JsonFileHandler.php';
require_once '../../../iDataBase/IDatabase.php';
require_once '../servicios/CiudadanosHandler.php';
require_once '../../../objects/Ciudadanos.php';

session_start();

$layout = new Layout(true, 'Agregar Ciudadano', false);
$data = new CiudadanosHandler('../../../databaseHandler');

if (isset($_SESSION['administracion'])) {
    $administrador = json_decode($_SESSION['administracion']);
} else {
    header('Location: ../../Login/vista/loginAdministracion.php');
}

if(isset($_POST['dni']) && isset($_POST['nombre']) && isset($_POST['apellido']) && isset($_POST['email'])) {
    if($_POST['dni'] == "" || $_POST['nombre'] == "" || $_POST['apellido'] == "" || $_POST['email'] == "") {
        echo "<script> alert('Llene los espacios en blanco.'); </script>";

    } else {

        $Ciudadanos = new Ciudadanos();
        $Ciudadanos->dni = $_POST['dni'];
        $Ciudadanos->nombre = $_POST['nombre'];
        $Ciudadanos->apellido = $_POST['apellido'];
        $Ciudadanos->email = $_POST['email'];

        $data->Add($Ciudadanos);

        echo "<script> alert('Ciudadano agregado con éxito'); </script>";
        header('Location: ../vistas/CiudadanosAdmin.php');
    }
}

?>

<?php $layout->Header(); ?>

<br>
<br>
<br>
<div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <img class="mb-4" src="../../../assets/images/web/ITEL.jpg" alt="" width="100" height="100">
        <br>
        <form enctype="multipart/form-data" action='agregarCiudadano.php' method="POST">
        <div class="form-group">
                <label for="dniciudadano">DNI:</label>
                <input type="text" class="form-control" id="dniciudadano" placeholder="Ingrese el dni del nuevo ciudadano" required name='dni'>
            </div>
            <div class="form-group">
                <label for="nombreciudadano">Nombre del Ciudadano</label>
                <input type="text" class="form-control" id="nombreciudadano" placeholder="Ingrese el nombre del nuevo ciudadano" required name='nombre'>
            </div>
            <div class="form-group">
                <label for="apellidociudadano">Apellido del Candidato</label>
                <input type="text" class="form-control" id="apellidociudadano" placeholder="Ingrese el apellido del nuevo ciudadano" required name='apellido'>
            </div>
            <div class="form-group">
                <label for="apellidocandidato">Correo electrónico</label>
                <input type="email" class="form-control" id="emailciudadano" placeholder="example@correo.com" required name='email'>
            </div>
            <div class="form-group">
                <button class="btn btn-lg btn-danger btn-block" type="submit">Agregar</button>
            </div>
        </form>
    </div>
    <div class="col-md-4"></div>
</div>

<?php $layout->Footer(); ?>