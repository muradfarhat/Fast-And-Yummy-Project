<?php
include "../connect.php";
$userID = filtterreq("userID");
$stmt = $con->prepare("SELECT * FROM `myorders_table` where `userID`= $userID order by `id` DESC");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if ($count > 0) {
    $stmt = $con->prepare("SELECT `cateName` FROM `category_table` where `cateID`= {$data[0]['cateID']}");
    $stmt->execute();
    $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt = $con->prepare("SELECT * FROM `{$cateName['cateName']}` where `productID`= {$data[0]['orderID']}");
    $stmt->execute();
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode(array("last" => $product));
}
else {
    echo json_encode(array("last" => "empty"));
}
