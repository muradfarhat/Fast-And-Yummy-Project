<?php
include "../connect.php";
$tableName = filtterreq("tableName");
$id = filtterreq("userID");
$stmt =$con ->prepare("SELECT * FROM `$tableName` WHERE `userID` = ?");
$stmt->execute(array($id)); 
$data = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "suc" , "data"=>$data));
}else{
    echo json_encode(array("status"=>"failed"));
}