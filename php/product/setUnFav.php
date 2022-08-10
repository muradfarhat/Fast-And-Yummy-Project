<?php
include "../connect.php";

$userID = filtterreq('userID');
$productID = filtterreq('productID');
$cateID = filtterreq('cateID');

$stmt = $con->prepare("INSERT INTO `favoritetable`(`storeID`, `userID`, `productID`, `userName`, `comment`, `cateID`) VALUES (?,?,?,?,?,?)");
$stmt->execute(array($storeID,$userID,$productID,$userName,$comment,$cateID));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
