-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Pát 10. kvě 2024, 13:23
-- Verze serveru: 10.1.37-MariaDB
-- Verze PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `pri_db`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `fakulty`
--

CREATE TABLE `fakulty` (
  `id` int(11) NOT NULL,
  `jmeno` varchar(50) COLLATE utf16_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `fakulty`
--

INSERT INTO `fakulty` (`id`, `jmeno`) VALUES
(1, 'prf'),
(2, 'fud');

-- --------------------------------------------------------

--
-- Struktura tabulky `osobni_udaje`
--

CREATE TABLE `osobni_udaje` (
  `id` int(11) NOT NULL,
  `jmeno` varchar(50) COLLATE utf16_czech_ci NOT NULL,
  `prijmeni` varchar(50) COLLATE utf16_czech_ci NOT NULL,
  `cislo` varchar(30) COLLATE utf16_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `osobni_udaje`
--

INSERT INTO `osobni_udaje` (`id`, `jmeno`, `prijmeni`, `cislo`) VALUES
(1, 'bája', 'boží', '46132asd'),
(2, 'pepa', 'bůh', 'qwe1234456'),
(3, 'bao', 'king kong', 'sfd'),
(4, 'aůlex', 'alexovič', 'sd8f4'),
(5, 'danda', 'říhá', 'rz7t64h1');

-- --------------------------------------------------------

--
-- Struktura tabulky `pozice`
--

CREATE TABLE `pozice` (
  `id` int(11) NOT NULL,
  `jmeno` varchar(50) COLLATE utf16_czech_ci NOT NULL,
  `plat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `pozice`
--

INSERT INTO `pozice` (`id`, `jmeno`, `plat`) VALUES
(1, 'vedouci', 2),
(2, 'profesor', 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `predmet`
--

CREATE TABLE `predmet` (
  `id` int(11) NOT NULL,
  `jmeno` varchar(50) COLLATE utf16_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `predmet`
--

INSERT INTO `predmet` (`id`, `jmeno`) VALUES
(1, 'asd'),
(2, 'tre'),
(3, 'hgj'),
(4, 'lml');

-- --------------------------------------------------------

--
-- Struktura tabulky `predmety-fakulty`
--

CREATE TABLE `predmety-fakulty` (
  `id_predmet` int(11) NOT NULL,
  `id_fakulta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `predmety-fakulty`
--

INSERT INTO `predmety-fakulty` (`id_predmet`, `id_fakulta`) VALUES
(1, 2),
(3, 2),
(4, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Struktura tabulky `studenti`
--

CREATE TABLE `studenti` (
  `id` int(11) NOT NULL,
  `osobni_udaje` int(11) NOT NULL,
  `rok` int(11) NOT NULL,
  `fakulta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `studenti`
--

INSERT INTO `studenti` (`id`, `osobni_udaje`, `rok`, `fakulta`) VALUES
(1, 1, 1, 2),
(2, 5, 2, 1),
(3, 2, 2, 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `zamestnanci`
--

CREATE TABLE `zamestnanci` (
  `ID_z` int(11) NOT NULL,
  `id_fakulta` int(11) NOT NULL,
  `osobni_udaje` int(11) NOT NULL,
  `telefon` int(11) NOT NULL,
  `id_pozice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_czech_ci;

--
-- Vypisuji data pro tabulku `zamestnanci`
--

INSERT INTO `zamestnanci` (`ID_z`, `id_fakulta`, `osobni_udaje`, `telefon`, `id_pozice`) VALUES
(1, 2, 4, 123456789, 1),
(2, 1, 3, 123456789, 1);

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `fakulty`
--
ALTER TABLE `fakulty`
  ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `osobni_udaje`
--
ALTER TABLE `osobni_udaje`
  ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `pozice`
--
ALTER TABLE `pozice`
  ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `predmet`
--
ALTER TABLE `predmet`
  ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `predmety-fakulty`
--
ALTER TABLE `predmety-fakulty`
  ADD KEY `id_fakulta` (`id_fakulta`),
  ADD KEY `id_predmet` (`id_predmet`);

--
-- Klíče pro tabulku `studenti`
--
ALTER TABLE `studenti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fakulta` (`fakulta`),
  ADD KEY `osobni_udaje` (`osobni_udaje`);

--
-- Klíče pro tabulku `zamestnanci`
--
ALTER TABLE `zamestnanci`
  ADD PRIMARY KEY (`ID_z`),
  ADD KEY `id_fakulta` (`id_fakulta`),
  ADD KEY `id_pozice` (`id_pozice`),
  ADD KEY `osobni_udaje` (`osobni_udaje`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `fakulty`
--
ALTER TABLE `fakulty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pro tabulku `osobni_udaje`
--
ALTER TABLE `osobni_udaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pro tabulku `pozice`
--
ALTER TABLE `pozice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pro tabulku `predmet`
--
ALTER TABLE `predmet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pro tabulku `studenti`
--
ALTER TABLE `studenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pro tabulku `zamestnanci`
--
ALTER TABLE `zamestnanci`
  MODIFY `ID_z` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `predmety-fakulty`
--
ALTER TABLE `predmety-fakulty`
  ADD CONSTRAINT `predmety-fakulty_ibfk_1` FOREIGN KEY (`id_fakulta`) REFERENCES `fakulty` (`id`),
  ADD CONSTRAINT `predmety-fakulty_ibfk_2` FOREIGN KEY (`id_predmet`) REFERENCES `predmet` (`id`);

--
-- Omezení pro tabulku `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `studenti_ibfk_1` FOREIGN KEY (`fakulta`) REFERENCES `fakulty` (`id`),
  ADD CONSTRAINT `studenti_ibfk_2` FOREIGN KEY (`osobni_udaje`) REFERENCES `osobni_udaje` (`id`);

--
-- Omezení pro tabulku `zamestnanci`
--
ALTER TABLE `zamestnanci`
  ADD CONSTRAINT `zamestnanci_ibfk_1` FOREIGN KEY (`id_fakulta`) REFERENCES `fakulty` (`id`),
  ADD CONSTRAINT `zamestnanci_ibfk_2` FOREIGN KEY (`id_pozice`) REFERENCES `pozice` (`id`),
  ADD CONSTRAINT `zamestnanci_ibfk_3` FOREIGN KEY (`osobni_udaje`) REFERENCES `osobni_udaje` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
