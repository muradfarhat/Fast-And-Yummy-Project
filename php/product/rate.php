<?php
include "../connect.php";
$storeID = filtterreq('storeID');
$userID = filtterreq('userID');
$productID = filtterreq('productID');
$rate = filtterreq('rate');
$oldrate = filtterreq('oldrate');
$cateID = filtterreq('cateID');

$stmt = $con->prepare("SELECT * from `rating` where  `userID` = ? and `cateID` = ? and productID = ?");
$stmt->execute(array($userID,$cateID,$productID));
$count = $stmt->rowCount();


if ($count > 0) {
    echo json_encode(array("status" => "suc"));
    $stmt = $con->prepare("UPDATE `rating` SET `rate`=? WHERE `userID`=?");
    $stmt->execute(array($rate, $userID));

    $stmt = $con->prepare("SELECT `cateName` from `category_table` where `cateID`= ?");
    $stmt->execute(array($cateID));
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $cateName = $data["cateName"];

    $stmt = $con->prepare("SELECT `#rate` from `$cateName` where `productID`= ?");
    $stmt->execute(array($productID));
    $rateN = $stmt->fetch(PDO::FETCH_ASSOC);

    $stmt = $con->prepare("SELECT `rate` from `$cateName` where `productID`= ?");
    $stmt->execute(array($productID));
    $rateP = $stmt->fetch(PDO::FETCH_ASSOC);
    $rateP['rate'] = (floatval($rateP['rate']) * floatval($rateN['#rate']) - floatval($oldrate));
    $result = (floatval($rateP['rate']) + floatval($rate)) / floatval($rateN['#rate']);
    $stmt = $con->prepare("UPDATE `$cateName` SET `rate`= $result WHERE `productID`=?");
    $stmt->execute(array($productID));
} else {
    $stmt = $con->prepare("INSERT INTO `rating`(`storeID`, `userID`, `productID`, `rate`, `cateID`) VALUES (?,?,?,?,?)");
    $stmt->execute(array($storeID, $userID, $productID, $rate, $cateID));
    $stmt = $con->prepare("SELECT `cateName` from `category_table` where `cateID`= ?");
    $stmt->execute(array($cateID));
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $cateName = $data["cateName"];

    $stmt = $con->prepare("UPDATE `$cateName` SET `#rate`= `#rate`+ 1 WHERE `productID`=?");
    $stmt->execute(array($productID));

    $stmt = $con->prepare("SELECT `#rate` from `$cateName` where `productID`= ?");
    $stmt->execute(array($productID));
    $rateN = $stmt->fetch(PDO::FETCH_ASSOC);

    $stmt = $con->prepare("SELECT `rate` from `$cateName` where `productID`= ?");
    $stmt->execute(array($productID));
    $rateP = $stmt->fetch(PDO::FETCH_ASSOC);
    $result = (floatval($rateP['rate'] * ($rateN['#rate'] - 1)) +floatval($rate)) / floatval($rateN['#rate']);
    $stmt = $con->prepare("UPDATE `$cateName` SET `rate`= $result WHERE `productID`=?");
    $stmt->execute(array($productID));
    echo json_encode(array("status" => "suc"));
}
