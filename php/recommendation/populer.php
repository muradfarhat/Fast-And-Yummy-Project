<?php
include "../connect.php";
$stmt = $con->prepare("SELECT `cateName` FROM `category_table`");
$stmt->execute();
$data = $stmt ->fetchAll(PDO::FETCH_ASSOC);
$products=[];
for($i=0;$i<count($data);$i++){
    $cateName=$data[$i]['cateName'];
    $stmt = $con->prepare("SELECT * FROM `$cateName` WHERE `totalBuy` >= 20");
    $stmt->execute();
    $addProduct = $stmt ->fetchAll(PDO::FETCH_ASSOC);
    for($k=0;$k<count($addProduct);$k++){
        $xc = array_push($products, $addProduct[$k]);
}
}
for ($i = 0; $i < count($products); $i++) {
    for ($j = $i + 1; $j < count($products); $j++) {
        $tmp = 0;
        if ($products[$i]['totalBuy'] < $products[$j]['totalBuy']) {
            $tmp = $products[$i];
            $products[$i] = $products[$j];
            $products[$j] = $tmp;
        }
    }
}
echo json_encode(array("populer"=>$products));