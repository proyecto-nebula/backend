-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 03-04-2026 a las 21:26:16
-- Versión del servidor: 9.6.0
-- Versión de PHP: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Proyecto_Final`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `AVATARES`
--

CREATE TABLE `AVATARES` (
  `id_avatar` int NOT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `AVATARES`
--

INSERT INTO `AVATARES` (`id_avatar`, `imagen`) VALUES
(1, 'https://api.multiavatar.com/estrella.png'),
(2, 'https://api.multiavatar.com/gamerpro.png'),
(3, 'https://api.multiavatar.com/n00b.png'),
(4, 'https://api.multiavatar.com/admin.png'),
(5, 'https://api.multiavatar.com/anonimo.png'),
(6, 'https://api.multiavatar.com/soporte.png'),
(7, 'https://api.multiavatar.com/tester1.png'),
(8, 'https://api.multiavatar.com/speedrunner.png'),
(9, 'https://api.multiavatar.com/coleccionista.png'),
(10, 'https://api.multiavatar.com/critico.png'),
(11, 'https://api.multiavatar.com/achievements.png'),
(12, 'https://api.multiavatar.com/indie.png'),
(13, 'https://api.multiavatar.com/wolf.png'),
(14, 'https://api.multiavatar.com/world.png'),
(15, 'https://api.multiavatar.com/strategy.png'),
(16, 'https://api.multiavatar.com/pilot.png'),
(17, 'https://api.multiavatar.com/mercenary.png'),
(18, 'https://api.multiavatar.com/wizard.png'),
(19, 'https://api.multiavatar.com/build.png'),
(20, 'https://api.multiavatar.com/legend.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CAPTURAS`
--

