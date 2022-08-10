<?php
include "../connect.php";
$id = filtterreq("id");
$lat = filtterreq("lat");
$lng = filtterreq("lng");
$cityL = filtterreq("cityL");

$stmt =$con ->prepare("UPDATE `users` SET `latitude`='$lat',`longitude`='$lng',`cityLocation`='$cityL' WHERE `id` = '$id'");
$stmt->execute(); 
$count=$stmt->rowCount();
if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}