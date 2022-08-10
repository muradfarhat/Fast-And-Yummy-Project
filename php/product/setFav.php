<?php
include "../connect.php";

$userID = filtterreq('userID');
$orderID = filtterreq('orderID');
$cateID = filtterreq('cateID');

$stmt = $con->prepare("SELECT * from `favoritetable` where `userID`= ?");
$stmt->execute(array($userID));
$count = $stmt->rowCount();
if ($count > 0) {
    $stmt = $con->prepare("DELETE FROM `favoritetable` WHERE `userID` = ? and `cateID` = ? and orderID = ?");
    $stmt->execute(array( $userID, $cateID,$orderID));
    echo json_encode(array("status" => "suc"));
} else {
    $stmt = $con->prepare("INSERT INTO `favoritetable`(`orderID`, `userID`, `cateID`) VALUES (?,?,?)");
    $stmt->execute(array($orderID, $userID, $cateID));
    echo json_encode(array("status" => "سشي"));
}
