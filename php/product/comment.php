<?php
include "../connect.php";
$storeID = filtterreq('storeID');
$userID = filtterreq('userID');
$productID = filtterreq('productID');
$userName = filtterreq('userName');
$comment = filtterreq('comment');
$cateID = filtterreq('cateID');

$stmt = $con->prepare("INSERT INTO `feedback`(`storeID`, `userID`, `productID`, `userName`, `comment`, `cateID`) VALUES (?,?,?,?,?,?)");
$stmt->execute(array($storeID,$userID,$productID,$userName,$comment,$cateID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
