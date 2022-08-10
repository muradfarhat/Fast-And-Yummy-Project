<?php
include "../connect.php";
$userID = filtterreq("userID");
$cateID = filtterreq("cateID");
$productID = filtterreq("productID");
$stmt =$con ->prepare("SELECT `rate` FROM `rating` WHERE `userID` = ? and `cateID` = ? and productID = ?");
$stmt->execute(array($userID,$cateID,$productID)); 
$data = $stmt->fetch(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();
$stmt = $con->prepare("SELECT `cateName` from `category_table` where `cateID`= ?");
$stmt->execute(array($cateID));
$data2 = $stmt -> fetch(PDO::FETCH_ASSOC);
$cateName=$data2["cateName"];

$stmt = $con->prepare("SELECT `rate` from `$cateName` where `productID`= ?");
$stmt->execute(array($productID));
$rate = $stmt -> fetch(PDO::FETCH_ASSOC);
if($count > 0){
    echo json_encode(array("status" => "suc" , "data"=>$data,"rate"=>$rate));
}else{
    echo json_encode(array("status"=>"failed","rate"=>$rate));
}