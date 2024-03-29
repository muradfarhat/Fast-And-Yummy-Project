// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';

const String linkServer = "http://10.0.2.2/Graduation-Project/php";
const String signUpLink = "$linkServer/auth/signup.php";
const String loginLink = "$linkServer/auth/signin.php";
const String forgetLink = "$linkServer/auth/forgetpass.php";
const String resetLink = "$linkServer/auth/reset.php";
const String afterSignupPage = "$linkServer/auth/afterSignup.php";
const String afterSignupChooseFavorite = "$linkServer/auth/chooseFavorite.php";
const String bringAllCate = "$linkServer/auth/bringAllCate.php";
const String bringUserFavCate = "$linkServer/auth/bringUserFav.php";
const String deleteFavorite = "$linkServer/auth/deleteFav.php";
const String getInfoLink = "$linkServer/userinfo/getinfo.php";
const String getInfoLinkDelivery = "$linkServer/userinfo/getDeliveryInfo.php";
const String getInfoFromUsers = "$linkServer/userinfo/getFromUserTable.php";
const String updatePers = "$linkServer/auth/updateprofiledata.php";
const String updateNameLink = "$linkServer/auth/updateName.php";
const String insertCreditCardInfo = "$linkServer/auth/insertCreditCard.php";
const String userCartLink = "$linkServer/userinfo/userCart.php";
const String personalDataAfterSignup =
    "$linkServer/auth/personalDataAfterSignup.php";
const String deliveryPersonalDataAfterSignup =
    "$linkServer/auth/deliveryPersonalData.php";
const String getfavlink = "$linkServer/userinfo/getfav.php";
const String visaLink = "$linkServer/userinfo/visa.php";
const String deleteILink = "$linkServer/userinfo/deleteImage.php";
const String imageULink = "$linkServer/userinfo/uploadImage.php";
const String policy =
    "If your website/app reaches users around the world, regardless of where you're located or headquartered, you'll need to make sure you follow privacy laws in all applicable countries you reach.While data protection and privacy laws differ from region to region, a Privacy Policy must comprehensively inform its users about how their data will be used. For example, the GDPR is currently the most robust privacy legislation in the world and one of its main requirements for any business that falls under its jurisdiction is to have a GDPR-compliant Privacy Policy that contains some very specific information and is written in an easy-to-understand way.";
const String imageRoot = "http://10.0.2.2/Graduation-Project/php/images";

const String orderCompleteLink = "$linkServer/userinfo/orderComplete.php";
// ignore: slash_for_doc_comments
/***************************** Start user pages links ********************** */
const String addSupportQuestion = "$linkServer/userPagePHP/addSupportQues.php";
const String deleteSupportQues =
    "$linkServer/userPagePHP/deleteSupportQuestion.php";
const String bringSupportQuestions =
    "$linkServer/userPagePHP/bringAllSupportQues.php";
const String bringUserFavProducts = "$linkServer/userPagePHP/userFavorite.php";
const String bringUserCartProducts = "$linkServer/userPagePHP/userCart.php";
const String bringUserMyOrdersProducts =
    "$linkServer/userPagePHP/userMyOrder.php";
const String bringProducts =
    "$linkServer/userPagePHP/bringProductFromCategory.php";
const String bringNameOfCate = "$linkServer/userPagePHP/bringcateName.php";
const String deleteFromUserFavoriteTable =
    "$linkServer/userPagePHP/deleteFromFavoriteTable.php";
const String deleteFromUserCartTable =
    "$linkServer/userPagePHP/deleteFromCartTable.php";
const String deleteFromMyOrderTable =
    "$linkServer/userPagePHP/deleteFromMyOrderTable.php";
const String addToUserFavoriteTable =
    "$linkServer/userPagePHP/addTofavoriteTable.php";
const String updateToCartTable =
    "$linkServer/userPagePHP/updateToCartTable.php";
/***************************** End user pages links ********************** */
///////////////store////////////////////
const String updateTown = "$linkServer/auth/updateTown.php";
const String updateCar = "$linkServer/auth/updateDeliveryCar.php";
const String haveStore = "$linkServer/store/haveStore.php";
const String storeInfo = "$linkServer/store/storeInfo.php";
const String storeImageLink = "$linkServer/store/storeImage.php";
const String storeNameLink = "$linkServer/store/storeName.php";
const String storesLink = "$linkServer/store/bringallstores.php";
const String deleteStoreLink = "$linkServer/store/deleteStore.php";
const String storeOrderLink = "$linkServer/store/storeOrder.php";
const String rejectOrderLink = "$linkServer/store/rejectOrder.php";
const String orderStateLink = "$linkServer/store/orderState.php";
const String readyOrderLink = "$linkServer/store/readyOrder.php";
/////////////endstore///////////////////////
///////////product///////////
const String bringProdectLink = "$linkServer/product/bringProdect.php";
const String addproductLink = "$linkServer/product/addproduct.php";
const String deleteproductLink = "$linkServer/product/deleteproduct.php";
const String editProductNameLink = "$linkServer/product/editProductName.php";
const String bringProductLink = "$linkServer/product/BringProduct.php";
const String editProductImageLink = "$linkServer/product/editProductImage.php";
const String editInfo = "$linkServer/product/editProductInfo.php";
const String commentLink = "$linkServer/product/comment.php";
const String bringCommentLink = "$linkServer/product/bringComment.php";
const String rateLink = "$linkServer/product/rate.php";
const String bringRateLink = "$linkServer/product/bringRate.php";
const String favLink = "$linkServer/product/bringIffav.php";
const String setfavLink = "$linkServer/product/setFav.php";
const String addToCartLink = "$linkServer/product/addToCart.php";
const String selectCateLink = "$linkServer/product/selectCate.php";
const String promotionLink = "$linkServer/product/promotion.php";

const String addPromotionLink = "$linkServer/product/addPromotion.php";
//////////////////////////////
/******************************* Delivery page api ***************** */
const String bringDeliveryReadyOrders =
    "$linkServer/deliveryPHP/bringOrders.php";
const String updateOrdersStatus =
    "$linkServer/deliveryPHP/updateOrderStatus.php";
const String userMapSetLocation = "$linkServer/userPagePHP/userMapLocation.php";
const String storeMapSetLocation =
    "$linkServer/userPagePHP/storeMapLocation.php";
const String bringDeliveryInfo =
    "$linkServer/deliveryPHP/bringDeliveryManInfo.php";
const String getDeliverName = "$linkServer/deliveryPHP/getDeliveryManName.php";
const String getDeliverActive = "$linkServer/deliveryPHP/getActiveDelivery.php";
const String setDeliverActive = "$linkServer/deliveryPHP/setActiveDelivery.php";
const String getAllDelivery = "$linkServer/deliveryPHP/bringAllDelivery.php";
const String setManID = "$linkServer/deliveryPHP/setID.php";
/******************************* Delivery page api ***************** */

const String recommendedULink =
    "$linkServer/recommendation/recommendedFromUsers.php";
const String populerLink = "$linkServer/recommendation/populer.php";

const String likedLink = "$linkServer/recommendation/recommendOnLike.php";

const String lastLink = "$linkServer/recommendation/lastPurchase.php";

const String earnLink = "$linkServer/userinfo/earnings.php";
