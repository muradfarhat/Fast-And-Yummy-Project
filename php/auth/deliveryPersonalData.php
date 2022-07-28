<?php
include "../connect.php";
$city = filtterreq("city");
$carModel = filtterreq("carModel");
$carNumber = filtterreq("carNumber");
$deliveryID = filtterreq("deliveryID");
$id = filtterreq("id");

$stmt =$con ->prepare("INSERT INTO `delivery_info`(`userID`, `city`, `carModel`, `carNumber`, `deliveryID`) VALUES ('".$id."','".$city."','".$carModel."','".$carNumber."','".$deliveryID."')");
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}