<?php
include "../connect.php";
$id = filtterreq("storeID");
$stmt = $con->prepare("SELECT * FROM `myorders_table` WHERE `storeID` = $id");
$stmt->execute();
$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
$products=[];
for ($i = 0; $i < count($orders); $i++) {
    $id2 = $orders[$i]['cateID'];
    $stmt = $con->prepare("SELECT `cateName` FROM `category_table` WHERE `cateID` = $id2");
    $stmt->execute();
    $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
    $id3=$orders[$i]['storeID'];
    $cate=$cateName["cateName"];
    $stmt = $con->prepare("SELECT * FROM `$cate` WHERE `userID` = $id3");
    $stmt->execute();
    $proudct = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $cx=array_push($products,$proudct[0]);
}


if ($count > 0) {
    echo json_encode(array("status" => "suc", "data" => $orders,"products"=>$products));
} else {
    echo json_encode(array("status" => "failed"));
}
