<?php
define('MB', 1048576);
function filtterreq($reqName)
{
    return htmlspecialchars(strip_tags($_POST[$reqName]));
}
function imageUpload($imageReq)
{
    global $msgError;

    $imageName = rand(1000,10000).$_FILES[$imageReq]['name'];
    $imageTmp = $_FILES[$imageReq]['tmp_name'];
    $imageSize = $_FILES[$imageReq]['size'];
    $allowExt = array('jpg', 'png', 'jpeg', 'gif');
    $strToArray = explode(".", $imageName);
    $ext = end($strToArray);
    $ext = strtolower($ext);
    if (!empty($imageName) && !in_array($ext, $allowExt)) {
        $msgError[] = "Not allow";
    }
    if ($imageSize > 2 * MB) {
        $msgError[] = "Size Error";
    }
    if (empty($msgError)) {
        move_uploaded_file($imageTmp, "../images/" . $imageName);
        return $imageName;
    } else {
        return "Faild";
    }
}
function deleteImage($dir,$imageName){
    if(file_exists($dir."/" . $imageName)){
        unlink($dir."/".$imageName);
    }
}
