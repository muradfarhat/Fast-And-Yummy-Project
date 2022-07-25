<?php
include "../connect.php";
$city = filtterreq("city");
$town = filtterreq("town");
$street = filtterreq("street");
$id = filtterreq("id");

$stmt =$con ->prepare("UPDATE `users` SET `city`='".$city."',`town`='".$town."',`street`='".$street."' WHERE `id` = '".$id."'");
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}