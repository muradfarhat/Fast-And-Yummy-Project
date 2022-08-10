<?php
include "../connect.php";
$userID = filtterreq("userID");
$cateID = filtterreq("cateID");
$productID = filtterreq("productID");
$stmt =$con ->prepare("SELECT * FROM `feedBack` WHERE `userID` = ? and `cateID` = ? and productID = ?");
$stmt->execute(array($userID,$cateID,$productID)); 
$data = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "suc" , "data"=>$data));
}else{
    echo json_encode(array("status"=>"failed"));
}