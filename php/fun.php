<?php
function filtterreq($reqName){
    return htmlspecialchars(strip_tags($_POST[$reqName]));
}