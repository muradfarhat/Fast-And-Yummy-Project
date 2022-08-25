
<?php
include "../connect.php";
$userID = filtterreq("userID");
$stmt = $con->prepare("SELECT * FROM `rating` where `userID` != ? GROUP BY userID");
$stmt->execute(array($userID));
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
$rcount = $stmt->rowCount();
$sUsers = [];
$rProducts = [];
for ($i = 0; $i < count($users); $i++) {
    $count = 0;
    $user = $users[$i]['userID'];
    $stmt = $con->prepare(" SELECT * from `rating` WHERE `userID`=$user and
     `productID` in(SELECT `productID` from `rating` where `userID`=$userID) 
     and `cateID` in(SELECT `cateID` from `rating` where `userID`=$userID) 
     or `rate` in (SELECT `rate`-1 from `rating` where `userID`=$userID)
     and(`rate` in (SELECT `rate`-0.5 from `rating` where `userID`=$userID) 
     or `rate` in (SELECT `rate` from `rating` where `userID`=$userID) 
     or `rate` in (SELECT `rate`+0.5 from `rating` where `userID`=$userID)
     or `rate` in (SELECT `rate`+1 from `rating` where `userID`=$userID))");
    $stmt->execute();
    $simProduct = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (count($simProduct) != 0) {
        $count = count($simProduct);
        $xc = array_push($sUsers, array("userid" => $user, "count" => $count));
    }
}
////sort for priority
for ($i = 0; $i < count($sUsers); $i++) {
    for ($j = $i + 1; $j < count($sUsers); $j++) {
        $tmp = 0;
        if ($sUsers[$i]['count'] < $sUsers[$j]['count']) {
            $tmp = $sUsers[$i];
            $sUsers[$i] = $sUsers[$j];
            $sUsers[$j] = $tmp;
        }
    }
}
/////start recommend from similer useres depend on priority
$recommended = [];
$recommendedProduct = [];
for ($i = 0; $i < count($sUsers); $i++) {
    $sUserid = $sUsers[$i]['userid'];
    $stmt = $con->prepare("SELECT *from `rating` where `userID`=$sUserid
     and (`productID` not in (select `productID` FROM `rating` where `userID`=$userID)
      or `cateID` not in (select `cateID` FROM `rating` where `userID`=$userID) )
       and `rate`>=3 ORDER BY `rate` DESC");
    $stmt->execute();
    $addToRecommended = $stmt->fetchAll(PDO::FETCH_ASSOC);
    for ($k = 0; $k < count($addToRecommended); $k++) {
        $xc = array_push($recommended, $addToRecommended[$k]);
    }
}

$stmt = $con->prepare("SELECT * FROM `promotion_table` where `storeID`!=$userID and `status`!= 'wait'");
$stmt->execute(array($userID));
$promotion = $stmt->fetchAll(PDO::FETCH_ASSOC);
$rxcount = $stmt->rowCount();
if($rxcount>0){
    for ($i = 0; $i < count($promotion); $i++) {
        $id = $promotion[$i]['cateID'];
        $stmt = $con->prepare("SELECT `cateName` FROM `category_table` WHERE `cateID` = $id");
        $stmt->execute();
        $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
        $id3 = $promotion[$i]['storeID'];
        $id4 = $promotion[$i]['productID'];
        $cate = $cateName["cateName"];
        $stmt = $con->prepare("SELECT * FROM `$cate` WHERE `userID` = $id3 and `productID`= $id4");
        $stmt->execute();
        $proudct = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $cx = array_push($recommendedProduct, $proudct[0]);
    }
   
}

for ($i = 0; $i < count($recommended); $i++) {
    $id = $recommended[$i]['cateID'];
    $stmt = $con->prepare("SELECT `cateName` FROM `category_table` WHERE `cateID` = $id");
    $stmt->execute();
    $cateName = $stmt->fetch(PDO::FETCH_ASSOC);
    $id3 = $recommended[$i]['storeID'];
    $id4 = $recommended[$i]['productID'];
    $cate = $cateName["cateName"];
    $stmt = $con->prepare("SELECT * FROM `$cate` WHERE `userID` = $id3 and `productID`= $id4");
    $stmt->execute();
    $proudct = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if(!in_array($proudct[0], $recommendedProduct))
    {$cx = array_push($recommendedProduct, $proudct[0]);}
}

if (count($recommendedProduct) != 0 && $rcount > 0) {
    echo json_encode(array("stat" => "suc", "Recommendation" => $recommendedProduct));
} else {
    echo json_encode(array("status" => "fail"));
    
}
