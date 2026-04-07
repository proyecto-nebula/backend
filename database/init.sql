-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 07-04-2026 a las 15:20:05
-- Versión del servidor: 8.0.45
-- Versión de PHP: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nebula_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avatares`
--

CREATE TABLE `avatares` (
  `id_avatar` int NOT NULL,
  `nombre_avatar` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `imagen_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `avatares`
--

INSERT INTO `avatares` (`id_avatar`, `nombre_avatar`, `imagen_avatar`) VALUES
(1, 'Estrella', 'https://api.multiavatar.com/estrella.png'),
(2, 'Gamer Pro', 'https://api.multiavatar.com/gamerpro.png'),
(3, 'Noob', 'https://api.multiavatar.com/n00b.png'),
(4, 'Admin', 'https://api.multiavatar.com/admin.png'),
(5, 'Anónimo', 'https://api.multiavatar.com/anonimo.png'),
(6, 'Soporte', 'https://api.multiavatar.com/soporte.png'),
(7, 'Tester', 'https://api.multiavatar.com/tester1.png'),
(8, 'Speedrunner', 'https://api.multiavatar.com/speedrunner.png'),
(9, 'Coleccionista', 'https://api.multiavatar.com/coleccionista.png'),
(10, 'Crítico', 'https://api.multiavatar.com/critico.png'),
(11, 'Logros', 'https://api.multiavatar.com/achievements.png'),
(12, 'Indie', 'https://api.multiavatar.com/indie.png'),
(13, 'Lobo', 'https://api.multiavatar.com/wolf.png'),
(14, 'Mundo', 'https://api.multiavatar.com/world.png'),
(15, 'Estratega', 'https://api.multiavatar.com/strategy.png'),
(16, 'Piloto', 'https://api.multiavatar.com/pilot.png'),
(17, 'Mercenario', 'https://api.multiavatar.com/mercenary.png'),
(18, 'Mago', 'https://api.multiavatar.com/wizard.png'),
(19, 'Constructor', 'https://api.multiavatar.com/build.png'),
(20, 'Leyenda', 'https://api.multiavatar.com/legend.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capturas`
--

CREATE TABLE `capturas` (
  `id_captura` int NOT NULL,
  `id_juego` int DEFAULT NULL,
  `imagen_captura` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `capturas`
--

INSERT INTO `capturas` (`id_captura`, `id_juego`, `imagen_captura`) VALUES
(1, 1, 'prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL,
  `nombre_categoria` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre_categoria`) VALUES
(1, 'Acción'),
(2, 'RPG'),
(3, 'Aventura'),
(4, 'Estrategia'),
(5, 'Shooter'),
(6, 'Terror'),
(7, 'Simulación'),
(8, 'Indie'),
(9, 'Supervivencia'),
(10, 'Mundo Abierto'),
(11, 'Sigilo'),
(12, 'Cooperativo'),
(13, 'Deportes'),
(14, 'Puzzle'),
(15, 'Carreras'),
(16, 'Lucha'),
(17, 'Plataformas'),
(18, 'Novela Visual'),
(19, 'Educativo'),
(20, 'Familiar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudios`
--

CREATE TABLE `estudios` (
  `id_estudio` int NOT NULL,
  `nombre_estudio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `logo_estudio` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `estudios`
--

INSERT INTO `estudios` (`id_estudio`, `nombre_estudio`, `logo_estudio`) VALUES
(1, 'Insomniac Games', 'https://ui-avatars.com/api/?name=Insomniac+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(2, 'Colossal Order', 'https://ui-avatars.com/api/?name=Colossal+Order&size=256&background=0D8ABC&color=fff&bold=true'),
(3, 'The Indie Stone', 'https://ui-avatars.com/api/?name=The+Indie+Stone&size=256&background=0D8ABC&color=fff&bold=true'),
(4, 'MachineGames', 'https://ui-avatars.com/api/?name=MachineGames&size=256&background=0D8ABC&color=fff&bold=true'),
(5, 'Rockstar North', 'https://ui-avatars.com/api/?name=Rockstar+North&size=256&background=0D8ABC&color=fff&bold=true'),
(6, 'Avalanche Software', 'https://ui-avatars.com/api/?name=Avalanche+Software&size=256&background=0D8ABC&color=fff&bold=true'),
(7, 'Ubisoft Montreal', 'https://ui-avatars.com/api/?name=Ubisoft+Montreal&size=256&background=0D8ABC&color=fff&bold=true'),
(8, 'Respawn Entertainment', 'https://ui-avatars.com/api/?name=Respawn+Entertainment&size=256&background=0D8ABC&color=fff&bold=true'),
(9, 'Telltale Games', 'https://ui-avatars.com/api/?name=Telltale+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(10, 'Hangar 13', 'https://ui-avatars.com/api/?name=Hangar+13&size=256&background=0D8ABC&color=fff&bold=true'),
(11, 'Warhorse Studios', 'https://ui-avatars.com/api/?name=Warhorse+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(12, 'Kojima Productions', 'https://ui-avatars.com/api/?name=Kojima+Productions&size=256&background=0D8ABC&color=fff&bold=true'),
(13, 'CD Projekt Red', 'https://ui-avatars.com/api/?name=CD+Projekt+Red&size=256&background=0D8ABC&color=fff&bold=true'),
(14, 'FromSoftware', 'https://ui-avatars.com/api/?name=FromSoftware&size=256&background=0D8ABC&color=fff&bold=true'),
(15, 'Larian Studios', 'https://ui-avatars.com/api/?name=Larian+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(16, 'Bethesda Game Studios', 'https://ui-avatars.com/api/?name=Bethesda+Game+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(17, 'Playground Games', 'https://ui-avatars.com/api/?name=Playground+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(18, 'Capcom', 'https://ui-avatars.com/api/?name=Capcom&size=256&background=0D8ABC&color=fff&bold=true'),
(19, 'Embark Studios', 'https://ui-avatars.com/api/?name=Embark+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(20, 'Santa Monica Studio', 'https://ui-avatars.com/api/?name=Santa+Monica+Studio&size=256&background=0D8ABC&color=fff&bold=true'),
(21, 'Guerrilla Games', 'https://ui-avatars.com/api/?name=Guerrilla+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(22, 'Naughty Dog', 'https://ui-avatars.com/api/?name=Naughty+Dog&size=256&background=0D8ABC&color=fff&bold=true'),
(23, 'Sucker Punch Productions', 'https://ui-avatars.com/api/?name=Sucker+Punch+Productions&size=256&background=0D8ABC&color=fff&bold=true'),
(24, 'Housemarque', 'https://ui-avatars.com/api/?name=Housemarque&size=256&background=0D8ABC&color=fff&bold=true'),
(25, 'Bluepoint Games', 'https://ui-avatars.com/api/?name=Bluepoint+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(26, 'BlueTwelve Studio', 'https://ui-avatars.com/api/?name=BlueTwelve+Studio&size=256&background=0D8ABC&color=fff&bold=true'),
(27, 'Hazelight Studios', 'https://ui-avatars.com/api/?name=Hazelight+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(28, 'Arkane Studios', 'https://ui-avatars.com/api/?name=Arkane+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(29, 'Polyphony Digital', 'https://ui-avatars.com/api/?name=Polyphony+Digital&size=256&background=0D8ABC&color=fff&bold=true'),
(30, 'id Software', 'https://ui-avatars.com/api/?name=id+Software&size=256&background=0D8ABC&color=fff&bold=true'),
(31, 'Tango Gameworks', 'https://ui-avatars.com/api/?name=Tango+Gameworks&size=256&background=0D8ABC&color=fff&bold=true'),
(32, 'Studio MDHR', 'https://ui-avatars.com/api/?name=Studio+MDHR&size=256&background=0D8ABC&color=fff&bold=true'),
(33, 'Maddy Makes Games', 'https://ui-avatars.com/api/?name=Maddy+Makes+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(34, 'Moon Studios', 'https://ui-avatars.com/api/?name=Moon+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(35, 'Mega Crit Games', 'https://ui-avatars.com/api/?name=Mega+Crit+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(36, 'Re-Logic', 'https://ui-avatars.com/api/?name=Re-Logic&size=256&background=0D8ABC&color=fff&bold=true'),
(37, 'Unknown Worlds', 'https://ui-avatars.com/api/?name=Unknown+Worlds&size=256&background=0D8ABC&color=fff&bold=true'),
(38, 'Iron Gate Studio', 'https://ui-avatars.com/api/?name=Iron+Gate+Studio&size=256&background=0D8ABC&color=fff&bold=true'),
(39, 'InnerSloth', 'https://ui-avatars.com/api/?name=InnerSloth&size=256&background=0D8ABC&color=fff&bold=true'),
(40, 'Kinetic Games', 'https://ui-avatars.com/api/?name=Kinetic+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(41, 'Behaviour Interactive', 'https://ui-avatars.com/api/?name=Behaviour+Interactive&size=256&background=0D8ABC&color=fff&bold=true'),
(42, 'Asobo Studio', 'https://ui-avatars.com/api/?name=Asobo+Studio&size=256&background=0D8ABC&color=fff&bold=true'),
(43, 'SCS Software', 'https://ui-avatars.com/api/?name=SCS+Software&size=256&background=0D8ABC&color=fff&bold=true'),
(44, 'Rare', 'https://ui-avatars.com/api/?name=Rare&size=256&background=0D8ABC&color=fff&bold=true'),
(45, 'Game Science', 'https://ui-avatars.com/api/?name=Game+Science&size=256&background=0D8ABC&color=fff&bold=true'),
(46, 'CyberConnect2', 'https://ui-avatars.com/api/?name=CyberConnect2&size=256&background=0D8ABC&color=fff&bold=true'),
(47, 'Arrowhead Game Studios', 'https://ui-avatars.com/api/?name=Arrowhead+Game+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(48, 'Saber Interactive', 'https://ui-avatars.com/api/?name=Saber+Interactive&size=256&background=0D8ABC&color=fff&bold=true'),
(49, 'Bloober Team', 'https://ui-avatars.com/api/?name=Bloober+Team&size=256&background=0D8ABC&color=fff&bold=true'),
(50, '11 bit studios', 'https://ui-avatars.com/api/?name=11+bit+studios&size=256&background=0D8ABC&color=fff&bold=true'),
(51, 'Slavic Magic', 'https://ui-avatars.com/api/?name=Slavic+Magic&size=256&background=0D8ABC&color=fff&bold=true'),
(52, 'GSC Game World', 'https://ui-avatars.com/api/?name=GSC+Game+World&size=256&background=0D8ABC&color=fff&bold=true'),
(53, 'Keen Games', 'https://ui-avatars.com/api/?name=Keen+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(54, 'LocalThunk', 'https://ui-avatars.com/api/?name=LocalThunk&size=256&background=0D8ABC&color=fff&bold=true'),
(55, 'Pocketpair', 'https://ui-avatars.com/api/?name=Pocketpair&size=256&background=0D8ABC&color=fff&bold=true'),
(56, 'Bandai Namco Studios', 'https://ui-avatars.com/api/?name=Bandai+Namco+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(57, 'Ironwood Studios', 'https://ui-avatars.com/api/?name=Ironwood+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(58, 'NEOWIZ', 'https://ui-avatars.com/api/?name=NEOWIZ&size=256&background=0D8ABC&color=fff&bold=true'),
(59, 'Atlus', 'https://ui-avatars.com/api/?name=Atlus&size=256&background=0D8ABC&color=fff&bold=true'),
(60, 'PlatinumGames', 'https://ui-avatars.com/api/?name=PlatinumGames&size=256&background=0D8ABC&color=fff&bold=true'),
(61, 'Arc System Works', 'https://ui-avatars.com/api/?name=Arc+System+Works&size=256&background=0D8ABC&color=fff&bold=true'),
(62, 'Sumo Digital', 'https://ui-avatars.com/api/?name=Sumo+Digital&size=256&background=0D8ABC&color=fff&bold=true'),
(63, 'Kunos Simulazioni', 'https://ui-avatars.com/api/?name=Kunos+Simulazioni&size=256&background=0D8ABC&color=fff&bold=true'),
(64, 'Sabotage Studio', 'https://ui-avatars.com/api/?name=Sabotage+Studio&size=256&background=0D8ABC&color=fff&bold=true'),
(65, 'Mintrocket', 'https://ui-avatars.com/api/?name=Mintrocket&size=256&background=0D8ABC&color=fff&bold=true'),
(66, 'Firaxis Games', 'https://ui-avatars.com/api/?name=Firaxis+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(67, 'NetherRealm Studios', 'https://ui-avatars.com/api/?name=NetherRealm+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(68, 'Relic Entertainment', 'https://ui-avatars.com/api/?name=Relic+Entertainment&size=256&background=0D8ABC&color=fff&bold=true'),
(69, 'Paradox Development Studio', 'https://ui-avatars.com/api/?name=Paradox+Development+Studio&size=256&background=0D8ABC&color=fff&bold=true'),
(70, 'Madden NFL Team', 'https://ui-avatars.com/api/?name=Madden+NFL+Team&size=256&background=0D8ABC&color=fff&bold=true'),
(71, 'Kowloon Nights', 'https://ui-avatars.com/api/?name=Kowloon+Nights&size=256&background=0D8ABC&color=fff&bold=true'),
(72, 'ZA/UM', 'https://ui-avatars.com/api/?name=ZA/UM&size=256&background=0D8ABC&color=fff&bold=true'),
(73, 'Nintendo EPD', 'https://ui-avatars.com/api/?name=Nintendo+EPD&size=256&background=0D8ABC&color=fff&bold=true'),
(74, 'Remedy Entertainment', 'https://ui-avatars.com/api/?name=Remedy+Entertainment&size=256&background=0D8ABC&color=fff&bold=true'),
(75, 'Techland', 'https://ui-avatars.com/api/?name=Techland&size=256&background=0D8ABC&color=fff&bold=true'),
(76, 'Valve', 'https://ui-avatars.com/api/?name=Valve&size=256&background=0D8ABC&color=fff&bold=true'),
(77, 'Toys for Bob', 'https://ui-avatars.com/api/?name=Toys+for+Bob&size=256&background=0D8ABC&color=fff&bold=true'),
(78, 'Massive Monster', 'https://ui-avatars.com/api/?name=Massive+Monster&size=256&background=0D8ABC&color=fff&bold=true'),
(79, 'Criterion Games', 'https://ui-avatars.com/api/?name=Criterion+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(80, 'One More Level', 'https://ui-avatars.com/api/?name=One+More+Level&size=256&background=0D8ABC&color=fff&bold=true'),
(81, 'Squad', 'https://ui-avatars.com/api/?name=Squad&size=256&background=0D8ABC&color=fff&bold=true'),
(82, 'Giant Army', 'https://ui-avatars.com/api/?name=Giant+Army&size=256&background=0D8ABC&color=fff&bold=true'),
(83, 'Tomorrow Corporation', 'https://ui-avatars.com/api/?name=Tomorrow+Corporation&size=256&background=0D8ABC&color=fff&bold=true'),
(84, 'Claudiu Kiss', 'https://ui-avatars.com/api/?name=Claudiu+Kiss&size=256&background=0D8ABC&color=fff&bold=true'),
(85, 'Luden.io', 'https://ui-avatars.com/api/?name=Ludenio&size=256&background=0D8ABC&color=fff&bold=true'),
(86, 'Dry Cactus', 'https://ui-avatars.com/api/?name=Dry+Cactus&size=256&background=0D8ABC&color=fff&bold=true'),
(87, '5th Cell', 'https://ui-avatars.com/api/?name=5th+Cell&size=256&background=0D8ABC&color=fff&bold=true'),
(88, 'Force Field', 'https://ui-avatars.com/api/?name=Force+Field&size=256&background=0D8ABC&color=fff&bold=true'),
(89, 'Mediatonic', 'https://ui-avatars.com/api/?name=Mediatonic&size=256&background=0D8ABC&color=fff&bold=true'),
(90, 'TT Games', 'https://ui-avatars.com/api/?name=TT+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(91, 'Mojang Studios', 'https://ui-avatars.com/api/?name=Mojang+Studios&size=256&background=0D8ABC&color=fff&bold=true'),
(92, 'ConcernedApe', 'https://ui-avatars.com/api/?name=ConcernedApe&size=256&background=0D8ABC&color=fff&bold=true'),
(93, 'MAGES. Inc.', 'https://ui-avatars.com/api/?name=MAGES+Inc&size=256&background=0D8ABC&color=fff&bold=true'),
(94, 'Spike Chunsoft', 'https://ui-avatars.com/api/?name=Spike+Chunsoft&size=256&background=0D8ABC&color=fff&bold=true'),
(95, 'Sukeban Games', 'https://ui-avatars.com/api/?name=Sukeban+Games&size=256&background=0D8ABC&color=fff&bold=true'),
(96, 'Toge Productions', 'https://ui-avatars.com/api/?name=Toge+Productions&size=256&background=0D8ABC&color=fff&bold=true'),
(97, 'Team Salvato', 'https://ui-avatars.com/api/?name=Team+Salvato&size=256&background=0D8ABC&color=fff&bold=true'),
(98, 'Vanillaware', 'https://ui-avatars.com/api/?name=Vanillaware&size=256&background=0D8ABC&color=fff&bold=true'),
(99, 'PaleMono', 'https://ui-avatars.com/api/?name=PaleMono&size=256&background=0D8ABC&color=fff&bold=true'),
(100, 'Key', 'https://ui-avatars.com/api/?name=Key&size=256&background=0D8ABC&color=fff&bold=true'),
(101, 'IO Interactive', 'https://ui-avatars.com/api/?name=IO+Interactive&size=256&background=0D8ABC&color=fff&bold=true'),
(102, 'Eidos-Montréal', 'https://ui-avatars.com/api/?name=Eidos-Montréal&size=256&background=0D8ABC&color=fff&bold=true'),
(103, 'Ubisoft Toronto', 'https://ui-avatars.com/api/?name=Ubisoft+Toronto&size=256&background=0D8ABC&color=fff&bold=true');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id_usuario` int NOT NULL,
  `id_juego` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`id_usuario`, `id_juego`) VALUES
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
(0, 101),
(1, 102),
(0, 105),
(1, 108),
(0, 110),
(1, 115),
(0, 120),
(1, 122),
(0, 125),
(1, 129);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juegos`
--

CREATE TABLE `juegos` (
  `id_juego` int NOT NULL,
  `id_desarrollador` int DEFAULT NULL,
  `id_distribuidor` int DEFAULT NULL,
  `id_pegi` int DEFAULT NULL,
  `id_steam` varchar(50) DEFAULT NULL,
  `id_igdb` varchar(50) DEFAULT NULL,
  `titulo_juego` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `descripcion_corta` text,
  `descripcion_larga` text,
  `portada_v` varchar(255) DEFAULT NULL,
  `portada_h` varchar(255) DEFAULT NULL,
  `hero_juego` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logo_juego` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `metacritic_juego` int DEFAULT NULL,
  `fecha_lanzamiento_juego` date DEFAULT NULL,
  `fecha_publicacion_juego` date DEFAULT NULL,
  `destacado_juego` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `juegos`
--

INSERT INTO `juegos` (`id_juego`, `id_desarrollador`, `id_distribuidor`, `id_pegi`, `id_steam`, `id_igdb`, `titulo_juego`, `descripcion_corta`, `descripcion_larga`, `portada_v`, `portada_h`, `hero_juego`, `logo_juego`, `metacritic_juego`, `fecha_lanzamiento_juego`, `fecha_publicacion_juego`, `destacado_juego`) VALUES
(1, 3, 3, 18, '108600', NULL, 'Project Zomboid', '¿Cómo morirás? La supervivencia zombi definitiva en un mundo implacable.', 'Project Zomboid es la cima de la supervivencia zombi. En un mapa inmenso basado en la Kentucky rural, los jugadores deben saquear casas, construir defensas y luchar contra el hambre, la sed y la enfermedad mientras intentan evitar ser devorados por la horda implacable.', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/logo.png', 80, '2013-11-08', '2026-01-05', 1),
(2, 4, 16, 16, '2677660', NULL, 'Indiana Jones and the Great Circle', 'Desentraña uno de los mayores misterios de la historia en esta aventura trotamundos.', 'Viaja al año 1937 y ponte el sombrero del arqueólogo más famoso del cine. Indiana Jones and the Great Circle es una experiencia de acción y aventura en primera persona.', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/logo.png', 85, '2024-12-09', '2026-01-05', 1),
(3, 2, 69, 3, '949230', NULL, 'Cities: Skylines II', 'Crea una ciudad desde cero y transfórmala en una metrópolis próspera.', 'Alza una ciudad desde sus cimientos y transfórmala en la metrópolis próspera que solo tú puedes imaginar. Nunca has experimentado una construcción a esta escala. Con una simulación profunda y una economía viva, Cities: Skylines II te permite construir un mundo sin límites.', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/logo.png', 74, '2023-10-24', '2026-01-05', 1),
(4, 5, 5, 18, '1174180', NULL, 'Red Dead Redemption 2', 'Una epopeya de forajidos en el ocaso del Salvaje Oeste americano.', 'Estados Unidos, 1899. Arthur Morgan y la banda de Van der Linde se ven obligados a huir tras un atraco fallido.', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/logo.png', 97, '2019-12-05', '2026-01-05', 1),
(5, 7, 7, 3, '2834010', NULL, 'Star Wars Outlaws', 'Vive la vida de una buscavidas en el primer mundo abierto de Star Wars.', 'Explora planetas distintos por toda la galaxia, tanto nuevos como clásicos.', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/logo.png', 76, '2024-08-30', '2026-01-05', 1),
(6, 1, 1, 16, '2715900', NULL, 'Marvel\'s Spider-Man 2', 'Los Spider-Men Peter Parker y Miles Morales regresan para una nueva aventura.', 'Balancéate, salta y usa tus Alas de Telaraña para viajar por la Nueva York de Marvel.', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/logo.png', 90, '2025-01-30', '2026-01-05', 0),
(7, 6, 6, 3, '990080', NULL, 'Hogwarts Legacy', 'Vive lo desconocido en el Colegio Hogwarts en el siglo XIX.', 'Hogwarts Legacy es un RPG de acción en un mundo abierto.', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 84, '2023-02-10', '2026-01-05', 0),
(8, 9, 9, 18, '250320', NULL, 'The Wolf Among Us', 'Un thriller crudo, violento y maduro basado en los cómics de Fábulas.', 'Ponte en la piel de Bigby Wolf, el lobo feroz.', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/logo.png', 85, '2013-10-11', '2022-05-14', 0),
(9, 13, 13, 18, '1091500', NULL, 'Cyberpunk 2077', 'Conviértete en un mercenario ciberpunk en Night City.', 'Cyberpunk 2077 es un RPG de acción y aventura en mundo abierto.', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/logo.png', 86, '2020-12-10', '2024-08-15', 0),
(10, 14, 14, 16, '1245620', NULL, 'Elden Ring', 'Levántate, Sinluz, para convertirte en el Señor del Círculo.', 'Elden Ring es una épica aventura de RPG de acción.', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/logo.png', 96, '2022-02-25', '2022-10-14', 0),
(11, 15, 15, 18, '1086940', NULL, 'Baldur\'s Gate 3', 'Regresa a los Reinos Olvidados en una historia de compañerismo.', 'Baldur\'s Gate 3 es un RPG de nueva generación.', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/logo.png', 96, '2023-08-03', '2024-03-22', 0),
(12, 17, 17, 3, '1551360', NULL, 'Forza Horizon 5', 'Tu aventura Horizon definitiva te espera en México.', 'Conduce por un mundo abierto lleno de contrastes y belleza.', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 92, '2021-11-09', '2022-06-18', 0),
(13, 18, 18, 18, '2050650', NULL, 'Resident Evil 4', 'La supervivencia es solo el principio.', 'Seis años después de Raccoon City, Leon S. Kennedy es enviado a una misión de rescate.', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/logo.png', 93, '2023-03-24', '2024-09-02', 0),
(14, 19, 19, 16, '1808500', NULL, 'ARC Raiders', 'Shooter de extracción donde la humanidad resiste a una amenaza mecánica.', 'ARC Raiders es un shooter de extracción en tercera persona gratuito.', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/logo.png', 82, '2025-10-15', '2025-11-20', 0),
(15, 20, NULL, 18, '2322010', NULL, 'God of War Ragnarök', 'Kratos y Atreus deben viajar a cada uno de los Nueve Reinos.', 'Acompaña a Kratos y Atreus en un viaje épico y emotivo mientras luchan por aferrarse y soltarse.', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/logo.png', 94, '2024-09-19', '2024-10-05', 0),
(16, 21, NULL, 16, '2420110', NULL, 'Horizon Forbidden West', 'Acompaña a Aloy en su aventura por las majestuosas tierras del Oeste Prohibido.', 'Explora tierras lejanas, lucha contra máquinas más grandes e imponentes.', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/logo.png', 89, '2024-03-21', '2023-05-12', 0),
(17, 22, NULL, 18, '2401430', NULL, 'The Last of Us Part II', 'Una historia de venganza y redención implacable en un mundo devastado.', 'Cinco años después de su peligroso viaje, Ellie y Joel se han asentado en Jackson.', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/logo.png', 93, '2024-06-19', '2022-01-25', 0),
(18, 23, NULL, 18, '2215430', NULL, 'Ghost of Tsushima', 'El honor de un samurái se enfrenta a una invasión brutal.', 'A finales del siglo XIII, el Imperio mongol ha devastado naciones enteras.', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/logo.png', 87, '2024-05-16', '2024-07-30', 0),
(19, 24, NULL, 16, '1446720', NULL, 'Returnal', 'Rompe el ciclo en este shooter roguelike en tercera persona.', 'Tras el aterrizaje forzoso en un mundo alienígena, Selene debe explorar el paisaje desolado.', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/logo.png', 86, '2023-02-15', '2023-08-22', 0),
(20, 25, NULL, 18, '2401410', NULL, 'Demon\'s Souls', 'Regresa al reino de Boletaria en este remake magistral.', 'En su búsqueda de poder, el duodécimo rey de Boletaria despertó a un demonio antiguo.', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/logo.png', 92, '2024-05-20', '2024-11-15', 0),
(21, 26, NULL, 3, '1332010', NULL, 'Stray', 'Un gato callejero debe resolver un antiguo misterio.', 'Stray es un juego de aventuras protagonizado por un gato en una ciberciudad decadente.', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/logo.png', 83, '2022-07-19', '2022-12-01', 0),
(22, 27, NULL, 3, '1426210', NULL, 'It Takes Two', 'La aventura de plataformas cooperativa definitiva.', 'Ponte en la piel de Cody y May, una pareja en conflicto convertida en muñecos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 88, '2021-03-26', '2023-01-10', 0),
(23, 28, NULL, 18, '1252330', NULL, 'Deathloop', 'Rompe el bucle temporal en este shooter de Arkane Studios.', 'Dos asesinos rivales atrapados en un bucle temporal misterioso en la isla de Blackreef.', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/logo.png', 87, '2021-09-14', '2022-04-18', 0),
(24, 74, NULL, 18, '2149300', NULL, 'Alan Wake 2', 'Horror psicológico donde la realidad y la ficción se entrelazan.', 'Una serie de asesinatos rituales amenaza Bright Falls, una pequeña comunidad aislada.', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/logo.png', 89, '2023-10-27', '2024-03-12', 0),
(25, 74, NULL, 16, '870780', NULL, 'Control Ultimate Edition', 'Domina habilidades sobrenaturales en este thriller de Remedy.', 'Tras una invasión secreta en Nueva York, te conviertes en la nueva directora.', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/logo.png', 85, '2020-08-27', '2022-09-15', 0),
(26, NULL, NULL, 16, '2138710', NULL, 'Sifu', 'La venganza requiere toda una vida de entrenamiento en este beat \'em up de kung-fu.', 'Sifu cuenta la historia de un joven estudiante de kung-fu en busca de venganza contra los asesinos de su familia.', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/logo.png', 81, '2023-03-28', '2023-06-10', 0),
(27, NULL, NULL, 18, '1693980', NULL, 'Dead Space', 'El clásico de terror y supervivencia de ciencia ficción regresa reconstruido.', 'Isaac Clarke es un ingeniero cualquiera en una misión para reparar la USG Ishimura.', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/logo.png', 89, '2023-01-27', '2024-02-14', 0),
(28, 31, NULL, 3, '1817230', NULL, 'Hi-Fi RUSH', 'Siente el ritmo mientras Chai y su equipo luchan contra un megaconglomerado.', 'Siente el ritmo en la piel con Hi-Fi RUSH, donde el mundo se sincroniza con la música.', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/logo.png', 87, '2023-01-25', '2023-12-25', 0),
(29, 18, 18, 18, '1196590', NULL, 'Resident Evil Village', 'Vive el horror de supervivencia como nunca antes en la octava entrega.', 'Ethan Winters deberá adentrarse en un pueblo remoto dominado por cuatro jerarcas.', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/logo.png', 84, '2021-05-07', '2022-03-14', 0),
(30, 30, NULL, 18, '782330', NULL, 'DOOM Eternal', 'Los ejércitos del infierno han invadido la Tierra. Arrasa con todo.', 'Experimenta la combinación definitiva de velocidad y potencia en la evolución del FPS.', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/logo.png', 88, '2020-03-20', '2023-11-28', 0),
(31, 27, NULL, 18, '1222700', NULL, 'A Way Out', 'Una aventura cooperativa donde juegas el papel de dos prisioneros.', 'De los creadores de Brothers llega una historia de fuga emocional e impredecible.', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/logo.png', 78, '2018-03-23', '2022-07-05', 0),
(32, 76, 76, 18, '546560', NULL, 'Half-Life: Alyx', 'El regreso de Valve a Half-Life en una experiencia VR completa.', 'Situada entre Half-Life y Half-Life 2, eres Alyx Vance, la última esperanza humana.', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/logo.png', 93, '2020-03-23', '2024-05-19', 0),
(33, 75, 75, 18, '534380', NULL, 'Dying Light 2 Stay Human', 'Sobrevive en un mundo abierto brutal donde la humanidad pierde la batalla.', 'Utiliza tus habilidades de parkour para recorrer la ciudad y dominar el combate creativo.', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/logo.png', 77, '2022-02-04', '2025-01-05', 0),
(34, 76, 76, 3, '620', NULL, 'Portal 2', 'La secuela del aclamado juego de puzles con humor negro y narrativa única.', 'Regresa a Aperture Science para enfrentarte una vez más a GLaDOS junto a Wheatley.', 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/logo.png', 95, '2011-04-18', '2023-04-12', 0),
(35, NULL, NULL, 18, '1328670', NULL, 'Mass Effect Legendary Edition', 'Vive la leyenda de Shepard en la trilogía remasterizada.', 'Incluye el contenido básico para un jugador y más de 40 DLC de los tres juegos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/logo.png', 86, '2021-05-14', '2022-11-20', 0),
(36, 44, NULL, 3, '1172620', NULL, 'Sea of Thieves', 'Navega, lucha y saquea en esta experiencia pirata definitiva.', 'Sin roles establecidos, tienes total libertad para enfrentarte al mundo como quieras.', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/logo.png', 82, '2020-06-03', '2024-02-15', 0),
(37, 7, NULL, 18, '2208920', NULL, 'Assassin\'s Creed Valhalla', 'Conviértete en Eivor, una leyenda vikinga en busca de gloria.', 'Lidera a tu clan desde las gélidas costas de Noruega hasta la Inglaterra del siglo IX.', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/logo.png', 82, '2022-12-06', '2023-08-10', 0),
(38, NULL, NULL, 3, '1145360', NULL, 'Hades', 'Desafía al dios de los muertos en este roguelike de Supergiant.', 'Como el príncipe inmortal del Inframundo, usarás los poderes del Olimpo para escapar.', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/logo.png', 93, '2020-09-17', '2025-01-02', 0),
(39, 14, NULL, 18, '814380', NULL, 'Sekiro: Shadows Die Twice', 'Traza tu propio camino hacia la venganza en esta aventura de FromSoftware.', 'Encarnas al lobo manco en el Japón Sengoku para rescatar a tu joven señor.', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/logo.png', 88, '2019-03-22', '2023-05-19', 0),
(40, NULL, NULL, 3, '367520', NULL, 'Hollow Knight', 'Aventura de acción épica a través de un reino en ruinas.', 'Explora cavernas retorcidas y lucha contra criaturas corrompidas en Hallownest.', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/logo.png', 87, '2017-02-24', '2022-09-02', 0),
(41, 34, NULL, 3, '1057090', NULL, 'Ori and the Will of the Wisps', 'Embárcate en una nueva aventura en un mundo vasto y exótico.', 'Ori debe reunir a una familia y curar una tierra quebrantada en esta esperada secuela.', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/logo.png', 88, '2020-03-11', '2024-01-15', 0),
(42, 18, 18, 18, '883710', NULL, 'Resident Evil 2', 'Una obra maestra que redefine el género regresa reconstruida.', 'Juega como Leon y Claire en Raccoon City infestada de zombis con el RE Engine.', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/logo.png', 89, '2019-01-25', '2022-11-30', 0),
(43, 18, 18, 18, '952060', NULL, 'Resident Evil 3', 'Jill Valentine presencia las atrocidades de Umbrella en Raccoon City.', 'Escapa de Nemesis, el arma secreta definitiva, en esta intensa recreación del clásico.', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/logo.png', 77, '2020-04-03', '2024-05-10', 0),
(44, 66, NULL, 3, '289070', NULL, 'Civilization VI', 'Construye un imperio que resista el paso del tiempo en este juego de estrategia.', 'Civilization VI ofrece nuevas formas de interactuar con tu mundo: las ciudades se expanden físicamente.', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/logo.png', 88, '2016-10-21', '2022-04-18', 0),
(45, NULL, NULL, 16, '1462040', NULL, 'Final Fantasy VII Remake Intergrade', 'La espectacular reinvención del clásico de Square Enix llega con contenido expandido.', 'Cloud Strife ayuda al grupo Avalancha en su lucha contra la corporación Shinra en Midgar.', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/logo.png', 89, '2022-06-17', '2024-11-05', 0),
(46, 77, NULL, 3, '1378990', NULL, 'Crash Bandicoot 4: It\'s About Time', 'Crash y Coco regresan en una aventura que salta a través del tiempo.', 'Neo Cortex y N. Tropy han vuelto para intentar conquistar el multiverso entero.', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/logo.png', 85, '2022-10-18', '2023-01-20', 0),
(47, 77, NULL, 3, '996580', NULL, 'Spyro Reignited Trilogy', 'El maestro de las llamaradas ha vuelto. Disfruta de la trilogía remasterizada.', 'Revive la magia de los tres juegos originales de Spyro completamente recreados.', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/logo.png', 82, '2019-09-03', '2022-06-12', 0),
(48, 68, NULL, 3, '1466860', NULL, 'Age of Empires IV', 'Celebra el regreso de la legendaria saga de estrategia en tiempo real.', 'Age of Empires IV te sitúa en el centro de batallas históricas épicas que moldearon el mundo.', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/logo.png', 81, '2021-10-28', '2025-01-04', 0),
(49, 18, 18, 3, '1364780', NULL, 'Street Fighter 6', 'El nuevo estandarte de la lucha de Capcom llega con estilo urbano.', 'Impulsado por el motor RE ENGINE, ofrece tres modos distintos: Fighting Ground, World Tour y Battle Hub.', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/logo.png', 92, '2023-06-02', '2023-09-21', 0),
(50, NULL, NULL, 3, '1341050', NULL, 'Immortals Fenyx Rising', 'Vive una gran aventura mitológica como Fenyx, un semidiós alado.', 'Erese la última esperanza de los dioses griegos en una misión para salvarlos de Tifón.', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/logo.png', 79, '2020-12-03', '2022-05-14', 0),
(51, 7, NULL, 18, '359550', NULL, 'Tom Clancy\'s Rainbow Six Siege', 'Domina el arte de la destrucción en este shooter táctico de élite.', 'Shooter táctico realista por equipos donde la planificación es la clave de la victoria.', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/logo.png', 79, '2015-12-01', '2024-02-10', 0),
(52, NULL, NULL, 16, '17410', NULL, 'Mirror\'s Edge', 'Corre por los tejados en una ciudad donde la información se vigila.', 'Mirror\'s Edge redefine el género de acción con un enfoque revolucionario en el parkour.', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/logo.png', 81, '2009-01-13', '2023-11-12', 0),
(53, NULL, NULL, 3, '682990', NULL, 'GRIS', 'Una experiencia serena sobre el dolor y la superación personal.', 'Gris es una joven perdida en su propio mundo debido a una experiencia dolorosa.', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/logo.png', 84, '2018-12-13', '2022-08-30', 0),
(54, 74, NULL, 16, '2904260', NULL, 'Alan Wake Remastered', 'Disfruta de la experiencia completa de Alan Wake con gráficos 4K.', 'El escritor Alan Wake busca a su esposa desaparecida mientras su propia historia cobra vida.', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/logo.png', 80, '2021-10-05', '2024-03-20', 0),
(55, 18, 18, 18, '601150', NULL, 'Devil May Cry 5', 'El cazademonios definitivo regresa con el combate más frenético.', 'Con tres personajes jugables, DMC5 ofrece la culminación del género hack and slash.', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/logo.png', 89, '2019-03-08', '2023-01-15', 0),
(56, NULL, NULL, 3, '3300000', NULL, 'F1 25', 'Domina la nueva era de la velocidad en el juego oficial de la F1.', 'F1 25 redefine la simulación con un motor físico renovado y todas las escuderías actuales.', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/logo.png', 84, '2025-05-30', '2025-06-15', 0),
(57, 42, NULL, 3, '1250410', NULL, 'Microsoft Flight Simulator', 'Explora el mundo entero con un detalle asombroso.', 'Vuela aeronaves altamente detalladas en un mundo dinámico generado por datos satelitales.', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/logo.png', 91, '2020-08-18', '2022-12-05', 0),
(58, 50, 50, 16, '1601580', NULL, 'Frostpunk 2', 'Sobrevive al invierno eterno en una sociedad dividida.', 'Treinta años después de la tormenta, debes liderar una metrópolis que ya no solo lucha contra el frío.', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/logo.png', 86, '2024-09-20', '2024-11-15', 0),
(59, 55, 55, 3, '1623730', NULL, 'Palworld', 'Sobrevive, construye y lucha junto a misteriosas criaturas llamadas Pals.', 'Palworld es un juego de supervivencia y recolección de criaturas en un mundo abierto masivo.', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/logo.png', 70, '2024-01-19', '2024-12-28', 0),
(60, 8, NULL, 3, '1774580', NULL, 'Star Wars Jedi: Survivor', 'La historia de Cal Kestis continúa en esta aventura galáctica.', 'Cinco años después de Fallen Order, Cal Kestis debe mantenerse un paso por delante del Imperio.', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/logo.png', 85, '2023-04-28', '2023-10-15', 0),
(61, NULL, NULL, 18, '1501750', NULL, 'Lords of the Fallen', 'Un vasto mundo te espera en este RPG de fantasía oscura.', 'Viaja a través de los reinos de los vivos y los muertos como un Cruzado de la Oscuridad.', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/logo.png', 75, '2023-10-13', '2024-05-22', 0),
(62, 58, 58, 16, '1627720', NULL, 'Lies of P', 'Una versión oscura de Pinocho ambientada en la Belle Époque.', 'Como una marioneta creada por Geppetto, lucha por encontrar a tu creador en la ciudad de Krat.', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/logo.png', 80, '2023-09-18', '2024-02-14', 0),
(63, 78, NULL, 3, '1313140', NULL, 'Cult of the Lamb', 'Crea tu propia secta y conviértete en el Dios Cordero.', 'Gestiona recursos, realiza rituales oscuros y da sermones para reforzar la fe de tu rebaño.', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/logo.png', 82, '2022-08-11', '2024-08-20', 0),
(64, 23, NULL, 18, '2215430', NULL, 'Ghost of Tsushima DIRECTOR\'S CUT', 'Libra una guerra poco convencional por la libertad de Tsushima.', 'Jin Sakai debe dejar de lado las tradiciones samurái para forjar el camino del Fantasma.', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/logo.png', 88, '2024-05-16', '2024-11-02', 0),
(65, 14, NULL, 3, '1888160', NULL, 'Armored Core VI Fires of Rubicon', 'Acción de mechas de alta intensidad por FromSoftware.', 'Pilota tu mecha en batallas vertiginosas por el control de la misteriosa sustancia Coral.', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/logo.png', 86, '2023-08-25', '2024-04-10', 0),
(66, 27, NULL, 3, '1426210', NULL, 'It Takes Two', 'Embárcate en el viaje más loco en esta aventura cooperativa.', 'Cody y May deben trabajar juntos para salvar su relación tras convertirse en muñecos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 88, '2021-03-26', '2023-05-18', 0),
(67, NULL, NULL, 18, '1544020', NULL, 'The Callisto Protocol', 'Sobrevive a los horrores de la Prisión de Hierro Negro.', 'Jacob Lee debe escapar de la luna muerta de Júpiter mientras reclusos mutan en monstruos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/logo.png', 69, '2022-12-02', '2024-01-12', 0),
(68, 42, NULL, 18, '1182900', NULL, 'A Plague Tale: Requiem', 'Un viaje desgarrador hacia un mundo asombroso y despiadado.', 'Amicia y Hugo buscan una cura para la maldición en una isla mística del sur.', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/logo.png', 82, '2022-10-18', '2023-11-15', 0),
(69, 49, NULL, 18, '2124490', NULL, 'Silent Hill 2', 'Clase magistral de terror psicológico recreada fielmente.', 'James Sunderland regresa a Silent Hill tras recibir una carta de su difunta esposa.', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/logo.png', 86, '2024-10-08', '2025-02-14', 0),
(70, 79, NULL, 3, '1849540', NULL, 'Need for Speed Unbound', 'Gana The Grand, el desafío de carreras callejeras definitivo.', 'Personaliza tu garaje con coches tuneados y domina las calles con un estilo visual único.', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/logo.png', 73, '2022-12-02', '2023-08-10', 0),
(71, 51, NULL, 3, '1363080', NULL, 'Manor Lords', 'Estrategia medieval con construcción de ciudades y batallas.', 'Construcción orgánica sin cuadrículas y gestión económica compleja del siglo XIV.', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/logo.png', 82, '2024-04-26', '2025-01-04', 0),
(72, 18, 18, 3, '1446780', NULL, 'Monster Hunter Rise', 'Acepta el desafío y únete a la caza en la Aldea Kamura.', 'Utiliza el Cordóptero y los Canyne para enfrentarte a hordas de monstruos en el Frenesí.', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 87, '2022-01-12', '2023-11-20', 0),
(73, NULL, NULL, 18, '1325200', NULL, 'Nioh 2', 'Desata tu oscuridad y domina el poder de los Yokai.', 'Mercenario mitad humano y Yokai lucha en el Japón de la era Sengoku.', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/logo.png', 86, '2021-02-05', '2022-06-15', 0),
(74, NULL, NULL, 3, '1551360', NULL, 'Forza Horizon 5', 'Texto corto...', 'Texto largo...', 'url...', 'url...', 'url...', 'url...', 92, '2021-11-09', '2023-04-12', 0),
(75, NULL, NULL, 3, '1551360', NULL, 'Forza Horizon 5', 'Tu aventura Horizon definitiva te espera. Explora los paisajes vibrantes de México.', 'Explora los paisajes vibrantes de México con una acción de conducción ilimitada en cientos de los mejores coches del mundo.', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 92, '2021-11-09', '2023-04-12', 0),
(77, NULL, NULL, 3, '1551360', NULL, 'Forza Horizon 5', 'Tu aventura Horizon definitiva te espera. Explora los paisajes vibrantes de México.', 'Explora los paisajes vibrantes y en constante evolución del mundo abierto de México con una acción de conducción ilimitada y divertida en cientos de los mejores coches del mundo. Sumérgete en una campaña profunda con cientos de desafíos que te recompensan por participar en las actividades que te gustan.', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 92, '2021-11-09', '2023-04-12', 0),
(78, NULL, NULL, 16, '739630', NULL, 'Phasmophobia', 'Un horror psicológico cooperativo para 4 jugadores donde la investigación es clave.', 'Phasmophobia es un horror psicológico cooperativo en línea para 4 jugadores. La actividad paranormal está en aumento y depende de ti y de tu equipo utilizar todo el equipo de caza de fantasmas a su disposición.', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/logo.png', 80, '2020-09-18', '2024-02-28', 0),
(79, NULL, NULL, 12, '1145350', NULL, 'Hades II', 'La primera secuela de Supergiant Games profundiza en la brujería y el Inframundo.', 'Lucha más allá del Inframundo utilizando brujería oscura para enfrentarte al Titán del Tiempo en esta secuela del aclamado roguelike de exploración de mazmorras.', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/logo.png', 90, '2024-05-06', '2024-12-20', 0),
(80, NULL, NULL, 12, '881020', NULL, 'Granblue Fantasy: Relink', 'Forma un grupo de cuatro y ábrete camino hacia la victoria en este RPG de acción.', '¡Surca los cielos en Granblue Fantasy: Relink! Forma un grupo de cuatro a partir de un elenco variado de navegantes y corta, dispara o hechiza para derrotar a enemigos traicioneros.', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/logo.png', 80, '2024-02-01', '2024-06-15', 0),
(81, NULL, NULL, 16, '1687950', NULL, 'Persona 5 Royal', 'Ponte la máscara y únete a los Ladrones de Guante Blanco en el RPG definitivo.', 'Persona 5 Royal presenta una historia profunda y elegante donde exploras Tokio, desbloqueas Personas y personalizas tu propia Guarida de los Ladrones.', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/logo.png', 95, '2022-10-21', '2024-05-30', 0),
(82, NULL, NULL, 16, '2358720', NULL, 'Black Myth: Wukong', 'Un RPG de acción basado en la mitología china y la novela Viaje al Oeste.', 'Black Myth: Wukong es un RPG de acción inspirado en la mitología china. La historia se basa en \"Viaje al Oeste\", una de las cuatro grandes novelas clásicas de la literatura china.', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/logo.png', 81, '2024-08-20', '2024-11-05', 0),
(83, NULL, NULL, 18, '782330', NULL, 'DOOM Eternal', 'Los ejércitos del infierno han invadido la Tierra. Eres el único que puede detenerlos.', 'Experimenta la combinación definitiva de velocidad y potencia en DOOM Eternal, la próxima evolución del combate en primera persona.', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/logo.png', 88, '2020-03-20', '2023-02-14', 0),
(84, NULL, NULL, 7, '753640', NULL, 'Outer Wilds', 'Un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal.', 'Outer Wilds es un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal infinito. Eres el nuevo recluta de Outer Wilds Ventures.', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/logo.png', 85, '2019-05-30', '2024-06-21', 0),
(85, NULL, NULL, 18, '2054970', NULL, 'Dragon\'s Dogma 2', 'Embárcate en tu gran aventura, Arisen, en este RPG de acción narrativo.', 'Dragon\'s Dogma 2 es un RPG de acción narrativo que desafía a los jugadores a elegir su propia experiencia.', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/logo.png', 86, '2024-03-22', '2024-08-14', 0),
(86, NULL, NULL, 18, '524220', NULL, 'NieR:Automata', 'La humanidad ha sido expulsada de la Tierra por formas de vida mecánicas.', 'NieR:Automata narra la historia de los androides 2B, 9S y A2 y su batalla para recuperar una distopía dirigida por máquinas.', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/logo.png', 88, '2017-03-17', '2022-12-20', 0),
(87, NULL, NULL, 18, '553850', NULL, 'Helldivers 2', 'La última línea de defensa de la galaxia. Únete a los Helldivers y lucha por la libertad.', 'Helldivers 2 es un shooter por equipos en tercera persona en el que las fuerzas de élite luchan para librar a la galaxia de amenazas alienígenas.', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/logo.png', 82, '2024-02-08', '2025-01-02', 0),
(88, NULL, NULL, 18, '632470', NULL, 'Disco Elysium', 'Un RPG de mundo abierto revolucionario donde tú decides qué tipo de detective ser.', 'Disco Elysium es un innovador juego de rol. Eres un detective con un sistema de habilidades único a tu disposición.', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/logo.png', 97, '2019-10-15', '2024-03-22', 0),
(89, NULL, NULL, 18, '2183900', NULL, 'Warhammer 40,000: Space Marine 2', 'Encarna la brutalidad sobrehumana de un Marine Espacial contra los Tiránidos.', 'La galaxia está en peligro. Mundos enteros están cayendo. Encarna la habilidad y brutalidad sobrehumana de un Marine Espacial.', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/logo.png', 82, '2024-09-09', '2024-11-20', 0),
(90, NULL, NULL, 18, '8870', NULL, 'BioShock Infinite', 'Lleva a la chica y saldarás tu deuda. Una aventura en la ciudad aérea de Columbia.', 'Booker DeWitt solo tiene una oportunidad para limpiar su nombre: debe rescatar a Elizabeth en la ciudad flotante de Columbia.', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/logo.png', 94, '2013-03-25', '2023-01-10', 0),
(91, NULL, NULL, 12, '1817230', NULL, 'Hi-Fi RUSH', 'Siente el ritmo mientras el aspirante a estrella de rock Chai lucha contra una megacorporación.', 'Siente el ritmo mientras Chai y su equipo se rebelan contra una malvada megacorporación en un mundo sincronizado con la música.', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/logo.png', 89, '2023-01-25', '2023-09-12', 0);
INSERT INTO `juegos` (`id_juego`, `id_desarrollador`, `id_distribuidor`, `id_pegi`, `id_steam`, `id_igdb`, `titulo_juego`, `descripcion_corta`, `descripcion_larga`, `portada_v`, `portada_h`, `hero_juego`, `logo_juego`, `metacritic_juego`, `fecha_lanzamiento_juego`, `fecha_publicacion_juego`, `destacado_juego`) VALUES
(92, NULL, NULL, 7, '268910', NULL, 'Cuphead', 'Un juego de acción clásico de \"dispara y corre\" centrado en batallas contra jefes.', 'Cuphead es un juego de acción clásico inspirado en las caricaturas de la década de 1930.', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/logo.png', 88, '2017-09-29', '2023-04-12', 0),
(93, NULL, NULL, 3, '2379780', NULL, 'Balatro', 'Un roguelike de póker hipnótico donde puedes crear combos ilegales.', 'Balatro es un constructor de mazos roguelike con temática de póker que trata de crear combos poderosos.', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/logo.png', 90, '2024-02-20', '2024-05-10', 0),
(94, NULL, NULL, 18, '814380', NULL, 'Sekiro: Shadows Die Twice', 'Traza tu propio camino hacia la venganza en esta aventura de FromSoftware.', 'En Sekiro encarnas al \"lobo manco\", un guerrero desfigurado rescatado de las garras de la muerte.', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/logo.png', 88, '2019-03-22', '2023-10-20', 0),
(95, NULL, NULL, 12, '1364780', NULL, 'Street Fighter 6', 'La evolución del género de lucha.', 'Street Fighter 6 ofrece una experiencia de lucha con un sistema de combate evolucionado y visuales impactantes.', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/logo.png', 92, '2023-06-02', '2024-01-15', 0),
(96, NULL, NULL, 7, '367520', NULL, 'Hollow Knight', 'Aventura de acción épica a través de un reino de insectos.', 'Explora cavernas tortuosas y lucha contra criaturas corrompidas en el vasto reino de Hallownest.', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/logo.png', 87, '2017-02-24', '2023-11-20', 1),
(97, NULL, NULL, 16, '546560', NULL, 'Half-Life: Alyx', 'El regreso de Valve a la serie Half-Life en una experiencia de realidad virtual pura.', 'Half-Life: Alyx es el regreso en realidad virtual de Valve a la serie Half-Life. Situada entre los eventos de Half-Life y Half-Life 2.', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/logo.png', 93, '2020-03-23', '2022-11-15', 0),
(98, NULL, NULL, 3, '2669320', NULL, 'EA SPORTS FC 25', 'Siente la emoción del fútbol con el nuevo modo Rush 5 contra 5 y FC IQ.', 'EA SPORTS FC 25 te ofrece más formas de ganar por el club. Forma equipo en Rush de 5 contra 5 con FC IQ renovado.', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/logo.png', 76, '2024-09-27', '2025-01-10', 0),
(99, NULL, NULL, 3, '2582560', NULL, 'Madden NFL 25', 'Golpea como si fuera en serio con FieldSENSE y la nueva tecnología BOOM Tech.', 'Experimenta un sistema de placajes dinámico y con base física que permite realizar animaciones realistas.', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/logo.png', 70, '2024-08-16', '2024-11-20', 0),
(100, NULL, NULL, 3, '2878980', NULL, 'NBA 2K25', 'Domina cada cancha con autenticidad y realismo gracias a ProPLAY.', 'Compite a tu manera mientras forjas tu legado en Mi CARRERA y Mi EQUIPO con tecnología ProPLAY.', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/logo.png', 78, '2024-09-06', '2024-12-05', 0),
(101, NULL, NULL, 18, '381210', NULL, 'Dead by Daylight', 'Un juego de terror multijugador de 4 contra 1 donde uno es el asesino.', 'Un jugador asume el rol de asesino despiadado y los otros cuatro juegan como supervivientes que intentan escapar.', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/logo.png', 71, '2016-06-14', '2023-10-31', 0),
(102, NULL, NULL, 16, '2516900', NULL, 'The Precinct', 'Una carta de amor a las películas policiales de los 80. Eres la ley en Averno City.', 'Averno City, 1983. Eres Nick Cordell Jr. policía novato en un mundo de persecuciones trepidantes.', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/logo.png', 80, '2024-10-01', '2025-02-15', 0),
(103, NULL, NULL, 7, '281990', NULL, 'Stellaris', 'Explora una galaxia llena de maravillas en este juego de gran estrategia de ciencia ficción.', 'Prepárate para explorar, descubrir e interactuar con una multitud de especies mientras viajas por las estrellas.', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/logo.png', 78, '2016-05-09', '2023-06-15', 0),
(104, NULL, NULL, 18, '242700', NULL, 'Watch Dogs', 'En Chicago, tú eres el hacker definitivo. El sistema es tu arma.', 'Encarna a Aiden Pearce, un brillante hacker. Accede a cámaras de seguridad y controla la ciudad.', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/logo.png', 77, '2014-05-27', '2022-10-05', 0),
(105, NULL, NULL, 18, '1139900', NULL, 'Ghostrunner', 'Un juego de acción \"slasher\" en primera persona con estética cyberpunk.', 'Combates vertiginosos y violentos en una ambientación que combina ciencia ficción con postapocalipsis.', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/logo.png', 81, '2020-10-27', '2023-09-14', 0),
(106, NULL, NULL, 12, '1790600', NULL, 'Dragon Ball: Sparking! ZERO', '¡El regreso de la legendaria saga Budokai Tenkaichi!', 'Siente el poder destructivo de los guerreros más fuertes en escenarios que se desmoronan.', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/logo.png', 82, '2024-10-11', '2024-11-01', 0),
(107, NULL, NULL, 3, '227300', NULL, 'Euro Truck Simulator 2', 'Viaja por Europa como el rey de la carretera.', 'Explora docenas de ciudades entregando cargas importantes por toda Europa.', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/logo.png', 79, '2012-10-18', '2022-09-20', 0),
(108, NULL, NULL, 3, '220200', NULL, 'Kerbal Space Program', 'Dirige el programa espacial de una raza alienígena y domina la astrofísica.', 'Monta naves espaciales plenamente funcionales que vuelan basándose en leyes físicas reales.', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/logo.png', 88, '2015-04-27', '2026-01-01', 0),
(109, NULL, NULL, 3, '375820', NULL, 'Human Resource Machine', 'Programa a pequeños oficinistas para resolver puzles.', 'Automatiza tareas programando a tu oficinista. Programar no es más que resolver puzles.', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/logo.png', 78, '2015-10-15', '2026-01-01', 0),
(110, NULL, NULL, 3, '621060', NULL, 'PC Building Simulator', 'Aprende a montar y reparar ordenadores reales.', 'Crea tu propio imperio de reparación de ordenadores. Aprende a diagnosticar, reparar y montar PCs con componentes reales.', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/logo.png', 72, '2019-01-29', '2026-01-01', 0),
(111, NULL, NULL, 3, '619150', NULL, 'while True: learn()', 'Un simulador de aprendizaje automático y redes neuronales.', 'Eres un especialista en aprendizaje automático que crea redes neuronales. Resuelve puzles para traducir el lenguaje de los gatos.', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/logo.png', 74, '2019-01-17', '2026-01-01', 0),
(112, NULL, NULL, 12, '1613530', NULL, 'Discovery Tour: Viking Age', 'Explora la historia vikinga sin combates en un museo viviente.', 'Discovery Tour te permite viajar por el mundo de Assassin\'s Creed Valhalla para aprender sobre su historia y cultura.', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/logo.png', 80, '2021-10-19', '2026-01-01', 0),
(113, NULL, NULL, 3, '1850240', NULL, 'Poly Bridge 3', 'Aprende ingeniería construyendo puentes creativos.', 'Diseña y construye puentes para que los vehículos lleguen a su destino. Una simulación de física y estructuras.', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/logo.png', 82, '2023-05-30', '2026-01-01', 0),
(114, NULL, NULL, 3, '218680', NULL, 'Scribblenauts Unlimited', 'Fomenta la creatividad invocando cualquier objeto imaginable.', 'Ayuda a Maxwell a resolver puzles en un mundo abierto donde puedes crear cualquier objeto escribiendo su nombre.', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/logo.png', 75, '2012-11-20', '2026-01-01', 0),
(115, NULL, NULL, 3, '0000003', NULL, 'Super Mario Odyssey', 'Acompaña a Mario en una aventura en 3D por todo el mundo.', 'Explora enormes reinos en 3D llenos de secretos. Mario tiene nuevos movimientos gracias a Cappy.', 'https://assets.nintendo.com/image/upload/f_auto/q_auto/ncom/software/switch/70010000001130/boxart', 'https://header_mario.jpg', 'https://hero_mario.jpg', 'https://logo_mario.png', 97, '2017-10-27', '2026-01-01', 0),
(116, NULL, NULL, 3, '1097150', NULL, 'Fall Guys', '¡Tropieza hacia la victoria en este battle royale de plataformas!', 'Compite a través de rondas de obstáculos cada vez más locas hasta que solo queda un vencedor.', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/logo.png', 80, '2020-08-04', '2026-01-01', 0),
(117, NULL, NULL, 7, '1443370', NULL, 'LEGO Star Wars: The Skywalker Saga', 'Vive las nueve películas de la saga con el humor de LEGO.', 'Juega a través de toda la saga Star Wars con cientos de personajes y vehículos.', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/logo.png', 82, '2022-04-05', '2026-01-01', 0),
(118, NULL, NULL, 7, '0000007', NULL, 'Minecraft', 'Construye y explora tu propio mundo infinito de bloques.', 'Explora mundos infinitos, sobrevive a la noche o crea obras de arte en el modo creativo.', 'https://minecraft.net/images/share/social-share-default.jpg', 'https://header_mc.jpg', 'https://hero_mc.jpg', 'https://logo_mc.png', 93, '2011-11-18', '2026-01-01', 0),
(119, NULL, NULL, 3, '413150', NULL, 'Stardew Valley', 'Hereda la granja de tu abuelo y comienza una nueva vida rural.', 'Cultiva la tierra, cría animales y entabla amistad con los habitantes del pueblo.', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/logo.png', 89, '2016-02-26', '2026-01-01', 0),
(120, NULL, NULL, 12, '787480', NULL, 'Phoenix Wright: Ace Attorney Trilogy', '¡Protesta! Defiende a tus clientes en juicios llenos de giros.', 'Investiga escenas del crimen y presenta pruebas en el tribunal para salvar a tus clientes.', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/logo.png', 81, '2019-04-09', '2026-01-01', 0),
(121, NULL, NULL, 16, '447530', NULL, 'VA-11 Hall-A', 'Sirve bebidas y escucha historias en un futuro cyberpunk distópico.', 'Eres una camarera en un bar de mala muerte. El juego trata sobre preparar cócteles y cómo estos influyen en la vida de tus clientes en una ciudad decadente.', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/logo.png', 83, '2016-06-21', '2026-01-01', 0),
(122, NULL, NULL, 12, '914800', NULL, 'Coffee Talk', 'Prepara café y charla con habitantes de una Seattle fantástica.', 'Un juego sobre escuchar los problemas de la gente y ayudarles sirviéndoles una bebida caliente. Una experiencia narrativa relajante.', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/logo.png', 75, '2020-01-29', '2026-01-01', 0),
(123, NULL, NULL, 18, '1388880', NULL, 'Doki Doki Literature Club Plus!', 'Únete al club de literatura en este thriller psicológico.', 'Lo que parece un inocente club escolar pronto se revela como una experiencia de terror psicológico que rompe la cuarta pared.', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/logo.png', 82, '2021-06-30', '2026-01-01', 0),
(124, NULL, NULL, 12, '0000008', NULL, '13 Sentinels: Aegis Rim', 'Entrelaza trece historias de adolescentes y mechas en una trama épica.', 'Una obra maestra que combina novela visual y estrategia. Descubre un misterio de ciencia ficción que abarca varias épocas.', 'https://m.media-amazon.com/images/I/81P2p+rP9PL._AC_SL1500_.jpg', 'https://header_13s.jpg', 'https://hero_13s.jpg', 'https://logo_13s.png', 85, '2019-11-28', '2026-01-01', 0),
(125, NULL, NULL, 16, '477740', NULL, 'Zero Escape: The Nonary Games', 'Resuelve puzles mortales para escapar de un secuestro.', 'Nueve personas son obligadas a participar en un juego mortal. Mezcla de novela visual y habitaciones de escape.', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/logo.png', 86, '2017-03-24', '2026-01-01', 0),
(126, NULL, NULL, 18, '1649240', NULL, 'Hitman World of Assassination', 'Conviértete en el Agente 47, el asesino definitivo.', 'Viaja por todo el mundo y elimina a tus objetivos de las formas más creativas y sigilosas imaginables.', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/logo.png', 87, '2022-01-20', '2026-01-01', 0),
(127, NULL, NULL, 18, '403640', NULL, 'Dishonored 2', 'Recupera lo que es tuyo con sigilo y poderes sobrenaturales.', 'Juega como Emily o Corvo y usa habilidades únicas para infiltrarte. Un diseño de niveles soberbio.', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/logo.png', 88, '2016-11-11', '2026-01-01', 0),
(128, NULL, NULL, 18, '287700', NULL, 'Metal Gear Solid V: The Phantom Pain', 'Sigilo táctico de nueva generación en un mundo abierto.', 'Snake regresa para una misión épica. Usa gadgets, entorno y estrategia para completar objetivos.', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/logo.png', 91, '2015-09-01', '2026-01-01', 0),
(129, NULL, NULL, 18, '235600', NULL, 'Splinter Cell Blacklist', 'Sam Fisher regresa para detener una amenaza global.', 'Detén ataques terroristas usando tecnología de vanguardia y el sigilo más letal.', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/logo.png', 82, '2013-08-20', '2026-01-01', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juegos_categorias`
--

CREATE TABLE `juegos_categorias` (
  `id_juego` int NOT NULL,
  `id_categoria` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `juegos_categorias`
--

INSERT INTO `juegos_categorias` (`id_juego`, `id_categoria`) VALUES
(2, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(9, 1),
(10, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(7, 2),
(9, 2),
(10, 2),
(11, 2),
(16, 2),
(2, 3),
(4, 3),
(8, 3),
(15, 3),
(17, 3),
(3, 4),
(11, 4),
(14, 5),
(1, 6),
(13, 6),
(3, 7),
(1, 8),
(1, 9),
(4, 10),
(5, 10),
(6, 10),
(7, 10),
(9, 10),
(10, 10),
(12, 10),
(18, 10),
(103, 10),
(104, 10),
(105, 10),
(106, 10),
(107, 10),
(108, 10),
(109, 10),
(110, 10),
(111, 10),
(112, 10),
(113, 10),
(114, 10),
(115, 10),
(116, 10),
(117, 10),
(118, 10),
(119, 10),
(120, 10),
(121, 10),
(122, 10),
(123, 10),
(124, 10),
(125, 10),
(126, 10),
(127, 10),
(128, 10),
(129, 10),
(5, 11),
(101, 11),
(102, 11),
(12, 15),
(8, 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partidas`
--

CREATE TABLE `partidas` (
  `id_partida` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `id_juego` int DEFAULT NULL,
  `fecha_partida` datetime DEFAULT NULL,
  `tiempo_partida` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `partidas`
--

INSERT INTO `partidas` (`id_partida`, `id_usuario`, `id_juego`, `fecha_partida`, `tiempo_partida`) VALUES
(1, 0, 1, '2026-01-10 10:00:00', '05:30:00'),
(2, 0, 2, '2026-01-12 15:30:00', '12:45:00'),
(3, 0, 3, '2026-01-15 20:00:00', '45:20:00'),
(4, 0, 4, '2026-01-18 12:45:00', '80:10:00'),
(5, 0, 5, '2026-01-20 18:00:00', '15:00:00'),
(6, 0, 6, '2026-01-22 09:00:00', '02:30:00'),
(7, 0, 7, '2026-01-25 21:15:00', '34:50:00'),
(8, 0, 8, '2026-01-28 14:20:00', '08:15:00'),
(9, 0, 9, '2026-02-01 19:30:00', '56:00:00'),
(10, 0, 10, '2026-02-03 11:00:00', '120:00:00'),
(11, 0, 11, '2026-02-05 22:00:00', '95:40:00'),
(12, 0, 12, '2026-02-07 08:00:00', '22:15:00'),
(13, 0, 13, '2026-02-10 17:45:00', '18:20:00'),
(14, 0, 14, '2026-02-12 13:00:00', '04:10:00'),
(15, 0, 15, '2026-02-14 20:30:00', '42:00:00'),
(16, 0, 16, '2026-02-16 10:15:00', '31:25:00'),
(17, 0, 17, '2026-02-18 15:00:00', '27:50:00'),
(18, 0, 18, '2026-02-20 23:00:00', '50:00:00'),
(19, 1, 101, '2026-03-01 10:00:00', '15:20:00'),
(20, 1, 102, '2026-03-02 12:00:00', '08:45:00'),
(21, 1, 103, '2026-03-03 14:00:00', '12:10:00'),
(22, 1, 104, '2026-03-04 16:00:00', '25:30:00'),
(23, 1, 105, '2026-03-05 18:00:00', '04:15:00'),
(24, 1, 106, '2026-03-06 20:00:00', '19:00:00'),
(25, 1, 107, '2026-03-07 22:00:00', '07:50:00'),
(26, 1, 108, '2026-03-08 09:00:00', '33:20:00'),
(27, 1, 109, '2026-03-09 11:00:00', '11:40:00'),
(28, 1, 110, '2026-03-10 13:00:00', '02:00:00'),
(29, 1, 111, '2026-03-11 15:00:00', '05:30:00'),
(30, 1, 112, '2026-03-12 17:00:00', '14:20:00'),
(31, 1, 113, '2026-03-13 19:00:00', '21:10:00'),
(32, 1, 114, '2026-03-14 21:00:00', '09:00:00'),
(33, 1, 115, '2026-03-15 23:00:00', '18:45:00'),
(34, 1, 116, '2026-03-20 10:00:00', '30:00:00'),
(35, 1, 117, '2026-03-21 12:00:00', '12:15:00'),
(36, 1, 118, '2026-03-22 14:00:00', '07:40:00'),
(37, 1, 119, '2026-03-23 16:00:00', '15:20:00'),
(38, 1, 120, '2026-03-24 18:00:00', '40:00:00'),
(39, 1, 121, '2026-03-25 20:00:00', '22:30:00'),
(40, 1, 122, '2026-03-26 22:00:00', '05:10:00'),
(41, 1, 123, '2026-03-27 09:00:00', '11:00:00'),
(42, 1, 124, '2026-03-28 11:00:00', '03:45:00'),
(43, 1, 125, '2026-03-29 13:00:00', '08:20:00'),
(44, 1, 126, '2026-03-30 15:00:00', '14:50:00'),
(45, 1, 127, '2026-03-31 17:00:00', '26:15:00'),
(46, 1, 128, '2026-04-01 19:00:00', '02:30:00'),
(47, 1, 129, '2026-04-02 21:00:00', '10:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pegi`
--

CREATE TABLE `pegi` (
  `id_pegi` int NOT NULL,
  `nombre_pegi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `imagen_pegi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `pegi`
--

INSERT INTO `pegi` (`id_pegi`, `nombre_pegi`, `imagen_pegi`) VALUES
(3, 'PEGI 3', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/3.png'),
(7, 'PEGI 7', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/7.png'),
(12, 'PEGI 12', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/12.png'),
(16, 'PEGI 16', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/16.png'),
(18, 'PEGI 18', 'https://rating.pegi.info/assets/images/games/age_threshold_icons/18.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int NOT NULL,
  `nombre_rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(0, 'Administrador'),
(1, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suscripciones`
--

CREATE TABLE `suscripciones` (
  `id_suscripcion` int NOT NULL,
  `nombre_suscripcion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descripcion_suscripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `precio_suscripcion` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `suscripciones`
--

INSERT INTO `suscripciones` (`id_suscripcion`, `nombre_suscripcion`, `descripcion_suscripcion`, `precio_suscripcion`) VALUES
(0, 'Gratis', 'Acceso limitado a juegos antiguos', 0.00),
(1, 'Plata', 'Acceso a 200 juegos y descuentos exclusivos', 9.99),
(2, 'Oro', 'Acceso total a todo el catálogo y betas', 14.99),
(3, 'Bronce', 'Acceso a 50 juegos y guardado en la nube', 4.99),
(4, 'Prueba', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL,
  `id_suscripcion` int DEFAULT '1',
  `id_rol` int DEFAULT '4',
  `alias_usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nombre_usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `apellidos_usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email_usuario` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_suscripcion` date DEFAULT NULL,
  `fecha_creacion_usuario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_avatar` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `id_suscripcion`, `id_rol`, `alias_usuario`, `password_usuario`, `token`, `nombre_usuario`, `apellidos_usuario`, `email_usuario`, `fecha_suscripcion`, `fecha_creacion_usuario`, `id_avatar`) VALUES
(0, 2, 0, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzU1NzA2MzQsImRhdGEiOnsiaWQiOiIwIiwibm9tYnJlIjoiYWRtaW4ifX0.mQ9FrHAwRNqczO3j2Dj9kZCfaMAj7dQb2ey9Pq4vXaw', 'Administrador', 'García', 'admin@ejemplo.com', '2024-01-15', '2026-04-03 19:34:55', 4),
(1, 0, 1, 'usuario', '9250e222c4c71f0c58d4c54b50a880a312e9f9fed55d5c3aa0b0e860ded99165', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzU1NjIxMzQsImRhdGEiOnsiaWQiOiIxNiIsIm5vbWJyZSI6InVzdWFyaW8ifX0.VcPJII1aXuoLz23UNuMSy5zIbcEhUDAIClGBdKeEsVc', 'usuario nombre', 'usuario apellido', 'usuario@test.com', NULL, '2026-04-07 11:35:29', 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `avatares`
--
ALTER TABLE `avatares`
  ADD PRIMARY KEY (`id_avatar`);

--
-- Indices de la tabla `capturas`
--
ALTER TABLE `capturas`
  ADD PRIMARY KEY (`id_captura`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `estudios`
--
ALTER TABLE `estudios`
  ADD PRIMARY KEY (`id_estudio`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id_usuario`,`id_juego`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD PRIMARY KEY (`id_juego`),
  ADD KEY `id_desarrollador` (`id_desarrollador`),
  ADD KEY `id_distribuidor` (`id_distribuidor`),
  ADD KEY `id_pegi` (`id_pegi`);

--
-- Indices de la tabla `juegos_categorias`
--
ALTER TABLE `juegos_categorias`
  ADD PRIMARY KEY (`id_juego`,`id_categoria`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `partidas`
--
ALTER TABLE `partidas`
  ADD PRIMARY KEY (`id_partida`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `pegi`
--
ALTER TABLE `pegi`
  ADD PRIMARY KEY (`id_pegi`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  ADD PRIMARY KEY (`id_suscripcion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`alias_usuario`),
  ADD UNIQUE KEY `email` (`email_usuario`),
  ADD KEY `id_suscripcion` (`id_suscripcion`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `fk_usuario_avatar` (`id_avatar`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `avatares`
--
ALTER TABLE `avatares`
  MODIFY `id_avatar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `capturas`
--
ALTER TABLE `capturas`
  MODIFY `id_captura` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `estudios`
--
ALTER TABLE `estudios`
  MODIFY `id_estudio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT de la tabla `juegos`
--
ALTER TABLE `juegos`
  MODIFY `id_juego` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT de la tabla `partidas`
--
ALTER TABLE `partidas`
  MODIFY `id_partida` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  MODIFY `id_suscripcion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `capturas`
--
ALTER TABLE `capturas`
  ADD CONSTRAINT `capturas_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`);

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`);

--
-- Filtros para la tabla `juegos`
--
ALTER TABLE `juegos`
  ADD CONSTRAINT `fk_juegos_pegi` FOREIGN KEY (`id_pegi`) REFERENCES `pegi` (`id_pegi`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `juegos_ibfk_1` FOREIGN KEY (`id_desarrollador`) REFERENCES `estudios` (`id_estudio`),
  ADD CONSTRAINT `juegos_ibfk_2` FOREIGN KEY (`id_distribuidor`) REFERENCES `estudios` (`id_estudio`);

--
-- Filtros para la tabla `juegos_categorias`
--
ALTER TABLE `juegos_categorias`
  ADD CONSTRAINT `juegos_categorias_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`),
  ADD CONSTRAINT `juegos_categorias_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);

--
-- Filtros para la tabla `partidas`
--
ALTER TABLE `partidas`
  ADD CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `partidas_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuario_avatar` FOREIGN KEY (`id_avatar`) REFERENCES `avatares` (`id_avatar`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_suscripcion`) REFERENCES `suscripciones` (`id_suscripcion`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
