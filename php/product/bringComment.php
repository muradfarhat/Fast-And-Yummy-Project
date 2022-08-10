<?php
include "../connect.php";
$productID = filtterreq("productID");
$stmt =$con ->prepare("SELECT * FROM `feedBack` WHERE productID = ?");
$stmt->execute(array($productID)); 
$data = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "suc" , "data"=>$data));
}else{
    echo json_encode(array("status"=>"failed"));
}