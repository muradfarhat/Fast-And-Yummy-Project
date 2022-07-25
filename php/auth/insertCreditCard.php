<?php
include "../connect.php";
$visaName = filtterreq("visaName");
$visaNumber = filtterreq("visaNumber");
$visaDate = filtterreq("visaDate");
$CVV = filtterreq("CVV");
$id = filtterreq("id");

$stmt =$con ->prepare("UPDATE `users` SET `visaName`='".$visaName."',`visaNumber`='".$visaNumber."',`CVV`='".$CVV."',`visaDate`='".$visaDate."' WHERE `id` = '".$id."'");
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}