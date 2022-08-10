<?php
include "../connect.php";
$cateID = filtterreq('cateID');
$userID = filtterreq('userID');
$orderID = filtterreq('orderID');
$quantity = filtterreq('quantity');

$stmt = $con->prepare("INSERT INTO `cart_table`(`orderID`, `cateID`, `userID`, `quantity`) VALUES (?,?,?,?)");
$stmt->execute(array($orderID,$cateID,$userID,$quantity));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
