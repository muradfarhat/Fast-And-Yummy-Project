<?php
include "../connect.php";
$tableName = filtterreq("tableName");
$productName = filtterreq("productName");
$storeName = filtterreq("storeName");
$id = filtterreq("userID");
$price = filtterreq("price");
$stmt = $con->prepare("INSERT INTO `$tableName`(`productName`, `storeName`, `rate`, `userID`, `price`, `totalBuy`, `image`) VALUES (?,?,?,?,?,?,?)");
$stmt->execute(array($productName, $storeName, 0, $id, $price, 0, ""));
$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
