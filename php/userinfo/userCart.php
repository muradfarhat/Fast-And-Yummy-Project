<?php
include "../connect.php";
$id = filtterreq("userID");
$stmt = $con->prepare("SELECT * FROM `cart_table` WHERE `userID` = $id");
$stmt->execute();
$cart = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
$products=[];
for ($i = 0; $i < count($cart); $i++) {
    $id2 = $cart[$i]['cateID'];
    $stmt = $con->prepare("SELECT `cateName` FROM `category_table` WHERE `cateID` = $id2");
    $stmt->execute();
    $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
    $id3=$cart[$i]['orderID'];
    $cate=$cateName["cateName"];
    $stmt = $con->prepare("SELECT * FROM `$cate` WHERE `productID` = $id3");
    $stmt->execute();
    $proudct = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $cx=array_push($products,$proudct[0]);
}


if ($count > 0) {
    echo json_encode(array("status" => "suc", "data" => $cart,"products"=>$products));
} else {
    echo json_encode(array("status" => "failed"));
}
