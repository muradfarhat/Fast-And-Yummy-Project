<?php
include "../connect.php";
$userID = filtterreq("userID");

$delete = $con ->prepare("DELETE FROM `favorite_cate` WHERE `userID` = '".$userID."'");
$delete->execute(); 
$count=$delete->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}