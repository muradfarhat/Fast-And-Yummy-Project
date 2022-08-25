
<?php
include "../connect.php";
$id = filtterreq("id");
$storeID = filtterreq("storeID");
$earn = filtterreq("earn");
$stmt =$con ->prepare("UPDATE `myorders_table` SET `receipt`='yes' WHERE `id`=$id ");
$stmt->execute();     
$count=$stmt->rowCount();
$float_value_of_var = floatval($earn);
$rate = $earn * 0.2;
$stmt =$con ->prepare("UPDATE `store` SET `earrings`=`earrings`+($earn - $rate) WHERE `storeID`=$storeID ");
$stmt->execute();     
$count=$stmt->rowCount();
$stmt =$con ->prepare("UPDATE `admin` SET `earnings`=`earnings`+$rate WHERE `id`= 1 ");
$stmt->execute();     
$count=$stmt->rowCount();

if($count>0){
    echo json_encode(array("status" => "suc","rate"=>$rate));
    
}else{
    echo json_encode(array("status"=>"failed"));
}
