
<?php
include "../connect.php";
$id = filtterreq("id");
$question = filtterreq("question");

$stmt =$con ->prepare("INSERT INTO `support`(`userID`, `question`) VALUES ('$id','$question')");
$stmt->execute();     
$user = $stmt->fetchAll(PDO::FETCH_ASSOC); 
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc", "data" => $user));
    
}else{
    echo json_encode(array("status"=>"failed"));
}