<?php
include "../connect.php";
$email = filtterreq("email");
$password = filtterreq("password");

$stmt =$con ->prepare(" SELECT * FROM users where `email`= ? AND `password` = ? ");
$stmt->execute(array($email,$password));     
$data= $stmt->fetch(PDO::FETCH_ASSOC);
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc","data"=>$data));
    
}else{
    echo json_encode(array("status"=>"failed"));
}