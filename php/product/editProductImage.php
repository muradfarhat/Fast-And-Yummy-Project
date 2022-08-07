<?php
include "../connect.php";
$imagename = imageUpload('file');
$id = filtterreq('id');
$tableName = filtterreq('tableName');
if ($imagename != 'Faild') {
    $stmt = $con->prepare("UPDATE `$tableName` SET `image`= ? WHERE `productID` = ?");
    $stmt->execute(array($imagename, $id));
    $count = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status1" => "suc"));
    } else {
        echo json_encode(array("status1" => "failed"));
    }
}

