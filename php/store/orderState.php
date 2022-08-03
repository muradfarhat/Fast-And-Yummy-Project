<?php
include "../connect.php";
$id = filtterreq('id');
$stmt = $con->prepare("UPDATE `myorders_table` SET `status`= ? WHERE `id` = ?");
$stmt->execute(array("In delivery", $id));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
