<?php
include "../connect.php";
$id = $id = filtterreq("id");

$stmt = $con->prepare("DELETE FROM `myorders_table` WHERE `id` = $id");
$stmt->execute();
$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
