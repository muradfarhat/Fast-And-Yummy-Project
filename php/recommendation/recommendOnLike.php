<?php
include "../connect.php";
$userID = filtterreq("userID");
$stmt = $con->prepare("SELECT * FROM `myorders_table` where `userID`= $userID GROUP BY `orderID`");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$products = [];
for ($i = 0; $i < count($data); $i++) {
    $orderIID = $data[$i]['orderID'];
    $stmt = $con->prepare("SELECT COUNT(orderID)
    FROM myorders_table
    WHERE orderID=$orderIID");
    $stmt->execute();
    $count = $stmt->fetch(PDO::FETCH_ASSOC);
    if ((int)$count['COUNT(orderID)'] >= 3) {
        $stmt = $con->prepare("SELECT `cateName` FROM `category_table` where `cateID`= {$data[$i]['cateID']}");
        $stmt->execute();
        $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt = $con->prepare("SELECT * FROM `{$cateName['cateName']}` where `productID`= {$data[$i]['orderID']}");
        $stmt->execute();
        $product = $stmt->fetch(PDO::FETCH_ASSOC);
        $add=array_push($products,$product);
    }
}

echo json_encode(array("Liked"=>$products));