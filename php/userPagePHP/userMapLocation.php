<?php
include "../connect.php";
$id = filtterreq("id");
$lat = filtterreq("lat");
$lng = filtterreq("lng");
$cityL = filtterreq("cityL");

$delete = $con ->prepare("UPDATE `users` SET `latitude`='$lat',`longitude`='$lng',`cityLocation`='$cityL' WHERE `id` = '$id'");
$delete->execute(); 
$count=$delete->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}