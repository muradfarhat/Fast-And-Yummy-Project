<?php
include "../connect.php";
$tableName = filtterreq('tableName');
$content = filtterreq('content');
$productID = filtterreq('productID');
$stmt = $con->prepare("UPDATE `$tableName` SET `content`= ? WHERE `productID` = ?");
$stmt->execute(array($content, $productID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
