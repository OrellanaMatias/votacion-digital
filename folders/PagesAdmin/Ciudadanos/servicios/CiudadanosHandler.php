<?php

require_once '../../../databaseHandler/databaseConnection.php';
require_once '../../../iDataBase/IDatabase.php';

class CiudadanosHandler implements IDataBaseHandler
{

    private $connection;

    function __construct($directory)
    {
        $this->connection = new databaseConnection($directory);
    }

    function getAll()
    {

        $tableList = array();

        $stm = $this->connection->db->prepare('Select * FROM Ciudadanos');
        $stm->execute();

        $result = $stm->get_result();

        if ($result->num_rows === 0) {

            return $tableList;
        } else {
            while ($row = $result->fetch_object()) {
                $user = new Ciudadanos();

                $user->dni = $row->dni;
                $user->nombre = $row->nombre;
                $user->apellido = $row->apellido;
                $user->email = $row->email;
                $user->estado = $row->estado;

                array_push($tableList, $user);
            }

            $stm->close();
            return $tableList;
        }
    }

    function getCiudadanoByDni($dni)
    {

        $stm = $this->connection->db->prepare('Select * FROM Ciudadanos where dni = ?');
        $stm->bind_param("s",$dni);
        $stm->execute();

        $result = $stm->get_result();

        if ($result->num_rows === 0) {

        } else {
                $row = $result->fetch_object();
                $user = new Ciudadanos();

                $user->dni = $row->dni;
                $user->nombre = $row->nombre;
                $user->apellido = $row->apellido;
                $user->email = $row->email;
                $user->estado = $row->estado;

                
            

            $stm->close();
            return $user;
        }
    }

    function getActive()
    {
    }

    function getInactive()
    {
    }

    function getById($id)
    {
    }

    function Add($entity)
    {
        $stm = $this->connection->db->prepare('insert into Ciudadanos(dni,nombre,apellido,email) VALUES(?,?,?,?)');
        $stm->bind_param('ssss', $entity->dni, $entity->nombre, $entity->apellido, $entity->email);
        $stm->execute();
    }

    function Habilitar($id)
    {
        $stm = $this->connection->db->prepare('update Ciudadanos set estado = true where dni = ?');
        $stm->bind_param('s', $id);
        $stm->execute();
    }

    function Deshabilitar($id)
    {
        $stm = $this->connection->db->prepare('update Ciudadanos set estado = false where dni = ?');
        $stm->bind_param('s', $id);
        $stm->execute();
    }

    function Edit($entity)
    {
    }
}
