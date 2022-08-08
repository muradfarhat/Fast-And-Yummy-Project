<?php
include "../connect.php";
$tableName = filtterreq('tableName');
$price = filtterreq('price');
$productID = filtterreq('productID');
$stmt = $con->prepare("UPDATE `$tableName` SET `price`= ? WHERE `productID` = ?");
$stmt->execute(array($price, $productID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
