<?php
include "../connect.php";
$email = filtterreq("email");
$first_name = filtterreq("first_name");
$last_name = filtterreq("last_name");
$phone = filtterreq("phone");
$password = filtterreq("password");
$have_store = filtterreq("have_store");

$stmt =$con ->prepare("
    INSERT INTO `users`(`email`, `first_name`, `last_name`, `phone`, `password`,`have_store`)
     VALUES (? , ? , ? , ? , ?, ?)
     ");
$stmt->execute(array($email,$first_name,$last_name,$phone,$password,$have_store));     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}