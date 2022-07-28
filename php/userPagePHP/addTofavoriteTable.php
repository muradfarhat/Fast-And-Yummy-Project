<?php
include "../connect.php";
$userID = filtterreq("userID");
$orderID = filtterreq("orderID");
$cateID = filtterreq("cateID");

$delete = $con ->prepare("INSERT INTO `favoritetable`(`userID`, `orderID`, `cateID`) VALUES ('$userID','$orderID','$cateID')");
$delete->execute(); 
$count=$delete->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}