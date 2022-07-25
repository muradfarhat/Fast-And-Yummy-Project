<?php
include "../connect.php";
$first_name = filtterreq("first_name");
$last_name = filtterreq("last_name");
$id = filtterreq("id");
$stmt =$con ->prepare("UPDATE `users` SET `first_name`= ?, `last_name`= ? WHERE `id` = ?");
$stmt->execute(array($first_name,$last_name,$id)); 
$count=$stmt->rowCount();
if($count>0 ){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}