<?php 

class Administrador {

    public $id_usuario;
    public $usuario;
    public $clave;
    public $nombre;
    public $apellido;
    public $dni;

    public function InizializeData(

        $id_usuario,
        $usuario,
        $clave,
        $nombre,
        $apellido,
        $dni
    ) {

        $this->id_usuario = $id_usuario;
        $this->usuario = $usuario;
        $this->clave = $clave;
        $this->nombre = $nombre;
        $this->apellido = $apellido;
        $this->dni = $dni;

    }
}
