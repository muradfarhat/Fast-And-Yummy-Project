<?php
include "../connect.php";
$tableName = filtterreq("tableName");
$stmt =$con ->prepare("SELECT * FROM `$tableName`");
$stmt->execute(); 
$data = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count > 0){
    echo json_encode(array("status" => "suc" , "data"=>$data));
}else{
    echo json_encode(array("status"=>"failed"));
}