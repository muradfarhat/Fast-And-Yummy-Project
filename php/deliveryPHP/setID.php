<?php
include "../connect.php";
$id = filtterreq("id");
$manID = filtterreq("manID");

$stmt =$con ->prepare("UPDATE `myorders_table` SET `deliveryManID`='$manID' WHERE `id` = '$id'");
$stmt->execute();     
$count=$stmt->rowCount();
if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}