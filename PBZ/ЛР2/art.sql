-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 15, 2021 at 07:57 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `art`
--

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE `artist` (
  `ID` int(10) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Date_of_birth` date DEFAULT NULL,
  `Place_of_birth` varchar(255) DEFAULT NULL,
  `Biography` varchar(255) DEFAULT NULL,
  `Education` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`ID`, `Name`, `Date_of_birth`, `Place_of_birth`, `Biography`, `Education`) VALUES
(1, 'Винсент Ван Гог', '1853-03-30', 'Нидерланды', 'Родился, писал, умер.', 'имеется'),
(2, 'Леонардо Да Винчи', '1452-04-15', 'Италия', 'был крутым челом', 'учился'),
(5, 'Месси', '2000-01-10', 'Польша', 'человек', 'высшее');

-- --------------------------------------------------------

--
-- Table structure for table `artwork`
--

CREATE TABLE `artwork` (
  `ID` int(10) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Execution` varchar(255) DEFAULT NULL,
  `Date_of_create` date DEFAULT NULL,
  `Size` varchar(255) DEFAULT NULL,
  `ArtistID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `artwork`
--

INSERT INTO `artwork` (`ID`, `Name`, `Execution`, `Date_of_create`, `Size`, `ArtistID`) VALUES
(1, 'Монолиза', 'Картина', '1503-01-01', 'fullHD', 2),
(2, 'Звёздная ночь', 'Картина', '1000-01-01', '256x256', 1),
(3, 'Картина маслом', 'масло', '1234-10-10', '1920x1080', 1);

-- --------------------------------------------------------

--
-- Table structure for table `exhibition`
--

CREATE TABLE `exhibition` (
  `ID` int(10) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exhibition`
--

INSERT INTO `exhibition` (`ID`, `Name`, `Type`, `Start_date`, `End_date`) VALUES
(1, 'Авангард', 'Искусство', '2021-09-01', '2021-11-06'),
(2, 'Анфас', 'картины', '2022-04-06', '2022-07-06'),
(3, 'Картины', 'Благотворительная', '2021-04-07', '2021-11-11');

-- --------------------------------------------------------

--
-- Table structure for table `exhibitionartwork`
--

CREATE TABLE `exhibitionartwork` (
  `ExhibitionID` int(10) NOT NULL,
  `ArtworkID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exhibitionartwork`
--

INSERT INTO `exhibitionartwork` (`ExhibitionID`, `ArtworkID`) VALUES
(3, 1),
(1, 2),
(2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `exhibitionhall`
--

CREATE TABLE `exhibitionhall` (
  `ID` int(10) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Area` int(10) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone_number` varchar(255) DEFAULT NULL,
  `OwnerID` int(10) NOT NULL,
  `ExhibitionID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exhibitionhall`
--

INSERT INTO `exhibitionhall` (`ID`, `Name`, `Area`, `Address`, `Phone_number`, `OwnerID`, `ExhibitionID`) VALUES
(1, 'Галерея', 100, 'г. Минск, ул. Пушкина, д. 1', '8-800-555-35-35', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE `owner` (
  `ID` int(10) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Type_of_organiztion` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`ID`, `Name`, `Type_of_organiztion`, `Address`, `Phone_number`) VALUES
(1, 'ГОРИСПОЛКОМ', 'ГОСУДАРСТВО', 'г. Минск', '8-800-555-35-35'),
(2, 'БГУ', 'ВУЗ', 'г. Минск, ул. Гикало', '+123456789'),
(3, 'Зубенко Михаил Петрович', 'физическое лицо', 'г.Минск, ул. Пушкина, д.15', '+375293213218'),
(4, 'Спасем их вместе', 'Благотворительный фонд', 'г. Брест, ул. Маркса, д. 38', '+375777666666'),
(8, 'аывфа', 'афываф', 'афывафыв', '312'),
(11, '32323', '3232', '323', '32'),
(13, 'аывфафы', 'афываыф', 'афыва', 'аыфвафыва');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `artwork`
--
ALTER TABLE `artwork`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ArtistID` (`ArtistID`);

--
-- Indexes for table `exhibition`
--
ALTER TABLE `exhibition`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `exhibitionartwork`
--
ALTER TABLE `exhibitionartwork`
  ADD KEY `ArtworkID` (`ArtworkID`),
  ADD KEY `ExhibitionID` (`ExhibitionID`);

--
-- Indexes for table `exhibitionhall`
--
ALTER TABLE `exhibitionhall`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ExhibitionID` (`ExhibitionID`),
  ADD KEY `OwnerID` (`OwnerID`);

--
-- Indexes for table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artist`
--
ALTER TABLE `artist`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `artwork`
--
ALTER TABLE `artwork`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `exhibition`
--
ALTER TABLE `exhibition`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `exhibitionhall`
--
ALTER TABLE `exhibitionhall`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `owner`
--
ALTER TABLE `owner`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artwork`
--
ALTER TABLE `artwork`
  ADD CONSTRAINT `artwork_ibfk_1` FOREIGN KEY (`ArtistID`) REFERENCES `artist` (`ID`);

--
-- Constraints for table `exhibitionartwork`
--
ALTER TABLE `exhibitionartwork`
  ADD CONSTRAINT `exhibitionartwork_ibfk_1` FOREIGN KEY (`ArtworkID`) REFERENCES `artwork` (`ID`),
  ADD CONSTRAINT `exhibitionartwork_ibfk_2` FOREIGN KEY (`ExhibitionID`) REFERENCES `exhibition` (`ID`);

--
-- Constraints for table `exhibitionhall`
--
ALTER TABLE `exhibitionhall`
  ADD CONSTRAINT `exhibitionhall_ibfk_1` FOREIGN KEY (`ExhibitionID`) REFERENCES `exhibition` (`ID`),
  ADD CONSTRAINT `exhibitionhall_ibfk_2` FOREIGN KEY (`OwnerID`) REFERENCES `owner` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
