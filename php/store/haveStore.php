<?php
include "../connect.php";
$id = filtterreq('id');
$imagename = imageUpload('file');
$stmt = $con->prepare("UPDATE `users` SET `have_store`= ? WHERE `id` = ?");
$stmt->execute(array("yes", $id));

$count = $stmt->rowCount();
$stmt2 = $con->prepare("INSERT INTO `store`(`storeID`, `storeName`, `storeImage`, `earrings`) VALUES (?,?,?,?)");
$stmt2->execute(array($id, "Store Name".rand(1,500),$imagename,0));
$count2= $stmt2->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
