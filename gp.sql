-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 07, 2022 at 11:07 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `visaName` varchar(255) NOT NULL,
  `visaNum` varchar(255) NOT NULL,
  `visaDate` varchar(255) NOT NULL,
  `cvv` varchar(255) NOT NULL,
  `earnings` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `pass`, `fullName`, `visaName`, `visaNum`, `visaDate`, `cvv`, `earnings`) VALUES
(1, 'raedkh3.2000@gmail.com', 'raedraed', 'Ra\'ed Khwayreh', 'ali', '4562456245624562', '02/25', '533', 457.80000000000007);

-- --------------------------------------------------------

--
-- Table structure for table `appetizers`
--

CREATE TABLE `appetizers` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appetizers`
--

INSERT INTO `appetizers` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(20, 'Vegetable soup', 'Tasty Shack', 0, 11, 7, 5, 23, '5228image_picker5394853224839517802.jpg', 'vegetable', 'Nice vegetable soup', 0),
(21, 'Crinkle fries', 'Tasty Shack', 0, 11, 7, 3, 26, '7001image_picker5376022893475930292.jpg', 'potato,papper', 'Nice crinkle fries', 0),
(22, 'Cheese potato', 'Tasty Shack', 4, 11, 7, 3, 37, '1106image_picker1265084276266026222.jpg', 'cheese,potato', 'Delishes cheese potato', 1),
(23, 'Salad', 'Tasty Shack', 0, 11, 7, 4, 23, '3153image_picker1320706004201307808.jpg', 'tomato,cucumber,onion', 'Salads with tomato, cucumber, salad and onion', 0),
(24, 'Potato', 'Tasty Shack', 0, 11, 7, 2, 19, '4804image_picker3445151758931296523.jpg', 'potato', 'Potato with salt', 0);

-- --------------------------------------------------------

--
-- Table structure for table `cart_table`
--

CREATE TABLE `cart_table` (
  `id` int(11) NOT NULL,
  `orderID` varchar(255) NOT NULL,
  `cateID` varchar(255) NOT NULL,
  `userID` varchar(255) NOT NULL,
  `storeID` int(11) NOT NULL,
  `quantity` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart_table`
--

INSERT INTO `cart_table` (`id`, `orderID`, `cateID`, `userID`, `storeID`, `quantity`) VALUES
(35, '13', '1', '15', 11, '1.0'),
(36, '23', '3', '19', 11, '1.0'),
(37, '22', '6', '29', 15, '1.0'),
(39, '24', '6', '18', 15, '1.0');

-- --------------------------------------------------------

--
-- Table structure for table `category_table`
--

