--
-- Baza danych: `shop`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `address`
--

CREATE TABLE `address` (
  `id_address` int(11) NOT NULL,
  `zipcode` varchar(5) NOT NULL,
  `city` varchar(30) NOT NULL,
  `street` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `categories`
--

CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL,
  `category_name` varchar(30) NOT NULL,
  `category_icon` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `categories`
--

INSERT INTO `categories` (`id_category`, `category_name`, `category_icon`) VALUES
(1, 'Komputery stacjonarne', 'fas fa-desktop'),
(2, 'Telefony', 'fas fa-mobile'),
(3, 'Laptopy i tablety', 'fas fa-laptop'),
(4, 'Urządzenia peryferyjne', 'fas fa-keyboard'),
(5, 'Podzespoły komputerowe', 'fas fa-microchip'),
(6, 'Gaming', 'fas fa-gamepad');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `discount`
--

CREATE TABLE `discount` (
  `id_discount` int(11) NOT NULL,
  `discount_type` int(11) NOT NULL,
  `discount_expDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `discount_useDate` timestamp NULL DEFAULT NULL,
  `discount_percent` int(11) DEFAULT NULL,
  `discount_money` int(11) DEFAULT NULL,
  `discount_ship` int(1) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orderproduct`
--

CREATE TABLE `orderproduct` (
  `id_orderProduct` int(11) NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `id_product` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `final_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `order_num` varchar(10) NOT NULL,
  `id_user` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_status` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `id_vat` int(11) DEFAULT NULL,
  `id_ship` int(11) DEFAULT NULL,
  `tracking` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

CREATE TABLE `products` (
  `id_products` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_desc` varchar(250) NOT NULL,
  `id_category` int(11) NOT NULL,
  `photo1` mediumblob NOT NULL,
  `photo2` mediumblob DEFAULT NULL,
  `photo3` mediumblob DEFAULT NULL,
  `photo4` mediumblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ship`
--

CREATE TABLE `ship` (
  `id_ship` int(11) NOT NULL,
  `ship_method_short` varchar(30) NOT NULL,
  `ship_method_long` varchar(50) NOT NULL,
  `ship_price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `ship`
--

INSERT INTO `ship` (`id_ship`, `ship_method_short`, `ship_method_long`, `ship_price`) VALUES
(1, 'DHL', 'Kurier DHL', '15.00'),
(2, 'DPD', 'Kurier DPD', '15.00'),
(3, 'inpost', 'Inpost, paczkomaty 24/7', '10.00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status`
--

CREATE TABLE `status` (
  `id_status` int(11) NOT NULL,
  `status_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `status`
--

INSERT INTO `status` (`id_status`, `status_name`) VALUES
(1, 'Oczekiwanie na zapłatę'),
(2, 'Przesyłka nieodebrana'),
(3, 'Anulowane'),
(4, 'W trakcie realizacji'),
(5, 'Wysłane'),
(6, 'Odebrane');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_passwd` varchar(100) NOT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `user_phone` varchar(9) DEFAULT NULL,
  `id_address` int(10) DEFAULT NULL,
  `admin` int(1) NOT NULL DEFAULT 0,
  `isactive` int(1) NOT NULL DEFAULT 0,
  `rulesAccepted` int(1) NOT NULL,
  `newsletter` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vat`
--

CREATE TABLE `vat` (
  `id_vat` int(11) NOT NULL,
  `vat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id_address`);

--
-- Indeksy dla tabeli `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_category`);

--
-- Indeksy dla tabeli `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id_discount`);

--
-- Indeksy dla tabeli `orderproduct`
--
ALTER TABLE `orderproduct`
  ADD PRIMARY KEY (`id_orderProduct`);

--
-- Indeksy dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`);

--
-- Indeksy dla tabeli `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id_products`);

--
-- Indeksy dla tabeli `ship`
--
ALTER TABLE `ship`
  ADD PRIMARY KEY (`id_ship`);

--
-- Indeksy dla tabeli `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_status`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeksy dla tabeli `vat`
--
ALTER TABLE `vat`
  ADD PRIMARY KEY (`id_vat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `address`
--
ALTER TABLE `address`
  MODIFY `id_address` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `categories`
--
ALTER TABLE `categories`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `discount`
--
ALTER TABLE `discount`
  MODIFY `id_discount` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `orderproduct`
--
ALTER TABLE `orderproduct`
  MODIFY `id_orderProduct` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `products`
--
ALTER TABLE `products`
  MODIFY `id_products` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `ship`
--
ALTER TABLE `ship`
  MODIFY `id_ship` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `status`
--
ALTER TABLE `status`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `vat`
--
ALTER TABLE `vat`
  MODIFY `id_vat` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;