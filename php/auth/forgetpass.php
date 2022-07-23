<?php
include "../connect.php";
$email = filtterreq("email");

$stmt =$con ->prepare(" SELECT * FROM users where `email`= ? ");
$stmt->execute(array($email));     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}