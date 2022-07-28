<?php
include "../connect.php";
$id = filtterreq('id');
$stmt = $con->prepare("UPDATE `users` SET `have_store`= ? WHERE `id` = ?");
$stmt->execute(array("yes", $id));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
