-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2024 at 07:36 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminlogin`
--

CREATE TABLE `adminlogin` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `adminlogin`
--

INSERT INTO `adminlogin` (`id`, `username`, `password`) VALUES
(1, 'arjun', 'arjun');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `bill_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_id`, `customer_id`, `order_id`, `total_amount`, `bill_date`) VALUES
(0, 123, 0, 0.00, '2024-06-21'),
(0, 100, 100, 0.00, '2024-06-22'),
(0, 100, 105, 96040.00, '2024-06-22'),
(0, 100, 200, 3000.00, '2024-06-22'),
(300, 100, 300, 300.00, '2024-06-22'),
(700, 131, 700, 1080.00, '2024-06-22'),
(900, 131, 900, 4130.00, '2024-06-22'),
(454, 131, 454, 400.00, '2024-06-22'),
(92, 131, 92, 240.00, '2024-06-22'),
(80, 99, 80, 1500.00, '2024-06-22'),
(177, 123, 177, 42.00, '2024-06-27'),
(7776, 7776, 7776, 30.00, '2024-06-27'),
(110, 123, 110, 31.00, '2024-07-06'),
(12, 123, 12, 42.00, '2024-07-06');

-- --------------------------------------------------------

--
-- Table structure for table `customer_info`
--

CREATE TABLE `customer_info` (
  `id` int(3) NOT NULL,
  `name` varchar(50) NOT NULL,
  `color` varchar(10) NOT NULL,
  `family_count` int(3) NOT NULL,
  `contact` char(10) DEFAULT NULL,
  `city` varchar(20) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_info`
--

