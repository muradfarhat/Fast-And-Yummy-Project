<?php
include "../connect.php";
$tableName = filtterreq('tableName');
$reqName = filtterreq('reqName');
$value= filtterreq('value');
$productID = filtterreq('productID');
$stmt = $con->prepare("UPDATE `$tableName` SET `$reqName`= ? WHERE `productID` = ?");
$stmt->execute(array($value, $productID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
