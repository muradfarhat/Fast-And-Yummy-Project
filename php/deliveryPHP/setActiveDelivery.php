<?php
include "../connect.php";
$id = filtterreq("id");
$active = filtterreq("active");

$stmt =$con ->prepare("UPDATE `users` SET `have_store`='$active' WHERE `id` = '$id'");
$stmt->execute();     
$count=$stmt->rowCount();
if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}