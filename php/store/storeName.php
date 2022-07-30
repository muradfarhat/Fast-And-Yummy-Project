<?php
include "../connect.php";
$storeName = filtterreq('storeName');
$id = filtterreq('id');
$stmt = $con->prepare("UPDATE `store` SET `storeName`= ? WHERE `storeID` = ?");
$stmt->execute(array($storeName, $id));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status1" => "suc"));
} else {
    echo json_encode(array("status1" => "failed"));
}
