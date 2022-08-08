<?php
include "../connect.php";
$tableName = filtterreq("tableName");
$productName = filtterreq("productName");
$storeName = filtterreq("storeName");
$id = filtterreq("userID");
$price = filtterreq("price");
$description = filtterreq("description");
$content = filtterreq("content");
$imagename = imageUpload('file');

if ($imagename != 'Faild') {
    $stmt = $con->prepare("INSERT INTO `$tableName`(`productName`, `storeName`, `rate`, `userID`, `price`, `totalBuy`, `image`,`description`,`content`) VALUES (?,?,?,?,?,?,?,?,?)");
    $stmt->execute(array($productName, $storeName, 0.0, $id, $price, 0.0,$imagename,$description,$content));
    $count = $stmt->rowCount();

    if ($count > 0) {
        echo json_encode(array("status" => "suc"));
        $stmt = $con->prepare("UPDATE `store` SET `numberOfProducts`=`numberOfProducts`+1 where `storeID`=? ");
        $stmt->execute(array($id));
    } else {
        echo json_encode(array("status" => "failed"));
    }
}