CREATE TABLE `category_table` (
  `cateID` int(11) NOT NULL,
  `cateName` varchar(255) NOT NULL,
  `cateImage` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category_table`
--

INSERT INTO `category_table` (`cateID`, `cateName`, `cateImage`) VALUES
(1, 'Meats', 'meats.jpeg'),
(2, 'Chicken', 'chicken.jpeg'),
(3, 'Fast Food', 'fast_food.jpg'),
(6, 'Traditional', 'traditional.jpg'),
(7, 'Appetizers', 'appetizers.png'),
(8, 'Drinks', 'drinks.jpg'),
(9, 'Sweet', 'sweets.jpg'),
(10, 'Milkshakes', 'milkshakes.jpg'),
(13, 'NewCate', 'food.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `chicken`
--

CREATE TABLE `chicken` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chicken`
--

INSERT INTO `chicken` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(16, 'Lemon Pepper Chicken', 'Tasty Shack', 4.25, 11, 2, 25, 20, '8399image_picker5621658755945993029.jpg', 'chicken thighs,Tbsp lemon pepper ,cooking oil,cloves garlic,chicken broth', 'Lemon Pepper Chicken with Orzo is a zesty one-pot meal featuring juicy chicken thighs, orzo, feta, and lemon pepper for tons of flavor!', 2),
(17, 'Alfredo', 'Tasty Shack', 5, 11, 2, 16, 25, '7046image_picker6889306659762465126.jpg', 'boneless, skinless c,Italian seasoning,cooking oil ,fettuccine', 'This Chicken Alfredo features pasta drenched in an ultra-rich and creamy sauce, topped with juicy strips of seared chicken.', 1),
(18, 'Teriyaki Chicken', 'Tasty Shack', 4, 11, 2, 12, 19, '7821image_picker2533024371898756400.jpg', 'soy sauce, brown sugar,water ,clove garlic, minced,boneless, skinless', 'This Easy Teriyaki Chicken is perfect for quick weeknight dinners, and has the most delicious salty, sweet, and savory flavor!', 1),
(19, 'Chicken kebabs', 'Tasty Shack', 3.5, 11, 2, 15, 30, '2833image_picker1388577325207205523.jpg', 'red onions ,pineapple ,Chicken Breasts, smoked paprika', 'These easy and delicious BBQ Chicken Kebabs combine chicken, pineapple, onion, and BBQ sauce for a fresh and easy summer BBQ main dish.', 2),
(20, 'Pesto Chicken', 'Tasty Shack', 5, 11, 2, 19, 25, '2711image_picker6793166149018015910.jpg', 'cooked chicken,fresh broccoli ,mayonnaise ,basil pesto', 'Chicken, broccoli, onion, and a creamy pesto dressing make this quick salad a delicious new lunchtime staple!', 1),
(21, 'Chicken Pizza', 'Tasty Shack', 4, 11, 2, 16, 40, '9286image_picker1541702567071592400.jpg', 'chicken breasts,olive oil,prepared pesto,large tomato', 'About Chicken Pizza Recipe: An Italian favorite, this chicken pizza recipe is a delicious mix of flat bread or base topped with cheese, chillies, onion, garlic sauce and chunks of chicken. Tossed to perfection, this quick and easy pizza recipe.', 2);

-- --------------------------------------------------------

--
-- Table structure for table `customer_info`
--

CREATE TABLE `customer_info` (
  `userID` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `town` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_info`
--

INSERT INTO `customer_info` (`userID`, `city`, `town`, `street`) VALUES
(15, 'Nablus', 'Balata', 'Amman Street'),
(11, 'Nablus', 'Nablus', 'Faisl Street'),
(17, 'Nablus', 'Rafedia', 'Rafedia'),
(18, 'Nablus', 'Makhfia', 'University street'),
(19, 'Nablus', 'Rafedia', '24 Street'),
(20, 'Nablus', 'Balata', 'Balata street'),
(35, 'Nablus', 'Nablus', 'Amman Street');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_info`
--

CREATE TABLE `delivery_info` (
  `userID` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `carModel` varchar(255) NOT NULL,
  `carNumber` varchar(255) NOT NULL,
  `deliveryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery_info`
--

INSERT INTO `delivery_info` (`userID`, `city`, `carModel`, `carNumber`, `deliveryID`) VALUES
(16, 'Nablus', 'Opel', '4645213', 406872314),
(21, 'Nablus', 'Fiat', '7894562', 906702348),
(23, 'Rammalh', 'motorcycle', '7945621', 402301234);

-- --------------------------------------------------------

--
-- Table structure for table `drinks`
--

CREATE TABLE `drinks` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `drinks`
--

INSERT INTO `drinks` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(20, 'Mirinda', 'Tasty Shack', 4.5, 11, 8, 1, 5, '5137image_picker8418268381651553057.jpg', 'cola', 'No description', 1),
(21, 'Pepsi', 'Tasty Shack', 3.5, 11, 8, 1, 6, '9396image_picker6492606271335168306.jpg', 'cola', 'No description', 1),
(22, 'Orange juice', 'Tasty Shack', 4, 11, 8, 2, 0, '8867image_picker8416300984246341723.jpg', 'orange', 'No description', 2),
(23, 'Fresh juice', 'Tasty Shack', 0, 11, 8, 3, 23, '1932image_picker5845168289406223987.jpg', 'Fresh fruit', 'No description', 0),
(24, 'Sprite', 'Tasty Shack', 0, 11, 8, 1, 5, '8071image_picker913955526042484429.jpg', 'cola', 'No description', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fast food`
--

CREATE TABLE `fast food` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fast food`
--

INSERT INTO `fast food` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(20, 'Cheese Pizza', 'Tasty Shack', 0, 11, 3, 9.5, 25, '7988image_picker1413927611251438597.jpg', 'pizza sauce,provolone cheese,mozzarella ,grated parmesan ', 'A classic cheese pizza is the ultimate crowd-pleaser. The delicious combination of crispy pizza crust, flavorful tomato sauce, and bubbly cheese make for an unbeatable combination. Even if you\'re a fan of unique toppings, it\'s hard to resist a slice ', 0),
(21, 'Veggie Pizza', 'Tasty Shack', 0, 11, 3, 12, 35, '9850image_picker4444041850095459956.jpg', 'pizza sauce,mozzarella cheese,canned artichoke', 'This vegetarian pizza recipe will delight vegetarians and carnivores alike. It\'s fresh and full of flavor, featuring cherry tomatoes, artichoke, bell pepper, olives, red onion and some hidden (and optional) baby spinach. You\'ll find a base of rich to', 0),
(22, 'Elk Burgers', 'Tasty Shack', 0, 11, 3, 12, 41, '7805image_picker8742229695617944043.jpg', 'salt,black pepper, grated butter,Pepper Jack cheese', 'Elk meat is a lean meat that is milk, tender and flavorful. It works well in many cooking applications such as elk meatloaf, elk burgers, elk burger meatballs and elk stroganoff', 0),
(23, 'Mushroom Burgers', 'Tasty Shack', 0, 11, 3, 17, 29, '5854image_picker7661629843129638072.jpg', ' mushrooms,lightly beaten,bread crumbs,cheddar cheese,dried thyme,burger buns', 'Big, juicy Swiss Mushrooms Burgers are a mighty vegetarian burger that at first glance, looks like a beef burger! Large mushrooms are roasted with garlic butter, topped with Swiss cheese then stuffed into fully loaded soft rolls', 0),
(25, 'Pizza', 'Hello', 0, 35, 3, 5, 0, '3978image_picker634850181240614420.jpg', 'cheese', 'No description', 0);

-- --------------------------------------------------------

--
-- Table structure for table `favoritetable`
--

CREATE TABLE `favoritetable` (
  `id` int(11) NOT NULL,
  `userID` varchar(255) NOT NULL,
  `orderID` varchar(255) NOT NULL,
  `cateID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favoritetable`
--

INSERT INTO `favoritetable` (`id`, `userID`, `orderID`, `cateID`) VALUES
(86, '11', '9', '3'),
(87, '15', '13', '1'),
(88, '11', '13', '1'),
(89, '11', '15', '3'),
(91, '20', '20', '2'),
(92, '29', '22', '6'),
(93, '18', '24', '6');

-- --------------------------------------------------------

--
-- Table structure for table `favorite_cate`
--

CREATE TABLE `favorite_cate` (
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `cateName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorite_cate`
--

INSERT INTO `favorite_cate` (`userID`, `cateID`, `cateName`) VALUES
(17, 1, 'Meats'),
(17, 3, 'Fast Food'),
(17, 2, 'Chicken'),
(17, 10, 'Milkshakes'),
(18, 9, 'Sweets'),
(18, 8, 'Drinks'),
(18, 10, 'Milkshakes'),
(18, 6, 'Traditional'),
(19, 1, 'Meats'),
(19, 3, 'Fast Food'),
(19, 6, 'Traditional'),
(19, 9, 'Sweets'),
(19, 10, 'Milkshakes'),
(20, 7, 'Appetizers'),
(20, 8, 'Drinks'),
(20, 9, 'Sweets'),
(20, 3, 'Fast Food'),
(35, 1, 'Meats'),
(35, 2, 'Chicken'),
(35, 6, 'Traditional');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `storeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `cateID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `storeID`, `userID`, `productID`, `userName`, `comment`, `cateID`) VALUES
(39, 11, 35, 13, 'Ra\'ed  Khwayerh', 'Nice', 1),
(40, 15, 35, 21, 'Ra\'ed  Khwayerh', 'Nice', 6);

-- --------------------------------------------------------

--
-- Table structure for table `meats`
--

CREATE TABLE `meats` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `content` varchar(255) NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `meats`
--

INSERT INTO `meats` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `description`, `content`, `#rate`) VALUES
(8, 'Salt-and-Pepper Steak', 'Tasty Shack', 4.5, 11, 1, 25, 15, '1070image_picker3460210925225885857.png', 'This &quot;salt and pepper&quot; grilled skirt steak recipe is so easy because the seasonings are so simple. Skirt steak is such a juicy, flavorful cut of beef ', 'soy sauce,cloves garlic,white pepper,cayenne pepper,vegetable oil', 1),
(9, 'Chicken Schnitzel', 'Tasty Shack', 4, 11, 1, 12, 28, '1272image_picker8730179206117641618.jpg', 'A layer of crunchy breadcrumbs spiked with sharp parmesan cheese and parsley, wrapped around tender chicken breast. This is is your new go-to guide for how to cook succulent chicken schnitzel. K. Kim Coverdale. 529 calories per serv', 'ounce skinless,black pepper,cup all-purpose flou,large eggs', 4),
(10, 'Grilled Flatiron Steak', 'Tasty Shack', 0, 11, 1, 20, 35, '1896image_picker1259736422704666228.jpg', 'Flat iron steak is tender, which is why is it becoming more and more popular; some say it is the second-most tender steak on an animal, after the tenderloin (filet mignon). I find it to be every bit as tender as the backstrap (ribeye), but not nearly', 'flat iron steaks,black pepper,squeezed lemon', 0),
(11, 'Bistro Steak', 'Tasty Shack', 3.5, 11, 1, 25, 21, '8504image_picker393181815395927507.jpg', 'Bistro rump is taken from the most tender part of the rump and is highly trimmed to produce a tender, flavoursome steak. It is slightly smaller than the prime rump steaks taken from the centre rump', 'teaspoon pepper,teaspoon salt,Olive oil,cup heavy cream', 1),
(12, 'Steack tacos', 'Tasty Shack', 4.3333333333333, 11, 1, 18, 19, '2210image_picker3786475129702826381.jpg', 'The BEST Steak Tacos recipe! Steak pieces are soaked in a simple lime and ancho chili seasoned marinade and quickly pan seared in a super hot skillet until just perfectly browned. From there it\'s layered on tortillas and finished with your favorite ', ' fresh lime juice,olive oil,honey,minced garlic', 3),
(13, 'Beef Burgers', 'Tasty Shack', 4.5, 11, 1, 14, 31, '8929image_picker8190442248957119323.jpg', 'Tasty, delicious, and has me craving more on the first bite.” to “Juicy, mouthwatering, tasty, and everything you\'d ever want to savor.', 'small onion,beef mince,burger buns,egg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `milkshakes`
--

CREATE TABLE `milkshakes` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `milkshakes`
--

INSERT INTO `milkshakes` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(20, 'Nutella milkshake ', 'Shake House', 4, 17, 10, 6, 25, '4844image_picker2310338285873310062.jpg', 'milk,nutella', 'milkshake with nutella', 6),
(21, 'Peanut Butter Milkshake ', 'Shake House', 0, 17, 10, 6, 23, '7361image_picker6788286731021450485.jpg', 'peanut,milk,ice cream', 'No description', 0),
(22, 'Strawberry Milkshake', 'Shake House', 0, 17, 10, 8, 31, '7991image_picker2508115294660923615.jpg', 'strawberry,milk,ice cream', 'no description', 0),
(23, 'Vanilla Milkshake', 'Shake House', 0, 17, 10, 6, 15, '9572image_picker6107953537295876318.jpg', 'vanilla,ice cream,milk', 'no description', 0),
(24, 'Banana Milkshake', 'Shake House', 0, 17, 10, 6, 18, '7005image_picker5280107703154993358.jpg', 'milk,banana,ice cream', 'no description', 0),
(25, 'Chocolate Milkshake', 'Shake House', 0, 17, 10, 7, 22, '7330image_picker7303553020449103958.jpg', 'chocolate,milk,ice cream', 'no description', 0),
(26, 'Cookies Milkshake', 'Shake House', 3.5, 17, 10, 8, 27, '7960image_picker3630990389211316409.jpg', 'Cookies,cream,ice cream,milk', 'no description', 1),
(27, 'Lotus milkshake', 'Shake House', 4, 17, 10, 8, 23, '6496image_picker4779584222167345092.jpg', 'lotus,ice cream,milk', 'No description', 1),
(28, 'Chikoo Milkshake', 'Shake House', 4.25, 17, 10, 6, 25, '2765image_picker7796218063112184208.jpg', 'Chikoo,milk', 'no description', 2),
(29, 'Berry Milkshake', 'Shake House', 0, 17, 10, 7.5, 11, '5472image_picker681603268506380798.jpg', 'Berry ,milk,ice cream', 'no description', 0),
(30, 'Cheesecakes', 'Shake House', 0, 17, 10, 6, 21, '8827image_picker5537235711396147452.jpg', 'blueberry', 'no description', 0);

-- --------------------------------------------------------

--
-- Table structure for table `myorders_table`
--

CREATE TABLE `myorders_table` (
  `id` int(11) NOT NULL,
  `orderID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `storeID` int(11) NOT NULL,
  `deliveryManID` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `cityLocation` varchar(255) NOT NULL,
  `receipt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `myorders_table`
--

INSERT INTO `myorders_table` (`id`, `orderID`, `cateID`, `userID`, `storeID`, `deliveryManID`, `quantity`, `status`, `latitude`, `longitude`, `cityLocation`, `receipt`) VALUES
(34, 24, 9, 19, 17, '21', 1, 'deliverd', '32.221330294412596', '35.2485666051507', 'Nablus', 'no'),
(35, 18, 2, 18, 11, '16', 1, 'In delivery', '32.22599097756793', '35.218943282961845', 'Nablus', 'yes'),
(38, 23, 9, 11, 17, '16', 1, 'deliverd', '32.217216260152696', '35.270296186208725', 'Nablus', 'yes'),
(41, 17, 2, 35, 11, '16', 1, 'In delivery', '32.23421863288991', '35.23556426167488', 'Nablus', 'no'),
(43, 11, 1, 35, 11, '16', 1, 'deliverd', '32.23532070208459', '35.24377182126045', 'Nablus', 'yes'),
(44, 21, 3, 35, 11, '21', 1, 'deliverd', '32.2328683', '35.2556217', 'Nablus', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `newcate`
--

CREATE TABLE `newcate` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `promotion_table`
--

CREATE TABLE `promotion_table` (
  `id` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `storeID` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `duration` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `promotion_table`
--

INSERT INTO `promotion_table` (`id`, `productID`, `cateID`, `storeID`, `status`, `duration`) VALUES
(28, 25, 3, 35, 'Active', 'Week');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `id` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `storeID` int(11) NOT NULL,
  `rate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`id`, `productID`, `cateID`, `userID`, `storeID`, `rate`) VALUES
(83, 24, 6, 18, 15, 4),
(84, 24, 9, 18, 17, 4.5),
(85, 9, 1, 18, 11, 4),
(86, 11, 1, 18, 11, 3.5),
(87, 21, 6, 18, 15, 4.5),
(88, 9, 1, 17, 11, 5),
(89, 9, 1, 15, 11, 4.5),
(90, 20, 8, 15, 11, 4.5),
(91, 22, 8, 15, 11, 4.5),
(92, 20, 10, 15, 17, 4.5),
(93, 12, 1, 15, 11, 4.5),
(94, 20, 10, 17, 17, 5),
(95, 21, 6, 15, 15, 4.5),
(96, 27, 10, 15, 17, 4),
(97, 26, 10, 15, 17, 3.5),
(98, 22, 7, 15, 11, 4),
(99, 21, 6, 17, 15, 5),
(100, 20, 10, 18, 17, 4.5),
(101, 16, 2, 19, 11, 4),
(102, 8, 1, 19, 11, 4.5),
(103, 13, 1, 19, 11, 4.5),
(104, 22, 9, 19, 17, 4.5),
(105, 25, 9, 19, 17, 5),
(106, 26, 9, 19, 17, 3.5),
(107, 26, 9, 17, 17, 5),
(108, 25, 9, 17, 17, 5),
(109, 22, 9, 17, 17, 5),
(110, 23, 9, 17, 17, 4.5),
(111, 21, 8, 17, 11, 3.5),
(112, 19, 2, 18, 11, 3.5),
(113, 16, 2, 18, 11, 4.5),
(121, 21, 6, 35, 15, 4.5),
(122, 20, 10, 35, 17, 4.5),
(123, 12, 1, 35, 11, 4.5),
(124, 22, 8, 35, 11, 4.5);

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `storeID` int(11) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `storeImage` varchar(255) NOT NULL,
  `earrings` double NOT NULL,
  `numberOfProducts` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `feedBack` int(11) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `cityLocation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`storeID`, `storeName`, `storeImage`, `earrings`, `numberOfProducts`, `rating`, `feedBack`, `latitude`, `longitude`, `cityLocation`) VALUES
(11, 'Tasty Shack', '9475image_picker7437479427388067987.png', 325.25, 26, 0, 1, '32.21297', '35.2798717', 'Nablus'),
(15, 'Bait al kel', '3855image_picker2862655545798383610.jpg', 176.4, 8, 0, 3, '32.2226667', '35.262145', 'Nablus'),
(17, 'Shake House', '1381image_picker2129350857615357832.jpg', 17.6, 20, 0, 2, '32.2244', '35.247055', 'Nablus'),
(18, 'Store Name235', '6028image_picker7750385151095990605.jpg', 0, 0, 0, 0, '32.22664757237873', '35.25468807667494', 'Nablus'),
(35, 'Hello', '4762image_picker1547122055269777827.jpg', 0, 1, 0, 0, '32.233744166148284', '35.25229688733816', 'Nablus');

-- --------------------------------------------------------

--
-- Table structure for table `support`
--

CREATE TABLE `support` (
  `questionID` int(11) NOT NULL,
  `userID` varchar(255) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `support`
--

INSERT INTO `support` (`questionID`, `userID`, `question`, `answer`) VALUES
(4, '11', 'I have problem', 'check it again'),
(5, '11', 'There is a problem', 'no problem');

-- --------------------------------------------------------

--
-- Table structure for table `sweet`
--

CREATE TABLE `sweet` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sweet`
--

INSERT INTO `sweet` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(22, 'Pies and cobblers', 'Shake House', 4.5, 17, 9, 8, 22, '6952image_picker7734513566324659445.jpg', 'Pies,nuts', 'No description', 4),
(23, 'Tarts', 'Shake House', 4.5, 17, 9, 4, 18, '3829image_picker4158584535188799589.jpg', ' pie crust', 'no description', 1),
(24, 'Cookies', 'Shake House', 4.25, 17, 9, 4, 41, '1423image_picker5162661820508610010.jpg', 'flour,Cookie\'s', 'no description', 2),
(25, 'Flourless cakes', 'Shake House', 5, 17, 9, 6, 23, '3867image_picker4738767603364811053.jpg', 'flour,chocolate', 'no description', 2),
(26, 'Pastries', 'Shake House', 3.6666666666667, 17, 9, 5, 20, '2577image_picker91461514046818167.jpg', 'butter', 'no description', 3),
(27, 'Custards', 'Shake House', 0, 17, 9, 4, 14, '5381image_picker7224759117580587901.png', 'custard', 'no description', 0),
(28, 'Confections', 'Shake House', 0, 17, 9, 8, 11, '9958image_picker2981554782127925860.jpg', 'flour', 'no description', 0),
(29, 'Brown ice cream', 'Shake House', 0, 17, 9, 5, 25, '9465image_picker8734992003495180747.png', 'ice cream', 'no description', 0);

-- --------------------------------------------------------

--
-- Table structure for table `traditional`
--

CREATE TABLE `traditional` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `storeName` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `userID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `price` double NOT NULL,
  `totalBuy` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `#rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `traditional`
--

INSERT INTO `traditional` (`productID`, `productName`, `storeName`, `rate`, `userID`, `cateID`, `price`, `totalBuy`, `image`, `content`, `description`, `#rate`) VALUES
(20, 'Bamia', 'Bait al kel', 0, 15, 6, 10, 22, '6502image_picker4614301346311497264.jpg', 'bamia,rise,tomato sauce', 'Bamia with rise', 0),
(21, 'Fasolia', 'Bait al kel', 4.5, 15, 6, 8, 18, '4426image_picker9050585088375762506.jpg', 'fasolia,rise,tomato soup', 'Fasolia with rise', 5),
(22, 'Kabsa', 'Bait al kel', 3.75, 15, 6, 15, 35, '1881image_picker2127464338772271031.jpg', 'Rise,chicken,tomato', 'Kabsa with chicken, for 4 persons', 2),
(23, 'Mahshi', 'Bait al kel', 0, 15, 6, 20, 20, '7671image_picker3422109008182113402.jpg', 'lemon,chicken', 'Chicken with rise and lemon', 0),
(24, 'Mansaf', 'Bait al kel', 4.1428571428572, 15, 6, 18, 43, '9172image_picker4020144979588740549.jpg', 'Rise,meat', 'Rise with yogurt, meat and bread', 7),
(25, 'Maqluba', 'Bait al kel', 0, 15, 6, 15, 9, '5953image_picker82108593800480531.jpg', 'rise', 'Rise with chicken', 0),
(26, 'Mujadara', 'Bait al kel', 0, 15, 6, 7, 6, '2021image_picker7411427980863332778.jpg', 'Lentils,onion,rise', 'Rise with onion and lentils', 0),
(27, 'Musakhan', 'Bait al kel', 0, 15, 6, 13, 15, '3835image_picker4603827743170312058.jpg', 'onion,chicken,bread', 'Bread with chicken and onion ', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `have_store` varchar(255) NOT NULL,
  `deliveryOrCustomer` varchar(255) NOT NULL,
  `visaName` varchar(255) NOT NULL,
  `visaNumber` varchar(255) NOT NULL,
  `CVV` varchar(255) NOT NULL,
  `visaDate` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `cityLocation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `phone`, `password`, `have_store`, `deliveryOrCustomer`, `visaName`, `visaNumber`, `CVV`, `visaDate`, `image`, `latitude`, `longitude`, `cityLocation`) VALUES
(11, 'ahmad.Fathi@gmail.com', 'Ahmad', 'Fathi', '567816357', '0raedkh789', 'yes', 'Customer', 'Mr. Ahmad Fathi', '7892789278927892', '123', '02/25', '', '32.20672355221524', '35.28639782220125', 'Balata'),
(15, 'ali.abood@gmail.com', 'Ali', 'Khaled', '592757174', 'raedraed', 'yes', 'Customer', 'Mr. Ali Khaled', '4562456245624562', '345', '02/25', '', '32.20672355221524', '35.28639782220125', 'Balata'),
(16, 'osama@gmail.com', 'Osama', 'Raed', '59478458', 'dsafsdg', 'yes', 'Delivery', 'fsafas', '9874987498749874', '546', '08/23', '', '31.9104384', '35.2072529', 'Ramallah'),
(17, 'muradF@gmail.com', 'Murad', 'Farhat', '597811512', 'murad456', 'yes', 'Customer', 'Mr. Murad Farhat', '1234123412341234', '712', '02/25', '', '32.2244', '35.247055', 'Nablus'),
(18, 'raedkh@gmail.com', 'Ra\'ed ', 'Khwayreh', '592757817', '0raedkh789', 'yes', 'Customer', '', '4456454564646655', '578', '06/24', '', '32.2244', '35.347055', 'Nablus'),
(19, 'plasma.2000@gmail.com', 'Sarah', 'Osama', '593487895', '12341234', 'no', 'Customer', '', '', '', '', '', '32.221330294412596', '35.2485666051507', 'Nablus'),
(20, 'raed.khwayreh.11@gmail.com', 'Mohammed', 'Khalel', '592345786', 'raedraed', 'no', 'Customer', '', '', '', '', '', '32.20723163492937', '35.2964487299323', ''),
(21, 'raed.khwayeh@gmail.com', 'Khaled', 'Zakria', '562146378', '456789', 'no', 'Delivery', 'Mr. Zakaria', '4456454564646655', '456', '01/24', '', '32.2328683', '35.2556217', 'Nablus'),
(23, 'ali.ezz@gmail.com', 'Ali', 'Ezz', '597891234', 'raczcsa', 'yes', 'Delivery', 'Mr. Ali', '5646854897897987', '214', '02/24', '', '31.9037633', '35.2034183', 'Ramallah'),
(35, 'raedkh.2000@gmail.com', 'Ra\'ed ', 'Khwayerh', '592757817', 'raed1234', 'yes', 'Customer', 'Mr. Raed', '4456454564646655', '582', '06/23', '', '32.2328683', '35.2556217', 'Nablus');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appetizers`
--
ALTER TABLE `appetizers`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `cart_table`
--
ALTER TABLE `cart_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `storeID` (`storeID`);

--
-- Indexes for table `category_table`
--
ALTER TABLE `category_table`
  ADD PRIMARY KEY (`cateID`),
  ADD UNIQUE KEY `cateName` (`cateName`);

--
-- Indexes for table `chicken`
--
ALTER TABLE `chicken`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`),
  ADD KEY `cateID` (`cateID`);

--
-- Indexes for table `customer_info`
--
ALTER TABLE `customer_info`
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `drinks`
--
ALTER TABLE `drinks`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `fast food`
--
ALTER TABLE `fast food`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `favoritetable`
--
ALTER TABLE `favoritetable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite_cate`
--
ALTER TABLE `favorite_cate`
  ADD KEY `userID` (`userID`),
  ADD KEY `cateID` (`cateID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeID` (`storeID`),
  ADD KEY `productID` (`productID`),
  ADD KEY `cateID` (`cateID`);

--
-- Indexes for table `meats`
--
ALTER TABLE `meats`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`);

--
-- Indexes for table `milkshakes`
--
ALTER TABLE `milkshakes`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `myorders_table`
--
ALTER TABLE `myorders_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `myorders_table_ibfk_2` (`userID`),
  ADD KEY `myorders_table_ibfk_3` (`storeID`),
  ADD KEY `orderID` (`orderID`);

--
-- Indexes for table `newcate`
--
ALTER TABLE `newcate`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `promotion_table`
--
ALTER TABLE `promotion_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `storeID` (`storeID`),
  ADD KEY `cateID` (`cateID`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeID` (`storeID`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`storeID`),
  ADD UNIQUE KEY `storeName` (`storeName`);

--
-- Indexes for table `support`
--
ALTER TABLE `support`
  ADD PRIMARY KEY (`questionID`);

--
-- Indexes for table `sweet`
--
ALTER TABLE `sweet`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `traditional`
--
ALTER TABLE `traditional`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `cateID` (`cateID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `storeName` (`storeName`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appetizers`
--
ALTER TABLE `appetizers`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `cart_table`
--
ALTER TABLE `cart_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `category_table`
--
ALTER TABLE `category_table`
  MODIFY `cateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `chicken`
--
ALTER TABLE `chicken`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `drinks`
--
ALTER TABLE `drinks`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `fast food`
--
ALTER TABLE `fast food`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `favoritetable`
--
ALTER TABLE `favoritetable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `meats`
--
ALTER TABLE `meats`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `milkshakes`
--
ALTER TABLE `milkshakes`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `myorders_table`
--
ALTER TABLE `myorders_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `newcate`
--
ALTER TABLE `newcate`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `promotion_table`
--
ALTER TABLE `promotion_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `storeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `support`
--
ALTER TABLE `support`
  MODIFY `questionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sweet`
--
ALTER TABLE `sweet`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `traditional`
--
ALTER TABLE `traditional`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appetizers`
--
ALTER TABLE `appetizers`
  ADD CONSTRAINT `appetizers_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appetizers_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appetizers_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart_table`
--
ALTER TABLE `cart_table`
  ADD CONSTRAINT `cart_table_ibfk_1` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `chicken`
--
ALTER TABLE `chicken`
  ADD CONSTRAINT `chicken_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chicken_ibfk_2` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chicken_ibfk_3` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_info`
--
ALTER TABLE `customer_info`
  ADD CONSTRAINT `customer_info_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD CONSTRAINT `delivery_info_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `drinks`
--
ALTER TABLE `drinks`
  ADD CONSTRAINT `drinks_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `drinks_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `drinks_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fast food`
--
ALTER TABLE `fast food`
  ADD CONSTRAINT `fast food_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fast food_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fast food_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorite_cate`
--
ALTER TABLE `favorite_cate`
  ADD CONSTRAINT `favorite_cate_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favorite_cate_ibfk_2` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_3` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_4` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `meats`
--
ALTER TABLE `meats`
  ADD CONSTRAINT `meats_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `milkshakes`
--
ALTER TABLE `milkshakes`
  ADD CONSTRAINT `milkshakes_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `milkshakes_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `milkshakes_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `myorders_table`
--
ALTER TABLE `myorders_table`
  ADD CONSTRAINT `myorders_table_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `myorders_table_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `myorders_table_ibfk_3` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newcate`
--
ALTER TABLE `newcate`
  ADD CONSTRAINT `NewCate_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `NewCate_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `NewCate_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `promotion_table`
--
ALTER TABLE `promotion_table`
  ADD CONSTRAINT `promotion_table_ibfk_1` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `promotion_table_ibfk_2` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_ibfk_3` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `store_ibfk_1` FOREIGN KEY (`storeID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sweet`
--
ALTER TABLE `sweet`
  ADD CONSTRAINT `sweet_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sweet_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sweet_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `traditional`
--
ALTER TABLE `traditional`
  ADD CONSTRAINT `traditional_ibfk_1` FOREIGN KEY (`cateID`) REFERENCES `category_table` (`cateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `traditional_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `store` (`storeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `traditional_ibfk_3` FOREIGN KEY (`storeName`) REFERENCES `store` (`storeName`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
