<?php
include "../connect.php";
$password = filtterreq("password");
$phone = filtterreq("phone");
$city = filtterreq("city");
$town = filtterreq("town");
$street = filtterreq("street");
$id = filtterreq("id");

$stmt =$con ->prepare("UPDATE `users` SET `password`= ?, `phone`=?,`city`=?,`town`=?,`street`=? WHERE `id` = ?");
$stmt->execute(array($password,$phone,$city,$town,$street,$id)); 
$count=$stmt->rowCount();
if($count>0 ){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}