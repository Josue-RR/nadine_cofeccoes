<?php
// endereco
// nome do banco
// usuario
// senha

$host = 'localhost';
$dbname    = 'loja_confeccao';
$user  = 'postgres';
$password    = '';

try{
    //SGBD;HOSTNAME;PORT;DBNAME
    //USUARIO
    //SENHA
    //ERRMODE


    $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Conexão com PostgreSQL feito com sucesso";
} catch (PDOException $e) {
    echo "Falha na conexão: " . $e->getMessage();
}

?>