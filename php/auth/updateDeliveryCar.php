<?php
include "../connect.php";
$city = filtterreq("city");
$carModel = filtterreq("carModel");
$carNumber = filtterreq("carNumber");
$deliveryID = filtterreq("deliveryID");
$userID = filtterreq("userID");

$stmt =$con ->prepare("UPDATE `delivery_info` SET `city`=?,`carModel`=?,`carNumber`=?,`deliveryID`=? WHERE `userID` = ?");
$stmt->execute(array($city,$carModel,$carNumber,$deliveryID,$userID)); 
$count=$stmt->rowCount();
if($count > 0){
    echo json_encode(array("status" => "suc"));
}else{
    echo json_encode(array("status"=>"failed"));
}
