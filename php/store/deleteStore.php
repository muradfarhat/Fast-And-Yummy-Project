<?php
include "../connect.php";
$id = filtterreq('storeID');
$imagename = filtterreq('imagename');
$stmt = $con->prepare("DELETE FROM `store` WHERE `storeID`= ?");
$stmt->execute(array($id));
$count = $stmt->rowCount();
$stmt = $con->prepare("UPDATE `users` SET `have_store`='no' WHERE `id`= ?");
$stmt->execute(array($id));
deleteImage("../images", $imagename);
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
