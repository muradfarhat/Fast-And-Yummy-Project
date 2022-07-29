<?php
include "../connect.php";
$id = filtterreq("id");
$quantity = filtterreq("quantity");

$delete = $con ->prepare("UPDATE `cart_table` SET `quantity`='$quantity' WHERE `id` = '$id'");
$delete->execute(); 
$count=$delete->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}