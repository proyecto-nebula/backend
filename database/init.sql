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
(1, 'Acción', 'pi-bolt'),
(2, 'RPG', 'pi-shield'),
(3, 'Aventura', 'pi-compass'),
(4, 'Estrategia', 'pi-sitemap'),
(5, 'Shooter', 'pi-bullseye'),
(6, 'Terror', 'pi-eye-slash'),
(7, 'Simulación', 'pi-wrench'),
(8, 'Supervivencia', 'pi-heart'),
(9, 'Mundo Abierto', 'pi-map'),
(10, 'Deportes', 'pi-trophy'),
(11, 'Puzzle', 'pi-objects-column'),
(12, 'Carreras', 'pi-car'),
(13, 'Lucha', 'pi-clone'),
(14, 'Plataformas', 'pi-arrow-up-right'),
(15, 'Educativo', 'pi-graduation-cap'),
(16, 'Familiar', 'pi-users');

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
INSERT INTO `games` (`id`, `title`, `slug`, `is_active`, `is_featured`, `published_at`, `release_date`, `developer_id`, `publisher_id`, `steam_id`, `igdb_id`, `pegi_id`, `metacritic_score`, `cover_url`, `banner_url`, `hero_url`, `logo_url`, `summary`, `description`) VALUES
(1, 'Project Zomboid', 'project-zomboid', 1, 1, '2025-12-05 22:30:00', '2013-11-08', 1, 1, 108600, 3189, 18, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/logo.png', '¿Cómo morirás? La supervivencia zombi definitiva en un mundo implacable.', 'El Evento Knox se refiere al brote zombi que ocurre antes y durante el juego. Comienza en Muldraugh y West Point (Kentucky) alrededor del 4 de julio de 1993. Días después el ejército evacuó a los residentes y estableció cordones en lo que hoy se conoce como la Zona de Exclusión, con el campamento principal al sur de Louisville.'),
(2, 'Indiana Jones and the Great Circle', 'indiana-jones-and-the-great-circle', 1, 1, '2025-11-15 19:30:00', '2024-12-09', 2, 3, 2677660, 142415, 16, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/logo.png', 'Desentraña uno de los mayores misterios de la historia en esta aventura trotamundos.', 'Descubre uno de los mayores misterios de la historia en Indiana Jones and the Great Circle. Juego en primera persona que te pone en la piel del legendario arqueólogo en una aventura cinematográfica donde explorarás tumbas, resolverás enigmas y desvelarás secretos ocultos entre las sombras de civilizaciones perdidas.'),
(3, 'Cities: Skylines II', 'cities-skylines-2', 1, 1, '2025-11-05 22:45:00', '2023-10-24', 4, 5, 949230, 240902, 3, 74, 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/logo.png', 'Crea una ciudad desde cero y transfórmala en una metrópolis próspera.', 'Construye y gestiona tu propia ciudad sin límites. Con una simulación profunda y una economía viva, Cities: Skylines II pondrá a prueba tus decisiones y te permitirá crear la metrópolis de tus sueños.\n\nTu ciudad evolucionará y reaccionará a tus decisiones. Usa creatividad y planificación estratégica para atraer negocios, residentes y turistas; gestiona servicios, tráfico e infraestructuras mientras observas cómo todo crece y cambia.'),
(4, 'Red Dead Redemption 2', 'red-dead-redemption-2', 1, 1, '2026-04-15 20:15:00', '2019-12-05', 6, 7, 1174180, 25076, 18, 97, 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/logo.png', 'Una epopeya de forajidos en el ocaso del Salvaje Oeste americano.', 'América, 1899. El ocaso del Salvaje Oeste: la ley persigue a las últimas bandas de forajidos. Tras un atraco que sale mal en Blackwater, Arthur Morgan y la banda Van der Linde huyen mientras agentes federales y buscadores de recompensas los persiguen.\n\nLa banda debe robar, saquear y luchar por sobrevivir atravesando el duro interior americano. Cuando las tensiones internas aumentan, Arthur afronta la difícil elección entre sus principios y la lealtad a quienes lo criaron.'),
(5, 'Star Wars Outlaws', 'star-wars-outlaws', 1, 1, '2026-05-05 16:30:00', '2024-08-30', 8, 9, 2842040, 252827, 3, 76, 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2842040/logo.png', 'Vive la vida de una buscavidas en el primer mundo abierto de Star Wars.', 'Experimenta el primer mundo abierto de Star Wars, situado entre El Imperio Contraataca y El Retorno del Jedi. Explora planetas icónicos y nuevos; juega como Kay Vess y Nix, y sobrevive entre bandas criminales: roba, pelea y escapa para ganarte la libertad.'),
(6, 'Marvel''s Spider-Man 2', 'marvels-spider-man-2', 1, 0, '2025-01-20 07:00:00', '2025-01-30', 10, 11, 2651280, 127044, 16, 90, 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2651280/logo.png', 'Los Spider-Men Peter Parker y Miles Morales regresan para una nueva aventura.', 'Marvel''s Spider-Man 2 es un juego de acción y aventura donde regresan Peter Parker y Miles Morales. Tras los eventos previos, ambos héroes afrontan nuevas amenazas en una Nueva York más amplia.\n\nLos jugadores alternan entre Peter y Miles, cada uno con habilidades únicas. El juego presenta nuevos villanos y un mundo abierto más detallado e interactivo.'),
(7, 'Hogwarts Legacy', 'hogwarts-legacy', 1, 0, '2025-09-20 11:45:00', '2023-02-10', 12, 13, 990080, 136625, 3, 84, 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 'Vive lo desconocido en el Colegio Hogwarts en el siglo XIX.', 'Vive una experiencia inmersiva en Hogwarts ambientada en el siglo XIX. Explora lugares conocidos y nuevos, encuentra bestias fantásticas, personaliza a tu personaje, aprende pociones y hechizos, mejora talentos y forja tu propio legado en la comunidad mágica.'),
(8, 'The Wolf Among Us', 'the-wolf-among-us', 1, 0, '2026-01-20 22:30:00', '2013-10-11', 14, 14, 250320, 2993, 18, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/logo.png', 'Un thriller crudo, violento y maduro basado en los cómics de Fábulas.', 'Ambientado en 1986, The Wolf Among Us muestra a los habitantes de las Tierras de las Fábulas refugiados en Fabletown, Manhattan. Para ocultarse entre humanos usan un "glamour" que les hace parecer normales. Como Bigby Wolf, sheriff de Fabletown, investigarás crímenes y tomarás decisiones que alteran la historia.'),
(9, 'Cyberpunk 2077', 'cyberpunk-2077', 1, 0, '2025-02-10 13:30:00', '2020-12-10', 15, 16, 1091500, 1877, 18, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/logo.png', 'Conviértete en un mercenario ciberpunk en Night City.', 'Año 2077: tras un colapso económico las grandes corporaciones dominan la sociedad. En Night City, decadencia, crimen y tecnología extrema conviven. Interpretas a V, un mercenario que busca un implante único que promete la inmortalidad.'),
(10, 'Elden Ring', 'elden-ring', 1, 0, '2025-08-25 22:45:00', '2022-02-25', 17, 18, 1245620, 119133, 16, 96, 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/logo.png', 'Levántate, Sinluz, para convertirte en el Señor del Círculo.', 'Elden Ring es un RPG de acción ambientado en las "Lands Between", creado por FromSoftware con aportes de George R. R. Martin. Asumes el papel de un Tarnished que debe explorar, enfrentarse a enemigos temibles y restaurar el Anillo Elden.\n\nCon mecánicas desafiantes al estilo Dark Souls, el juego añade exploración masiva, clima dinámico y ciclo día-noche en un mundo interconectado lleno de secretos y jefes.'),
(11, 'Baldur''s Gate III', 'baldurs-gate-3', 1, 0, '2025-12-20 22:45:00', '2023-08-03', 19, 19, 1086940, 119171, 18, 96, 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/logo.png', 'Regresa a los Reinos Olvidados en una historia de compañerismo.', 'Faerûn está en caos: refugiados y cultos amenazan la Sword Coast. Tras un ataque, un nautiloide secuestra a los protagonistas e introduce un parásito en sus mentes. Sobrevivir al naufragio te lleva a una conspiración que te pondrá en el centro de Baldur''s Gate.'),
(12, 'Forza Horizon 5', 'forza-horizon-5', 1, 0, '2025-03-10 08:30:00', '2021-11-09', 20, 21, 1551360, 141503, 3, 92, 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 'Tu aventura Horizon definitiva te espera en México.', 'Tu aventura Horizon definitiva te espera en México: explora paisajes vibrantes y cambiantes al volante de cientos de coches.\n\nDisfruta del clima dinámico, eventos sociales, misiones de historia y herramientas creativas como EventLab para diseñar pruebas, carreras y compartir tus creaciones.'),
(13, 'Resident Evil 4', 'resident-evil-4', 1, 0, '2025-04-15 17:45:00', '2023-03-24', 22, 23, 2050650, 145191, 18, 93, 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/logo.png', 'La supervivencia es solo el principio.', 'Aunque hubo rumores sobre limitaciones en la versión para PS2, esta adaptación de Resident Evil 4 logró mantener calidad convirtiendo escenas en vídeo y añadiendo contenido exclusivo como minijuegos y trajes.'),
(14, 'ARC Raiders', 'arc-raiders', 1, 0, '2025-01-15 10:45:00', '2025-10-15', 24, 24, 1808500, 185258, 16, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/logo.png', 'Shooter de extracción donde la humanidad resiste a una amenaza mecánica.', 'ARC Raiders es una aventura multijugador de extracción ambientada en una Tierra futura devastada por máquinas. Forma equipo, saquea recursos y enfréntate tanto a máquinas como a otros jugadores en intensas incursiones cooperativas.'),
(15, 'God of War Ragnarök', 'god-of-war-ragnarok', 1, 0, '2025-10-20 15:45:00', '2024-09-19', 25, 11, 2322010, 112875, 18, 94, 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/logo.png', 'Kratos y Atreus deben viajar a cada uno de los Nueve Reinos.', 'Los vientos de Fimbulwinter azotan Midgard y ponen a prueba a Kratos, Atreus y Mimir. Con la revelación del linaje de Atreus y profecías ocultas, padre e hijo deben tomar decisiones que podrían definir el destino de los Nueve Reinos.'),
(16, 'Horizon Forbidden West', 'horizon-forbidden-west', 1, 0, '2025-11-25 12:45:00', '2024-03-21', 26, 11, 2420110, 112874, 16, 89, 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/logo.png', 'Acompaña a Aloy en su aventura por las majestuosas tierras del Oeste Prohibido.', 'Horizon Forbidden West continúa la historia de Aloy mientras explora un futuro lejano de América occidental, enfrentándose a máquinas impresionantes y nuevas amenazas en una frontera majestuosa.'),
(17, 'The Last of Us Part II', 'the-last-of-us-part-2', 1, 0, '2026-03-15 22:00:00', '2024-06-19', 27, 11, 2531310, 26192, 18, 93, 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2531310/logo.png', 'Una historia de venganza y redención implacable en un mundo devastado.', 'The Last of Us Part II transcurre cinco años después del original. Los protagonistas recorren entornos postapocalípticos, empleando armas, sigilo y plataformas para sobrevivir frente a humanos hostiles e infectados.'),
(18, 'Ghost of Tsushima', 'ghost-of-tsushima', 1, 0, '2025-05-05 15:45:00', '2024-05-16', 28, 11, 2215430, 75235, 18, 87, 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/logo.png', 'El honor de un samurái se enfrenta a una invasión brutal.', '1274: los samuráis defienden Japón contra la invasión mongola en Tsushima. Como uno de los últimos samuráis debes adaptarte y abandonar tácticas puras para convertirte en el ''Ghost'' y librar una guerra no convencional por la libertad.'),
(19, 'Returnal', 'returnal', 1, 0, '2025-08-15 18:00:00', '2023-02-15', 29, 11, 1446720, 134584, 16, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/logo.png', 'Rompe el ciclo en este shooter roguelike en tercera persona.', 'Returnal es un shooter roguelike que sigue a la astronauta Selene en el planeta Atropos, atrapada en un bucle temporal. Cada ciclo te obliga a reaprender, combatir y avanzar en un mundo alienígena cambiante.'),
(20, 'Demon''s Souls', 'demons-souls', 1, 0, '2026-05-20 13:45:00', '2024-05-20', 30, 11, 2401410, 134606, 18, 92, 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/logo.png', 'Regresa al reino de Boletaria en este remake magistral.', 'Remake de Demon’s Souls reconstruido con gráficos y rendimiento modernos. Enfréntate a un oscuro mundo de fantasía lleno de enemigos peligrosos y mecánicas desafiantes.'),
(21, 'Stray', 'stray', 1, 0, '2025-10-05 11:45:00', '2022-07-19', 31, 32, 1332010, 110248, 3, 83, 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/logo.png', 'Un gato callejero debe resolver un antiguo misterio.', 'Stray es una aventura en tercera persona protagonizada por un gato, ambientada entre los detallados callejones iluminados por neón de una ciudad cibernética decadente y los entornos sombríos de su inframundo. Recorre alturas y bajos, defiéndete de amenazas imprevistas y resuelve los misterios de este lugar inhóspito habitado por autómatas y criaturas peligrosas.\n\nDescubre el mundo desde los ojos de un gato y relaciona con el entorno de forma juguetona. Sé sigiloso, ágil, travieso y a veces molesto mientras interactúas con los extraños habitantes de este mundo ajeno.'),
(22, 'It Takes Two', 'it-takes-two', 1, 0, '2026-04-20 07:00:00', '2021-03-26', 33, 34, 1426210, 135243, 3, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 'La aventura de plataformas cooperativa definitiva.', 'Embárcate en el viaje más loco de tu vida en It Takes Two, una aventura cooperativa que rompe géneros. Invita a un amigo con Friend’s Pass y trabajad juntos en una enorme variedad de desafíos divertidos y desconcertantes. Juega como la pareja en conflicto, Cody y May, convertidos en muñecos por un hechizo: atrapados en un mundo fantástico donde lo imprevisible acecha en cada rincón, deberán salvar su relación a duras penas.'),
(23, 'Deathloop', 'deathloop', 1, 0, '2025-02-20 07:45:00', '2021-09-14', 35, 3, 1252330, 113598, 18, 87, 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/logo.png', 'Rompe el bucle temporal en este shooter de Arkane Studios.', 'Participa en la lucha eterna entre dos extraordinarios asesinos.\n\nInterpreta a Colt en su búsqueda por terminar un bucle temporal que atrapa a la isla de Blackreef mientras es perseguido por sus habitantes.\n\nUsa armas y habilidades poderosas para eliminar ocho objetivos clave repartidos por la isla antes de que el día se reinicie. Julianna, la asesina rival, acecha desde las sombras para mantener el bucle. Aprende de cada ciclo, prueba nuevos caminos y rompe el bucle de una vez por todas.'),
(24, 'Control: Ultimate Edition', 'control-ultimate-edition', 1, 0, '2026-02-20 14:00:00', '2020-08-27', 36, 37, 870780, 136604, 16, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/logo.png', 'Domina habilidades sobrenaturales en este thriller de Remedy.', 'Control: Ultimate Edition incluye el juego principal y todas las expansiones anteriores ("The Foundation" y "AWE") en un solo paquete. Ganador de numerosos premios, Control es una experiencia visualmente impactante de acción y aventura en tercera persona que te mantendrá en vilo.'),
(25, 'Sifu', 'sifu', 1, 0, '2026-06-25 08:30:00', '2023-03-28', 38, 38, 2138710, 144022, 16, 81, 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/logo.png', 'La venganza requiere toda una vida de entrenamiento en este beat ''em up de kung-fu.', 'Sifu cuenta la historia de un joven estudiante de Kung Fu en su senda de venganza, buscando a los asesinos de su familia. Solo contra todos, sin aliados, debe confiar en su dominio del Kung Fu y en un misterioso colgante para prevalecer y preservar el legado de su familia.'),
(26, 'Dead Space', 'dead-space', 1, 0, '2026-05-10 18:15:00', '2023-01-27', 39, 34, 1693980, 131931, 18, 89, 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/logo.png', 'El clásico de terror y supervivencia de ciencia ficción regresa reconstruido.', 'Han pasado tres años desde la destrucción del Marker en la primera entrega de Dead Space. Ahora vivirás de primera mano los eventos que desatan de nuevo a las hordas Necromorph. Te encontrarás en una misión de propósito incierto en las Minas de Titán; pronto, sin embargo, la verdad de tu situación se volverá grotescamente evidente...'),
(27, 'Hi-Fi Rush', 'hi-fi-rush', 1, 0, '2026-03-25 07:30:00', '2023-01-25', 40, 41, 1817230, 233585, 3, 87, 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/logo.png', 'Siente el ritmo mientras Chai y su equipo luchan contra un megaconglomerado.', 'Chai, de 25 años, se une al Proyecto Armstrong, un programa experimental de prótesis en la compañía Vandelay Technologies para perseguir su sueño de ser rockstar. Cuando su reproductor musical acaba implantado en su pecho, la empresa lo declara un defecto. Junto a nuevos aliados, Chai debe usar sus nuevos poderes musicales para descubrir una conspiración misteriosa dentro de la alta dirección de Vandelay.'),
(28, 'Resident Evil Village', 'resident-evil-village', 1, 0, '2025-07-20 22:15:00', '2021-05-07', 42, 23, 1196590, 55163, 18, 84, 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/logo.png', 'Vive el horror de supervivencia como nunca antes en la octava entrega.', 'Resident Evil Village es un juego de terror y supervivencia en primera persona y la secuela de Resident Evil 7: Biohazard. Mantiene elementos de la saga, con recolección de recursos y gestión de inventario, pero añade un enfoque más orientado a la acción, con mayor número de enemigos y énfasis en el combate.'),
(29, 'Doom Eternal', 'doom-eternal', 1, 0, '2026-01-10 14:45:00', '2020-03-20', 43, 3, 782330, 103298, 18, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/logo.png', 'Los ejércitos del infierno han invadido la Tierra. Arrasa con todo.', 'Los ejércitos del Infierno han invadido la Tierra. Conviértete en el Slayer en una épica campaña para derrotar demonios a través de dimensiones y detener la destrucción final de la humanidad. Lo único que tiemblan... eres tú.'),
(30, 'A Way Out', 'a-way-out', 1, 0, '2026-05-25 11:30:00', '2018-03-23', 33, 34, 1222700, 36897, 18, 78, 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/logo.png', 'Una aventura cooperativa donde juegas el papel de dos prisioneros.', 'De los creadores de Brothers: A Tale of Two Sons, A Way Out es una aventura exclusivamente cooperativa donde interpretas a uno de dos presos que planean una audaz fuga. Lo que comienza como una espectacular huida se convierte en una impredecible y emotiva aventura que debe jugarse entre dos jugadores, controlando a Leo y Vincent en su alianza forzada para recuperar la libertad.'),
(31, 'Half-Life: Alyx', 'half-life-alyx', 1, 0, '2025-02-15 09:45:00', '2020-03-23', 44, 44, 546560, 126098, 18, 93, 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/logo.png', 'El regreso de Valve a Half-Life en una experiencia VR completa.', 'Interpreta a Alyx Vance; eres la última esperanza de la humanidad. El control de la Combine sobre el planeta se ha reforzado desde Black Mesa y la población se concentra en ciudades controladas. Como fundadores de una incipiente resistencia, realizáis investigaciones clandestinas y construís herramientas vitales para desafiar al Combine. Cada día aprendes más sobre tu enemigo y trabajas para encontrar una debilidad.'),
(32, 'Dying Light 2: Stay Human', 'dying-light-2-stay-human', 1, 0, '2025-07-10 12:15:00', '2022-02-04', 45, 45, 534380, 102584, 18, 77, 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/logo.png', 'Sobrevive en un mundo abierto brutal donde la humanidad pierde la batalla.', 'Han pasado 15 años desde que la humanidad sucumbió al virus.\n\nEl último gran asentamiento humano existe en un mundo infectado, sumido en una edad moderna oscura. Durante el día, bandidos, facciones y supervivientes hambrientos recorren las calles; por la noche, los infectados acechan fuera.\n\nEres Aiden Caldwell: un superviviente con agilidad excepcional y habilidades de combate que te convierten en un agente de cambio dentro de esta metrópolis decadente. Entra en lugares que otros no se atreven y transforma la ciudad a tu manera.'),
(33, 'Portal 2', 'portal-2', 1, 0, '2026-06-10 16:45:00', '2011-04-18', 44, 44, 620, 72, 3, 95, 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/logo.png', 'La secuela del aclamado juego de puzles con humor negro y narrativa única.', 'Has perdido la memoria y estás solo en un mundo lleno de peligros; tu misión es sobrevivir usando la inteligencia. Bienvenido: soy GLaDOS y te presentaré al increíble mundo de Portal 2, lleno de pruebas que desafiarán tu ingenio. Avanza por niveles usando la pistola de portales, resuelve puzles y demuestra que nada es imposible si perseveras. ¡Los acertijos te esperan!'),
(34, 'Mass Effect Legendary Edition', 'mass-effect-legendary-edition', 1, 0, '2025-10-25 19:15:00', '2021-05-14', 46, 34, 1328670, 140839, 18, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/logo.png', 'Vive la leyenda de Shepard en la trilogía remasterizada.', 'Solo una persona se interpone entre la humanidad y la mayor amenaza que jamás haya enfrentado. Revive la leyenda del Comandante Shepard en la Mass Effect Legendary Edition, que incluye la trilogía original con más de 40 DLCs, armas y contenidos promocionales. Sumérgete en un universo rico y detallado donde tus decisiones tienen consecuencias profundas.'),
(35, 'Sea of Thieves', 'sea-of-thieves', 1, 0, '2025-06-15 13:45:00', '2020-06-03', 47, 21, 1172620, 11137, 3, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/logo.png', 'Navega, lucha y saquea en esta experiencia pirata definitiva.', 'Sea of Thieves ofrece la experiencia pirata esencial: navegar, combatir, explorar y saquear; todo lo necesario para vivir la vida de un pirata y forjar tu leyenda. Sin roles fijos, tienes libertad total para abordar el mundo y a otros jugadores como prefieras.'),
(36, 'Assassin''s Creed Valhalla', 'assassins-creed-valhalla', 1, 0, '2025-09-25 07:00:00', '2022-12-06', 48, 48, 2208920, 133004, 18, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/logo.png', 'Conviértete en Eivor, una leyenda vikinga en busca de gloria.', 'Conducidos desde Noruega por guerras y escasez en el siglo IX, los jugadores lideran al clan de Eivor a través del gélido mar del Norte hacia las ricas tierras de los reinos fracturados de Inglaterra. Debes forjar un nuevo futuro para tu clan: combate brutal, saqueos en longships y asentamientos en territorios hostiles mientras te enfrentas a la resistencia sajona y a líderes como el rey Alfredo.'),
(37, 'Hades', 'hades', 1, 0, '2025-08-20 19:00:00', '2020-09-17', 49, 50, 1145360, 113112, 3, 93, 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/logo.png', 'Desafía al dios de los muertos en este roguelike de Supergiant.', 'Hades es un roguelike de acción en el que Zagreus, hijo de Hades, intenta escapar del inframundo enfrentándose a las distintas capas del reino y forjando relaciones con sus habitantes. Cada intento te acerca más a la verdad y te permite mejorar capacidades para futuras escapadas.'),
(38, 'Sekiro: Shadows Die Twice', 'sekiro-shadows-die-twice', 1, 0, '2025-05-20 08:30:00', '2019-03-22', 17, 51, 814380, 76882, 18, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/logo.png', 'Traza tu propio camino hacia la venganza en esta aventura de FromSoftware.', 'Sekiro: Shadows Die Twice se sitúa en una versión reimaginada del Japón del período Sengoku tardío. Tras un golpe de estado, el clan Ashina está al borde del colapso. Siguiendo la historia de un huérfano adoptado por el shinobi Owl, el jugador encarna a "Wolf" y debe rescatar al Heir Divino, enfrentándose a enemigos letales y ejerciendo venganza.'),
(39, 'Hollow Knight', 'hollow-knight', 1, 0, '2026-02-10 18:00:00', '2017-02-24', 23, 23, 367520, 365702, 3, 87, 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/logo.png', 'Aventura de acción épica a través de un reino en ruinas.', 'Puerto no oficial del exitoso Hollow Knight para PlayStation Vita.'),
(40, 'Ori and the Will of the Wisps', 'ori-and-the-will-of-the-wisps', 1, 0, '2025-04-25 07:45:00', '2020-03-11', 52, 21, 1057090, 37001, 3, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/logo.png', 'Embárcate en una nueva aventura en un mundo vasto y exótico.', 'El pequeño espíritu Ori no es ajeno al peligro; cuando un vuelo fatídico pone al polluelo Ku en peligro, hará falta más que valentía para reunir a una familia, sanar una tierra herida y descubrir el verdadero destino de Ori. De los creadores de Ori and the Blind Forest, esta secuela ofrece plataformas ajustadas, emoción y un mundo pintado a mano con una banda sonora orquestal.'),
(41, 'Resident Evil 2', 'resident-evil-2', 1, 0, '2026-02-25 17:30:00', '2019-01-25', 23, 23, 883710, 347128, 18, 89, 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/logo.png', 'Una obra maestra que redefine el género regresa reconstruida.', 'Puerto de Resident Evil 2 mejorado con reescalado, rebobinado, guardado rápido y filtros de vídeo. Resident Evil 2 es la secuela del primer título, usando personajes poligonales sobre fondos prerenderizados y múltiples ángulos de cámara; los jugadores pueden escoger entre dos personajes con experiencias y encuentros ligeramente diferentes.'),
(42, 'Resident Evil 3', 'resident-evil-3', 1, 0, '2025-09-10 21:30:00', '2020-04-03', 42, 23, 952060, 115115, 18, 77, 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/logo.png', 'Jill Valentine presencia las atrocidades de Umbrella en Raccoon City.', 'Una serie de desapariciones extrañas ocurren en Racoon City. El escuadrón S.T.A.R.S. investiga y descubre que la compañía farmacéutica Umbrella y su virus T-Virus están detrás de los incidentes. Jill Valentine y otros supervivientes intentan exponer la verdad mientras la plaga se extiende por la ciudad y un perseguidor implacable ha sido enviado para eliminarlos.'),
(43, 'Civilization VI', 'civilization-vi', 1, 0, '2025-02-25 10:45:00', '2016-10-21', 53, 54, 289070, 19130, 3, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/logo.png', 'Construye un imperio que resista el paso del tiempo en este juego de estrategia.', 'Civilization es un juego de estrategia por turnos donde construyes un imperio para perdurar en el tiempo. Llega a ser el gobernante del mundo guiando una civilización desde la Edad de Piedra hasta la Era de la Información: haz la guerra, negocia diplomacia, desarrolla la cultura y compite contra los líderes históricos por la supremacía.'),
(44, 'Final Fantasy VII Remake Intergrade', 'final-fantasy-6-remake-intergrade', 1, 0, '2025-06-25 21:15:00', '2022-06-17', 55, 56, 1462040, 144024, 16, 89, 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/logo.png', 'La espectacular reinvención del clásico de Square Enix llega con contenido expandido.', 'Final Fantasy VII Remake Intergrade es una versión ampliada y mejorada de Final Fantasy VII Remake que incluye un nuevo episodio protagonizado por Yuffie y añade nuevas mecánicas y contenido narrativo para disfrutar.'),
(45, 'Crash Bandicoot 4', 'crash-bandicoot-4-its-about-time', 1, 0, '2026-02-15 11:15:00', '2022-10-18', 57, 51, 1378990, 135254, 3, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/logo.png', 'Crash y Coco regresan en una aventura que salta a través del tiempo.', 'Crash Bandicoot 4: It''s About Time retoma la clásica jugabilidad de plataformas e introduce las Quantum Masks, que alteran niveles y proporcionan nuevas formas de superar obstáculos. Incluye modos adicionales para rejugar niveles y la posibilidad de controlar varios personajes con mecánicas y fases únicas.'),
(46, 'Spyro Reignited Trilogy', 'spyro-reignited-trilogy', 1, 0, '2025-04-20 20:30:00', '2019-09-03', 57, 51, 996580, 87683, 3, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/logo.png', 'El maestro de las llamaradas ha vuelto. Disfruta de la trilogía remasterizada.', 'Spyro Reignited Trilogy es una colección de remasterizaciones de los tres primeros juegos de Spyro: Spyro the Dragon, Ripto''s Rage! y Year of the Dragon, modernizados con gráficos y mejoras técnicas.'),
(47, 'Age of Empires IV', 'age-of-empires-iv', 1, 0, '2025-07-25 21:15:00', '2021-10-28', 58, 21, 1466860, 55029, 3, 81, 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/logo.png', 'Celebra el regreso de la legendaria saga de estrategia en tiempo real.', 'Age of Empires IV regresa con batallas históricas épicas que marcaron el mundo. Expande tu imperio con nuevas y conocidas mecánicas en paisajes vastos y visuales 4K, ofreciendo una experiencia de estrategia en tiempo real evolucionada para una nueva generación.'),
(48, 'Street Fighter 6', 'street-fighter-6', 1, 0, '2025-08-05 09:45:00', '2023-06-02', 23, 23, 1364780, 343673, 3, 92, 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/logo.png', 'El nuevo estandarte de la lucha de Capcom llega con estilo urbano.', 'La versión para Switch 2 de Street Fighter 6 ofrece visuales mejoradas y rendimiento estable, con opciones multijugador local y en línea y modos exclusivos como Local Wireless y Avatar Matches. Incluye modos centrales como Fighting Ground, World Tour y Battle Hub, además de sistemas como Drive Gauge y un extenso plantel de luchadores.'),
(49, 'Immortals Fenyx Rising', 'immortals-fenyx-rising', 1, 0, '2025-02-05 08:15:00', '2020-12-03', 59, 9, 1341050, 119357, 3, 79, 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/logo.png', 'Vive una gran aventura mitológica como Fenyx, un semidiós alado.', 'De los creadores de Assassin’s Creed Odyssey, Immortals Fenyx Rising propone una aventura de cuento sobre un héroe olvidado en misión de salvar a los dioses griegos. Explora la Isla de los Bendecidos, resuelve acertijos y lucha contra criaturas mitológicas para enfrentarte a Typhon en un duelo legendario.'),
(50, 'Rainbow Six Siege', 'tom-clancys-rainbow-six-siege', 1, 0, '2025-05-10 12:00:00', '2015-12-01', 48, 9, 359550, 7360, 18, 79, 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/logo.png', 'Domina el arte de la destrucción en este shooter táctico de élite.', 'Rainbow Six Siege se inspira en la realidad de los equipos antiterroristas y te reta a dominar el arte de la destrucción. Enfrentamientos tácticos en espacios reducidos, alto impacto letal, trabajo en equipo y acción explosiva definen la experiencia multijugador, elevando el estándar de combates intensos y estrategia experta.'),
(51, 'Mirror''s Edge', 'mirrors-edge', 1, 0, '2025-10-10 08:45:00', '2009-01-13', 60, 34, 17410, 1051, 16, 81, 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/logo.png', 'Corre por los tejados en una ciudad donde la información se vigila.', 'En una ciudad donde la información está vigilada, los mensajeros llamados Runners transportan datos sensibles. Faith es una Runner y, tras un crimen que la convierte en objetivo, debe huir y usar sus habilidades de parkour en esta innovadora aventura en primera persona.'),
(52, 'Gris', 'gris', 1, 0, '2025-01-25 13:45:00', '2018-12-13', 61, 62, 682990, 22917, 3, 84, 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/logo.png', 'Una experiencia serena sobre el dolor y la superación personal.', 'Gris es un juego de plataformas 2D con una estética pictórica que sigue a una joven llamada Gris mientras navega un mundo de duelo y pérdida. Sin diálogo, su historia se cuenta mediante un arte hecho a mano, música evocadora y narración ambiental. La jugabilidad incluye exploración, plataformas y resolución de puzles, y Gris adquiere nuevas habilidades conforme avanza la historia.'),
(53, 'Devil May Cry 5', 'devil-may-cry-5', 1, 0, '2025-07-15 13:15:00', '2019-03-08', 42, 23, 601150, 76253, 18, 89, 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/logo.png', 'El cazademonios definitivo regresa con el combate más frenético.', 'Devil May Cry 5 es una nueva entrega de la legendaria serie de acción exagerada. Ofrece tres personajes jugables con estilos de combate radicalmente distintos para enfrentarse a una ciudad invadida por demonios, desarrollada con el motor RE de Capcom para lograr gráficos y efectos impresionantes.'),
(54, 'F1 25', 'f1-25', 1, 0, '2025-10-15 12:15:00', '2025-05-30', 63, 34, 3300000, 336964, 3, 84, 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/logo.png', 'Domina la nueva era de la velocidad en el juego oficial de la F1.', 'Deja tu huella en el mundo de las carreras en F1 25, el videojuego oficial del Campeonato del Mundo FIA 2025. Incluye un renovado modo My Team, el emocionante tercer capítulo de Braking Point y más contenido para vivir la experiencia F1.'),
(55, 'Microsoft Flight Simulator', 'microsoft-flight-simulator', 1, 0, '2025-05-25 19:30:00', '2020-08-18', 64, 21, 1250410, 119295, 3, 91, 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/logo.png', 'Explora el mundo entero con un detalle asombroso.', 'Microsoft Flight Simulator es la nueva generación de una de las franquicias de simulación más queridas. Pilota desde ligeros biplanos hasta grandes jets en un mundo increíblemente realista. Crea tu plan de vuelo y surca cualquier parte del planeta, enfrentándote a condiciones meteorológicas realistas y desafiantes.'),
(56, 'Frostpunk 2', 'frostpunk-2', 1, 0, '2025-11-10 20:45:00', '2024-09-20', 65, 65, 1601580, 164290, 16, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/logo.png', 'Sobrevive al invierno eterno en una sociedad dividida.', 'Frostpunk 2 es la continuación del aclamado juego de supervivencia social. Ambientado 30 años después de la tormenta apocalíptica, la humanidad aún sufre un clima glacial. Lideras una metrópolis hambrienta de recursos y debes expandirte y buscar nuevas fuentes de energía (como el petróleo), gestionando tensiones entre facciones y tomando decisiones difíciles para la supervivencia.'),
(57, 'Palworld', 'palworld', 1, 0, '2026-01-05 09:45:00', '2024-01-19', 66, 66, 1623730, 151665, 3, 70, 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/logo.png', 'Sobrevive, construye y lucha junto a misteriosas criaturas llamadas Pals.', 'Palworld es un juego multijugador de supervivencia y crafting en mundo abierto donde puedes domesticar y coleccionar criaturas llamadas "Pal". Haz que tus Pals luchen, trabajen, cultiven y operen en fábricas mientras exploras un mundo extenso.'),
(58, 'Star Wars Jedi: Survivor', 'star-wars-jedi-survivor', 1, 0, '2025-12-25 16:15:00', '2023-04-28', 67, 34, 1774580, 201156, 3, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/logo.png', 'La historia de Cal Kestis continúa en esta aventura galáctica.', 'La historia de Cal Kestis continúa en Star Wars Jedi: Survivor, una aventura de acción en tercera persona que abarca la galaxia. Cinco años después de Fallen Order, Cal lucha mientras la galaxia se oscurece: perseguido por el Imperio y rodeado de amenazas, debe protegerse a sí mismo, a su tripulación y al legado Jedi en tiempos desesperados.'),
(59, 'Lords of the Fallen', 'lords-of-the-fallen', 1, 0, '2025-05-15 18:15:00', '2023-10-13', 68, 18, 1501750, 4847, 18, 75, 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/logo.png', 'Un vasto mundo te espera en este RPG de fantasía oscura.', 'Lords of the Fallen es un RPG de acción desafiante ambientado en un mundo duro donde la humanidad venció a su Dios. Cuando su ejército demoníaco resurge, liderado por poderosos Señores, la humanidad busca un defensor improbable. Ofrece combate cuerpo a cuerpo profundo, magia espectacular y una aventura épica de exploración y descubrimiento.'),
(60, 'Lies of P', 'lies-of-p', 1, 0, '2025-04-10 15:45:00', '2023-09-18', 69, 70, 1627720, 148241, 16, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/logo.png', 'Una versión oscura de Pinocho ambientada en la Belle Époque.', 'Lies of P se sitúa en la Belle Époque en la ciudad de Krat, ahora convertida en un infierno plagado de horrores y autómatas. Juegas como el muñeco mecánico Pinocchio, que despierta en una estación de tren abandonada sin recuerdos ni propósito, y emprende una búsqueda para convertirse en un niño de verdad mientras descubre la oscura verdad de la ciudad.'),
(61, 'Cult of the Lamb', 'cult-of-the-lamb', 1, 0, '2025-06-05 22:45:00', '2022-08-11', 71, 62, 1313140, 165351, 3, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/logo.png', 'Crea tu propia secta y conviértete en el Dios Cordero.', 'Reúne y usa recursos para construir estructuras, realiza oscuros rituales para apaciguar a los dioses y da sermones para reforzar la fe de tus seguidores. Explora un mundo generado aleatoriamente, combate hordas de enemigos y derrota líderes de cultos rivales para absorber su poder. Entrena a tu rebaño, explora cinco regiones misteriosas, purga a los infieles y realiza rituales místicos para convertirte en la poderosa deidad cordero.'),
(62, 'Armored Core VI: Fires of Rubicon', 'armored-core-vi-fires-of-rubicon', 1, 0, '2026-06-20 12:30:00', '2023-08-25', 17, 17, 1888160, 228542, 3, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/logo.png', 'Acción de mechas de alta intensidad por FromSoftware.', 'En el remoto planeta Rubicon 3 se descubrió una misteriosa sustancia con potencial energético masivo, que provocó una catástrofe formando un sistema estelar ardiente. Cincuenta años después, la sustancia reaparece y corporaciones y grupos de resistencia luchan por ella. Como mercenario independiente te infiltras en Rubicon y quedas atrapado en una lucha por el control entre facciones.'),
(63, 'The Callisto Protocol', 'the-callisto-protocol', 1, 0, '2025-01-10 10:30:00', '2022-12-02', 72, 41, 1544020, 141538, 18, 69, 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/logo.png', 'Sobrevive a los horrores de la Prisión de Hierro Negro.', 'Ambientado en la luna muerta de Júpiter, Callisto, en el año 2320, The Callisto Protocol te pone en la piel de Jacob Lee, un preso en la prisión Black Iron. Cuando un misterioso brote sume la luna en el caos, Jacob deberá enfrentar sus peores miedos y derrotar a criaturas sedientas de sangre mientras desentraña los oscuros secretos de la United Jupiter Company.'),
(64, 'A Plague Tale: Requiem', 'a-plague-tale-requiem', 1, 0, '2025-12-15 10:15:00', '2022-10-18', 64, 73, 1182900, 152242, 18, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/logo.png', 'Un viaje desgarrador hacia un mundo asombroso y despiadado.', 'A Plague Tale: Requiem es una aventura de acción en la que controlas a Amicia para enfrentarte tanto a los soldados de la Inquisición francesa como a hordas de ratas que propagan la peste negra. La jugabilidad amplia el combate respecto al original y añade un sistema de progresión con nuevas habilidades que permiten enfoques sigilosos o más letales.'),
(65, 'Silent Hill 2', 'silent-hill-2', 1, 0, '2025-03-15 14:00:00', '2024-10-08', 74, 75, 2124490, 222341, 18, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/logo.png', 'Clase magistral de terror psicológico recreada fielmente.', 'Silent Hill 2 Remake es una reimaginación completa del juego psicológico de 2001. Sigue a James Sunderland en su búsqueda de su esposa fallecida por la ciudad envuelta en niebla de Silent Hill. El remake ofrece gráficos reconstruidos en Unreal Engine 5, cámara por encima del hombro, combate revisado y nuevas actuaciones de voz.'),
(66, 'Need for Speed: Unbound', 'need-for-speed-unbound', 1, 0, '2025-08-10 09:45:00', '2022-12-02', 76, 34, 1846380, 219442, 3, 73, 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1846380/logo.png', 'Gana The Grand, el desafío de carreras callejeras definitivo.', 'En la ciudad de Lakeshore, tú, tu socia Yaz y el mecánico Rydell regentabais un taller hasta que una traición deja el negocio al borde del cierre. Dos años después, tras conocer a Tess y ayudarla a escapar de la policía, te unes a ella y a Rydell para recaudar dinero y competir en la Gran carrera de la ciudad para recuperar tu coche y recuperar el honor.'),
(67, 'Manor Lords', 'manor-lords', 1, 0, '2025-03-25 17:45:00', '2024-04-26', 77, 78, 1363080, 137206, 3, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/logo.png', 'Estrategia medieval con construcción de ciudades y batallas.', 'Manor Lords es un juego de estrategia que te pone en la piel de un señor medieval. Haz crecer tu aldea en una ciudad próspera, gestiona recursos y cadenas de producción, y expande mediante la conquista. Inspirado en la arquitectura y el arte de la Franconia del siglo XIV, apuesta por la veracidad histórica para ofrecer un mundo auténtico y creíble.'),
(68, 'Monster Hunter Rise', 'monster-hunter-rise', 1, 0, '2025-03-05 12:00:00', '2022-01-12', 79, 23, 1446780, 138950, 3, 87, 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 'Acepta el desafío y únete a la caza en la Aldea Kamura.', 'Ambientado en la aldea Kamura, con inspiración ninja, Monster Hunter Rise propone explorar ecosistemas exuberantes y cazar monstruos temibles para convertirte en el cazador definitivo. Medio siglo después de la última calamidad, una nueva amenaza emerge y pone en peligro la paz del territorio.'),
(69, 'Nioh 2', 'nioh-2', 1, 0, '2025-01-05 18:15:00', '2021-02-05', 80, 81, 1325200, 103330, 18, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/logo.png', 'Desata tu oscuridad y domina el poder de los Yokai.', 'Domina las artes letales del samurái como un guerrero mitad humano, mitad Yokai en este desafiante RPG de acción. Explora un Japón violento de la era Sengoku y el oscuro Reino Oscuro plagado de demonios; usa un sistema de combate renovado y la capacidad de transformarte en Yokai para desencadenar poderes devastadores.'),
(70, 'Hades II', 'hades-2', 1, 0, '2026-03-05 10:30:00', '2024-05-06', 49, 49, 1145350, 228525, 12, 90, 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/logo.png', 'La primera secuela de Supergiant Games profundiza en la brujería y el Inframundo.', 'Como princesa inmortal del Inframundo explorarás un mundo mítico más grande y profundo, derrotando a las fuerzas del Titán del Tiempo con el poder de los olímpicos. Hades II expande localizaciones, desafíos y sistemas de mejoras mientras una historia en constante evolución se despliega a través de tus avances y retrocesos.'),
(71, 'Granblue Fantasy: Relink', 'granblue-fantasy-relink', 1, 0, '2026-03-20 10:45:00', '2024-02-01', 82, 82, 881020, 22788, 12, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/logo.png', 'Forma un grupo de cuatro y ábrete camino hacia la victoria en este RPG de acción.', 'Hacia la Tierra Prometida, aparece la Chica de Azul.\n\nEn un mundo de islas flotantes sobre un mar de nubes, antiguos conflictos dieron paso a una era de paz. Tras recibir una carta de tu padre, te embarcas hacia una isla legendaria y conoces a Lyria, la misteriosa joven que pone en marcha tu destino.'),
(72, 'Persona 5 Royal', 'persona-5-royal', 1, 0, '2025-11-20 12:00:00', '2022-10-21', 83, 84, 1687950, 114283, 16, 95, 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/logo.png', 'Ponte la máscara y únete a los Ladrones de Guante Blanco en el RPG definitivo.', 'Versión ampliada de Persona 5 con personajes nuevos y un tercer semestre añadido al juego. Lanzada internacionalmente en 2020, ofrece mayor contenido narrativo y mecánicas revisadas.'),
(73, 'Black Myth: Wukong', 'black-myth-wukong', 1, 0, '2026-03-10 08:30:00', '2024-08-20', 85, 85, 2358720, 136879, 16, 81, 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/logo.png', 'Un RPG de acción basado en la mitología china y la novela Viaje al Oeste.', 'Black Myth: Wukong es un RPG de acción basado en la mitología china, inspirado en Viaje al Oeste. Asume el papel del Elegido y emprende un viaje repleto de desafíos y maravillas para descubrir la verdad oculta tras una legendaria historia del pasado.'),
(74, 'Outer Wilds', 'outer-wilds', 1, 0, '2026-04-10 17:30:00', '2019-05-30', 86, 32, 753640, 11737, 7, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/logo.png', 'Un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal.', '¡Bienvenido al Programa Espacial! Eres el recluta de Outer Wilds Ventures, un incipiente programa que busca respuestas en un sistema solar extraño y cambiante. ¿Qué acecha en el corazón del inquietante Dark Bramble? ¿Quién construyó las ruinas alienígenas en la Luna? ¿Se puede detener el bucle temporal?\n\nLos planetas están llenos de ubicaciones ocultas y cambios con el paso del tiempo. Explora, usa gadgets únicos, rastrea señales misteriosas y decodifica escritos alienígenas mientras te adentras en los rincones más peligrosos del espacio.'),
(75, 'Dragon''s Dogma II', 'dragons-dogma-2', 1, 0, '2025-06-20 09:30:00', '2024-03-22', 42, 23, 2054970, 115060, 18, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/logo.png', 'Embárcate en tu gran aventura, Arisen, en este RPG de acción narrativo.', 'Dragon''s Dogma 2 es un RPG de acción narrativo para un solo jugador que te permite elegir tu experiencia: apariencia del Arisen, vocación, grupo y enfoque en combate o sigilo. En tu viaje te acompañarán Pawns, seres misteriosos que actúan como compañeros, ofreciendo una sensación parecida a jugar con otros, aun siendo una aventura en solitario. Todo potenciado por mejoras gráficas, IA y físicas para crear un mundo fantástico inmersivo.'),
(76, 'NieR: Automata', 'nierautomata', 1, 0, '2025-03-20 17:15:00', '2017-03-17', 87, 56, 524220, 11208, 18, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/logo.png', 'La humanidad ha sido expulsada de la Tierra por formas de vida mecánicas.', 'En un futuro lejano, invasores de otro mundo traen una nueva amenaza: los "machine lifeforms". La humanidad es expulsada de la Tierra y se refugia en la Luna. El Consejo de la Humanidad organiza la resistencia con androides como la unidad YoRHa. En las tierras desoladas la guerra entre máquinas y androides desvela la verdad olvidada del mundo.'),
(77, 'Helldivers 2', 'helldivers-2', 1, 0, '2026-05-15 15:30:00', '2024-02-08', 88, 11, 553850, 250616, 18, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/logo.png', 'La última línea de defensa de la galaxia. Únete a los Helldivers y lucha por la libertad.', 'Helldivers 2: la última línea de defensa de la galaxia. Alístate en los Helldivers y únete a la lucha por la libertad en una galaxia hostil en este frenético shooter en tercera persona.'),
(78, 'Disco Elysium', 'disco-elysium', 1, 0, '2026-02-05 09:00:00', '2019-10-15', 89, 89, 632470, 26472, 18, 97, 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/logo.png', 'Un RPG de mundo abierto revolucionario donde tú decides qué tipo de detective ser.', 'Disco Elysium es un RPG ambientado en la ciudad ficticia de Revachol, donde interpretas a un detective amnésico investigando un asesinato. El juego enfatiza el diálogo y las decisiones basadas en habilidades, con voces internas que influyen en las decisiones y una narrativa profunda que explora política, filosofía e identidad personal.'),
(79, 'Warhammer 40,000: Space Marine II', 'warhammer-40000-space-marine-2', 1, 0, '2026-01-25 20:30:00', '2024-09-09', 90, 73, 2183900, 185252, 18, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/logo.png', 'Encarna la brutalidad sobrehumana de un Marine Espacial contra los Tiránidos.', 'La galaxia está en peligro. Mundos enteros caen. El Imperio necesita héroes. Encarna la habilidad y brutalidad de un Marine del Imperio en batallas épicas contra las hordas Tyranid. Desata habilidades y un arsenal devastador para proteger la humanidad y desvelar oscuros secretos en combates en planetas remotos.'),
(80, 'BioShock Infinite', 'bioshock-infinite', 1, 0, '2025-09-05 20:00:00', '2013-03-25', 91, 92, 8870, 538, 18, 94, 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/logo.png', 'Lleva a la chica y saldarás tu deuda. Una aventura en la ciudad aérea de Columbia.', 'BioShock Infinite es la tercera entrega de la serie BioShock, ambientada en un escenario distinto a los anteriores. Ofrece entornos variados que obligan al jugador a adaptarse, combinando combates cuerpo a cuerpo y a distancia con diferentes estrategias y dinámicas de enfrentamiento.'),
(81, 'Cuphead', 'cuphead', 1, 0, '2025-12-05 14:00:00', '2017-09-29', 93, 93, 268910, 9061, 7, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/logo.png', 'Un juego de acción clásico de \"dispara y corre\" centrado en batallas contra jefes.', 'Cuphead es un run-and-gun clásico centrado en épicas batallas contra jefes. Inspirado en los dibujos animados de los años 30, todo el apartado visual y sonoro se creó con técnicas tradicionales: animación a mano, fondos en acuarela y jazz original. Juega como Cuphead o Mugman (en solitario o en cooperativo), mejora armas y descubre secretos mientras avanzas.'),
(82, 'Balatro', 'balatro', 1, 0, '2025-11-15 16:00:00', '2024-02-20', 94, 95, 2379780, 251833, 3, 90, 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/logo.png', 'Un roguelike de póker hipnótico donde puedes crear combos ilegales.', 'Balatro es un roguelite de construcción de mazos donde los jugadores forman manos de poker para ganar fichas y superar vendettas enemigas. Mejora tu mazo, compra comodines que modifiquen efectos y busca sinergias para avanzar en encuentros cada vez más difíciles.'),
(83, 'EA Sports FC 25', 'ea-sports-fc-25', 1, 0, '2025-09-20 21:45:00', '2024-09-27', 96, 97, 2669320, 308698, 3, 76, 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/logo.png', 'Siente la emoción del fútbol con el nuevo modo Rush 5 contra 5 y FC IQ.', 'EA SPORTS FC 25 ofrece más formas de ganar con tu club. Juega con amigos en modos como el nuevo 5v5 Rush y gestiona tu equipo con FC IQ para tener más control táctico que nunca.'),
(84, 'Madden NFL 25', 'madden-nfl-25', 1, 0, '2026-01-20 10:30:00', '2024-08-16', 98, 97, 2582560, 301506, 3, 70, 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/logo.png', 'Golpea como si fuera en serio con FieldSENSE y la nueva tecnología BOOM Tech.', 'En EA SPORTS Madden NFL 25 descubre la siguiente evolución de FieldSENSE: un sistema de física reingenierizado, características renovadas en modos como Franchise y nuevas opciones de presentación y comentarios.'),
(85, 'NBA 2K25', 'nba-2k25', 1, 0, '2025-02-10 15:45:00', '2024-09-06', 99, 100, 2878980, 308034, 3, 78, 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/logo.png', 'Domina cada cancha con autenticidad y realismo gracias a ProPLAY.', 'Conquista canchas y haz historia en NBA 2K25. Controla cada aspecto del juego con autenticidad gracias a ProPLAY y define tu legado en MyCAREER, MyTEAM, MyNBA y The W.'),
(86, 'Dead by Daylight', 'dead-by-daylight', 1, 0, '2025-08-25 16:30:00', '2016-06-14', 101, 101, 381210, 18866, 18, 71, 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/logo.png', 'Un juego de terror multijugador de 4 contra 1 donde uno es el asesino.', 'Los supervivientes juegan en tercera persona con mejor conciencia situacional; el Asesino en primera persona se centra en su presa. El objetivo de los supervivientes es escapar del terreno de caza sin ser atrapados: algo más difícil de lo que parece, especialmente cuando el entorno cambia cada partida.'),
(87, 'The Precinct', 'the-precinct', 1, 0, '2025-12-20 08:45:00', '2024-10-01', 102, 103, 490110, 249013, 16, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/490110/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/490110/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/490110/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/490110/logo.png', 'Una carta de amor a las películas policiales de los 80. Eres la ley en Averno City.', 'Averno City, 1983. Las bandas dominan las calles y tu padre yace inquieto en su tumba. Limpia la ciudad, descubre la verdad y emprende persecuciones vehiculares por entornos destructibles en este sandbox policial de estética neon-noir.'),
(88, 'Stellaris', 'stellaris', 1, 0, '2025-03-10 07:30:00', '2016-05-09', 104, 5, 281990, 11582, 7, 78, 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/logo.png', 'Explora una galaxia llena de maravillas en este juego de gran estrategia de ciencia ficción.', 'Explora una galaxia llena de maravillas en el grand strategy sci-fi de Paradox. Interactúa con razas alienígenas diversas, descubre mundos extraños y expande tu imperio. Cada aventura ofrece posibilidades casi ilimitadas.'),
(89, 'Watch Dogs', 'watch-dogs', 1, 0, '2025-04-15 17:30:00', '2014-05-27', 48, 9, 242700, 1121, 18, 77, 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/logo.png', 'En Chicago, tú eres el hacker definitivo. El sistema es tu arma.', 'Ambientado en Chicago, donde una red central conecta todo, Watch Dogs explora el impacto de la tecnología en la sociedad. Usa la ciudad como arma en tu misión personal de imponer justicia: el Central Operating System (ctOS) controla la tecnología y la información de los residentes, y tú puedes manipularlo para lograr tus objetivos.'),
(90, 'Ghostrunner', 'ghostrunner', 1, 0, '2025-01-15 10:30:00', '2020-10-27', 105, 106, 1139900, 121752, 18, 81, 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/logo.png', 'Un juego de acción \"slasher\" en primera persona con estética cyberpunk.', 'Adéntrate en un intenso mundo cyberpunk y vive combates dinámicos. Conquista enemigos en el mundo físico y en el ciberespacio mientras asciendes por la gran torre-ciudad, descubres secretos sobre tu origen y desafías al Keymaster en un entorno violento y despiadado.'),
(91, 'Dragon Ball: Sparking! Zero', 'dragon-ball-sparking-zero', 1, 0, '2025-10-20 20:30:00', '2024-10-11', 107, 18, 1790600, 279634, 12, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/logo.png', '¡El regreso de la legendaria saga Budokai Tenkaichi!', 'Dragon Ball: Sparking! Zero eleva la jugabilidad de la serie Budokai Tenkaichi a nuevos niveles. Desata el poder destructivo de los luchadores más poderosos de Dragon Ball en combates espectaculares.'),
(92, 'Euro Truck Simulator 2', 'euro-truck-simulator-2', 1, 0, '2025-11-25 07:30:00', '2012-10-18', 108, 108, 227300, 3070, 3, 79, 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/logo.png', 'Viaja por Europa como el rey de la carretera.', 'Euro Truck Simulator 2 es un simulador de camiones donde viajas por Europa entregando mercancías a largas distancias. Explora docenas de ciudades del Reino Unido, Bélgica, Alemania, Italia, Países Bajos, Polonia y más; tu resistencia, habilidad y velocidad serán puestas a prueba.'),
(93, 'Kerbal Space Program', 'kerbal-space-program', 1, 0, '2026-03-15 13:00:00', '2015-04-27', 109, 110, 220200, 3102, 3, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/logo.png', 'Dirige el programa espacial de una raza alienígena y domina la astrofísica.', 'En Kerbal Space Program diriges el programa espacial de los Kerbals. Construye cohetes con piezas reales y aplica físicas aerodinámicas y orbitales; lanza tripulaciones, explora lunas y planetas, y desarrolla bases y estaciones para ampliar tu alcance espacial.'),
(94, 'Human Resource Machine', 'human-resource-machine', 1, 0, '2025-05-05 10:15:00', '2015-10-15', 111, 111, 375820, 14545, 3, 78, 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/logo.png', 'Programa a pequeños oficinistas para resolver puzles.', 'Human Resource Machine es un juego de puzles donde tu jefe te da tareas que debes automatizar programando a tu pequeño trabajador de oficina. Si resuelves los retos, asciendes al siguiente nivel. No hace falta experiencia previa en programación: es lógica, resolución de problemas y diversión.'),
(95, 'PC Building Simulator', 'pc-building-simulator', 1, 0, '2025-08-15 10:00:00', '2019-01-29', 112, 112, 621060, 27792, 3, 72, 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/logo.png', 'Aprende a montar y reparar ordenadores reales.', 'PC Building Simulator permite experimentar y construir tu propio PC de gaming sin riesgos ni costes reales. Con tutoriales y una gran variedad de componentes realistas que funcionan como en la vida real, aprenderás a montar y optimizar tu equipo.'),
(96, 'Dishonored 2', 'dishonored-2', 1, 0, '2025-06-15 15:30:00', '2016-11-11', 35, 3, 403640, 11118, 18, 88, 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/logo.png', 'Recupera lo que es tuyo con sigilo y poderes sobrenaturales.', 'Dishonored 2 se sitúa 15 años después de la caída del Lord Regent. Un usurpador ocupa el trono de la Emperatriz Emily Kaldwin; el jugador, como Emily o Corvo, viaja a Karnaca para restaurarla. Armada con la marca del Outsider y nuevas habilidades sobrenaturales, caza a tus enemigos y cambia el destino del Imperio.'),
(97, 'Discovery Tour: Viking Age', 'discovery-tour-viking-age', 1, 0, '2025-10-05 18:30:00', '2021-10-19', 48, 9, 1613530, 152231, 12, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/logo.png', 'Explora la historia vikinga sin combates en un museo viviente.', 'Discovery Tour: Viking Age, gratuito para propietarios de Assassin''s Creed Valhalla, permite explorar el mundo del juego con un enfoque educativo y ofrece un análisis más profundo de la historia de la era vikinga.'),
(98, 'Poly Bridge 3', 'poly-bridge-3', 1, 0, '2026-04-20 07:45:00', '2023-05-30', 113, 113, 1850240, 243400, 3, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/logo.png', 'Aprende ingeniería construyendo puentes creativos.', 'Poly Bridge 3 es la tercera entrega de la serie de simulación y puzles que te desafía a diseñar y construir puentes. Incluye una campaña extensa, modo sandbox y soporte para herramientas de mods.'),
(99, 'Scribblenauts Unlimited', 'scribblenauts-unlimited', 1, 0, '2025-02-20 11:30:00', '2012-11-20', 114, 115, 218680, 2943, 3, 75, 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/logo.png', 'Fomenta la creatividad invocando cualquier objeto imaginable.', 'Aventúrate en un mundo abierto donde la imaginación es la herramienta más poderosa. Ayuda a Maxwell a resolver puzles en niveles libres y crea objetos invocando cualquier cosa que imagines. Diseña objetos originales, asignales propiedades y compártelos con amigos mediante Steam Workshop.'),
(100, 'Fall Guys', 'fall-guys', 1, 0, '2026-02-20 19:15:00', '2020-08-04', 116, 117, 1097150, 119313, 3, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/logo.png', '¡Tropieza hacia la victoria en este battle royale de plataformas!', 'Fall Guys lanza a hordas de concursantes en línea en una carrera caótica de rondas tras rondas hasta que solo queda un vencedor. Enfréntate a obstáculos absurdos, empuja a tus rivales y supera las físicas impredecibles para evitar la eliminación. Deja la dignidad en la puerta y prepárate para fallos hilarantes en tu búsqueda de la corona.'),
(101, 'LEGO Star Wars: The Skywalker Saga', 'lego-star-wars-the-skywalker-saga', 1, 0, '2026-06-25 20:15:00', '2022-04-05', 118, 115, 1443370, 119305, 7, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/logo.png', 'Vive las nueve películas de la saga con el humor de LEGO.', 'LEGO Star Wars: The Skywalker Saga es una aventura de acción en tercera persona con hubs en mundo abierto. A diferencia de entregas anteriores, puedes comenzar el juego desde cualquier episodio de la saga Skywalker y completarlos en el orden que prefieras. Cada episodio tiene su propio hub repleto de planetas para explorar, cinco misiones de historia por episodio y cientos de personajes jugables. El combate y la cámara se han renovado, añadiendo combos de sable de luz y ángulos sobre el hombro para personajes con bláster.'),
(102, 'Stardew Valley', 'stardew-valley', 1, 0, '2026-03-25 07:45:00', '2016-02-26', 119, 120, 413150, 17000, 3, 89, 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/logo.png', 'Hereda la granja de tu abuelo y comienza una nueva vida rural.', 'Stardew Valley es un RPG de vida campestre abierto. Heredas la granja de tu abuelo y, con herramientas básicas y unas pocas monedas, deberás convertir campos descuidados en un hogar próspero. Planta cultivos, mejora tu granja, participa en la comunidad local y devuelve la vida al valle con dedicación y trabajo.'),
(103, 'Phoenix Wright: Ace Attorney Trilogy', 'phoenix-wright-ace-attorney-trilogy', 1, 0, '2025-07-20 15:15:00', '2019-04-09', 23, 23, 787480, 21610, 12, 81, 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/logo.png', '¡Protesta! Defiende a tus clientes en juicios llenos de giros.', 'Defiende a los inocentes y salva el día. Phoenix Wright: Ace Attorney Trilogy reúne la trilogía clásica con gráficos redibujados y visuales optimizados: investiga escenas del crimen, reúne pruebas y cuestiona testigos para exponer contradicciones y lograr la absolución de tus clientes en intensos juicios.'),
(104, 'VA-11 Hall-A', 'va-11-hall-a', 1, 0, '2026-01-10 14:00:00', '2016-06-21', 121, 122, 447530, 15465, 16, 83, 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/logo.png', 'Sirve bebidas y escucha historias en un futuro cyberpunk distópico.', 'VA-11 HALL-A: Cyberpunk Bartender Action es un juego sobre coctelería, waifus y vida post-distrópica. En un mundo dominado por corporaciones y control social, trabajas como camarero en Valhalla, un pequeño bar que atrae a personajes fascinantes. Sirve bebidas adecuadas y te convertirás en oyente de historias únicas de un mundo distópico.'),
(105, 'Coffee Talk', 'coffee-talk', 1, 0, '2026-05-25 07:30:00', '2020-01-29', 123, 123, 914800, 106847, 12, 75, 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/logo.png', 'Prepara café y charla con habitantes de una Seattle fantástica.', 'Coffee Talk es un simulador de preparar café y conversar, donde escucharás los problemas de personajes inspirados en fantasías modernas y les ayudarás sirviendo una bebida caliente y un oído atento.'),
(106, 'Doki Doki Literature Club Plus!', 'doki-doki-literature-club-plus', 1, 0, '2025-02-15 22:45:00', '2021-06-30', 124, 125, 1388880, 152122, 18, 82, 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/logo.png', 'Únete al club de literatura en este thriller psicológico.', 'Bienvenido a un mundo aterrador de poesía y romance. Escribe poemas para tu interés amoroso y toma decisiones que desvelan horrores psicológicos. Doki Doki Literature Club Plus! expande la experiencia original con contenido nuevo y características adicionales en una envoltura inquietante.'),
(107, 'Zero Escape: The Nonary Games', 'zero-escape-the-nonary-games', 1, 0, '2026-06-10 11:00:00', '2017-03-24', 107, 107, 477740, 25343, 16, 86, 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/logo.png', 'Resuelve puzles mortales para escapar de un secuestro.', 'Secuestrados y llevados a un lugar desconocido, nueve personas se ven obligadas a participar en el diabólico Nonary Game diseñado por el enigmático Zero. ¿Por qué fueron elegidos y quién puede confiarse? Las tensiones aumentan y los nueve extraños deben descubrir cómo escapar antes de que la situación termine en muerte.'),
(108, 'Hitman World of Assassination', 'hitman-world-of-assassination', 1, 0, '2025-10-25 12:00:00', '2022-01-20', 126, 126, 1659040, 233571, 18, 87, 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1659040/logo.png', 'Conviértete en el Agente 47, el asesino definitivo.', 'Conviértete en el Agente 47 en la aventura definitiva de espionaje a través de más de 20 ubicaciones. Hitman World of Assassination reúne lo mejor de Hitman, Hitman 2 y Hitman 3, incluyendo campañas, modo contratos, escaladas, objetivos elusivos y el modo Freelancer.');

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
(1, 108);

-- Game Categories (Pivot Table)
-- Categorías referencia: 1: Acción, 2: Aventura, 3: Estrategia, 4: RPG, 5: Simulación, 7: Indie, 8: Arcade
INSERT INTO `game_categories` (`game_id`, `category_id`) VALUES
(1, 8), (1, 7),  -- Project Zomboid (Supervivencia, Simulación)
(2, 3), (2, 1),  -- Indiana Jones and the Great Circle (Aventura, Acción)
(3, 7), (3, 4),  -- Cities: Skylines II (Simulación, Estrategia)
(4, 9), (4, 1),  -- Red Dead Redemption 2 (Mundo Abierto, Acción)
(5, 9), (5, 1),  -- Star Wars Outlaws (Mundo Abierto, Acción)
(6, 1), (6, 9),  -- Marvel's Spider-Man 2 (Acción, Mundo Abierto)
(7, 2), (7, 9),  -- Hogwarts Legacy (RPG, Mundo Abierto)
(8, 3), (8, 6),  -- The Wolf Among Us (Aventura, Terror)
(9, 2), (9, 9),  -- Cyberpunk 2077 (RPG, Mundo Abierto)
(10, 2), (10, 1),  -- Elden Ring (RPG, Acción)
(11, 2), (11, 3),  -- Baldur's Gate III (RPG, Aventura)
(12, 12), (12, 9),  -- Forza Horizon 5 (Carreras, Mundo Abierto)
(13, 6), (13, 1),  -- Resident Evil 4 (Terror, Acción)
(14, 5), (14, 1),  -- ARC Raiders (Shooter, Acción)
(15, 1), (15, 3),  -- God of War Ragnarök (Acción, Aventura)
(16, 12), (16, 9),  -- Horizon Forbidden West (Carreras, Mundo Abierto)
(17, 3), (17, 8),  -- The Last of Us Part II (Aventura, Supervivencia)
(18, 1), (18, 9),  -- Ghost of Tsushima (Acción, Mundo Abierto)
(19, 5), (19, 1),  -- Returnal (Shooter, Acción)
(20, 2), (20, 1),  -- Demon's Souls (RPG, Acción)
(21, 3), (21, 14),  -- Stray (Aventura, Plataformas)
(22, 14), (22, 3),  -- It Takes Two (Plataformas, Aventura)
(23, 5), (23, 3),  -- Deathloop (Shooter, Aventura)
(24, 6), (24, 3),  -- Control: Ultimate Edition (Terror, Aventura)
(25, 13), (25, 1),  -- Sifu (Lucha, Acción)
(26, 6), (26, 1),  -- Dead Space (Terror, Acción)
(27, 1), (27, 14),  -- Hi-Fi Rush (Acción, Plataformas)
(28, 6), (28, 1),  -- Resident Evil Village (Terror, Acción)
(29, 5), (29, 1),  -- Doom Eternal (Shooter, Acción)
(30, 3), (30, 1),  -- A Way Out (Aventura, Acción)
(31, 5), (31, 1),  -- Half-Life: Alyx (Shooter, Acción)
(32, 5), (32, 1),  -- Dying Light 2: Stay Human (Shooter, Acción)
(33, 11), (33, 3),  -- Portal 2 (Puzzle, Aventura)
(34, 2), (34, 1),  -- Mass Effect Legendary Edition (RPG, Acción)
(35, 3), (35, 9),  -- Sea of Thieves (Aventura, Mundo Abierto)
(36, 1), (36, 9),  -- Assassin's Creed Valhalla (Acción, Mundo Abierto)
(37, 1), (37, 2),  -- Hades (Acción, RPG)
(38, 1), (38, 3),  -- Sekiro: Shadows Die Twice (Acción, Aventura)
(39, 14), (39, 3),  -- Hollow Knight (Plataformas, Aventura)
(40, 14), (40, 3),  -- Ori and the Will of the Wisps (Plataformas, Aventura)
(41, 6), (41, 1),  -- Resident Evil 2 (Terror, Acción)
(42, 6), (42, 1),  -- Resident Evil 3 (Terror, Acción)
(43, 4), (43, 7),  -- Civilization VI (Estrategia, Simulación)
(44, 2), (44, 1),  -- Final Fantasy VII Remake Intergrade (RPG, Acción)
(45, 14), (45, 3),  -- Crash Bandicoot 4 (Plataformas, Aventura)
(46, 14), (46, 3),  -- Spyro Reignited Trilogy (Plataformas, Aventura)
(47, 4), (47, 3),  -- Age of Empires IV (Estrategia, Aventura)
(48, 13), (48, 1),  -- Street Fighter 6 (Lucha, Acción)
(49, 1), (49, 3),  -- Immortals Fenyx Rising (Acción, Aventura)
(50, 5), (50, 4),  -- Rainbow Six Siege (Shooter, Estrategia)
(51, 14), (51, 1),  -- Mirror's Edge (Plataformas, Acción)
(52, 14), (52, 3),  -- Gris (Plataformas, Aventura)
(53, 1), (53, 14),  -- Devil May Cry 5 (Acción, Plataformas)
(54, 12), (54, 7),  -- F1 25 (Carreras, Simulación)
(55, 7), (55, 15),  -- Microsoft Flight Simulator (Simulación, Educativo)
(56, 4), (56, 7),  -- Frostpunk 2 (Estrategia, Simulación)
(57, 8), (57, 7),  -- Palworld (Supervivencia, Simulación)
(58, 1), (58, 3),  -- Star Wars Jedi: Survivor (Acción, Aventura)
(59, 2), (59, 1),  -- Lords of the Fallen (RPG, Acción)
(60, 2), (60, 1),  -- Lies of P (RPG, Acción)
(61, 4), (61, 7),  -- Cult of the Lamb (Estrategia, Simulación)
(62, 1), (62, 5),  -- Armored Core VI: Fires of Rubicon (Acción, Shooter)
(63, 1), (63, 3),  -- The Callisto Protocol (Acción, Aventura)
(64, 1), (64, 3),  -- A Plague Tale: Requiem (Acción, Aventura)
(65, 1), (65, 3),  -- Silent Hill 2 (Acción, Aventura)
(66, 12), (66, 1),  -- Need for Speed: Unbound (Carreras, Acción)
(67, 4), (67, 3),  -- Manor Lords (Estrategia, Aventura)
(68, 2), (68, 1),  -- Monster Hunter Rise (RPG, Acción)
(69, 2), (69, 1),  -- Nioh 2 (RPG, Acción)
(70, 1), (70, 2),  -- Hades II (Acción, RPG)
(71, 1), (71, 3),  -- Granblue Fantasy: Relink (Acción, Aventura)
(72, 2), (72, 3),  -- Persona 5 Royal (RPG, Aventura)
(73, 2), (73, 1),  -- Black Myth: Wukong (RPG, Acción)
(74, 3), (74, 11),  -- Outer Wilds (Aventura, Puzzle)
(75, 2), (75, 1),  -- Dragon's Dogma II (RPG, Acción)
(76, 2), (76, 1),  -- NieR: Automata (RPG, Acción)
(77, 5), (77, 1),  -- Helldivers 2 (Shooter, Acción)
(78, 2), (78, 3),  -- Disco Elysium (RPG, Aventura)
(79, 1), (79, 5),  -- Warhammer 40,000: Space Marine II (Acción, Shooter)
(80, 1), (80, 3),  -- BioShock Infinite (Acción, Aventura)
(81, 14), (81, 1),  -- Cuphead (Plataformas, Acción)
(82, 11), (82, 3),  -- Balatro (Puzzle, Aventura)
(83, 10), (83, 7),  -- EA Sports FC 25 (Deportes, Simulación)
(84, 10), (84, 7),  -- Madden NFL 25 (Deportes, Simulación)
(85, 10), (85, 7),  -- NBA 2K25 (Deportes, Simulación)
(86, 6), (86, 1),  -- Dead by Daylight (Terror, Acción)
(87, 1), (87, 3),  -- The Precinct (Acción, Aventura)
(88, 4), (88, 7),  -- Stellaris (Estrategia, Simulación)
(89, 1), (89, 3),  -- Watch Dogs (Acción, Aventura)
(90, 1), (90, 14),  -- Ghostrunner (Acción, Plataformas)
(91, 13), (91, 1),  -- Dragon Ball: Sparking! Zero (Lucha, Acción)
(92, 7), (92, 15),  -- Euro Truck Simulator 2 (Simulación, Educativo)
(93, 7), (93, 15),  -- Kerbal Space Program (Simulación, Educativo)
(94, 11), (94, 15),  -- Human Resource Machine (Puzzle, Educativo)
(95, 7), (95, 15),  -- PC Building Simulator (Simulación, Educativo)
(96, 1), (96, 3),  -- Dishonored 2 (Acción, Aventura);
(97, 1), (97, 3),  -- Discovery Tour: Viking Age (Acción, Aventura)
(98, 7), (98, 11),  -- Poly Bridge 3 (Simulación, Puzzle)
(99, 11), (99, 3),  -- Scribblenauts Unlimited (Puzzle, Aventura)
(100, 14), (100, 16),  -- Fall Guys (Plataformas, Familiar)
(101, 16), (101, 3),  -- LEGO Star Wars: The Skywalker Saga (Familiar, Aventura)
(102, 7), (102, 2),  -- Stardew Valley (Simulación, RPG)
(103, 11), (103, 3),  -- Phoenix Wright: Ace Attorney Trilogy (Puzzle, Aventura)
(104, 7), (104, 3),  -- VA-11 Hall-A (Simulación, Aventura)
(105, 7), (105, 3),  -- Coffee Talk (Simulación, Aventura)
(106, 6), (106, 11),  -- Doki Doki Literature Club Plus! (Terror, Puzzle)
(107, 11), (107, 3),  -- Zero Escape: The Nonary Games (Puzzle, Aventura)
(108, 1), (108, 9);  -- Hitman World of Assassination (Acción, Mundo Abierto)


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
