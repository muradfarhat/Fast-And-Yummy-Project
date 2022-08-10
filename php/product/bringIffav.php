<?php
include "../connect.php";
$userID = filtterreq("userID");
$cateID = filtterreq("cateID");
$orderID = filtterreq("orderID");
$stmt =$con ->prepare("SELECT * FROM `favoritetable` WHERE `userID` = ? and `cateID` = ? and orderID = ?");
$stmt->execute(array($userID,$cateID,$orderID)); 
$count=$stmt->rowCount();
if($count > 0){
    echo json_encode(array("status" => "suc"));
}else{
    echo json_encode(array("status"=>"failed"));
}