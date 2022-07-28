<?php
include "../connect.php";
$city = filtterreq("city");
$town = filtterreq("town");
$street = filtterreq("street");
$userID = filtterreq("userID");

$stmt =$con ->prepare("UPDATE `customer_info` SET `city`=?,`town`=?,`street`=? WHERE `userID` = ?");
$stmt->execute(array($city,$town,$street,$userID)); 
$count=$stmt->rowCount();
if($count > 0){
    echo json_encode(array("status" => "suc"));
}else{
    echo json_encode(array("status"=>"failed"));
}