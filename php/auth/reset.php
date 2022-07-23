<?php
include "../connect.php";
$email = filtterreq("email");
$password = filtterreq("password");

$stmt =$con ->prepare(" UPDATE `users` SET `password`= ? where `email`= ? ");
$stmt->execute(array($password,$email));     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}