INSERT INTO `customer_info` (`id`, `name`, `color`, `family_count`, `contact`, `city`, `password`) VALUES
(1, 'saish', 'white', 4, '98989898', 'kopargoan', ''),
(2, 'sanket', 'orange', 3, '78787878', 'gadchiroli', ''),
(3, 'yashodeep', 'yellow', 4, '12121212', 'shrirampur', ''),
(4, 'aditya', 'yellow', 5, '15151515', 'karjat', ''),
(5, 'kishor', 'white', 5, '23232323', 'shirdi', ''),
(9, 'manoj', 'orange', 5, '89878787', 'ahmednagar', ''),
(10, 'pratik', 'white', 5, '898989', 'pune', ''),
(12, 'xyz', 'orange', 5, '65656524', 'hvgv', ''),
(23, 'ketan', 'white', 4, '9898989898', 'nagar', ''),
(54, 'sumit', 'white', 10, '1234567890', 'karjat', ''),
(99, 'arjun', 'orange', 4, '9391491205', 'bapatla', '99'),
(100, 'vishal', 'white', 2, '9834664178', 'ap', '100'),
(101, 'Ashish', 'white', 5, '9999999999', 'dffd', ''),
(123, 'arjun', 'yellow', 5, '6987566612', 'bapatla', '123456'),
(131, 'sowmya', 'white', 7, '8548719819', 'odisha', '131'),
(456, 'hima', 'yellow', 7, '6283057332', 'guntur', '456'),
(7776, 'Rajendra', 'yellow', 4, '9100803167', 'dhone', '7776'),
(25436, '', 'yellow', 0, '', '', ''),
(25437, '', 'yellow', 0, '', '', ''),
(25438, '', 'yellow', 0, '', '', ''),
(168777, 'JESHI', 'yellow', 4, '8967687814', 'BAPATLA', '123'),
(168778, '', 'yellow', 0, '', '', ''),
(168779, '', 'yellow', 0, '', '', ''),
(168780, '', 'yellow', 0, '', '', ''),
(168781, '', 'yellow', 0, '', '', ''),
(168782, '', 'yellow', 0, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `dispatched`
--

CREATE TABLE `dispatched` (
  `order_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dispatched`
--

INSERT INTO `dispatched` (`order_id`, `stock_id`) VALUES
(0, 1),
(92, 1),
(100, 1),
(177, 1),
(454, 10),
(80, 99),
(105, 100),
(110, 100),
(200, 232),
(700, 233),
(7776, 233);

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(3) NOT NULL,
  `date` date NOT NULL,
  `rice` int(3) NOT NULL,
  `wheat` int(3) NOT NULL,
  `sugar` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `date`, `rice`, `wheat`, `sugar`) VALUES
(3, '2022-12-05', 3, 3, 3),
(3, '2022-12-05', 2, 2, 2),
(5, '2022-11-15', 1, 1, 1),
(5, '2022-11-15', 1, 1, 1),
(2, '2022-11-15', 2, 2, 2),
(1, '2022-11-15', 1, 1, 1),
(1, '2022-11-15', 2, 2, 1),
(4, '2022-12-05', 4, 4, 4),
(3, '2022-12-05', 12, 12, 12),
(54, '2022-12-05', 1, 1, 1),
(54, '2022-12-05', 40, 15, 10);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `rice_kg` int(11) NOT NULL,
  `wheat_kg` int(11) NOT NULL,
  `sugar_kg` int(11) NOT NULL,
  `order_state` text NOT NULL,
  `order_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`customer_id`, `order_id`, `rice_kg`, `wheat_kg`, `sugar_kg`, `order_state`, `order_date`) VALUES
(123, 0, 11, 1, 1, 'Cancelled', '0000-00-00'),
(123, 0, 1, 11, 1, 'Cancelled', '0000-00-00'),
(100, 100, 100, 100, 100, 'Confirmed', '0000-00-00'),
(100, 105, 9465, 84, 55, 'Confirmed', '0000-00-00'),
(100, 200, 100, 100, 100, 'Confirmed', '0000-00-00'),
(100, 300, 10, 10, 10, 'Cancelled', '0000-00-00'),
(131, 700, 14, 16, 78, 'Confirmed', '0000-00-00'),
(131, 900, 123, 145, 145, 'Cancelled', '0000-00-00'),
(131, 454, 12, 13, 15, 'Confirmed', '0000-00-00'),
(131, 92, 9, 8, 7, 'Confirmed', '0000-00-00'),
(99, 80, 100, 100, 100, 'Confirmed', '0000-00-00'),
(123, 177, 12, 14, 16, 'Confirmed', '2024-06-27'),
(7776, 7776, 10, 10, 10, 'Confirmed', '2024-06-27'),
(168777, 454, 10, 10, 10, 'Confirmed', '2024-06-29'),
(168777, 900, 1, 1, 1, 'Cancelled', '2024-06-29'),
(123, 432, 12, 12, 12, '', '2024-07-05'),
(123, 110, 24, 5, 2, 'Confirmed', '2024-07-06'),
(123, 453324, 34, 2, 6, 'Cancelled', '2024-07-06'),
(123, 12, 14, 14, 14, '', '2024-07-06');

-- --------------------------------------------------------

--
-- Stand-in structure for view `order_view`
-- (See below for the actual view)
--
CREATE TABLE `order_view` (
`order_id` int(11)
,`rice_kg` int(11)
,`wheat_kg` int(11)
,`sugar_kg` int(11)
,`order_state` text
,`order_date` date
,`customer_name` varchar(50)
,`customer_city` varchar(20)
,`customer_contact` char(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `color` varchar(10) NOT NULL,
  `rice` int(3) NOT NULL,
  `wheat` int(3) NOT NULL,
  `sugar` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`color`, `rice`, `wheat`, `sugar`) VALUES
('orange', 5, 5, 5),
('white', 10, 10, 10),
('yellow', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `remain_stock`
--

CREATE TABLE `remain_stock` (
  `id` int(3) NOT NULL,
  `rice` int(3) NOT NULL,
  `wheat` int(3) NOT NULL,
  `sugar` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `remain_stock`
--

INSERT INTO `remain_stock` (`id`, `rice`, `wheat`, `sugar`) VALUES
(1, 1456, 1506, 1607),
(2, 3441, 650, 8681),
(3, -7, -7, -7),
(5, 21, 21, 21),
(9, 12, 12, 12),
(10, 1113, 1113, 1113),
(12, 6, 6, 6),
(13, 503, 549, 691),
(23, 15, 15, 15),
(54, 300, 5, 34522),
(99, 66, 66, 66),
(100, 0, 0, 0),
(232, 12, 14, 10),
(233, 0, 0, 34),
(234, 0, 0, 0),
(235, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure for view `order_view`
--
DROP TABLE IF EXISTS `order_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_view`  AS SELECT `orders`.`order_id` AS `order_id`, `orders`.`rice_kg` AS `rice_kg`, `orders`.`wheat_kg` AS `wheat_kg`, `orders`.`sugar_kg` AS `sugar_kg`, `orders`.`order_state` AS `order_state`, `orders`.`order_date` AS `order_date`, `customer_info`.`name` AS `customer_name`, `customer_info`.`city` AS `customer_city`, `customer_info`.`contact` AS `customer_contact` FROM (`orders` join `customer_info` on(`orders`.`customer_id` = `customer_info`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminlogin`
--
ALTER TABLE `adminlogin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_info`
--
ALTER TABLE `customer_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dispatched`
--
ALTER TABLE `dispatched`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `stock_id` (`stock_id`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD UNIQUE KEY `color` (`color`);

--
-- Indexes for table `remain_stock`
--
ALTER TABLE `remain_stock`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminlogin`
--
ALTER TABLE `adminlogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_info`
--
ALTER TABLE `customer_info`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168783;

--
-- AUTO_INCREMENT for table `remain_stock`
--
ALTER TABLE `remain_stock`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
