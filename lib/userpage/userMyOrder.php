<?php
include "../connect.php";
$id = $id = filtterreq("id");

$stmt =$con ->prepare("SELECT * FROM `myorders_table` WHERE `userID` = '".$id."'");
$stmt->execute();     
$user = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc", "data" => $user));
    
}else{
    echo json_encode(array("status"=>"failed"));
}