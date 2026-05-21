SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
SET CHARACTER SET utf8mb4;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- ESTRUCTURA DE TABLAS
-- --------------------------------------------------------

-- Avatars
CREATE TABLE `avatars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Categories
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Studios
CREATE TABLE `studios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Pegi Ratings
CREATE TABLE `pegi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Roles
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Subscription Plans
CREATE TABLE `plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `quality` varchar(10) DEFAULT NULL,
  `gpu` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Games
CREATE TABLE `games` (
  `id` int NOT NULL AUTO_INCREMENT,
  `developer_id` int DEFAULT NULL,
  `publisher_id` int DEFAULT NULL,
  `pegi_id` int DEFAULT NULL,
  `steam_id` int DEFAULT NULL,
  `igdb_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `summary` text,
  `description` text,
  `cover_url` varchar(255) DEFAULT NULL,
  `banner_url` varchar(255) DEFAULT NULL,
  `hero_url` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `metacritic_score` int DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `is_featured` boolean DEFAULT 0,
  `is_active` boolean DEFAULT 1,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `developer_id_idx` (`developer_id`),
  KEY `publisher_id_idx` (`publisher_id`),
  KEY `pegi_id_idx` (`pegi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Users
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `avatar_id` int DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `is_active` boolean DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `plan_id_idx` (`plan_id`),
  KEY `role_id_idx` (`role_id`),
  KEY `avatar_id_idx` (`avatar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Favorites (Pivot Table)
CREATE TABLE `favorites` (
  `user_id` int NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`user_id`, `game_id`),
  KEY `game_id_idx` (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Game Categories (Pivot Table)
CREATE TABLE `game_categories` (
  `game_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`game_id`, `category_id`),
  KEY `category_id_idx` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Play Sessions
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `game_id` int DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `duration` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `game_id_idx` (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- --------------------------------------------------------
-- DATA
-- --------------------------------------------------------

-- Avatars
INSERT INTO `avatars` (`id`, `name`, `image_url`) VALUES
(1, 'Estrella', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Estrella&backgroundColor=ff5a5f'),
(2, 'Gamer Pro', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=GamerPro&backgroundColor=4e5ba6'),
(3, 'Noob', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Noob&backgroundColor=ffc857'),
(4, 'Admin', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Admin&backgroundColor=718096'),
(5, 'Anónimo', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Anonimo&backgroundColor=9f7aea'),
(6, 'Soporte', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Soporte&backgroundColor=48bb78'),
(7, 'Tester', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Tester&backgroundColor=f56565'),
(8, 'Speedrunner', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Speedrunner&backgroundColor=4299e1'),
(9, 'Coleccionista', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Coleccionista&backgroundColor=ecc94b'),
(10, 'Crítico', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Critico&backgroundColor=ed64a6'),
(11, 'Logros', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Logros&backgroundColor=a0aec0'),
(12, 'Indie', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Indie&backgroundColor=667eea'),
(13, 'Lobo', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Lobo&backgroundColor=f6ad55'),
(14, 'Mundo', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Mundo&backgroundColor=4fd1c5'),
(15, 'Estratega', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Estratega&backgroundColor=b794f4'),
(16, 'Piloto', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Piloto&backgroundColor=fc8181'),
(17, 'Mercenario', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Mercenario&backgroundColor=2d3748'),
(18, 'Mago', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Mago&backgroundColor=90cdf4'),
(19, 'Constructor', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Constructor&backgroundColor=f6e05e'),
(20, 'Leyenda', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Leyenda&backgroundColor=d53f8c'),
(21, 'Heroe', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Heroe&backgroundColor=63b3ed'),
(22, 'Villano', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Villano&backgroundColor=ed8936'),
(23, 'Explorador', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Explorador&backgroundColor=718096'),
(24, 'Cazador', 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Cazador&backgroundColor=68d391');

-- Categories
INSERT INTO `categories` (`id`, `name`, `icon`) VALUES
(1, 'Acción', 'pi-play'),
(2, 'RPG', 'pi-book'),
(3, 'Aventura', 'pi-compass'),
(4, 'Estrategia', 'pi-cog'),
(5, 'Shooter', 'pi-bullseye'),
(6, 'Terror', 'pi-exclamation-triangle'),
(7, 'Simulación', 'pi-cubes'),
(8, 'Supervivencia', 'pi-shield'),
(9, 'Mundo Abierto', 'pi-map-marker'),
(10, 'Deportes', 'pi-trophy'),
(11, 'Puzzle', 'pi-question-circle'),
(12, 'Carreras', 'pi-car'),
(13, 'Lucha', 'pi-flag'),
(14, 'Plataformas', 'pi-step-forward'),
(15, 'Educativo', 'pi-graduation-cap'),
(16, 'Familiar', 'pi-heart'),

-- Studios
INSERT INTO `studios` (`id`, `name`) VALUES
(1, 'The Indie Stone'),
(2, 'MachineGames'),
(3, 'Bethesda Softworks'),
(4, 'Colossal Order'),
(5, 'Paradox Interactive'),
(6, 'Rockstar Games'),
(7, 'Take-Two Interactive'),
(8, 'Massive Entertainment'),
(9, 'Ubisoft Entertainment'),
(10, 'Insomniac Games'),
(11, 'Sony Interactive Entertainment'),
(12, 'Avalanche Software'),
(13, 'Warner Bros. Games'),
(14, 'Telltale Games'),
(15, 'CD Projekt RED'),
(16, 'CD Projekt'),
(17, 'FromSoftware'),
(18, 'Bandai Namco Entertainment'),
(19, 'Larian Studios'),
(20, 'Playground Games'),
(21, 'Xbox Game Studios'),
(22, 'Capcom Production Studio 4'),
(23, 'Capcom'),
(24, 'Embark Studios'),
(25, 'SIE Santa Monica Studio'),
(26, 'Guerrilla Games'),
(27, 'Naughty Dog'),
(28, 'Sucker Punch Productions'),
(29, 'Housemarque'),
(30, 'Bluepoint Games'),
(31, 'BlueTwelve Studio'),
(32, 'Annapurna Interactive'),
(33, 'Hazelight Studios'),
(34, 'Electronic Arts'),
(35, 'Arkane Studios'),
(36, 'Remedy Entertainment'),
(37, '505 Games'),
(38, 'Sloclap'),
(39, 'IronMonkey Studios'),
(40, 'Tango Gameworks'),
(41, 'Krafton'),
(42, 'Capcom Development Division 1'),
(43, 'id Software'),
(44, 'Valve'),
(45, 'Techland Publishing'),
(46, 'BioWare'),
(47, 'Rare'),
(48, 'Ubisoft Montreal'),
(49, 'Supergiant Games'),
(50, 'Netflix'),
(51, 'Activision'),
(52, 'Moon Studios'),
(53, 'Firaxis Games'),
(54, 'Aspyr Media'),
(55, 'Square Enix Creative Business Unit I'),
(56, 'Square Enix'),
(57, 'Toys for Bob'),
(58, 'Relic Entertainment'),
(59, 'Ubisoft Québec'),
(60, 'EA Digital Illusions CE'),
(61, 'Nomada Studio'),
(62, 'Devolver Digital'),
(63, 'Codemasters'),
(64, 'Asobo Studio'),
(65, '11 bit studios'),
(66, 'PocketPair'),
(67, 'Respawn Entertainment'),
(68, 'Deck13 Interactive'),
(69, 'Round8 Studio'),
(70, 'Neowiz'),
(71, 'Massive Monster'),
(72, 'Striking Distance Studios'),
(73, 'Focus Entertainment'),
(74, 'Bloober Team'),
(75, 'Konami'),
(76, 'Criterion Games'),
(77, 'Slavic Magic'),
(78, 'Hooded Horse'),
(79, 'Capcom Development Division 2'),
(80, 'Team NINJA'),
(81, 'Koei Tecmo Games'),
(82, 'Cygames'),
(83, 'P Studio'),
(84, 'Sega'),
(85, 'Game Science'),
(86, 'Mobius Digital'),
(87, 'PlatinumGames'),
(88, 'Arrowhead Game Studios'),
(89, 'ZA/UM'),
(90, 'Saber Interactive'),
(91, 'Irrational Games'),
(92, '2K Games'),
(93, 'Studio MDHR'),
(94, 'LocalThunk'),
(95, 'Playstack'),
(96, 'EA Vancouver'),
(97, 'EA Sports'),
(98, 'EA Orlando'),
(99, 'Visual Concepts'),
(100, '2K'),
(101, 'Behaviour Interactive'),
(102, 'Fallen Tree Games'),
(103, 'Kwalee'),
(104, 'Paradox Development Studio'),
(105, 'One More Level'),
(106, 'All In! Games'),
(107, 'Spike Chunsoft'),
(108, 'SCS Software'),
(109, 'Squad'),
(110, 'Private Division'),
(111, 'Tomorrow Corporation'),
(112, 'The Irregular Corporation'),
(113, 'Dry Cactus'),
(114, '5th Cell'),
(115, 'WB Games'),
(116, 'Mediatonic'),
(117, 'Epic Games'),
(118, 'Traveller''s Tales'),
(119, 'ConcernedApe'),
(120, 'Chucklefish Games'),
(121, 'SUKEBAN'),
(122, 'Ysbryd Games'),
(123, 'Toge Productions'),
(124, 'Team Salvato'),
(125, 'PLAYISM'),
(126, 'IO Interactive');



-- Pegi Ratings
INSERT INTO `pegi` (`id`, `name`, `image_url`) VALUES
(3, 'PEGI 3', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/3.png'),
(7, 'PEGI 7', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/7.png'),
(12, 'PEGI 12', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/12.png'),
(16, 'PEGI 16', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/16.png'),
(18, 'PEGI 18', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/18.png');

-- Roles
INSERT INTO `roles` (`id`, `name`) VALUES
(0, 'Administrador'),
(1, 'Usuario');

-- Subscription Plans
INSERT INTO `plans` (`id`, `name`, `description`, `price`, `quality`, `gpu`) VALUES
(0, 'Gratis', 'Acceso limitado a juegos antiguos', 4.99, '720p', 'NVIDIA GeForce RTX 4090'),
(1, 'Standar', 'Acceso a 200 juegos y descuentos exclusivos', 9.99, '1080p', 'NVIDIA GeForce RTX 5070ti'),
(2, 'Premium', 'Acceso total a todo el catálogo y betas', 19.99, '4K', 'NVIDIA GeForce RTX 5090');

-- Games
INSERT INTO `games` (`id`, `developer_id`, `publisher_id`, `pegi_id`, `steam_id`, `igdb_id`, `title`, `summary`, `description`, `cover_url`, `banner_url`, `hero_url`, `logo_url`, `metacritic_score`, `release_date`, `published_at`, `is_featured`, `is_active`, `slug`) VALUES
(1, 1, 1, 18, 108600, 3189, 'Project Zomboid', '¿Cómo morirás? La supervivencia zombi definitiva en un mundo implacable.', 'Project Zomboid es la cima de la supervivencia zombi. En un mapa inmenso basado en la Kentucky rural, los jugadores deben saquear casas, construir defensas y luchar contra el hambre, la sed y la enfermedad mientras intentan evitar ser devorados por la horda implacable.', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/logo.png', 80, '2013-11-08', '2025-12-05 22:30:00', 1, 1, 'project-zomboid'),
(2, 2, 3, 16, 2677660, 142415, 'Indiana Jones and the Great Circle', 'Desentraña uno de los mayores misterios de la historia en esta aventura trotamundos.', 'Viaja al año 1937 y ponte el sombrero del arqueólogo más famoso del cine. Indiana Jones and the Great Circle es una experiencia de acción y aventura en primera persona.', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/logo.png', 85, '2024-12-09', '2025-11-15 19:30:00', 1, 1, 'indiana-jones-and-the-great-circle'),
(3, 4, 5, 3, 949230, 240902, 'Cities: Skylines II', 'Crea una ciudad desde cero y transfórmala en una metrópolis próspera.', 'Alza una ciudad desde sus cimientos y transfórmala en la metrópolis próspera que solo tú puedes imaginar. Nunca has experimentado una construcción a esta escala. Con una simulación profunda y una economía viva, Cities: Skylines II te permite construir un mundo sin límites.', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/logo.png', 74, '2023-10-24', '2025-11-05 22:45:00', 1, 1, 'cities-skylines-2'),
(4, 6, 7, 18, 1174180, 25076, 'Red Dead Redemption 2', 'Una epopeya de forajidos en el ocaso del Salvaje Oeste americano.', 'Estados Unidos, 1899. Arthur Morgan y la banda de Van der Linde se ven obligados a huir tras un atraco fallido.', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/logo.png', 97, '2019-12-05', '2026-04-15 20:15:00', 1, 1, 'red-dead-redemption-2'),
(5, 8, 9, 3, 2842040, 252827, 'Star Wars Outlaws', 'Vive la vida de una buscavidas en el primer mundo abierto de Star Wars.', 'Explora planetas distintos por toda la galaxia, tanto nuevos como clásicos.', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/logo.png', 76, '2024-08-30', '2026-05-05 16:30:00', 1, 1, 'star-wars-outlaws'),
(6, 10, 11, 16, 2651280, 127044, 'Marvel''s Spider-Man 2', 'Los Spider-Men Peter Parker y Miles Morales regresan para una nueva aventura.', 'Balancéate, salta y usa tus Alas de Telaraña para viajar por la Nueva York de Marvel.', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/logo.png', 90, '2025-01-30', '2025-01-20 07:00:00', 0, 1, 'marvels-spider-man-2'),
(7, 12, 13, 3, 990080, 136625, 'Hogwarts Legacy', 'Vive lo desconocido en el Colegio Hogwarts en el siglo XIX.', 'Hogwarts Legacy es un RPG de acción en un mundo abierto.', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 84, '2023-02-10', '2025-09-20 11:45:00', 0, 1, 'hogwarts-legacy'),
(8, 14, 14, 18, 250320, 2993, 'The Wolf Among Us', 'Un thriller crudo, violento y maduro basado en los cómics de Fábulas.', 'Ponte en la piel de Bigby Wolf, el lobo feroz.', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/logo.png', 85, '2013-10-11', '2026-01-20 22:30:00', 0, 1, 'the-wolf-among-us'),
(9, 15, 16, 18, 1091500, 1877, 'Cyberpunk 2077', 'Conviértete en un mercenario ciberpunk en Night City.', 'Cyberpunk 2077 es un RPG de acción y aventura en mundo abierto.', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/logo.png', 86, '2020-12-10', '2025-02-10 13:30:00', 0, 1, 'cyberpunk-2077'),
(10, 17, 18, 16, 1245620, 119133, 'Elden Ring', 'Levántate, Sinluz, para convertirte en el Señor del Círculo.', 'Elden Ring es una épica aventura de RPG de acción.', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/logo.png', 96, '2022-02-25', '2025-08-25 22:45:00', 0, 1, 'elden-ring'),
(11, 19, 19, 18, 1086940, 119171, 'Baldur''s Gate III', 'Regresa a los Reinos Olvidados en una historia de compañerismo.', 'Baldur''s Gate 3 es un RPG de nueva generación.', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/logo.png', 96, '2023-08-03', '2025-12-20 22:45:00', 0, 1, 'baldurs-gate-3'),
(12, 20, 21, 3, 1551360, 141503, 'Forza Horizon 5', 'Tu aventura Horizon definitiva te espera en México.', 'Conduce por un mundo abierto lleno de contrastes y belleza.', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 92, '2021-11-09', '2025-03-10 08:30:00', 0, 1, 'forza-horizon-5'),
(13, 22, 23, 18, 2050650, 145191, 'Resident Evil 4', 'La supervivencia es solo el principio.', 'Seis años después de Raccoon City, Leon S. Kennedy es enviado a una misión de rescate.', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/logo.png', 93, '2023-03-24', '2025-04-15 17:45:00', 0, 1, 'resident-evil-4'),
(14, 24, 24, 16, 1808500, 185258, 'ARC Raiders', 'Shooter de extracción donde la humanidad resiste a una amenaza mecánica.', 'ARC Raiders es un shooter de extracción en tercera persona gratuito.', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/logo.png', 82, '2025-10-15', '2025-01-15 10:45:00', 0, 1, 'arc-raiders'),
(15, 25, 11, 18, 2322010, 112875, 'God of War Ragnarök', 'Kratos y Atreus deben viajar a cada uno de los Nueve Reinos.', 'Acompaña a Kratos y Atreus en un viaje épico y emotivo mientras luchan por aferrarse y soltarse.', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/logo.png', 94, '2024-09-19', '2025-10-20 15:45:00', 0, 1, 'god-of-war-ragnarok'),
(16, 26, 11, 16, 2420110, 112874, 'Horizon Forbidden West', 'Acompaña a Aloy en su aventura por las majestuosas tierras del Oeste Prohibido.', 'Explora tierras lejanas, lucha contra máquinas más grandes e imponentes.', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/logo.png', 89, '2024-03-21', '2025-11-25 12:45:00', 0, 1, 'horizon-forbidden-west'),
(17, 27, 11, 18, 2531310, 26192, 'The Last of Us Part II', 'Una historia de venganza y redención implacable en un mundo devastado.', 'Cinco años después de su peligroso viaje, Ellie y Joel se han asentado en Jackson.', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/logo.png', 93, '2024-06-19', '2026-03-15 22:00:00', 0, 1, 'the-last-of-us-part-2'),
(18, 28, 11, 18, 2215430, 75235, 'Ghost of Tsushima', 'El honor de un samurái se enfrenta a una invasión brutal.', 'A finales del siglo XIII, el Imperio mongol ha devastado naciones enteras.', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/logo.png', 87, '2024-05-16', '2025-05-05 15:45:00', 0, 1, 'ghost-of-tsushima'),
(19, 29, 11, 16, 1446720, 134584, 'Returnal', 'Rompe el ciclo en este shooter roguelike en tercera persona.', 'Tras el aterrizaje forzoso en un mundo alienígena, Selene debe explorar el paisaje desolado.', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/logo.png', 86, '2023-02-15', '2025-08-15 18:00:00', 0, 1, 'returnal'),
(20, 30, 11, 18, 2401410, 134606, 'Demon''s Souls', 'Regresa al reino de Boletaria en este remake magistral.', 'En su búsqueda de poder, el duodécimo rey de Boletaria despertó a un demonio antiguo.', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/logo.png', 92, '2024-05-20', '2026-05-20 13:45:00', 0, 1, 'demons-souls'),
(21, 31, 32, 3, 1332010, 110248, 'Stray', 'Un gato callejero debe resolver un antiguo misterio.', 'Stray es un juego de aventuras protagonizado por un gato en una ciberciudad decadente.', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/logo.png', 83, '2022-07-19', '2025-10-05 11:45:00', 0, 1, 'stray'),
(22, 33, 34, 3, 1426210, 135243, 'It Takes Two', 'La aventura de plataformas cooperativa definitiva.', 'Ponte en la piel de Cody y May, una pareja en conflicto convertida en muñecos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 88, '2021-03-26', '2026-04-20 07:00:00', 0, 1, 'it-takes-two'),
(23, 35, 3, 18, 1252330, 113598, 'Deathloop', 'Rompe el bucle temporal en este shooter de Arkane Studios.', 'Dos asesinos rivales atrapados en un bucle temporal misterioso en la isla de Blackreef.', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/logo.png', 87, '2021-09-14', '2025-02-20 07:45:00', 0, 1, 'deathloop'),
(24, 36, 37, 16, 870780, 136604, 'Control: Ultimate Edition', 'Domina habilidades sobrenaturales en este thriller de Remedy.', 'Tras una invasión secreta en Nueva York, te conviertes en la nueva directora.', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/logo.png', 85, '2020-08-27', '2026-02-20 14:00:00', 0, 1, 'control-ultimate-edition'),
(25, 38, 38, 16, 2138710, 144022, 'Sifu', 'La venganza requiere toda una vida de entrenamiento en este beat ''em up de kung-fu.', 'Sifu cuenta la historia de un joven estudiante de kung-fu en busca de venganza contra los asesinos de su familia.', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/logo.png', 81, '2023-03-28', '2026-06-25 08:30:00', 0, 1, 'sifu'),
(26, 39, 34, 18, 1693980, 131931, 'Dead Space', 'El clásico de terror y supervivencia de ciencia ficción regresa reconstruido.', 'Isaac Clarke es un ingeniero cualquiera en una misión para reparar la USG Ishimura.', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/logo.png', 89, '2023-01-27', '2026-05-10 18:15:00', 0, 1, 'dead-space'),
(27, 40, 41, 3, 1817230, 233585, 'Hi-Fi Rush', 'Siente el ritmo mientras Chai y su equipo luchan contra un megaconglomerado.', 'Siente el ritmo en la piel con Hi-Fi RUSH, donde el mundo se sincroniza con la música.', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/logo.png', 87, '2023-01-25', '2026-03-25 07:30:00', 0, 1, 'hi-fi-rush'),
(28, 42, 23, 18, 1196590, 55163, 'Resident Evil Village', 'Vive el horror de supervivencia como nunca antes en la octava entrega.', 'Ethan Winters deberá adentrarse en un pueblo remoto dominado por cuatro jerarcas.', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/logo.png', 84, '2021-05-07', '2025-07-20 22:15:00', 0, 1, 'resident-evil-village'),
(29, 43, 3, 18, 782330, 103298, 'Doom Eternal', 'Los ejércitos del infierno han invadido la Tierra. Arrasa con todo.', 'Experimenta la combinación definitiva de velocidad y potencia en la evolución del FPS.', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/logo.png', 88, '2020-03-20', '2026-01-10 14:45:00', 0, 1, 'doom-eternal'),
(30, 33, 34, 18, 1222700, 36897, 'A Way Out', 'Una aventura cooperativa donde juegas el papel de dos prisioneros.', 'De los creadores de Brothers llega una historia de fuga emocional e impredecible.', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/logo.png', 78, '2018-03-23', '2026-05-25 11:30:00', 0, 1, 'a-way-out'),
(31, 44, 44, 18, 546560, 126098, 'Half-Life: Alyx', 'El regreso de Valve a Half-Life en una experiencia VR completa.', 'Situada entre Half-Life y Half-Life 2, eres Alyx Vance, la última esperanza humana.', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/logo.png', 93, '2020-03-23', '2025-02-15 09:45:00', 0, 1, 'half-life-alyx'),
(32, 45, 45, 18, 534380, 102584, 'Dying Light 2: Stay Human', 'Sobrevive en un mundo abierto brutal donde la humanidad pierde la batalla.', 'Utiliza tus habilidades de parkour para recorrer la ciudad y dominar el combate creativo.', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/logo.png', 77, '2022-02-04', '2025-07-10 12:15:00', 0, 1, 'dying-light-2-stay-human'),
(33, 44, 44, 3, 620, 72, 'Portal 2', 'La secuela del aclamado juego de puzles con humor negro y narrativa única.', 'Regresa a Aperture Science para enfrentarte una vez más a GLaDOS junto a Wheatley.', 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/logo.png', 95, '2011-04-18', '2026-06-10 16:45:00', 0, 1, 'portal-2'),
(34, 46, 34, 18, 1328670, 140839, 'Mass Effect Legendary Edition', 'Vive la leyenda de Shepard en la trilogía remasterizada.', 'Incluye el contenido básico para un jugador y más de 40 DLC de los tres juegos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/logo.png', 86, '2021-05-14', '2025-10-25 19:15:00', 0, 1, 'mass-effect-legendary-edition'),
(35, 47, 21, 3, 1172620, 11137, 'Sea of Thieves', 'Navega, lucha y saquea en esta experiencia pirata definitiva.', 'Sin roles establecidos, tienes total libertad para enfrentarte al mundo como quieras.', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/logo.png', 82, '2020-06-03', '2025-06-15 13:45:00', 0, 1, 'sea-of-thieves'),
(36, 48, 48, 18, 2208920, 133004, 'Assassin''s Creed Valhalla', 'Conviértete en Eivor, una leyenda vikinga en busca de gloria.', 'Lidera a tu clan desde las gélidas costas de Noruega hasta la Inglaterra del siglo IX.', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/logo.png', 82, '2022-12-06', '2025-09-25 07:00:00', 0, 1, 'assassins-creed-valhalla'),
(37, 49, 50, 3, 1145360, 113112, 'Hades', 'Desafía al dios de los muertos en este roguelike de Supergiant.', 'Como el príncipe inmortal del Inframundo, usarás los poderes del Olimpo para escapar.', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/logo.png', 93, '2020-09-17', '2025-08-20 19:00:00', 0, 1, 'hades'),
(38, 17, 51, 18, 814380, 76882, 'Sekiro: Shadows Die Twice', 'Traza tu propio camino hacia la venganza en esta aventura de FromSoftware.', 'Encarnas al lobo manco en el Japón Sengoku para rescatar a tu joven señor.', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/logo.png', 88, '2019-03-22', '2025-05-20 08:30:00', 0, 1, 'sekiro-shadows-die-twice'),
(39, 23, 23, 3, 367520, 365702, 'Hollow Knight', 'Aventura de acción épica a través de un reino en ruinas.', 'Explora cavernas retorcidas y lucha contra criaturas corrompidas en Hallownest.', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/logo.png', 87, '2017-02-24', '2026-02-10 18:00:00', 0, 1, 'hollow-knight'),
(40, 52, 21, 3, 1057090, 37001, 'Ori and the Will of the Wisps', 'Embárcate en una nueva aventura en un mundo vasto y exótico.', 'Ori debe reunir a una familia y curar una tierra quebrantada en esta esperada secuela.', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/logo.png', 88, '2020-03-11', '2025-04-25 07:45:00', 0, 1, 'ori-and-the-will-of-the-wisps'),
(41, 23, 23, 18, 883710, 347128, 'Resident Evil 2', 'Una obra maestra que redefine el género regresa reconstruida.', 'Juega como Leon y Claire en Raccoon City infestada de zombis con el RE Engine.', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/logo.png', 89, '2019-01-25', '2026-02-25 17:30:00', 0, 1, 'resident-evil-2'),
(42, 42, 23, 18, 952060, 115115, 'Resident Evil 3', 'Jill Valentine presencia las atrocidades de Umbrella en Raccoon City.', 'Escapa de Nemesis, el arma secreta definitiva, en esta intensa recreación del clásico.', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/logo.png', 77, '2020-04-03', '2025-09-10 21:30:00', 0, 1, 'resident-evil-3'),
(43, 53, 54, 3, 289070, 19130, 'Civilization VI', 'Construye un imperio que resista el paso del tiempo en este juego de estrategia.', 'Civilization VI ofrece nuevas formas de interactuar con tu mundo: las ciudades se expanden físicamente.', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/logo.png', 88, '2016-10-21', '2025-02-25 10:45:00', 0, 1, 'civilization-vi'),
(44, 55, 56, 16, 1462040, 144024, 'Final Fantasy VII Remake Intergrade', 'La espectacular reinvención del clásico de Square Enix llega con contenido expandido.', 'Cloud Strife ayuda al grupo Avalancha en su lucha contra la corporación Shinra en Midgar.', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/logo.png', 89, '2022-06-17', '2025-06-25 21:15:00', 0, 1, 'final-fantasy-6-remake-intergrade'),
(45, 57, 51, 3, 1378990, 135254, 'Crash Bandicoot 4', 'Crash y Coco regresan en una aventura que salta a través del tiempo.', 'Neo Cortex y N. Tropy han vuelto para intentar conquistar el multiverso entero.', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/logo.png', 85, '2022-10-18', '2026-02-15 11:15:00', 0, 1, 'crash-bandicoot-4-its-about-time'),
(46, 57, 51, 3, 996580, 87683, 'Spyro Reignited Trilogy', 'El maestro de las llamaradas ha vuelto. Disfruta de la trilogía remasterizada.', 'Revive la magia de los tres juegos originales de Spyro completamente recreados.', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/logo.png', 82, '2019-09-03', '2025-04-20 20:30:00', 0, 1, 'spyro-reignited-trilogy'),
(47, 58, 21, 3, 1466860, 55029, 'Age of Empires IV', 'Celebra el regreso de la legendaria saga de estrategia en tiempo real.', 'Age of Empires IV te sitúa en el centro de batallas históricas épicas que moldearon el mundo.', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/logo.png', 81, '2021-10-28', '2025-07-25 21:15:00', 0, 1, 'age-of-empires-iv'),
(48, 23, 23, 3, 1364780, 343673, 'Street Fighter 6', 'El nuevo estandarte de la lucha de Capcom llega con estilo urbano.', 'Impulsado por el motor RE ENGINE, ofrece tres modos distintos: Fighting Ground, World Tour y Battle Hub.', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/logo.png', 92, '2023-06-02', '2025-08-05 09:45:00', 0, 1, 'street-fighter-6'),
(49, 59, 9, 3, 1341050, 119357, 'Immortals Fenyx Rising', 'Vive una gran aventura mitológica como Fenyx, un semidiós alado.', 'Erese la última esperanza de los dioses griegos en una misión para salvarlos de Tifón.', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/logo.png', 79, '2020-12-03', '2025-02-05 08:15:00', 0, 1, 'immortals-fenyx-rising'),
(50, 48, 9, 18, 359550, 7360, 'Rainbow Six Siege', 'Domina el arte de la destrucción en este shooter táctico de élite.', 'Shooter táctico realista por equipos donde la planificación es la clave de la victoria.', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/logo.png', 79, '2015-12-01', '2025-05-10 12:00:00', 0, 1, 'tom-clancys-rainbow-six-siege'),
(51, 60, 34, 16, 17410, 1051, 'Mirror''s Edge', 'Corre por los tejados en una ciudad donde la información se vigila.', 'Mirror''s Edge redefine el género de acción con un enfoque revolucionario en el parkour.', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/logo.png', 81, '2009-01-13', '2025-10-10 08:45:00', 0, 1, 'mirrors-edge'),
(52, 61, 62, 3, 682990, 22917, 'Gris', 'Una experiencia serena sobre el dolor y la superación personal.', 'Gris es una joven perdida en su propio mundo debido a una experiencia dolorosa.', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/logo.png', 84, '2018-12-13', '2025-01-25 13:45:00', 0, 1, 'gris'),
(53, 42, 23, 18, 601150, 76253, 'Devil May Cry 5', 'El cazademonios definitivo regresa con el combate más frenético.', 'Con tres personajes jugables, DMC5 ofrece la culminación del género hack and slash.', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/logo.png', 89, '2019-03-08', '2025-07-15 13:15:00', 0, 1, 'devil-may-cry-5'),
(54, 63, 34, 3, 3300000, 336964, 'F1 25', 'Domina la nueva era de la velocidad en el juego oficial de la F1.', 'F1 25 redefine la simulación con un motor físico renovado y todas las escuderías actuales.', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/logo.png', 84, '2025-05-30', '2025-10-15 12:15:00', 0, 1, 'f1-25'),
(55, 64, 21, 3, 1250410, 119295, 'Microsoft Flight Simulator', 'Explora el mundo entero con un detalle asombroso.', 'Vuela aeronaves altamente detalladas en un mundo dinámico generado por datos satelitales.', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/logo.png', 91, '2020-08-18', '2025-05-25 19:30:00', 0, 1, 'microsoft-flight-simulator'),
(56, 65, 65, 16, 1601580, 164290, 'Frostpunk 2', 'Sobrevive al invierno eterno en una sociedad dividida.', 'Treinta años después de la tormenta, debes liderar una metrópolis que ya no solo lucha contra el frío.', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/logo.png', 86, '2024-09-20', '2025-11-10 20:45:00', 0, 1, 'frostpunk-2'),
(57, 66, 66, 3, 1623730, 151665, 'Palworld', 'Sobrevive, construye y lucha junto a misteriosas criaturas llamadas Pals.', 'Palworld es un juego de supervivencia y recolección de criaturas en un mundo abierto masivo.', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/logo.png', 70, '2024-01-19', '2026-01-05 09:45:00', 0, 1, 'palworld'),
(58, 67, 34, 3, 1774580, 201156, 'Star Wars Jedi: Survivor', 'La historia de Cal Kestis continúa en esta aventura galáctica.', 'Cinco años después de Fallen Order, Cal Kestis debe mantenerse un paso por delante del Imperio.', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/logo.png', 85, '2023-04-28', '2025-12-25 16:15:00', 0, 1, 'star-wars-jedi-survivor'),
(59, 68, 18, 18, 1501750, 4847, 'Lords of the Fallen', 'Un vasto mundo te espera en este RPG de fantasía oscura.', 'Viaja a través de los reinos de los vivos y los muertos como un Cruzado de la Oscuridad.', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/logo.png', 75, '2023-10-13', '2025-05-15 18:15:00', 0, 1, 'lords-of-the-fallen'),
(60, 69, 70, 16, 1627720, 148241, 'Lies of P', 'Una versión oscura de Pinocho ambientada en la Belle Époque.', 'Como una marioneta creada por Geppetto, lucha por encontrar a tu creador en la ciudad de Krat.', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/logo.png', 80, '2023-09-18', '2025-04-10 15:45:00', 0, 1, 'lies-of-p'),
(61, 71, 62, 3, 1313140, 165351, 'Cult of the Lamb', 'Crea tu propia secta y conviértete en el Dios Cordero.', 'Gestiona recursos, realiza rituales oscuros y da sermones para reforzar la fe de tu rebaño.', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/logo.png', 82, '2022-08-11', '2025-06-05 22:45:00', 0, 1, 'cult-of-the-lamb'),
(62, 17, 17, 3, 1888160, 228542, 'Armored Core VI: Fires of Rubicon', 'Acción de mechas de alta intensidad por FromSoftware.', 'Pilota tu mecha en batallas vertiginosas por el control de la misteriosa sustancia Coral.', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/logo.png', 86, '2023-08-25', '2026-06-20 12:30:00', 0, 1, 'armored-core-vi-fires-of-rubicon'),
(63, 72, 41, 18, 1544020, 141538, 'The Callisto Protocol', 'Sobrevive a los horrores de la Prisión de Hierro Negro.', 'Jacob Lee debe escapar de la luna muerta de Júpiter mientras reclusos mutan en monstruos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/logo.png', 69, '2022-12-02', '2025-01-10 10:30:00', 0, 1, 'the-callisto-protocol'),
(64, 64, 73, 18, 1182900, 152242, 'A Plague Tale: Requiem', 'Un viaje desgarrador hacia un mundo asombroso y despiadado.', 'Amicia y Hugo buscan una cura para la maldición en una isla mística del sur.', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/logo.png', 82, '2022-10-18', '2025-12-15 10:15:00', 0, 1, 'a-plague-tale-requiem'),
(65, 74, 75, 18, 2124490, 222341, 'Silent Hill 2', 'Clase magistral de terror psicológico recreada fielmente.', 'James Sunderland regresa a Silent Hill tras recibir una carta de su difunta esposa.', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/logo.png', 86, '2024-10-08', '2025-03-15 14:00:00', 0, 1, 'silent-hill-2'),
(66, 76, 34, 3, 1846380, 219442, 'Need for Speed: Unbound', 'Gana The Grand, el desafío de carreras callejeras definitivo.', 'Personaliza tu garaje con coches tuneados y domina las calles con un estilo visual único.', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/logo.png', 73, '2022-12-02', '2025-08-10 09:45:00', 0, 1, 'need-for-speed-unbound'),
(67, 77, 78, 3, 1363080, 137206, 'Manor Lords', 'Estrategia medieval con construcción de ciudades y batallas.', 'Construcción orgánica sin cuadrículas y gestión económica compleja del siglo XIV.', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/logo.png', 82, '2024-04-26', '2025-03-25 17:45:00', 0, 1, 'manor-lords'),
(68, 79, 23, 3, 1446780, 138950, 'Monster Hunter Rise', 'Acepta el desafío y únete a la caza en la Aldea Kamura.', 'Utiliza el Cordóptero y los Canyne para enfrentarte a hordas de monstruos en el Frenesí.', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 87, '2022-01-12', '2025-03-05 12:00:00', 0, 1, 'monster-hunter-rise'),
(69, 80, 81, 18, 1325200, 103330, 'Nioh 2', 'Desata tu oscuridad y domina el poder de los Yokai.', 'Mercenario mitad humano y Yokai lucha en el Japón de la era Sengoku.', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/logo.png', 86, '2021-02-05', '2025-01-05 18:15:00', 0, 1, 'nioh-2'),
(70, 49, 49, 12, 1145350, 228525, 'Hades II', 'La primera secuela de Supergiant Games profundiza en la brujería y el Inframundo.', 'Lucha más allá del Inframundo utilizando brujería oscura para enfrentarte al Titán del Tiempo en esta secuela del aclamado roguelike de exploración de mazmorras.', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/logo.png', 90, '2024-05-06', '2026-03-05 10:30:00', 0, 1, 'hades-2'),
(71, 82, 82, 12, 881020, 22788, 'Granblue Fantasy: Relink', 'Forma un grupo de cuatro y ábrete camino hacia la victoria en este RPG de acción.', '¡Surca los cielos en Granblue Fantasy: Relink! Forma un grupo de cuatro a partir de un elenco variado de navegantes y corta, dispara o hechiza para derrotar a enemigos traicioneros.', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/logo.png', 80, '2024-02-01', '2026-03-20 10:45:00', 0, 1, 'granblue-fantasy-relink'),
(72, 83, 84, 16, 1687950, 114283, 'Persona 5 Royal', 'Ponte la máscara y únete a los Ladrones de Guante Blanco en el RPG definitivo.', 'Persona 5 Royal presenta una historia profunda y elegante donde exploras Tokio, desbloqueas Personas y personalizas tu propia Guarida de los Ladrones.', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/logo.png', 95, '2022-10-21', '2025-11-20 12:00:00', 0, 1, 'persona-5-royal'),
(73, 85, 85, 16, 2358720, 136879, 'Black Myth: Wukong', 'Un RPG de acción basado en la mitología china y la novela Viaje al Oeste.', 'Black Myth: Wukong es un RPG de acción inspirado en la mitología china. La historia se basa en \"Viaje al Oeste\", una de las cuatro grandes novelas clásicas de la literatura china.', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/logo.png', 81, '2024-08-20', '2026-03-10 08:30:00', 0, 1, 'black-myth-wukong'),
(74, 86, 32, 7, 753640, 11737, 'Outer Wilds', 'Un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal.', 'Outer Wilds es un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal infinito. Eres el nuevo recluta de Outer Wilds Ventures.', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/logo.png', 85, '2019-05-30', '2026-04-10 17:30:00', 0, 1, 'outer-wilds'),
(75, 42, 23, 18, 2054970, 115060, 'Dragon''s Dogma II', 'Embárcate en tu gran aventura, Arisen, en este RPG de acción narrativo.', 'Dragon''s Dogma 2 es un RPG de acción narrativo que desafía a los jugadores a elegir su propia experiencia.', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/logo.png', 86, '2024-03-22', '2025-06-20 09:30:00', 0, 1, 'dragons-dogma-2'),
(76, 87, 56, 18, 524220, 11208, 'NieR: Automata', 'La humanidad ha sido expulsada de la Tierra por formas de vida mecánicas.', 'NieR:Automata narra la historia de los androides 2B, 9S y A2 y su batalla para recuperar una distopía dirigida por máquinas.', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/logo.png', 88, '2017-03-17', '2025-03-20 17:15:00', 0, 1, 'nierautomata'),
(77, 88, 11, 18, 553850, 250616, 'Helldivers 2', 'La última línea de defensa de la galaxia. Únete a los Helldivers y lucha por la libertad.', 'Helldivers 2 es un shooter por equipos en tercera persona en el que las fuerzas de élite luchan para librar a la galaxia de amenazas alienígenas.', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/logo.png', 82, '2024-02-08', '2026-05-15 15:30:00', 0, 1, 'helldivers-2'),
(78, 89, 89, 18, 632470, 26472, 'Disco Elysium', 'Un RPG de mundo abierto revolucionario donde tú decides qué tipo de detective ser.', 'Disco Elysium es un innovador juego de rol. Eres un detective con un sistema de habilidades único a tu disposición.', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/logo.png', 97, '2019-10-15', '2026-02-05 09:00:00', 0, 1, 'disco-elysium'),
(79, 90, 73, 18, 2183900, 185252, 'Warhammer 40,000: Space Marine II', 'Encarna la brutalidad sobrehumana de un Marine Espacial contra los Tiránidos.', 'La galaxia está en peligro. Mundos enteros están cayendo. Encarna la habilidad y brutalidad sobrehumana de un Marine Espacial.', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/logo.png', 82, '2024-09-09', '2026-01-25 20:30:00', 0, 1, 'warhammer-40000-space-marine-2'),
(80, 91, 92, 18, 8870, 538, 'BioShock Infinite', 'Lleva a la chica y saldarás tu deuda. Una aventura en la ciudad aérea de Columbia.', 'Booker DeWitt solo tiene una oportunidad para limpiar su nombre: debe rescatar a Elizabeth en la ciudad flotante de Columbia.', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/logo.png', 94, '2013-03-25', '2025-09-05 20:00:00', 0, 1, 'bioshock-infinite'),
(81, 93, 93, 7, 268910, 9061, 'Cuphead', 'Un juego de acción clásico de \"dispara y corre\" centrado en batallas contra jefes.', 'Cuphead es un juego de acción clásico inspirado en las caricaturas de la década de 1930.', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/logo.png', 88, '2017-09-29', '2025-12-05 14:00:00', 0, 1, 'cuphead'),
(82, 94, 95, 3, 2379780, 251833, 'Balatro', 'Un roguelike de póker hipnótico donde puedes crear combos ilegales.', 'Balatro es un constructor de mazos roguelike con temática de póker que trata de crear combos poderosos.', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/logo.png', 90, '2024-02-20', '2025-11-15 16:00:00', 0, 1, 'balatro'),
(83, 96, 97, 3, 2669320, 308698, 'EA Sports FC 25', 'Siente la emoción del fútbol con el nuevo modo Rush 5 contra 5 y FC IQ.', 'EA SPORTS FC 25 te ofrece más formas de ganar por el club. Forma equipo en Rush de 5 contra 5 con FC IQ renovado.', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/logo.png', 76, '2024-09-27', '2025-09-20 21:45:00', 0, 1, 'ea-sports-fc-25'),
(84, 98, 97, 3, 2582560, 301506, 'Madden NFL 25', 'Golpea como si fuera en serio con FieldSENSE y la nueva tecnología BOOM Tech.', 'Experimenta un sistema de placajes dinámico y con base física que permite realizar animaciones realistas.', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/logo.png', 70, '2024-08-16', '2026-01-20 10:30:00', 0, 1, 'madden-nfl-25'),
(85, 99, 100, 3, 2878980, 308034, 'NBA 2K25', 'Domina cada cancha con autenticidad y realismo gracias a ProPLAY.', 'Compite a tu manera mientras forjas tu legado en Mi CARRERA y Mi EQUIPO con tecnología ProPLAY.', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/logo.png', 78, '2024-09-06', '2025-02-10 15:45:00', 0, 1, 'nba-2k25'),
(86, 101, 101, 18, 381210, 18866, 'Dead by Daylight', 'Un juego de terror multijugador de 4 contra 1 donde uno es el asesino.', 'Un jugador asume el rol de asesino despiadado y los otros cuatro juegan como supervivientes que intentan escapar.', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/logo.png', 71, '2016-06-14', '2025-08-25 16:30:00', 0, 1, 'dead-by-daylight'),
(87, 102, 103, 16, 2516900, 249013, 'The Precinct', 'Una carta de amor a las películas policiales de los 80. Eres la ley en Averno City.', 'Averno City, 1983. Eres Nick Cordell Jr. policía novato en un mundo de persecuciones trepidantes.', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/logo.png', 80, '2024-10-01', '2025-12-20 08:45:00', 0, 1, 'the-precinct'),
(88, 104, 5, 7, 281990, 11582, 'Stellaris', 'Explora una galaxia llena de maravillas en este juego de gran estrategia de ciencia ficción.', 'Prepárate para explorar, descubrir e interactuar con una multitud de especies mientras viajas por las estrellas.', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/logo.png', 78, '2016-05-09', '2025-03-10 07:30:00', 0, 1, 'stellaris'),
(89, 48, 9, 18, 242700, 1121, 'Watch Dogs', 'En Chicago, tú eres el hacker definitivo. El sistema es tu arma.', 'Encarna a Aiden Pearce, un brillante hacker. Accede a cámaras de seguridad y controla la ciudad.', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/logo.png', 77, '2014-05-27', '2025-04-15 17:30:00', 0, 1, 'watch-dogs'),
(90, 105, 106, 18, 1139900, 121752, 'Ghostrunner', 'Un juego de acción \"slasher\" en primera persona con estética cyberpunk.', 'Combates vertiginosos y violentos en una ambientación que combina ciencia ficción con postapocalipsis.', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/logo.png', 81, '2020-10-27', '2025-01-15 10:30:00', 0, 1, 'ghostrunner'),
(91, 107, 18, 12, 1790600, 279634, 'Dragon Ball: Sparking! Zero', '¡El regreso de la legendaria saga Budokai Tenkaichi!', 'Siente el poder destructivo de los guerreros más fuertes en escenarios que se desmoronan.', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/logo.png', 82, '2024-10-11', '2025-10-20 20:30:00', 0, 1, 'dragon-ball-sparking-zero'),
(92, 108, 108, 3, 227300, 3070, 'Euro Truck Simulator 2', 'Viaja por Europa como el rey de la carretera.', 'Explora docenas de ciudades entregando cargas importantes por toda Europa.', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/logo.png', 79, '2012-10-18', '2025-11-25 07:30:00', 0, 1, 'euro-truck-simulator-2'),
(93, 109, 110, 3, 220200, 3102, 'Kerbal Space Program', 'Dirige el programa espacial de una raza alienígena y domina la astrofísica.', 'Monta naves espaciales plenamente funcionales que vuelan basándose en leyes físicas reales.', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/logo.png', 88, '2015-04-27', '2026-03-15 13:00:00', 0, 1, 'kerbal-space-program'),
(94, 111, 111, 3, 375820, 14545, 'Human Resource Machine', 'Programa a pequeños oficinistas para resolver puzles.', 'Automatiza tareas programando a tu oficinista. Programar no es más que resolver puzles.', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/logo.png', 78, '2015-10-15', '2025-05-05 10:15:00', 0, 1, 'human-resource-machine'),
(95, 112, 112, 3, 621060, 27792, 'PC Building Simulator', 'Aprende a montar y reparar ordenadores reales.', 'Crea tu propio imperio de reparación de ordenadores. Aprende a diagnosticar, reparar y montar PCs con componentes reales.', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/logo.png', 72, '2019-01-29', '2025-08-15 10:00:00', 0, 1, 'pc-building-simulator'),
(97, 48, 9, 12, 1613530, 152231, 'Discovery Tour: Viking Age', 'Explora la historia vikinga sin combates en un museo viviente.', 'Discovery Tour te permite viajar por el mundo de Assassin''s Creed Valhalla para aprender sobre su historia y cultura.', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/logo.png', 80, '2021-10-19', '2025-10-05 18:30:00', 0, 1, 'discovery-tour-viking-age'),
(98, 113, 113, 3, 1850240, 243400, 'Poly Bridge 3', 'Aprende ingeniería construyendo puentes creativos.', 'Diseña y construye puentes para que los vehículos lleguen a su destino. Una simulación de física y estructuras.', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/logo.png', 82, '2023-05-30', '2026-04-20 07:45:00', 0, 1, 'poly-bridge-3'),
(99, 114, 115, 3, 218680, 2943, 'Scribblenauts Unlimited', 'Fomenta la creatividad invocando cualquier objeto imaginable.', 'Ayuda a Maxwell a resolver puzles en un mundo abierto donde puedes crear cualquier objeto escribiendo su nombre.', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/logo.png', 75, '2012-11-20', '2025-02-20 11:30:00', 0, 1, 'scribblenauts-unlimited'),
(100, 116, 117, 3, 1097150, 119313, 'Fall Guys', '¡Tropieza hacia la victoria en este battle royale de plataformas!', 'Compite a través de rondas de obstáculos cada vez más locas hasta que solo queda un vencedor.', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/logo.png', 80, '2020-08-04', '2026-02-20 19:15:00', 0, 1, 'fall-guys'),
(101, 118, 115, 7, 1443370, 119305, 'LEGO Star Wars: The Skywalker Saga', 'Vive las nueve películas de la saga con el humor de LEGO.', 'Juega a través de toda la saga Star Wars con cientos de personajes y vehículos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/logo.png', 82, '2022-04-05', '2026-06-25 20:15:00', 0, 1, 'lego-star-wars-the-skywalker-saga'),
(102, 119, 120, 3, 413150, 17000, 'Stardew Valley', 'Hereda la granja de tu abuelo y comienza una nueva vida rural.', 'Cultiva la tierra, cría animales y entabla amistad con los habitantes del pueblo.', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/logo.png', 89, '2016-02-26', '2026-03-25 07:45:00', 0, 1, 'stardew-valley'),
(103, 23, 23, 12, 787480, 21610, 'Phoenix Wright: Ace Attorney Trilogy', '¡Protesta! Defiende a tus clientes en juicios llenos de giros.', 'Investiga escenas del crimen y presenta pruebas en el tribunal para salvar a tus clientes.', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/logo.png', 81, '2019-04-09', '2025-07-20 15:15:00', 0, 1, 'phoenix-wright-ace-attorney-trilogy'),
(104, 121, 122, 16, 447530, 15465, 'VA-11 Hall-A', 'Sirve bebidas y escucha historias en un futuro cyberpunk distópico.', 'Eres una camarera en un bar de mala muerte. El juego trata sobre preparar cócteles y cómo estos influyen en la vida de tus clientes en una ciudad decadente.', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/logo.png', 83, '2016-06-21', '2026-01-10 14:00:00', 0, 1, 'va-11-hall-a'),
(105, 123, 123, 12, 914800, 106847, 'Coffee Talk', 'Prepara café y charla con habitantes de una Seattle fantástica.', 'Un juego sobre escuchar los problemas de la gente y ayudarles sirviéndoles una bebida caliente. Una experiencia narrativa relajante.', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/logo.png', 75, '2020-01-29', '2026-05-25 07:30:00', 0, 1, 'coffee-talk'),
(106, 124, 125, 18, 1388880, 152122, 'Doki Doki Literature Club Plus!', 'Únete al club de literatura en este thriller psicológico.', 'Lo que parece un inocente club escolar pronto se revela como una experiencia de terror psicológico que rompe la cuarta pared.', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/logo.png', 82, '2021-06-30', '2025-02-15 22:45:00', 0, 1, 'doki-doki-literature-club-plus'),
(107, 107, 107, 16, 477740, 25343, 'Zero Escape: The Nonary Games', 'Resuelve puzles mortales para escapar de un secuestro.', 'Nueve personas son obligadas a participar en un juego mortal. Mezcla de novela visual y habitaciones de escape.', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/logo.png', 86, '2017-03-24', '2026-06-10 11:00:00', 0, 1, 'zero-escape-the-nonary-games'),
(108, 126, 126, 18, 1659040, 233571, 'Hitman World of Assassination', 'Conviértete en el Agente 47, el asesino definitivo.', 'Viaja por todo el mundo y elimina a tus objetivos de las formas más creativas y sigilosas imaginables.', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/logo.png', 87, '2022-01-20', '2025-10-25 12:00:00', 0, 1, 'hitman-world-of-assassination'),
(109, 35, 3, 18, 403640, 11118, 'Dishonored 2', 'Recupera lo que es tuyo con sigilo y poderes sobrenaturales.', 'Juega como Emily o Corvo y usa habilidades únicas para infiltrarte. Un diseño de niveles soberbio.', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/logo.png', 88, '2016-11-11', '2025-06-15 15:30:00', 0, 1, 'dishonored-2'),;



-- Users
INSERT INTO `users` (`id`, `plan_id`, `role_id`, `username`, `password`, `token`, `email`, `birth_date`, `last_login_at`, `is_active`, `created_at`, `avatar_id`) VALUES
(0, 2, 0, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzU2NzM5MTAsImRhdGEiOnsiaWQiOiIwIiwibm9tYnJlIjoiYWRtaW5AZWplbXBsby5jb20ifX0.CiryWHQbch2W2xS982JCjdQRbKs1lJo8NSwIVtOAlKU', 'admin@ejemplo.com', '1990-05-15', '2026-04-03 19:34:55', 1, '2026-04-03 19:34:55', 4),
(1, 0, 1, 'usuario', '9250e222c4c71f0c58d4c54b50a880a312e9f9fed55d5c3aa0b0e860ded99165', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzU2NzQwMTIsImRhdGEiOnsiaWQiOiIxIiwibm9tYnJlIjoidXN1YXJpb0B0ZXN0LmNvbSJ9fQ.Qw6ybv4POr1QIauFET8F1KBemdKw5dY6m1UtaJPESZE', 'usuario@test.com', '1995-08-22', '2026-04-07 11:35:29', 1, '2026-04-07 11:35:29', 5);

-- Favorites (Pivot Table)
INSERT INTO `favorites` (`user_id`, `game_id`) VALUES
(0, 1),
(1, 2),
(1, 3),
(0, 4),
(0, 7),
(0, 9),
(0, 10),
(1, 11),
(1, 13),
(0, 15),
(1, 17),
(1, 18),
(1, 95),
(1, 98),
(1, 99),
(0, 101),
(1, 102),
(0, 105),
(1, 108),
(0, 110),
(1, 115),
(0, 118);

-- Game Categories (Pivot Table)
-- Categorías referencia: 1: Acción, 2: Aventura, 3: Estrategia, 4: RPG, 5: Simulación, 7: Indie, 8: Arcade
INSERT INTO `game_categories` (`game_id`, `category_id`) VALUES
(1, 5), (1, 7),  -- Project Zomboid (Simulación, Indie)
(2, 2), (2, 1),  -- Indiana Jones and the Great Circle (Aventura, Acción)
(3, 5), (3, 3),  -- Cities: Skylines II (Simulación, Estrategia)
(4, 1), (4, 2),  -- Red Dead Redemption 2 (Acción, Aventura)
(5, 1), (5, 2),  -- Star Wars Outlaws (Acción, Aventura)
(6, 1), (6, 2),  -- Marvel's Spider-Man 2 (Acción, Aventura)
(7, 4), (7, 2),  -- Hogwarts Legacy (RPG, Aventura)
(8, 2), (8, 7),  -- The Wolf Among Us (Aventura, Indie)
(9, 1), (9, 4),  -- Cyberpunk 2077 (Acción, RPG)
(10, 4), (10, 1), -- Elden Ring (RPG, Acción)
(11, 4), (11, 3), -- Baldur's Gate 3 (RPG, Estrategia)
(12, 5), (12, 6), -- Forza Horizon 5 (Simulación, Deportes/Carreras)
(13, 1), (13, 2), -- Resident Evil 4 (Acción, Aventura)
(14, 1), (14, 3), -- ARC Raiders (Acción, Estrategia/Shooter)
(15, 1), (15, 2), -- God of War Ragnarök (Acción, Aventura)
(16, 1), (16, 2), -- Horizon Forbidden West (Acción, Aventura)
(17, 1), (17, 2), -- The Last of Us Part II (Acción, Aventura)
(18, 1), (18, 2), -- Ghost of Tsushima (Acción, Aventura)
(19, 1), (19, 7), -- Returnal (Acción, Indie/Roguelike)
(20, 4), (20, 1), -- Demon's Souls (RPG, Acción)
(21, 2), (21, 7), -- Stray (Aventura, Indie)
(22, 2), (22, 7), -- It Takes Two (Aventura, Indie)
(23, 1), (23, 2), -- Deathloop (Acción, Aventura)
(24, 1), (24, 2), -- Alan Wake 2 (Acción, Aventura)
(25, 1), (25, 2), -- Control Ultimate Edition (Acción, Aventura)
(26, 1), (26, 8),  -- Sifu (Acción, Arcade)
(27, 1), (27, 2),  -- Dead Space (Acción, Aventura)
(28, 1), (28, 8),  -- Hi-Fi RUSH (Acción, Arcade)
(29, 1), (29, 2),  -- Resident Evil Village (Acción, Aventura)
(30, 1), (30, 8),  -- DOOM Eternal (Acción, Arcade)
(31, 2), (31, 7),  -- A Way Out (Aventura, Indie)
(32, 1), (32, 2),  -- Half-Life: Alyx (Acción, Aventura)
(33, 1), (33, 4),  -- Dying Light 2 Stay Human (Acción, RPG)
(34, 1), (34, 3),  -- Portal 2 (Acción, Estrategia/Puzzle)
(35, 4), (35, 1),  -- Mass Effect Legendary Edition (RPG, Acción)
(36, 2), (36, 1),  -- Sea of Thieves (Aventura, Acción)
(37, 4), (37, 1),  -- Assassin's Creed Valhalla (RPG, Acción)
(38, 7), (38, 1),  -- Hades (Indie, Acción)
(39, 1), (39, 2),  -- Sekiro: Shadows Die Twice (Acción, Aventura)
(40, 7), (40, 2),  -- Hollow Knight (Indie, Aventura)
(41, 7), (41, 2),  -- Ori and the Will of the Wisps (Indie, Aventura)
(42, 1), (42, 2),  -- Resident Evil 2 (Acción, Aventura)
(43, 1), (43, 2),  -- Resident Evil 3 (Acción, Aventura)
(44, 3), (44, 5),  -- Civilization VI (Estrategia, Simulación)
(45, 4), (45, 1),  -- Final Fantasy VII Remake Intergrade (RPG, Acción)
(46, 8), (46, 2),  -- Crash Bandicoot 4: It's About Time (Arcade, Aventura)
(47, 8), (47, 2),  -- Spyro Reignited Trilogy (Arcade, Aventura)
(48, 3), (48, 5),  -- Age of Empires IV (Estrategia, Simulación)
(49, 1), (49, 8),  -- Street Fighter 6 (Acción, Arcade)
(50, 4), (50, 2),  -- Immortals Fenyx Rising (RPG, Aventura)
(51, 1), (51, 3),  -- Tom Clancy's Rainbow Six Siege (Acción, Estrategia)
(52, 1), (52, 2),  -- Mirror's Edge (Acción, Aventura)
(53, 7), (53, 2),  -- GRIS (Indie, Aventura)
(54, 1), (54, 2),  -- Alan Wake Remastered (Acción, Aventura)
(55, 1), (55, 8),  -- Devil May Cry 5 (Acción, Arcade)
(56, 5), (56, 6),  -- F1 25 (Simulación, Deportes)
(57, 5), (57, 2),  -- Microsoft Flight Simulator (Simulación, Aventura)
(58, 3), (58, 5),  -- Frostpunk 2 (Estrategia, Simulación)
(59, 1), (59, 5),  -- Palworld (Acción, Simulación)
(60, 1), (60, 2),  -- Star Wars Jedi: Survivor (Acción, Aventura)
(61, 4), (61, 1),  -- Lords of the Fallen (RPG, Acción)
(62, 4), (62, 1),  -- Lies of P (RPG, Acción)
(63, 3), (63, 7),  -- Cult of the Lamb (Estrategia, Indie)
(64, 1), (64, 2),  -- Ghost of Tsushima DIRECTOR'S CUT (Acción, Aventura)
(65, 1), (65, 5),  -- Armored Core VI Fires of Rubicon (Acción, Simulación)
(66, 2), (66, 7),  -- It Takes Two (Aventura, Indie)
(67, 1), (67, 2),  -- The Callisto Protocol (Acción, Aventura)
(68, 2), (68, 1),  -- A Plague Tale: Requiem (Aventura, Acción)
(69, 2), (69, 1),  -- Silent Hill 2 (Aventura, Acción)
(70, 6), (70, 8),  -- Need for Speed Unbound (Deportes, Arcade)
(71, 3), (71, 5),  -- Manor Lords (Estrategia, Simulación)
(72, 4), (72, 1),  -- Monster Hunter Rise (RPG, Acción)
(73, 4), (73, 1),  -- Nioh 2 (RPG, Acción)
(74, 5), (74, 6),  -- Forza Horizon 5 (ID duplicado en img, manteniendo coherencia)
(75, 5), (75, 6),  -- Forza Horizon 5 (ID duplicado en img)
(77, 5), (77, 6),  -- Forza Horizon 5 (ID duplicado en img)
(78, 1), (78, 7),  -- Phasmophobia (Acción, Indie)
(79, 7), (79, 1),  -- Hades II (Indie, Acción)
(80, 4), (80, 1),  -- Granblue Fantasy: Relink (RPG, Acción)
(81, 4), (81, 5),  -- Persona 5 Royal (RPG, Simulación)
(82, 4), (82, 1),  -- Black Myth: Wukong (RPG, Acción)
(83, 1), (83, 8),  -- DOOM Eternal (Acción, Arcade)
(84, 7), (84, 2),  -- Outer Wilds (Indie, Aventura)
(85, 4), (85, 2),  -- Dragon's Dogma 2 (RPG, Aventura)
(86, 4), (86, 1),  -- NieR:Automata (RPG, Acción)
(87, 1), (87, 3),  -- Helldivers 2 (Acción, Estrategia)
(88, 4), (88, 7),  -- Disco Elysium (RPG, Indie)
(89, 1), (89, 3),  -- Warhammer 40,000: Space Marine 2 (Acción, Estrategia)
(90, 1), (90, 2),  -- BioShock Infinite (Acción, Aventura)
(91, 1), (91, 8),  -- Hi-Fi RUSH (Acción, Arcade)
(92, 1), (92, 7),  -- Cuphead (Acción, Indie)
(93, 3), (93, 7),  -- Balatro (Estrategia, Indie)
(94, 1), (94, 2),  -- Sekiro: Shadows Die Twice (Acción, Aventura)
(95, 1), (95, 8),  -- Street Fighter 6 (Acción, Arcade)
(96, 7), (96, 2),  -- Hollow Knight (Indie, Aventura)
(97, 1), (97, 2),  -- Half-Life: Alyx (Acción, Aventura)
(98, 6), (98, 5),  -- EA SPORTS FC 25 (Deportes, Simulación)
(99, 6), (99, 5),  -- Madden NFL 25 (Deportes, Simulación)
(100, 6), (100, 5), -- NBA 2K25 (Deportes, Simulación)
(101, 1), (101, 7), -- Dead by Daylight (Acción, Indie)
(102, 1), (102, 2), -- The Precinct (Acción, Aventura)
(103, 3), (103, 5), -- Stellaris (Estrategia, Simulación)
(104, 1), (104, 2),  -- Watch Dogs (Acción, Aventura)
(105, 1), (105, 7),  -- Ghostrunner (Acción, Indie)
(106, 1), (106, 8),  -- Dragon Ball: Sparking! ZERO (Acción, Arcade)
(107, 5), (107, 2),  -- Euro Truck Simulator 2 (Simulación, Aventura)
(108, 5), (108, 3),  -- Kerbal Space Program (Simulación, Estrategia)
(109, 3), (109, 7),  -- Human Resource Machine (Estrategia, Indie)
(110, 5), (110, 7),  -- PC Building Simulator (Simulación, Indie)
(111, 3), (111, 7),  -- while True: learn() (Estrategia, Indie)
(112, 2), (112, 5),  -- Discovery Tour: Viking Age (Aventura, Simulación)
(113, 3), (113, 7),  -- Poly Bridge 3 (Estrategia, Indie)
(114, 2), (114, 7),  -- Scribblenauts Unlimited (Aventura, Indie)
(115, 2), (115, 8),  -- Super Mario Odyssey (Aventura, Arcade)
(116, 8), (116, 7),  -- Fall Guys (Arcade, Indie)
(117, 2), (117, 1),  -- LEGO Star Wars: The Skywalker Saga (Aventura, Acción)
(118, 2), (118, 7);  -- Nebula Adventure Test (Aventura, Estrategia)


-- Play Sessions
INSERT INTO `sessions` (`id`, `user_id`, `game_id`, `started_at`, `duration`) VALUES
(1, 0, 1, '2026-01-10 10:00:00', 1800),
(2, 0, 2, '2026-01-12 15:30:00', 3600),
(3, 0, 3, '2026-01-15 20:00:00', 2700),
(4, 0, 4, '2026-01-18 12:45:00', 4320),
(5, 0, 5, '2026-01-20 18:00:00', 900),
(6, 0, 6, '2026-01-22 09:00:00', 1200),
(7, 0, 7, '2026-01-25 21:15:00', 2100),
(8, 0, 8, '2026-01-28 14:20:00', 480),
(9, 0, 9, '2026-02-01 19:30:00', 3360),
(10, 0, 10, '2026-02-03 11:00:00', 4800),
(11, 0, 11, '2026-02-05 22:00:00', 4200),
(12, 0, 12, '2026-02-07 08:00:00', 1320),
(13, 0, 13, '2026-02-10 17:45:00', 1080),
(14, 0, 14, '2026-02-12 13:00:00', 240),
(15, 0, 15, '2026-02-14 20:30:00', 2520),
(16, 0, 16, '2026-02-16 10:15:00', 1860),
(17, 0, 17, '2026-02-18 15:00:00', 1680),
(18, 0, 18, '2026-02-20 23:00:00', 3000),
(19, 1, 101, '2026-03-01 10:00:00', 900),
(20, 1, 102, '2026-03-02 12:00:00', 540),
(21, 1, 103, '2026-03-03 14:00:00', 720),
(22, 1, 104, '2026-03-04 16:00:00', 1500),
(23, 1, 105, '2026-03-05 18:00:00', 240),
(24, 1, 106, '2026-03-06 20:00:00', 1140),
(25, 1, 107, '2026-03-07 22:00:00', 480),
(26, 1, 108, '2026-03-08 09:00:00', 2040),
(27, 1, 109, '2026-03-09 11:00:00', 720),
(28, 1, 110, '2026-03-10 13:00:00', 120),
(29, 1, 111, '2026-03-11 15:00:00', 300),
(30, 1, 112, '2026-03-12 17:00:00', 840),
(31, 1, 113, '2026-03-13 19:00:00', 1260),
(32, 1, 114, '2026-03-14 21:00:00', 540),
(33, 1, 115, '2026-03-15 23:00:00', 1140),
(34, 1, 116, '2026-03-20 10:00:00', 1800),
(35, 1, 117, '2026-03-21 12:00:00', 720),
(36, 1, 118, '2026-03-22 14:00:00', 480);



-- --------------------------------------------------------
-- RELACIONES (FOREIGN KEYS)
-- --------------------------------------------------------

-- Games Relations
ALTER TABLE `games`
  ADD CONSTRAINT `fk_games_developer` FOREIGN KEY (`developer_id`) REFERENCES `studios` (`id`),
  ADD CONSTRAINT `fk_games_publisher` FOREIGN KEY (`publisher_id`) REFERENCES `studios` (`id`),
  ADD CONSTRAINT `fk_games_pegi` FOREIGN KEY (`pegi_id`) REFERENCES `pegi` (`id`);

-- Users Relations
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_plan` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_users_avatar` FOREIGN KEY (`avatar_id`) REFERENCES `avatars` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- Favorites Relations
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_favorites_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_favorites_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE;

-- Game Categories Relations
ALTER TABLE `game_categories`
--  ADD CONSTRAINT `fk_gc_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_gc_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

-- Sessions Relations
ALTER TABLE `sessions`
  ADD CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sessions_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE;



-- Reports
CREATE TABLE `reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT 4,
  `description` text DEFAULT NULL,
  `is_solved` boolean NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `game_id_idx` (`game_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `fk_reports_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reports_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
-- COMMIT
-- --------------------------------------------------------
COMMIT;
