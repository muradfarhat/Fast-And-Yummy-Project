<?php
include "../connect.php";
$deliveryOrCustomer = filtterreq("deliveryOrCustomer");
$email = filtterreq("email");

$stmt =$con ->prepare("UPDATE `users` SET `deliveryOrCustomer`='".$deliveryOrCustomer."' WHERE `email` = '".$email."'");
$stmt->execute(); 
$count=$stmt->rowCount();
$stmt2 = $con -> prepare("SELECT * FROM `users` WHERE `email`='$email'");
$stmt2->execute();     
$count2=$stmt2->rowCount();
$user = $stmt2 ->fetchAll(PDO::FETCH_ASSOC); 
if($count>0 && $count2 > 0){
    echo json_encode(array("status" => "suc",'data'=>$user[0]['id']));
    
}else{
    echo json_encode(array("status"=>"failed"));
}