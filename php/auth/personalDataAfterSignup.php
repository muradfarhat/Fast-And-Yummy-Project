<?php
include "../connect.php";
$city = filtterreq("city");
$town = filtterreq("town");
$street = filtterreq("street");
$id = filtterreq("id");

$stmt =$con ->prepare("INSERT INTO `customer_info`(`city`, `town`, `street`, `userID`) VALUES ('".$city."','".$town."','".$street."','".$id."')");
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}