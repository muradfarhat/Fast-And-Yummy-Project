<?php
include "../connect.php";

$stmt =$con ->prepare("SELECT * FROM `users` WHERE `deliveryOrCustomer` = 'delivery'");
$stmt->execute();     
$user = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();
if($count>0){
    echo json_encode(array("status" => "suc", "data" => $user));
    
}else{
    echo json_encode(array("status"=>"failed"));
}