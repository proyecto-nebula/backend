-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 25-02-2026 a las 20:25:25
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ESTUDIOS`
--

CREATE TABLE `ESTUDIOS` (
  `id_estudio` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
-- Estructura de tabla para la tabla `IDIOMAS`
--

CREATE TABLE `IDIOMAS` (
  `id_idioma` int NOT NULL,
  `nombre` varchar(50) NOT NULL
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
-- Estructura de tabla para la tabla `JUEGOS_IDIOMAS`
--

CREATE TABLE `JUEGOS_IDIOMAS` (
  `id_juego` int NOT NULL,
  `id_idioma` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PAIS`
--

CREATE TABLE `PAIS` (
  `id_pais` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `bandera` varchar(255) DEFAULT NULL
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ROLES`
--

CREATE TABLE `ROLES` (
  `id_rol` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `id_usuario` int NOT NULL,
  `id_suscripcion` int DEFAULT NULL,
  `id_pais` int DEFAULT NULL,
  `id_rol` int DEFAULT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `fecha_suscripcion` date DEFAULT NULL,
  `id_avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `IDIOMAS`
--
ALTER TABLE `IDIOMAS`
  ADD PRIMARY KEY (`id_idioma`);

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
-- Indices de la tabla `JUEGOS_IDIOMAS`
--
ALTER TABLE `JUEGOS_IDIOMAS`
  ADD PRIMARY KEY (`id_juego`,`id_idioma`),
  ADD KEY `id_idioma` (`id_idioma`);

--
-- Indices de la tabla `PAIS`
--
ALTER TABLE `PAIS`
  ADD PRIMARY KEY (`id_pais`);

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
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_suscripcion` (`id_suscripcion`),
  ADD KEY `id_pais` (`id_pais`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `CAPTURAS`
--
ALTER TABLE `CAPTURAS`
  MODIFY `id_captura` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `CATEGORIAS`
--
ALTER TABLE `CATEGORIAS`
  MODIFY `id_categoria` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ESTUDIOS`
--
ALTER TABLE `ESTUDIOS`
  MODIFY `id_estudio` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `IDIOMAS`
--
ALTER TABLE `IDIOMAS`
  MODIFY `id_idioma` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `JUEGOS`
--
ALTER TABLE `JUEGOS`
  MODIFY `id_juego` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `PAIS`
--
ALTER TABLE `PAIS`
  MODIFY `id_pais` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `PARTIDAS`
--
ALTER TABLE `PARTIDAS`
  MODIFY `id_partida` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `PEGI`
--
ALTER TABLE `PEGI`
  MODIFY `id_pegi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ROLES`
--
ALTER TABLE `ROLES`
  MODIFY `id_rol` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `SUSCRIPCION`
--
ALTER TABLE `SUSCRIPCION`
  MODIFY `id_suscripcion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `JUEGOS_IDIOMAS`
--
ALTER TABLE `JUEGOS_IDIOMAS`
  ADD CONSTRAINT `juegos_idiomas_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `JUEGOS` (`id_juego`),
  ADD CONSTRAINT `juegos_idiomas_ibfk_2` FOREIGN KEY (`id_idioma`) REFERENCES `IDIOMAS` (`id_idioma`);

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
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_suscripcion`) REFERENCES `SUSCRIPCION` (`id_suscripcion`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_pais`) REFERENCES `PAIS` (`id_pais`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_rol`) REFERENCES `ROLES` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
