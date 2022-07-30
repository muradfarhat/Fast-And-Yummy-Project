<?php
include "../connect.php";
$id = filtterreq("id");

$delete = $con ->prepare("DELETE FROM `myorders_table` WHERE `id` = '$id'");
$delete->execute(); 
$count=$delete->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}