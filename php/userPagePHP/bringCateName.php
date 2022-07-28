<?php
include "../connect.php";
$cateID = filtterreq("cateID");


$stmt =$con ->prepare("SELECT `cateName` FROM `category_table` WHERE `cateID` = '".$cateID."'");
$stmt->execute();     
$user = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc", "data" => $user[0]['cateName']));
    
}else{
    echo json_encode(array("status"=>"failed"));
}