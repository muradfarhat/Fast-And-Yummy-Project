<?php
include "../connect.php";
$id = filtterreq("id");
$stmt =$con ->prepare("SELECT `visaName`, `visaNumber` , `visaDate` , `CVV` FROM `users` WHERE `id` = ?");
$stmt->execute(array($id)); 
$data = $stmt->fetch(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "suc" , "data"=>$data));
}else{
    echo json_encode(array("status"=>"failed"));
}