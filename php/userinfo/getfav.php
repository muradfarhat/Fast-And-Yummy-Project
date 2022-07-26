<?php
include "../connect.php";
$userID = filtterreq("userID");

$stmt =$con ->prepare(" SELECT `cateName` FROM favorite_cate where `userID`= ? ");
$stmt->execute(array($userID));     
$data= $stmt->fetchAll(PDO::FETCH_ASSOC);
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc","data"=>$data));
}else{
    echo json_encode(array("status"=>"failed"));
}