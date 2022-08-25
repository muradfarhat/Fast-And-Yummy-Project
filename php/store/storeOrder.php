<?php
include "../connect.php";
$storeID = filtterreq("storeID");
$stmt = $con->prepare("SELECT * FROM `myorders_table` WHERE `storeID` = $storeID and `status`!=?");
$stmt->execute(array("Deliverd"));
$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
$products=[];
for ($i = 0; $i < count($orders); $i++) {
    $id2 = $orders[$i]['cateID'];
    $stmt = $con->prepare("SELECT `cateName` FROM `category_table` WHERE `cateID` = $id2");
    $stmt->execute();
    $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
    $id3=$orders[$i]['storeID'];
    $id4=$orders[$i]['orderID'];
    $cate=$cateName["cateName"];
    $stmt = $con->prepare("SELECT * FROM `$cate` WHERE  `productID`= $id4");
    $stmt->execute();
    $proudct = $stmt->fetch(PDO::FETCH_ASSOC);
    $cx=array_push($products,$proudct);
}


if ($count > 0) {
    echo json_encode(array("status" => "suc", "data" => $orders,"products"=>$products));
} else {
    echo json_encode(array("status" => "failed"));
}
