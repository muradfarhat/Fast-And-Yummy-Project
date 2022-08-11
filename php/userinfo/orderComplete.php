<?php
include "../connect.php";
$cateID = filtterreq('cateID');
$userID = filtterreq('userID');
$orderID = filtterreq('orderID');
$storeID = filtterreq('storeID');
$quantity = filtterreq('quantity');
$latitude = filtterreq('latitude');
$longitude =filtterreq('longitude');
$cityLocation =filtterreq('cityLocation');

$stmt = $con->prepare("INSERT INTO `myorders_table`(`orderID`, `cateID`, `userID`,`storeID`, `quantity` ,`status`,`latitude`,`longitude`,`cityLocation`) 
VALUES (?,?,?,?,?,?,?,?,?)");
$stmt->execute(array($orderID,$cateID,$userID,$storeID,$quantity,"In wait",$latitude,$longitude,$cityLocation));
$count = $stmt->rowCount();
if ($count > 0) {
    $stmt = $con->prepare("DELETE FROM `cart_table` WHERE `orderID`= ? and `userID`=? AND `cateID`=?");
    $stmt->execute(array($orderID,$userID,$cateID));
    echo json_encode(array("status" => "suc"));
} else {

echo json_encode(array("status" => "suc2"));
}
