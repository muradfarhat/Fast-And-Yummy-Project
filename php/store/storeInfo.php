<?php
include "../connect.php";
$id = filtterreq("id");

$stmt =$con ->prepare(" SELECT * FROM `store` where `storeID`= ? ");
$stmt->execute(array($id));     
$data= $stmt->fetch(PDO::FETCH_ASSOC);
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc","data"=>$data));
    
}else{
    echo json_encode(array("status"=>"failed"));
}