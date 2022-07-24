<?php
include "../connect.php";
$cateID = filtterreq("cateID");
$userID = filtterreq("userID");
$cateName = filtterreq("cateName");

$stmt =$con ->prepare("INSERT INTO `favorite_cate`(`cateID`, `userID`, `cateName`) VALUES ('".$cateID."','".$userID."','".$cateName."')");
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}