<?php
include "../connect.php";
$id = filtterreq('productID');
$tableName = filtterreq('tableName');
$id2 = filtterreq("userID");
$imagename = filtterreq('imagename');
$stmt = $con->prepare("DELETE FROM `$tableName` WHERE `productID`= ?");
$stmt->execute(array($id));
$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "suc"));
    $stmt = $con->prepare("UPDATE `store` SET `numberOfProducts`=`numberOfProducts`-1 where `storeID`=? ");
    $stmt->execute(array($id2));
    deleteImage("../images", $imagename);
} else {
    echo json_encode(array("status" => "failed"));
}
