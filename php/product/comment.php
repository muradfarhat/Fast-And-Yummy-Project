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
    
    $stmt = $con->prepare("UPDATE `store` SET `feedBack`= `feedBack`+1 WHERE `storeID`=?");
$stmt->execute(array($storeID));
    echo json_encode(array("status" => "suc"));
} else {
    echo json_encode(array("status" => "failed"));
}
