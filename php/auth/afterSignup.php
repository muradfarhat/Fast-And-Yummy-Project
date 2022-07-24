<?php
include "../connect.php";
$deliveryOrCustomer = filtterreq("deliveryOrCustomer");
$id = filtterreq("id");

$stmt =$con ->prepare("
UPDATE `users` SET `deliveryOrCustomer`='".$deliveryOrCustomer."' WHERE `id` = ".$id);
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}