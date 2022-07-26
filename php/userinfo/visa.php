<?php
include "../connect.php";
$visaName = filtterreq("visaName");
$visaNumber = filtterreq("visaNumber");
$visaDate = filtterreq("visaDate");
$CVV = filtterreq("CVV");
$id = filtterreq("id");
$stmt =$con ->prepare("UPDATE `users` SET `visaName`= ?, `visaNumber`= ?,`visaDate`=?,`CVV`=? WHERE `id` = ?");
$stmt->execute(array($visaName,$visaNumber,$visaDate,$CVV,$id));     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc"));
    
}else{
    echo json_encode(array("status"=>"failed"));
}