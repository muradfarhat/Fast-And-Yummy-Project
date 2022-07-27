<?php
include "../connect.php";
$imagename = imageUpload('file');
$id = filtterreq('id');
if ($imagename != 'Faild') {
    $stmt = $con->prepare("UPDATE `users` SET `image`= ? WHERE `id` = ?");
    $stmt->execute(array($imagename, $id));
    $count = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "suc"));
    } else {
        echo json_encode(array("status" => "failed"));
    }
}