CREATE TABLE `CAPTURAS` (
  `id_captura` int NOT NULL,
  `id_juego` int DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CATEGORIAS`
--

CREATE TABLE `CATEGORIAS` (
  `id_categoria` int NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `CATEGORIAS`
--

INSERT INTO `CATEGORIAS` (`id_categoria`, `nombre`) VALUES
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
-- Estructura de tabla para la tabla `ESTUDIOS`
--

CREATE TABLE `ESTUDIOS` (
  `id_estudio` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `logo` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ESTUDIOS`
--

INSERT INTO `ESTUDIOS` (`id_estudio`, `nombre`, `logo`) VALUES
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
-- Estructura de tabla para la tabla `FAVORITOS`
--

CREATE TABLE `FAVORITOS` (
  `id_usuario` int NOT NULL,
  `id_juego` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JUEGOS`
--

CREATE TABLE `JUEGOS` (
  `id_juego` int NOT NULL,
  `id_desarrollador` int DEFAULT NULL,
  `id_distribuidor` int DEFAULT NULL,
  `id_pegi` int DEFAULT NULL,
  `id_steam` varchar(50) DEFAULT NULL,
  `id_igdb` varchar(50) DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion_corta` text,
  `descripcion_larga` text,
  `portada_v` varchar(255) DEFAULT NULL,
  `portada_h` varchar(255) DEFAULT NULL,
  `hero` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `metacritic` int DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `destacado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JUEGOS_CATEGORIAS`
--

CREATE TABLE `JUEGOS_CATEGORIAS` (
  `id_juego` int NOT NULL,
  `id_categoria` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PARTIDAS`
--

CREATE TABLE `PARTIDAS` (
  `id_partida` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `id_juego` int DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `tiempo` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PEGI`
--

CREATE TABLE `PEGI` (
  `id_pegi` int NOT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `PEGI`
--

INSERT INTO `PEGI` (`id_pegi`, `imagen`) VALUES
(1, 'pegi3.png'),
(2, 'pegi7.png'),
(3, 'pegi12.png'),
(4, 'pegi16.png'),
(5, 'pegi18.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ROLES`
--

CREATE TABLE `ROLES` (
  `id_rol` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ROLES`
--

INSERT INTO `ROLES` (`id_rol`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Moderador'),
(3, 'Usuario Premium'),
(4, 'Usuario Estándar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SUSCRIPCION`
--

CREATE TABLE `SUSCRIPCION` (
  `id_suscripcion` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `SUSCRIPCION`
--

INSERT INTO `SUSCRIPCION` (`id_suscripcion`, `nombre`, `descripcion`, `precio`) VALUES
(1, 'Gratis', 'Acceso limitado a juegos antiguos', 0.00),
(2, 'Bronce', 'Acceso a 50 juegos y guardado en la nube', 4.99),
(3, 'Plata', 'Acceso a 200 juegos y descuentos exclusivos', 9.99),
(4, 'Oro', 'Acceso total a todo el catálogo y betas', 14.99),
(8, 'Prueba', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `id_usuario` int NOT NULL,
  `id_suscripcion` int DEFAULT '1',
  `id_rol` int DEFAULT '4',
  `alias` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `fecha_suscripcion` date DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_avatar` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `USUARIOS`
--

INSERT INTO `USUARIOS` (`id_usuario`, `id_suscripcion`, `id_rol`, `alias`, `password`, `token`, `nombre`, `apellidos`, `email`, `fecha_suscripcion`, `fecha_creacion`, `id_avatar`) VALUES
(1, 4, 1, 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzUyNDEwMjYsImRhdGEiOnsiaWQiOiIxIiwibm9tYnJlIjoiQWRtaW5pc3RyYWRvciJ9fQ.FpG3ZmOs6-JBld9SMJPxw8q2DcIh3G3RNVKuka4fCgU', 'Administrador', 'García', 'admin@ejemplo.com', '2024-01-15', '2026-04-03 19:34:55', 20),
(2, 1, 4, 'jdoe', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzUyNDY2NjksImRhdGEiOnsiaWQiOiIyIiwibm9tYnJlIjoiamRvZSJ9fQ.bz6efugRAQO7ZyNRfbj_3VyaoxxI6tNigs_0lRmUhlw', 'John', 'Doe', 'john@mail.com', '2024-02-10', '2026-04-03 19:34:55', 9),
(3, 3, 3, 'akira_san', 'f29185ab577d8702dc4e6faa00f364abf359dca0020f3c9f88a243b29b0305c8', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzQ5NjAzODAsImRhdGEiOnsiaWQiOiIzIiwibm9tYnJlIjoiQWtpcmEifX0.PsKyLxMf5PVoBlBRA1ymIOjEezxbP8s5OignVkA_LQU', 'Akira', 'Tanaka', 'akira@mail.jp', '2024-03-01', '2026-04-03 19:34:55', 4),
(4, 2, 4, 'marie_fr', 'c3255ad8dad4cd57a29f3a61293003d5aca4447c0e7846173fb0fb6b186b62ee', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzQ5NjA0MjIsImRhdGEiOnsiaWQiOiI0Iiwibm9tYnJlIjoiTWFyaWUifX0.7Kfolgbx91ScyjEqRFs89A3HFAgFCw0lVn2yVDrOquY', 'Marie', 'Dubois', 'marie@mail.fr', '2024-02-20', '2026-04-03 19:34:55', 2),
(5, 4, 1, 'superadmin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzQ5NTg3ODAsImRhdGEiOnsiaWQiOiI1Iiwibm9tYnJlIjoiU3VwZXIifX0.oCWSw6zT5d640mZYvrkf3VY0C4etEj9aVpF5hw3zvwo', 'Super', 'Admin', 'super@proyecto.com', '2026-03-31', '2026-04-03 19:34:55', 18),
(11, 1, 4, 'NuevoUsuario', '607e2cb7dda0621e99f121fdad9b0207a62387c20937a290cc4c95b25cfee9b7', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NzUyNDY3MDEsImRhdGEiOnsiaWQiOiIxMSIsIm5vbWJyZSI6Ik51ZXZvVXN1YXJpbyJ9fQ.bv3bqOxvpRy8LhaOlaDN3m7pJMbArleIqnHuwUuQT5Y', 'Pepe', 'Pérez', 'pepe@email.com', NULL, '2026-04-03 20:04:43', 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `AVATARES`
--
ALTER TABLE `AVATARES`
  ADD PRIMARY KEY (`id_avatar`);

--
-- Indices de la tabla `CAPTURAS`
--
ALTER TABLE `CAPTURAS`
  ADD PRIMARY KEY (`id_captura`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `CATEGORIAS`
--
ALTER TABLE `CATEGORIAS`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `ESTUDIOS`
--
ALTER TABLE `ESTUDIOS`
  ADD PRIMARY KEY (`id_estudio`);

--
-- Indices de la tabla `FAVORITOS`
--
ALTER TABLE `FAVORITOS`
  ADD PRIMARY KEY (`id_usuario`,`id_juego`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `JUEGOS`
--
ALTER TABLE `JUEGOS`
  ADD PRIMARY KEY (`id_juego`),
  ADD KEY `id_desarrollador` (`id_desarrollador`),
  ADD KEY `id_distribuidor` (`id_distribuidor`),
  ADD KEY `id_pegi` (`id_pegi`);

--
-- Indices de la tabla `JUEGOS_CATEGORIAS`
--
ALTER TABLE `JUEGOS_CATEGORIAS`
  ADD PRIMARY KEY (`id_juego`,`id_categoria`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `PARTIDAS`
--
ALTER TABLE `PARTIDAS`
  ADD PRIMARY KEY (`id_partida`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_juego` (`id_juego`);

--
-- Indices de la tabla `PEGI`
--
ALTER TABLE `PEGI`
  ADD PRIMARY KEY (`id_pegi`);

--
-- Indices de la tabla `ROLES`
--
ALTER TABLE `ROLES`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `SUSCRIPCION`
--
ALTER TABLE `SUSCRIPCION`
  ADD PRIMARY KEY (`id_suscripcion`);

--
-- Indices de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`alias`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_suscripcion` (`id_suscripcion`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `fk_usuario_avatar` (`id_avatar`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `AVATARES`
--
ALTER TABLE `AVATARES`
  MODIFY `id_avatar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `CAPTURAS`
--
ALTER TABLE `CAPTURAS`
  MODIFY `id_captura` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `CATEGORIAS`
--
ALTER TABLE `CATEGORIAS`
  MODIFY `id_categoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `ESTUDIOS`
--
ALTER TABLE `ESTUDIOS`
  MODIFY `id_estudio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT de la tabla `JUEGOS`
--
ALTER TABLE `JUEGOS`
  MODIFY `id_juego` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `PARTIDAS`
--
ALTER TABLE `PARTIDAS`
  MODIFY `id_partida` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `PEGI`
--
ALTER TABLE `PEGI`
  MODIFY `id_pegi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ROLES`
--
ALTER TABLE `ROLES`
  MODIFY `id_rol` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `SUSCRIPCION`
--
ALTER TABLE `SUSCRIPCION`
  MODIFY `id_suscripcion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `CAPTURAS`
--
ALTER TABLE `CAPTURAS`
  ADD CONSTRAINT `capturas_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `JUEGOS` (`id_juego`);

--
-- Filtros para la tabla `FAVORITOS`
--
ALTER TABLE `FAVORITOS`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `USUARIOS` (`id_usuario`),
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `JUEGOS` (`id_juego`);

--
-- Filtros para la tabla `JUEGOS`
--
ALTER TABLE `JUEGOS`
  ADD CONSTRAINT `juegos_ibfk_1` FOREIGN KEY (`id_desarrollador`) REFERENCES `ESTUDIOS` (`id_estudio`),
  ADD CONSTRAINT `juegos_ibfk_2` FOREIGN KEY (`id_distribuidor`) REFERENCES `ESTUDIOS` (`id_estudio`),
  ADD CONSTRAINT `juegos_ibfk_3` FOREIGN KEY (`id_pegi`) REFERENCES `PEGI` (`id_pegi`);

--
-- Filtros para la tabla `JUEGOS_CATEGORIAS`
--
ALTER TABLE `JUEGOS_CATEGORIAS`
  ADD CONSTRAINT `juegos_categorias_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `JUEGOS` (`id_juego`),
  ADD CONSTRAINT `juegos_categorias_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `CATEGORIAS` (`id_categoria`);

--
-- Filtros para la tabla `PARTIDAS`
--
ALTER TABLE `PARTIDAS`
  ADD CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `USUARIOS` (`id_usuario`),
  ADD CONSTRAINT `partidas_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `JUEGOS` (`id_juego`);

--
-- Filtros para la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD CONSTRAINT `fk_usuario_avatar` FOREIGN KEY (`id_avatar`) REFERENCES `AVATARES` (`id_avatar`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_suscripcion`) REFERENCES `SUSCRIPCION` (`id_suscripcion`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_rol`) REFERENCES `ROLES` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
