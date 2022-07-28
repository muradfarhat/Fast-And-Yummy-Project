<?php
include "../connect.php";
$id = filtterreq("id");
$cateName = filtterreq("cateName");

$stmt =$con ->prepare("SELECT `productID`, `productName`, `storeName`, `rate`, `userID`, `price`, `totalBuy`, `image` FROM `".$cateName."` WHERE `productID` = '".$id."'");
$stmt->execute();     
$user = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc", "data" => $user));
    
}else{
    echo json_encode(array("status"=>"failed"));
}