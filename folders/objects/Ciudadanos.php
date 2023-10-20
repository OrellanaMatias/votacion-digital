<?php 

class Ciudadanos {

    public $dni;
    public $nombre;
    public $apellido;
    public $email;
    public $estado;

    public function InizializeData(

        $dni,
        $nombre,
        $apellido,
        $email,
        $estado
    ) {

        $this->dni = $dni; 
        $this->nombre = $nombre;
        $this->apellido = $apellido;
        $this->email = $email;
        $this->estado = $estado;

    }
}
