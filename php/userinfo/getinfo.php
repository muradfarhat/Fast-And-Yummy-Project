<?php
include "../connect.php";
$id = filtterreq("id");

$stmt =$con ->prepare(" SELECT * FROM users where `id`= ? ");
$stmt->execute(array($id));     
$data= $stmt->fetch(PDO::FETCH_ASSOC);
$count=$stmt->rowCount();
$stmt2 =$con ->prepare(" SELECT * FROM customer_info where `userID`= ? ");
$stmt2->execute(array($id));     
$data2= $stmt2->fetch(PDO::FETCH_ASSOC);
$count=$stmt2->rowCount();



if($count>0){
    echo json_encode(array("status" => "suc","data"=>$data,"data2"=>$data2));
    
}else{
    echo json_encode(array("status"=>"failed"));
}