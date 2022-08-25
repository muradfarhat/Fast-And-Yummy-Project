<?php
include "../connect.php";
$productID = filtterreq("productID");
$cateID = filtterreq("cateID");
$storeID = filtterreq("storeID");
$status = filtterreq("status");
$duration = filtterreq("duration");
$stmt = $con->prepare("INSERT INTO `promotion_table`(`productID`, `cateID`, `storeID`, `status`,`duration`) VALUES (?,?,?,?,?)");
$stmt->execute(array($productID, $cateID, $storeID,$status,$duration));
$count = $stmt->rowCount();


if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
