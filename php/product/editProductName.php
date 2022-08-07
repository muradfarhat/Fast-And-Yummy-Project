<?php
include "../connect.php";
$tableName = filtterreq('tableName');
$productName = filtterreq('productName');
$productID = filtterreq('productID');
$stmt = $con->prepare("UPDATE `$tableName` SET `productName`= ? WHERE `productID` = ?");
$stmt->execute(array($productName, $productID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
