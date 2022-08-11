<?php
include "../connect.php";
$cateID = filtterreq('cateID');
$userID = filtterreq('userID');
$orderID = filtterreq('orderID');
$quantity = filtterreq('quantity');
$storeID = filtterreq('storeID');
$stmt = $con->prepare("SELECT * FROM `cart_table` WHERE `orderID`=? and `cateID`=? and `userID`= ? and `storeID`=?");
$stmt->execute(array($orderID,$cateID,$userID,$storeID ));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    $stmt = $con->prepare("INSERT INTO `cart_table`(`orderID`, `cateID`, `userID`, `quantity`,`storeID`) VALUES (?,?,?,?,?)");
$stmt->execute(array($orderID,$cateID,$userID,$quantity,$storeID ));
echo json_encode(array("status" => "suc2"));
}
