<?php
include "../connect.php";
$tableName = filtterreq('tableName');
$description = filtterreq('description');
$productID = filtterreq('productID');
$stmt = $con->prepare("UPDATE `$tableName` SET `description`= ? WHERE `productID` = ?");
$stmt->execute(array($description, $productID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
