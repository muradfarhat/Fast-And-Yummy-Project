<?php
include "../connect.php";
$stmt = $con->prepare("SELECT * From `promotion_table` where `storeID`!= 11");
$stmt->execute();
$data = $stmt ->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();


if ($count > 0) {
    echo json_encode(array("status" => "suc","data"=>$data));
} else {
    echo json_encode(array("status" => "failed"));
}
