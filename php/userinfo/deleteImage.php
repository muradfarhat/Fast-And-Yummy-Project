<?php
include "../connect.php";
$imagename = filtterreq('imagename');
$id = filtterreq('id');
if ($imagename != 'Faild') {
    $stmt = $con->prepare("UPDATE `users` SET `image`= ? WHERE `id` = ?");
    $stmt->execute(array("",$id));
    $count = $stmt->rowCount();
    if ($count > 0) {
        deleteImage("../images",$imagename);
        echo json_encode(array("status" => "suc"));
    } else {
        echo json_encode(array("status" => "failed"));
    }
}
