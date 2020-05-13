--
-- Struktura tabeli dla tabeli `address`
--

CREATE TABLE `address` (
  `id_address` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `zipcode` varchar(5) NOT NULL,
  `city` varchar(30) NOT NULL,
  `street` varchar(30) NOT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `categories`
--

CREATE TABLE `categories` (
  `id_category` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `category_name` varchar(30) NOT NULL,
  `category_icon` varchar(30) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discount`
--

CREATE TABLE `discount` (
  `id_discount` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `discount_type` int(11) NOT NULL,
  `discount_expDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `discount_useDate` timestamp NULL DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `discount_money` int(11) DEFAULT NULL,
  `discount_ship` int(1) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orderproduct`
--

CREATE TABLE `orderproduct` (
  `id_orderProduct` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `id_product` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `final_price` decimal(10,2) NOT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `order_num` varchar(10) NOT NULL,
  `id_user` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_status` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `id_vat` int(11) DEFAULT NULL,
  `id_ship` int(11) DEFAULT NULL,
  `tracking` varchar(255) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

CREATE TABLE `products` (
  `id_products` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_desc` varchar(250) NOT NULL,
  `id_category` int(11) NOT NULL,
  `photo1` mediumblob NOT NULL,
  `photo2` mediumblob DEFAULT NULL,
  `photo3` mediumblob DEFAULT NULL,
  `photo4` mediumblob DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ship`
--

CREATE TABLE `ship` (
  `id_ship` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `ship_method_short` varchar(30) NOT NULL,
  `ship_method_long` varchar(50) NOT NULL,
  `ship_price` decimal(8,2) NOT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status`
--

CREATE TABLE `status` (
  `id_status` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `status_name` varchar(45) NOT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id_user` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_passwd` varchar(100) NOT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `user_phone` varchar(9) DEFAULT NULL,
  `id_address` int(10) DEFAULT NULL,
  `admin` int(1) NOT NULL DEFAULT '0',
  `isactive` int(1) NOT NULL DEFAULT '0',
  `rulesAccepted` int(1) NOT NULL,
  `newsletter` int(1) NOT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vat`
--

CREATE TABLE `vat` (
  `id_vat` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `vat` varchar(100) NOT NULL
);
