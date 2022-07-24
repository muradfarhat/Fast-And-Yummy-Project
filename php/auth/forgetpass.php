<?php
include "../connect.php";
$email = filtterreq("email");

$stmt =$con ->prepare(" SELECT * FROM users where `email`= ? ");
$stmt->execute(array($email));  
$user = $stmt->fetchAll(PDO::FETCH_ASSOC);   
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc", "data" => $user));
    //echo json_encode($user);
    
}else{
    echo json_encode(array("status"=>"failed"));
}