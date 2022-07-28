<?php
include "../connect.php";
$password = filtterreq("password");
$phone = filtterreq("phone");

$id = filtterreq("id");


$stmt =$con ->prepare("UPDATE `users` SET `password`= ?, `phone`=? WHERE `id` = ?");
$stmt->execute(array($password,$phone,$id)); 
$count=$stmt->rowCount();
if($count > 0){
    echo json_encode(array("status" => "suc"));
}else{
    echo json_encode(array("status"=>"failed"));
}