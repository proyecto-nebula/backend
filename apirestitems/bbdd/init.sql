-- Configuración de codificación para los acentos
SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;

-- Borrado en orden inverso para evitar errores de claves ajenas
DROP TABLE IF EXISTS juego_gameplay;
DROP TABLE IF EXISTS juego_idiomas;
DROP TABLE IF EXISTS juego_categorias;
DROP TABLE IF EXISTS usuario_categorias_preferidas;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS juegos;
DROP TABLE IF EXISTS gameplay;
DROP TABLE IF EXISTS idiomas;
DROP TABLE IF EXISTS paises;
DROP TABLE IF EXISTS desarrolladores;
DROP TABLE IF EXISTS distribuidores;
DROP TABLE IF EXISTS categorias;

-- 1. TABLAS MAESTRAS
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE paises (
    id CHAR(2) PRIMARY KEY, -- 'ES', 'MX', 'US'...
    nombre VARCHAR(100) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE idiomas (
    id CHAR(2) PRIMARY KEY, -- 'ES', 'EN', 'FR'...
    nombre VARCHAR(50) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE distribuidores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE desarrolladores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE gameplay (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. TABLA DE JUEGOS
CREATE TABLE juegos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    steam_id BIGINT UNIQUE, -- ID oficial de la tienda de Steam
    titulo VARCHAR(255) NOT NULL,
    descripcion_corta VARCHAR(255),
    descripcion_larga TEXT,
    portada_v VARCHAR(255), -- Imagen vertical (600x900 aprox)
    portada_h VARCHAR(255), -- Imagen horizontal (header)
    hero VARCHAR(255),      -- Imagen de fondo grande
    logo VARCHAR(255),      -- Logo transparente del juego
    metacritic INT,
    pegi INT,
    fecha_lanzamiento DATE,
    fecha_publicacion DATE,
    destacado TINYINT(1) DEFAULT 0,
    -- Nuevas columnas para relaciones
    desarrollador_id INT,
    distribuidor_id INT,
    CONSTRAINT fk_juego_desarrollador FOREIGN KEY (desarrollador_id) 
        REFERENCES desarrolladores(id) ON DELETE SET NULL,
    CONSTRAINT fk_juego_distribuidor FOREIGN KEY (distribuidor_id) 
        REFERENCES distribuidores(id) ON DELETE SET NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. TABLAS INTERMEDIAS (Muchos a Muchos)
CREATE TABLE juego_categorias (
    juego_id INT,
    categoria_id INT,
    PRIMARY KEY (juego_id, categoria_id),
    FOREIGN KEY (juego_id) REFERENCES juegos(id) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE
);

CREATE TABLE juego_idiomas (
    juego_id INT,
    idioma_id CHAR(2),
    PRIMARY KEY (juego_id, idioma_id),
    FOREIGN KEY (juego_id) REFERENCES juegos(id) ON DELETE CASCADE,
    FOREIGN KEY (idioma_id) REFERENCES idiomas(id) ON DELETE CASCADE
);

CREATE TABLE juego_gameplay (
    juego_id INT,
    gameplay_id INT,
    PRIMARY KEY (juego_id, gameplay_id),
    FOREIGN KEY (juego_id) REFERENCES juegos(id) ON DELETE CASCADE,
    FOREIGN KEY (gameplay_id) REFERENCES gameplay(id) ON DELETE CASCADE
);

-- 4. USUARIOS
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    alias VARCHAR(100),
    fecha_nacimiento DATE NOT NULL,
    pais_id CHAR(2),
    FOREIGN KEY (pais_id) REFERENCES paises(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ---------------------------------------------------------
-- INSERCIÓN DE DATOS MAESTROS
-- ---------------------------------------------------------

INSERT INTO categorias (nombre) VALUES 
('Acción'), ('RPG'), ('Aventura'), ('Estrategia'), ('Shooter'), 
('Terror'), ('Simulación'), ('Indie'), ('Supervivencia'), ('Mundo Abierto'), 
('Sigilo'), ('Cooperativo'), ('Deportes'), ('Puzzle'), ('Carreras'), 
('Lucha'), ('Plataformas'), ('Novela Visual'), ('Educativo'), ('Familiar');

INSERT INTO gameplay (nombre) VALUES 
('Un jugador'), ('Cooperativo local'), ('Cooperativo online'), ('Multijugador local'), ('Multijugador online');

INSERT INTO paises (id, nombre) VALUES ('ES', 'España'), ('MX', 'México'), ('AR', 'Argentina'), ('US', 'Estados Unidos'), ('CO', 'Colombia');

-- Limpieza e Inserción de Idiomas
TRUNCATE TABLE idiomas;
INSERT INTO idiomas (id, nombre) VALUES 
('ES', 'Español'),
('EN', 'Inglés'),
('FR', 'Francés'),
('IT', 'Italiano'),
('DE', 'Alemán'),
('PT', 'Portugués'),
('JP', 'Japonés'),
('KR', 'Coreano'),
('ZH', 'Chino'),
('RU', 'Ruso'),
('PL', 'Polaco'),
('UA', 'Ucraniano');


INSERT INTO distribuidores (nombre) VALUES 
('Paradox Interactive'),
('Bethesda Softworks'),
('Rockstar Games'),
('Ubisoft'),
('Sony Interactive Entertainment'),
('Warner Bros. Games'),
('Electronic Arts'),
('2K Games'),
('Focus Entertainment'),
('Annapurna Interactive'),
('Activision'),
('Epic Games'),
('Devolver Digital'),
('Hooded Horse'),
('Capcom'),
('PlayStation Publishing'),
('505 Games'),
('Valve'),
('SCS Software'),
('Coffee Stain Publishing'),
('Microsoft Store'),
('Take-Two Interactive'),
('Bandai Namco Entertainment'),
('Larian Studios'),
('CD Projekt Red'),
('Sega'),
('Square Enix'),
('FromSoftware'),
('Game Science'),
('Konami'),
('InnerSloth'),
('Team17'),
('Studio MDHR'),
('Nintendo'),
('Private Division'),
('Giant Army'),
('Tomorrow Corporation'),
('The Irregular Corporation'),
('Nival'),
('Dry Cactus'),
('Disney'),
('Ysbryd Games'),
('Serenity Forge'),
('Fruitbat Factory'),
('VisualArts');


INSERT INTO desarrolladores (nombre) VALUES 
('Insomniac Games'),
('Colossal Order'),
('The Indie Stone'),
('MachineGames'),
('Rockstar North'),
('Avalanche Software'),
('Ubisoft Montreal'),
('Respawn Entertainment'),
('Telltale Games'),
('Hangar 13'),
('Warhorse Studios'),
('Kojima Productions'),
('CD Projekt Red'),
('FromSoftware'),
('Larian Studios'),
('Bethesda Game Studios'),
('Playground Games'),
('Capcom'),
('Embark Studios'),
('Santa Monica Studio'),
('Guerrilla Games'),
('Naughty Dog'),
('Sucker Punch Productions'),
('Housemarque'),
('Bluepoint Games'),
('BlueTwelve Studio'),
('Hazelight Studios'),
('Arkane Studios'),
('Polyphony Digital'),
('id Software'),
('Tango Gameworks'),
('Studio MDHR'),
('Maddy Makes Games'),
('Moon Studios'),
('Mega Crit Games'),
('Re-Logic'),
('Unknown Worlds'),
('Iron Gate Studio'),
('InnerSloth'),
('Kinetic Games'),
('Behaviour Interactive'),
('Asobo Studio'),
('SCS Software'),
('Rare'),
('Game Science'),
('CyberConnect2'),
('Arrowhead Game Studios'),
('Saber Interactive'),
('Bloober Team'),
('11 bit studios'),
('Slavic Magic'),
('GSC Game World'),
('Keen Games'),
('LocalThunk'),
('Pocketpair'),
('Bandai Namco Studios'),
('Ironwood Studios'),
('NEOWIZ'),
('Atlus'),
('PlatinumGames'),
('Arc System Works'),
('Sumo Digital'),
('Kunos Simulazioni'),
('Sabotage Studio'),
('Mintrocket'),
('Firaxis Games'),
('NetherRealm Studios'),
('Relic Entertainment'),
('Paradox Development Studio'),
('Madden NFL Team'),
('Kowloon Nights'),
('ZA/UM'),
('Nintendo EPD'),
('Remedy Entertainment'),
('Techland'),
('Valve'),
('Toys for Bob'),
('Massive Monster'),
('Criterion Games'),
('One More Level'),
('Squad'),
('Giant Army'),
('Tomorrow Corporation'),
('Claudiu Kiss'),
('Luden.io'),
('Dry Cactus'),
('5th Cell'),
('Force Field'),
('Mediatonic'),
('TT Games'),
('Mojang Studios'),
('ConcernedApe'),
('MAGES. Inc.'),
('Spike Chunsoft'),
('Sukeban Games'),
('Toge Productions'),
('Team Salvato'),
('Vanillaware'),
('PaleMono'),
('Key'),
('IO Interactive'),
('Eidos-Montréal'),
('Ubisoft Toronto');


-- 1. Cities: Skylines II
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (949230, 'Cities: Skylines II', 
'Crea una ciudad desde cero y transfórmala en una metrópolis próspera.', 
'Alza una ciudad desde sus cimientos y transfórmala en la metrópolis próspera que solo tú puedes imaginar. Nunca has experimentado una construcción a esta escala. Con una simulación profunda y una economía viva, Cities: Skylines II te permite construir un mundo sin límites.\n\nEstablece la infraestructura, las carreteras y los sistemas que hacen posible la vida diaria. Cada decisión que tomes tendrá un impacto en el crecimiento de tu ciudad. ¿Podrás gestionar las demandas de la industria mientras mantienes la calidad de vida de los ciudadanos? Desde los servicios públicos hasta la zonificación, el destino de tu urbe está en tus manos en el simulador de ciudades más realista jamás creado.', 
'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/949230/logo.png', 74, 3, '2023-10-24', '2026-01-05', 1, 
(SELECT id FROM desarrolladores WHERE nombre = 'Colossal Order'), (SELECT id FROM distribuidores WHERE nombre = 'Paradox Interactive'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'KR'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'PL');

-- 2. Project Zomboid
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (108600, 'Project Zomboid', 
'¿Cómo morirás? La supervivencia zombi definitiva en un mundo implacable.', 
'Project Zomboid es la cima de la supervivencia zombi. En un mapa inmenso basado en la Kentucky rural, los jugadores deben saquear casas, construir defensas y luchar contra el hambre, la sed y la enfermedad mientras intentan evitar ser devorados por la horda implacable.\n\nNo hay héroes aquí. El juego comienza con la frase "Así es como moriste", y cada partida es una crónica de tu resistencia. La profundidad del sistema de salud, la gestión del estrés, la mecánica de cocina y la construcción detallada hacen que cada día sobrevivido sea un triunfo. Puedes jugar solo o unirte a servidores multijugador para reconstruir la sociedad o verla colapsar desde dentro.', 
'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/108600/logo.png', 80, 18, '2013-11-08', '2026-01-05', 1, 
(SELECT id FROM desarrolladores WHERE nombre = 'The Indie Stone'), (SELECT id FROM desarrolladores WHERE nombre = 'The Indie Stone'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL');

-- 3. Indiana Jones and the Great Circle
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2677660, 'Indiana Jones and the Great Circle', 
'Desentraña uno de los mayores misterios de la historia en esta aventura trotamundos.', 
'Viaja al año 1937 y ponte el sombrero del arqueólogo más famoso del cine. Indiana Jones and the Great Circle es una experiencia de acción y aventura en primera persona que te lleva desde los pasillos de la Universidad de Marshall hasta las pirámides de Egipto y los picos nevados del Himalaya.\n\nDesarrollado por MachineGames, el juego combina combate cinematográfico con el uso icónico del látigo para distraer, desarmar y balancearte sobre los enemigos. Resuelve acertijos ancestrales y sobrevive a una conspiración global mientras compites contra fuerzas siniestras para descubrir el secreto detrás del Gran Círculo. Es la carta de amor definitiva a la saga original.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2677660/logo.png', 85, 16, '2024-12-09', '2026-01-05', 1, 
(SELECT id FROM desarrolladores WHERE nombre = 'MachineGames'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'PT'), (@j_id, 'RU');

-- 4. Red Dead Redemption 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1174180, 'Red Dead Redemption 2', 
'Una epopeya de forajidos en el ocaso del Salvaje Oeste americano.', 
'Estados Unidos, 1899. Arthur Morgan y la banda de Van der Linde se ven obligados a huir tras un atraco fallido. Con agentes federales y cazarrecompensas pisándoles los talones, la banda deberá abrirse camino por el corazón de América a base de robos y peleas para sobrevivir.\n\nRed Dead Redemption 2 es un mundo abierto con una atención al detalle sin precedentes. Cada interacción, desde cazar en las montañas hasta jugar al póker en un salón, se siente orgánica y real. A medida que las divisiones internas amenazan con desgarrar a la banda, Arthur debe elegir entre sus propios ideales y la lealtad al hombre que lo crió. Una obra maestra narrativa y visual que define una generación.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1174180/logo.png', 97, 18, '2019-12-05', '2026-01-05', 1, 
(SELECT id FROM desarrolladores WHERE nombre = 'Rockstar North'), (SELECT id FROM distribuidores WHERE nombre = 'Rockstar Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'JP'), (@j_id, 'KR');

-- 5. Star Wars Outlaws
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2834010, 'Star Wars Outlaws', 
'Vive la vida de una buscavidas en el primer mundo abierto de Star Wars.', 
'Explora planetas distintos por toda la galaxia, tanto nuevos como clásicos. Arriésgalo todo como Kay Vess, una buscavidas que busca la libertad y los medios para empezar una nueva vida junto con su compañero Nix. Lucha, roba y engaña a los sindicatos del crimen mientras te conviertes en una de las personas más buscadas de la galaxia.\n\nAmbientado entre los eventos de El Imperio Contraataca y El Retorno del Jedi, Outlaws te permite pilotar tu nave, la Trailblazer, en combates espaciales dogfight, aceptar misiones de alto riesgo de los señores del crimen y explorar ciudades bulliciosas y paisajes salvajes. Si estás dispuesto a correr el riesgo, la galaxia está llena de oportunidades.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2834010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2834010/logo.png', 76, 12, '2024-08-30', '2026-01-05', 1, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Montreal'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'KR'), (@j_id, 'PT'), (@j_id, 'ZH');

-- 6. Marvel's Spider-Man 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2715900, 'Marvel\'s Spider-Man 2', 
'Los Spider-Men Peter Parker y Miles Morales regresan para una nueva e increíble aventura.', 
'Balancéate, salta y usa tus Alas de Telaraña para viajar por la Nueva York de Marvel, alternando rápidamente entre Peter Parker y Miles Morales. Vive historias distintas y domina nuevos poderes mientras el icónico villano Venom amenaza con destruir sus vidas, su ciudad y a quienes aman.\n\nExplora una Nueva York expandida que ahora incluye Brooklyn y Queens, con mecánicas de desplazamiento mejoradas y un sistema de combate más fluido. Utiliza las nuevas habilidades de simbionte de Peter y los explosivos poderes venenosos bioeléctricos de Miles en una narrativa profunda que explora la carga de la máscara y la verdadera naturaleza del heroísmo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2715900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2715900/logo.png', 90, 16, '2025-01-30', '2026-01-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Insomniac Games'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'PL'), (@j_id, 'RU');

-- 7. Hogwarts Legacy
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (990080, 'Hogwarts Legacy', 
'Vive lo desconocido en el Colegio Hogwarts de Magia y Hechicería en el siglo XIX.', 
'Hogwarts Legacy es un RPG de acción en un mundo abierto ambientado en el universo de los libros de Harry Potter. Embárcate en un viaje por lugares nuevos y conocidos mientras exploras y descubres animales fantásticos, personalizas tu personaje, elaboras pociones, dominas hechizos y mejoras tus talentos para convertirte en el mago o bruja que quieres ser.\n\nTu personaje es un estudiante que posee la clave de un antiguo secreto que amenaza con destruir el mundo mágico. Experimenta la vida en Hogwarts mientras forjas alianzas, luchas contra magos tenebrosos y, en última instancia, decides el destino del mundo mágico. Tu legado es lo que tú hagas de él.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 84, 12, '2023-02-10', '2026-01-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Avalanche Software'), (SELECT id FROM distribuidores WHERE nombre = 'Warner Bros. Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'PT'), (@j_id, 'PL');

-- 8. Star Wars Jedi: Survivor
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1774580, 'Star Wars Jedi: Survivor', 
'La historia de Cal Kestis continúa en esta épica aventura de acción galáctica.', 
'Cinco años después de los eventos de Jedi: Fallen Order, Cal Kestis ya no es un padawan, sino un poderoso Caballero Jedi. La persecución del Imperio se ha vuelto más implacable, y Cal debe decidir hasta dónde está dispuesto a llegar para salvar a sus seres queridos y proteger el legado de la Orden Jedi.\n\nDescubre nuevos planetas y visita mundos conocidos en la galaxia de Star Wars, cada uno con biomas, desafíos y enemigos únicos. Domina nuevas habilidades, posturas de combate con sable de luz y poderes de la Fuerza para superar obstáculos y derrotar a adversarios cada vez más peligrosos en una narrativa cinematográfica cargada de emoción y giros inesperados.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/logo.png', 85, 12, '2023-04-28', '2026-01-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Respawn Entertainment'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 9. Star Wars Jedi: Fallen Order
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1172380, 'Star Wars Jedi: Fallen Order', 
'Conviértete en un Jedi en una aventura de acción que abarca toda la galaxia.', 
'Tras la ejecución de la Orden 66, Cal Kestis, un joven padawan que vive en la clandestinidad, debe completar su entrenamiento y dominar las artes del sable de luz para reconstruir la Orden Jedi. En su viaje, contará con la ayuda de una antigua Caballero Jedi, un piloto cascarrabias y un intrépido droide llamado BD-1.\n\nExplora selvas antiguas, cuevas azotadas por el viento y complejos imperiales mientras resuelves acertijos y luchas contra la Inquisición. El sistema de combate requiere precisión y estrategia, permitiéndote usar la Fuerza para manipular el entorno y superar a enemigos superiores en número. Es el inicio del viaje que cambiará el destino de Cal para siempre.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1172380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172380/logo.png', 81, 12, '2019-11-15', '2026-01-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Respawn Entertainment'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KO');

-- 10. The Expanse: A Telltale Series
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1708010, 'The Expanse: A Telltale Series', 
'Experimenta el universo de la aclamada serie de TV en esta tensa aventura narrativa.', 
'Sumérgete en el emocionante universo de The Expanse antes de los eventos de la serie de televisión. Tomas el control de Camina Drummer, la segunda de a bordo de una nave de reconocimiento llamada Artemis, que busca un botín misterioso en los bordes del Cinturón.\n\nExplora naves naufragadas en gravedad cero, sobrevive a motines y enfréntate a piratas espaciales despiadados. Cada decisión que tomes determinará el destino de la tripulación y el futuro de Drummer en una narrativa donde la moralidad es gris y los recursos son escasos. Es la combinación perfecta entre la profundidad política de la serie y la toma de decisiones clásica de Telltale.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1708010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1708010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1708010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1708010/logo.png', 70, 18, '2023-07-27', '2026-01-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Telltale Games'), (SELECT id FROM distribuidores WHERE nombre = 'Warner Bros. Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'ZH'), (@j_id, 'IT'), (@j_id, 'PT');

-- 11. The Wolf Among Us
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (250320, 'The Wolf Among Us', 
'Un thriller crudo, violento y maduro basado en los cómics de Fábulas.', 
'Ponte en la piel de Bigby Wolf, el lobo feroz, que ahora ejerce como sheriff de Fabletown, una comunidad clandestina de personajes de cuentos en la Nueva York de los años 80. En esta aventura narrativa de Telltale Games, deberás resolver un asesinato brutal que amenaza con exponer la existencia de las fábulas ante el mundo humano.\n\nCada decisión que tomes alterará el curso de la historia y tu relación con otros personajes icónicos como Blancanieves o el Sr. Sapo. La estética cel-shading de estilo neo-noir y una trama cargada de dilemas morales hacen de este juego una pieza imprescindible para los amantes del misterio y la narrativa interactiva.', 
'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/250320/logo.png', 85, 18, '2013-10-11', '2022-05-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Telltale Games'), (SELECT id FROM distribuidores WHERE nombre = 'Warner Bros. Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT');

-- 12. Mafia: Definitive Edition
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1030840, 'Mafia: Definitive Edition', 
'Un remake completo del clásico criminal ambientado en la prohibición de los años 30.', 
'Redescubre la primera entrega de la saga Mafia, reconstruida desde cero con un motor gráfico impresionante y una narrativa expandida. Ambientado en Lost Heaven, Illinois, encarnarás a Tommy Angelo, un taxista que, tras un fatídico encuentro con la mafia, se ve arrastrado al peligroso pero lucrativo mundo del crimen organizado.\n\nEl juego recrea con fidelidad absoluta la atmósfera de la Gran Depresión, ofreciendo tiroteos intensos, persecuciones de época y una historia de lealtad y traición que rivaliza con las mejores películas de gánsteres. Esta edición definitiva no solo mejora lo visual, sino que profundiza en los personajes y el trasfondo de la ciudad.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1030840/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1030840/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1030840/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1030840/logo.png', 78, 18, '2020-09-25', '2023-11-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Hangar 13'), (SELECT id FROM distribuidores WHERE nombre = '2K Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 13. Kingdom Come: Deliverance II
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1771300, 'Kingdom Come: Deliverance II', 
'Un RPG de acción histórico y realista en el corazón de la Bohemia medieval.', 
'Regresa a la Bohemia del siglo XV como Henry de Skalitz. Esta secuela eleva el realismo histórico a nuevas cotas, ofreciendo un mundo abierto masivo y detallado donde tus acciones definen el futuro de un reino sumido en la guerra civil. Desde humildes aldeas hasta bulliciosas ciudades medievales, cada rincón está lleno de vida y consecuencias.\n\nExperimenta un sistema de combate táctico y desafiante que requiere habilidad y paciencia. Podrás personalizar a Henry para que se convierta en un caballero de brillante armadura, un sigiloso ladrón o un diplomático carismático. Con una narrativa cinematográfica y un rigor histórico sin precedentes, es la experiencia definitiva de la vida en la Edad Media.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1771300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1771300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1771300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1771300/logo.png', 82, 18, '2025-02-11', '2025-01-02', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Warhorse Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Focus Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'PL'), (@j_id, 'UA'), (@j_id, 'ZH');

-- 14. Death Stranding Director's Cut
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1850570, 'Death Stranding Director\'s Cut', 
'Una experiencia revolucionaria de Hideo Kojima sobre la conexión humana.', 
'En un futuro cercano, unas misteriosas explosiones han desencadenado una serie de eventos sobrenaturales conocidos como el Death Stranding. Con criaturas espectrales asolando el mundo y la humanidad al borde de la extinción, Sam Porter Bridges debe viajar a través de unos Estados Unidos devastados para reconectar a la sociedad aislada.\n\nEsta versión definitiva expande la visión original con nuevas zonas, misiones, armas y mecánicas de entrega. El juego desafía las convenciones del género, centrándose en la logística, la paciencia y el impacto de nuestras acciones en una red social asíncrona donde puedes ayudar a otros jugadores sin verlos nunca. Una obra visualmente impactante que reflexiona sobre la soledad y la esperanza.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1850570/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850570/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850570/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850570/logo.png', 85, 18, '2022-03-30', '2024-04-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Kojima Productions'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 15. Cyberpunk 2077
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1091500, 'Cyberpunk 2077', 
'Conviértete en un mercenario ciberpunk en la megaciudad de Night City.', 
'Cyberpunk 2077 es un RPG de acción y aventura en mundo abierto ambientado en Night City, una megalópolis obsesionada con el poder, el glamur y la modificación corporal. Juegas como V, un mercenario que busca un implante único que permite alcanzar la inmortalidad. Personaliza tu ciberware, tus habilidades y tu estilo de juego mientras exploras una ciudad inmensa donde tus decisiones afectan a la historia y al mundo que te rodea.\n\nTras las importantes actualizaciones, el juego ofrece una experiencia densa y vibrante con combates viscerales, conducción mejorada y una narrativa emocionalmente cargada junto al icónico Johnny Silverhand (interpretado por Keanu Reeves). Vive la fantasía ciberpunk definitiva en un mundo donde la línea entre el hombre y la máquina es cada vez más borrosa.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1091500/logo.png', 86, 18, '2020-12-10', '2024-08-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'CD Projekt Red'), (SELECT id FROM distribuidores WHERE nombre = 'CD Projekt Red'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PL'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'JP');

-- 16. Elden Ring
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1245620, 'Elden Ring', 
'Levántate, Sinluz, y déjate guiar por la gracia para convertirte en el Señor del Círculo.', 
'Elden Ring es una épica aventura de RPG de acción ambientada en las Tierras Intermedias, un mundo de fantasía oscura creado por Hidetaka Miyazaki y George R. R. Martin. Explora vastos paisajes a lomos de Torrentera, tu corcel espectral, y adéntrate en mazmorras lúgubres y castillos imponentes llenos de secretos ancestrales.\n\nPersonaliza tu estilo de juego combinando una enorme variedad de armas, artes de batalla y hechizos. Enfréntate a semidioses caídos en combates legendarios y decide el destino de un mundo fracturado. La libertad de exploración y la profundidad de su lore lo convierten en una experiencia cumbre del género "soulslike" llevada al mundo abierto.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/logo.png', 96, 16, '2022-02-25', '2022-10-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'FromSoftware'), (SELECT id FROM distribuidores WHERE nombre = 'Bandai Namco Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'KR'), (@j_id, 'ZH'), (@j_id, 'PL'), (@j_id, 'RU');

-- 17. Baldur's Gate 3
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1086940, 'Baldur\'s Gate 3', 
'Reúne a tu grupo y regresa a los Reinos Olvidados en una historia de compañerismo y traición.', 
'Baldur\'s Gate 3 es un RPG de nueva generación con una narrativa profunda basada en el universo de Dungeons & Dragons. Tras ser infectado por un parásito de los azotamentes, te enfrentarás a una transformación aterradora, pero también obtendrás poderes oscuros que podrían ser tu salvación o tu perdición.\n\nDisfruta de una libertad sin precedentes para explorar, interactuar y tomar decisiones que alterarán el destino de ciudades enteras. Con un sistema de combate por turnos fiel a las reglas de la 5ª edición de D&D y un elenco de compañeros inolvidables con sus propias motivaciones, cada partida es única. Elige tu camino y decide si quieres ser una fuerza para el bien o sucumbir a la tentación del mal absoluto.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/logo.png', 96, 18, '2023-08-03', '2024-03-22', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Larian Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Larian Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'PL'), (@j_id, 'UA');

-- 18. Starfield
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1716740, 'Starfield', 
'Embarca en un viaje épico a través de las estrellas en el primer universo nuevo de Bethesda en 25 años.', 
'En Starfield, la humanidad se ha aventurado más allá de nuestro sistema solar. Como miembro de Constelación, un grupo de exploradores espaciales, buscarás artefactos raros por toda la galaxia en este masivo RPG de mundo abierto. Crea cualquier personaje que puedas imaginar y personaliza tu nave, desde su apariencia hasta sus sistemas de combate.\n\nExplora más de 1000 planetas, establece bases, extrae recursos y entabla relaciones con diversas facciones. La libertad es total: puedes ser un pirata espacial, un explorador pacífico o un diplomático influyente. El juego combina la profundidad clásica de los juegos de Bethesda con una escala galáctica impresionante, invitándote a responder al mayor misterio de la humanidad.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1716740/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1716740/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1716740/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1716740/logo.png', 83, 18, '2023-09-06', '2023-12-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Bethesda Game Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH');

-- 19. Forza Horizon 5
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1551360, 'Forza Horizon 5', 
'Tu aventura Horizon definitiva te espera en los vibrantes paisajes de México.', 
'Conduce por un mundo abierto lleno de contrastes y belleza en Forza Horizon 5. Participa en expediciones a través de desiertos vivos, selvas frondosas, ciudades históricas y hasta la cima de un volcán nevado mientras disfrutas de una acción de conducción ilimitada con cientos de los mejores coches del mundo.\n\nExperimenta un clima dinámico que cambia cada semana, afectando drásticamente a la conducción y al entorno. Supera desafíos en solitario o únete a tus amigos en Horizon Arcade para divertiros juntos en pruebas locas. Con unos gráficos fotorrealistas y un sonido de motor envolvente, es la celebración definitiva de la cultura automovilística y la libertad al volante.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 92, 3, '2021-11-09', '2022-06-18', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Playground Games'), (SELECT id FROM distribuidores WHERE nombre = 'Microsoft Store'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'KR'), (@j_id, 'ZH'), (@j_id, 'RU');

-- 20. Resident Evil 4
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2050650, 'Resident Evil 4', 
'La supervivencia es solo el principio en este remake magistral del clásico de terror.', 
'Seis años después de la catástrofe biológica en Raccoon City, Leon S. Kennedy es enviado a rescatar a la hija del presidente, secuestrada en una aldea europea aislada. Allí, descubre que los habitantes han sucumbido a un mal terrible que los priva de su voluntad, convirtiéndolos en seres violentos y despiadados.\n\nEsta versión moderniza el clásico de 2005 con gráficos de última generación, controles actualizados y una trama más profunda y oscura. La tensión es constante mientras gestionas tus limitados recursos y te enfrentas a horrores inimaginables. Con una mezcla perfecta de acción intensa, atmósfera agobiante y momentos icónicos reinventados, Resident Evil 4 redefine una vez más el género del survival horror.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2050650/logo.png', 93, 18, '2023-03-24', '2024-09-02', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 21. ARC Raiders
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1808500, 'ARC Raiders', 
'Un shooter de extracción en tercera persona donde la humanidad resiste a una amenaza mecánica.', 
'ARC Raiders es un shooter de extracción en tercera persona gratuito donde los jugadores deben unirse para resistir el asalto de ARC, una amenaza mecánica despiadada que desciende desde el espacio. En un mundo devastado y futurista, tu objetivo es descender a la superficie para recuperar suministros vitales y tecnología antigua.\n\nLa supervivencia no solo depende de tu puntería, sino del trabajo en equipo y el uso estratégico del entorno. Cada incursión es un riesgo constante: debes decidir cuándo luchar y cuándo huir con el botín antes de que las máquinas de ARC o incluso otros Raiders acaben con tu misión. Con un apartado visual puntero y físicas destructibles, cada partida promete ser una experiencia cinematográfica de alta tensión.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1808500/logo.png', 82, 16, '2025-10-15', '2025-11-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Embark Studios'), (SELECT id FROM desarrolladores WHERE nombre = 'Embark Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'KR');

-- 22. God of War Ragnarök
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2322010, 'God of War Ragnarök', 
'Kratos y Atreus deben viajar a cada uno de los Nueve Reinos en busca de respuestas.', 
'Acompaña a Kratos y Atreus en un viaje épico y emotivo mientras luchan por aferrarse y soltarse. En el centro de una guerra nórdica que amenaza con destruir el mundo, padre e hijo deben enfrentarse a dioses como Thor y Odín mientras el Fimbulwinter acecha.\n\nEsta secuela expande el combate visceral del título de 2018 con nuevas habilidades y armas, ofreciendo una narrativa magistral sobre el destino, el crecimiento y la redención en los paisajes más impresionantes de la mitología nórdica. Descubre una conclusión espectacular para la saga nórdica que profundiza en la relación entre un padre y un hijo que se convierte en hombre.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2322010/logo.png', 94, 18, '2024-09-19', '2024-10-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Santa Monica Studio'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL'), (@j_id, 'ZH');

-- 23. Horizon Forbidden West
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2420110, 'Horizon Forbidden West', 
'Acompaña a Aloy en su aventura por las majestuosas tierras del Oeste Prohibido.', 
'Explora tierras lejanas, lucha contra máquinas más grandes e imponentes y conoce a nuevas tribus increíbles en el futuro lejano de Horizon. La tierra se muere. Tormentas asoladoras y una plaga imparable merman a los restos de la humanidad, mientras nuevas y temibles máquinas merodean por sus fronteras.\n\nAloy debe desentrañar los secretos detrás de estas amenazas y restaurar el orden y el equilibrio del mundo. Por el camino, se reencontrará con viejos amigos, forjará alianzas con nuevas facciones en guerra y descubrirá la herencia de un pasado antiguo. Una experiencia visual inigualable con un sistema de combate táctico que te permite desmantelar pieza a pieza a tus colosales enemigos metálicos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2420110/logo.png', 89, 16, '2024-03-21', '2023-05-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Guerrilla Games'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'PL');

-- 24. The Last of Us Part II
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2401430, 'The Last of Us Part II', 
'Una historia de venganza y redención implacable en un mundo devastado.', 
'Cinco años después de su peligroso viaje por unos Estados Unidos postpandémicos, Ellie y Joel se han asentado en Jackson, Wyoming. Vivir en una comunidad próspera de supervivientes les ha permitido disfrutar de paz y estabilidad. Sin embargo, un violento acontecimiento interrumpe esa paz, y Ellie se embarca en un viaje sin descanso para hacer justicia.\n\nA medida que va dando caza a los responsables, tendrá que enfrentarse a las devastadoras consecuencias físicas y emocionales de sus actos. El juego ofrece un combate cuerpo a cuerpo de alta intensidad, un sigilo fluido y una narrativa que desafía la percepción del jugador sobre el bien y el mal. Una obra técnica y artística que empuja los límites del realismo en los videojuegos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2401430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401430/logo.png', 93, 18, '2024-06-19', '2022-01-25', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Naughty Dog'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 25. Ghost of Tsushima
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2215430, 'Ghost of Tsushima', 
'En la Tsushima de finales del siglo XIII, el honor de un samurái se enfrenta a una invasión brutal.', 
'A finales del siglo XIII, el Imperio mongol ha devastado naciones enteras en su campaña por conquistar Oriente. La isla de Tsushima es lo único que se interpone entre el Japón continental y una enorme flota de invasión mongola. El samurái Jin Sakai es uno de los pocos supervivientes de su clan y debe decidir entre seguir el código del honor con el que se crió o adoptar el camino del Fantasma para liberar su hogar.\n\nExplora un mundo abierto lleno de belleza poética, desde extensos campos de flores hasta templos serenos. Domina el arte de la katana en duelos intensos y utiliza el sigilo y las armas poco convencionales para diezmar a las fuerzas invasoras en una historia épica de sacrificio y resistencia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/logo.png', 87, 18, '2024-05-16', '2024-07-30', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Sucker Punch Productions'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL'), (@j_id, 'ZH');

-- 26. Returnal
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1446720, 'Returnal', 
'Rompe el ciclo en este shooter roguelike en tercera persona premiado y frenético.', 
'Tras el aterrizaje forzoso en un mundo alienígena cambiante, Selene debe explorar el paisaje desolado de una antigua civilización para escapar. Sola y aislada, se ve obligada a luchar con uñas y dientes para sobrevivir. Una y otra vez, es derrotada y obligada a reiniciar su viaje cada vez que muere.\n\nDiseñado para una rejugabilidad extrema, el mundo procedimental de Returnal te invita a sacudirte el polvo de la derrota y enfrentarte a nuevos desafíos que evolucionan con cada renacimiento. Disfruta de intensos combates de estilo bullet hell y una narrativa fragmentada que te obligará a cuestionar la realidad mientras desentrañas el misterio de un planeta que parece conocer tus secretos más oscuros.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446720/logo.png', 86, 16, '2023-02-15', '2023-08-22', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Housemarque'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL'), (@j_id, 'ZH');

-- 27. Demon's Souls
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2401410, 'Demon\'s Souls', 
'Regresa al reino de Boletaria en este remake magistral del clásico que definió un género.', 
'En su búsqueda de poder, el duodécimo rey de Boletaria, el rey Allant, canalizó las antiguas artes del alma y despertó a un demonio tan antiguo como el tiempo: el Anciano. Tras la invocación del Anciano, una niebla incolora se extendió por la tierra, liberando a criaturas terribles hambrientas de almas humanas.\n\nTotalmente reconstruido desde cero y mejorado magistralmente, este remake te invita a enfrentarte a los desafíos de un mundo oscuro y despiadado. Domina el combate de precisión y aprende cuándo atacar y cuándo defender, ya que cada golpe en falso puede ser el último. Como un guerrero solitario que ha atravesado la niebla, deberás enfrentarte a los demonios más imponentes para ganarte el título de "Asesino de Demonios" y devolver al Anciano a su letargo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2401410/logo.png', 92, 18, '2024-05-20', '2024-11-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Bluepoint Games'), (SELECT id FROM distribuidores WHERE nombre = 'Sony Interactive Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'RU');

-- 28. Stray
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1332010, 'Stray', 
'Perdido, solo y separado de su familia, un gato callejero debe resolver un antiguo misterio.', 
'Stray es un juego de aventuras en tercera persona protagonizado por un gato callejero en medio de los detallados callejones iluminados por el neón de una ciberciudad decadente y sus lúgubres entornos. Deambula por los alrededores, defiéndete de amenazas imprevistas y resuelve los misterios de este lugar poco acogedor habitado por robots inocentes y criaturas peligrosas.\n\nVelo todo a través de los ojos de un gato e interactúa con el entorno de formas lúdicas. Sé sigiloso, ágil, tonto y, a veces, lo más molesto posible con los extraños habitantes de este mundo desconocido. Por el camino, el gato se hará amigo de un pequeño dron volador, conocido solo como B-12. Con la ayuda de este nuevo compañero, ambos intentarán encontrar una salida.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/logo.png', 83, 12, '2022-07-19', '2022-12-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'BlueTwelve Studio'), (SELECT id FROM distribuidores WHERE nombre = 'Annapurna Interactive')); -- Nota: No estaba en la lista inicial pero es el distribuidor real.
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'KR');

-- 29. It Takes Two
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1426210, 'It Takes Two', 
'Embárcate en el viaje más loco de tu vida en esta aventura de plataformas cooperativa pura.', 
'Ponte en la piel de Cody y May, una pareja en conflicto que se convierte en muñecos por un hechizo mágico. Juntos, atrapados en un mundo fantástico donde lo impredecible se esconde a la vuelta de cada esquina, deberán trabajar juntos a regañadientes para salvar su relación fracturada.\n\nDomina habilidades de personaje únicas y conectadas en cada nuevo nivel. Ayudaos el uno al otro a superar una gran variedad de obstáculos inesperados y momentos desternillantes. Patea las colas peludas de ardillas gánsteres, pilota unos calzoncillos, haz de DJ en un club nocturno zumbante y atraviesa una bola de nieve mágica en una experiencia cooperativa que rompe los géneros.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 88, 12, '2021-03-26', '2023-01-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Hazelight Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'KR');

-- 30. Deathloop
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1252330, 'Deathloop', 
'Rompe el bucle temporal en este shooter de nueva generación de Arkane Studios.', 
'En Deathloop, dos asesinos rivales están atrapados en un bucle temporal misterioso en la isla de Blackreef, condenados a repetir el mismo día por toda la eternidad. Como Colt, la única posibilidad de escapar es terminar con el bucle asesinando a ocho objetivos clave antes de que el día se reinicie.\n\nAprende de cada ciclo: prueba nuevos caminos, reúne información y encuentra nuevas armas y habilidades. Haz lo que sea necesario para romper el bucle. Por otro lado, tienes a Julianna, cuya única misión es proteger el bucle eliminando a Colt. Si quieres, puedes elegir jugar como Julianna e invadir la partida de otro jugador para un tenso juego del gato y el ratón.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1252330/logo.png', 87, 18, '2021-09-14', '2022-04-18', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Arkane Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'PL');

-- 31. Alan Wake 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2149300, 'Alan Wake 2', 
'Un horror psicológico intenso donde la realidad y la ficción se entrelazan de forma aterradora.', 
'Una serie de asesinatos rituales amenaza Bright Falls, una pequeña comunidad rodeada por la naturaleza del noroeste del Pacífico. Saga Anderson, una reputada agente del FBI, llega para investigar. Mientras tanto, Alan Wake, un escritor atrapado en una pesadilla más allá de nuestro mundo, escribe una historia oscura para intentar moldear la realidad y escapar de su prisión.\n\nJuega como Anderson y Wake, y observa cómo se desarrolla la historia desde dos perspectivas diferentes y perturbadoras. Alterna entre la lucha por la supervivencia de Anderson y los intentos desesperados de Wake por reescribir su destino. Explora dos mundos hermosos pero terroríficos y enfréntate a enemigos sobrenaturales con recursos limitados en esta obra maestra del survival horror cinematográfico.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2149300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2149300/logo.png', 89, 18, '2023-10-27', '2024-03-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Remedy Entertainment'), (SELECT id FROM distribuidores WHERE nombre = 'Epic Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'RU'), (@j_id, 'PL');

-- 32. Control Ultimate Edition
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (870780, 'Control Ultimate Edition', 
'Domina habilidades sobrenaturales en este thriller de acción en tercera persona de Remedy.', 
'Tras una invasión de una agencia secreta en Nueva York por parte de una amenaza de otro mundo, te conviertes en la nueva directora que lucha por recuperar el Control. Esta edición definitiva incluye el juego principal y todas las expansiones publicadas, ofreciendo la experiencia completa de la lucha de Jesse Faden por respuestas.\n\nExplora la Casa Antigua, un edificio en constante cambio donde las leyes de la física no se aplican. Utiliza un arsenal de armas transformables y poderes telequinéticos para enfrentarte a los enemigos conocidos como el Hiss. Con una atmósfera brutalista y una narrativa llena de misterios inexplicables, Control es un viaje visual y jugable que te mantendrá al borde del asiento mientras descubres los secretos de la Oficina Federal de Control.', 
'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/870780/logo.png', 85, 16, '2020-08-27', '2022-09-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Remedy Entertainment'), (SELECT id FROM distribuidores WHERE nombre = '505 Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 33. Sifu
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2138710, 'Sifu', 
'La venganza requiere toda una vida de entrenamiento en este beat \'em up de kung-fu.', 
'Sifu cuenta la historia de un joven estudiante de kung-fu en busca de venganza contra los asesinos de su familia. Uno contra todos, no tiene aliados y cuenta con innumerables enemigos. Deberá confiar en su dominio único del Pak Mei Kung Fu para prevalecer y preservar el legado de su familia.\n\nLa caza de tus enemigos te llevará por los rincones ocultos de la ciudad, desde suburbios plagados de bandas hasta los pasillos gélidos de torres corporativas. Tienes un día y un sinfín de enemigos en tu camino. El tiempo será el precio a pagar: cada vez que mueras, resucitarás gracias a un colgante mágico, pero envejecerás en el proceso. ¿Lograrás completar tu venganza antes de que el tiempo se agote por completo?', 
'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2138710/logo.png', 81, 16, '2023-03-28', '2023-06-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Sloclap'), (SELECT id FROM desarrolladores WHERE nombre = 'Sloclap'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'KO'), (@j_id, 'PT'), (@j_id, 'RU');

-- 34. Dead Space (2023)
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1693980, 'Dead Space', 
'El clásico de terror y supervivencia de ciencia ficción regresa reconstruido desde cero.', 
'Isaac Clarke es un ingeniero cualquiera en una misión para reparar la USG Ishimura, una inmensa nave de minería planetaria. Sin embargo, una vez a bordo, descubre que algo ha salido terriblemente mal: la tripulación de la nave ha sido asesinada y la querida compañera de Isaac, Nicole, se ha perdido en algún lugar de la nave.\n\nAhora, solo y armado únicamente con sus herramientas y habilidades de ingeniería, Isaac corre para descubrir el misterio de lo que sucedió a bordo de la Ishimura con la esperanza de encontrar a Nicole. Atrapado con criaturas hostiles llamadas necromorfos, Isaac se enfrenta a una batalla por la supervivencia, no solo contra los horrores crecientes de la nave, sino también contra su propia cordura que se desmorona.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1693980/logo.png', 89, 18, '2023-01-27', '2024-02-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Motive'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 35. Hi-Fi RUSH
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1817230, 'Hi-Fi RUSH', 
'Siente el ritmo mientras Chai y su equipo luchan contra un malvado megaconglomerado.', 
'Siente el ritmo en la piel con Hi-Fi RUSH, un juego de acción único donde los personajes, el mundo y el combate se sincronizan con la música. Juegas como Chai, un aspirante a estrella de rock etiquetado como "defecto" tras un experimento corporativo que fusionó por error un reproductor de música a su corazón.\n\nLucha a través de departamentos de una corporación despiadada en combates rítmicos donde tus ataques son más potentes si sigues el compás. No es solo un juego de acción; es un vídeo musical interactivo con una estética de cómic vibrante y una banda sonora licenciada increíble. Únete a un grupo de aliados pintorescos y demuestra que tienes lo necesario para derrotar a los jefes corporativos en este éxito sorpresa de Tango Gameworks.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/logo.png', 87, 12, '2023-01-25', '2023-12-25', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Tango Gameworks'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL');

-- 36. Resident Evil Village
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1196590, 'Resident Evil Village', 
'Vive el horror de supervivencia como nunca antes en la octava entrega de Resident Evil.', 
'Ambientada unos años después de los escalofriantes sucesos del aclamado Resident Evil 7 Biohazard, esta nueva historia comienza con Ethan Winters y su esposa Mia viviendo pacíficamente en un lugar nuevo, libres de sus pesadillas pasadas. Sin embargo, justo cuando están construyendo su nueva vida juntos, la tragedia les golpea de nuevo.\n\nEthan deberá adentrarse en un pueblo remoto y nevado dominado por cuatro jerarcas y su líder, la misteriosa Madre Miranda. Te enfrentarás a enemigos únicos como las hijas de Lady Dimitrescu y licántropos feroces en una lucha desesperada por rescatar a su hija secuestrada. El juego combina la acción intensa con el horror de supervivencia clásico, todo potenciado por el RE Engine para ofrecer un realismo visual impactante.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1196590/logo.png', 84, 18, '2021-05-07', '2022-03-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 37. DOOM Eternal
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (782330, 'DOOM Eternal', 
'Los ejércitos del infierno han invadido la Tierra. Conviértete en el Slayer y arrasa con todo.', 
'Experimenta la combinación definitiva de velocidad y potencia en DOOM Eternal, la próxima evolución del combate en primera persona. Como el DOOM Slayer, regresas a la Tierra para encontrarla invadida por fuerzas demoníacas. Tu misión: arrasar con el infierno y descubrir los orígenes del Slayer y su eterna lucha.\n\nEquipado con un lanzallamas montado en el hombro, una hoja de muñeca retráctil y una amplia gama de armas mejoradas, eres más rápido y letal que nunca. Domina el "combate de recursos" donde necesitas ejecutar gloriosamente a los enemigos para recuperar salud, incinerarlos para obtener armadura y cortarlos con la motosierra para conseguir munición. Es una danza de destrucción frenética con una banda sonora de metal industrial que te mantendrá en tensión constante.', 
'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/logo.png', 88, 18, '2020-03-20', '2023-11-28', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'id Software'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL'), (@j_id, 'ZH');

-- 38. A Way Out
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1222700, 'A Way Out', 
'Una aventura cooperativa exclusiva donde juegas el papel de uno de los dos prisioneros.', 
'De los creadores de Brothers: A Tale of Two Sons llega A Way Out, una aventura exclusivamente cooperativa en la que encarnas a uno de los dos prisioneros, Leo y Vincent, en su audaz huida de la cárcel. Lo que comienza como una fuga cargada de adrenalina se convierte rápidamente en una historia emocional e impredecible.\n\nA Way Out se debe jugar con dos personas, ya sea en el sofá o en línea. Cada jugador controla a uno de los protagonistas, trabajando juntos para superar obstáculos y avanzar en la trama. Desde persecuciones en coche hasta momentos de sigilo y tiroteos, el juego ofrece una variedad de mecánicas que requieren una comunicación constante entre los jugadores para tener éxito en su camino hacia la libertad y la redención.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1222700/logo.png', 78, 18, '2018-03-23', '2022-07-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Hazelight Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU');

-- 39. Half-Life: Alyx
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (546560, 'Half-Life: Alyx', 
'El regreso de Valve a la serie Half-Life en una experiencia de realidad virtual completa.', 
'Half-Life: Alyx es el regreso en VR de Valve a la serie Half-Life. Es la historia de una lucha imposible contra una raza alienígena cruel conocida como la Alianza, situada entre los eventos de Half-Life y Half-Life 2. Jugando como Alyx Vance, eres la única oportunidad de supervivencia de la humanidad.\n\nDesde que perdiste la batalla de la Ciudad 17, has estado trabajando en la resistencia, realizando investigaciones críticas y fabricando herramientas invaluables para los pocos humanos lo suficientemente valientes como para enfrentarse a la Alianza. El juego redefine lo que es posible en la realidad virtual, ofreciendo interacciones ambientales profundas, resolución de acertijos y combates viscerales en un mundo increíblemente detallado.', 
'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/logo.png', 93, 18, '2020-03-23', '2024-05-19', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Valve'), (SELECT id FROM desarrolladores WHERE nombre = 'Valve'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 40. Dying Light 2 Stay Human
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (534380, 'Dying Light 2 Stay Human', 
'La humanidad está perdiendo la batalla contra el virus. Sobrevive en un mundo abierto brutal.', 
'Hace más de veinte años, en Harran, luchamos contra el virus... y perdimos. Ahora, estamos perdiendo de nuevo. La Ciudad, uno de los últimos asentamientos humanos importantes, está desgarrada por los conflictos. Eres un nómada con el poder de cambiar el destino de La Ciudad, pero tus habilidades tienen un precio: recuerdos que no puedes descifrar.\n\nUtiliza tus habilidades de parkour para recorrer el mundo abierto y domina el combate creativo para sobrevivir a las facciones humanas y a los infectados que acechan en las sombras. El ciclo de día y noche cambia drásticamente el juego: durante el día, los humanos gobiernan las calles; por la noche, los infectados salen de sus nidos. Tus decisiones tendrán consecuencias reales en el paisaje y en el equilibrio de poder en la ciudad.', 
'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/534380/logo.png', 77, 18, '2022-02-04', '2025-01-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Techland'), (SELECT id FROM desarrolladores WHERE nombre = 'Techland'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'PL'), (@j_id, 'ZH');

-- 41. Portal 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (620, 'Portal 2', 
'La secuela del aclamado juego de puzles con portales, humor negro y una narrativa única.', 
'Portal 2 retoma la fórmula ganadora de una jugabilidad innovadora, una historia cautivadora y una música creativa que le valieron al Portal original más de 70 galardones. Regresa a los laboratorios de Aperture Science para enfrentarte una vez más a GLaDOS, la inteligencia artificial letalmente ingeniosa. Esta vez no estarás solo; te acompaña Wheatley, una personalidad robótica con más entusiasmo que sentido común.\n\nEl juego expande los horizontes con nuevos personajes, puzles más complejos y una campaña cooperativa independiente con su propia historia y personajes. Utiliza geles propulsores, puentes de luz sólida y, por supuesto, tu fiel pistola de portales para navegar por instalaciones en ruinas en una de las experiencias narrativas más divertidas y brillantes de la historia de los videojuegos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/620/logo.png', 95, 12, '2011-04-18', '2023-04-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Valve'), (SELECT id FROM desarrolladores WHERE nombre = 'Valve'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 42. Mass Effect Legendary Edition
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1328670, 'Mass Effect Legendary Edition', 
'Vive la leyenda de Shepard en la trilogía de Mass Effect remasterizada.', 
'Solo una persona se interpone entre la humanidad y la mayor amenaza a la que se haya enfrentado jamás. Revive la saga de Shepard en la aclamada trilogía Mass Effect con Mass Effect Legendary Edition. Incluye el contenido básico para un jugador y más de 40 contenidos descargables de los tres juegos, además de armas, armaduras y paquetes promocionales, todo remasterizado y optimizado para 4K Ultra HD.\n\nTus decisiones tienen consecuencias que se propagan de un juego a otro. Cada elección que hagas determinará el resultado de cada misión, cada relación y cada batalla, e incluso el destino de la propia galaxia. Personaliza a tu comandante Shepard y lidera a tu pelotón de élite a través de un universo lleno de razas alienígenas complejas y peligros ancestrales en esta epopeya de ciencia ficción sin igual.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1328670/logo.png', 86, 18, '2021-05-14', '2022-11-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'BioWare'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PL'), (@j_id, 'RU'), (@j_id, 'JP');

-- 43. Sea of Thieves
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1172620, 'Sea of Thieves', 
'Navega, lucha, explora y saquea en esta experiencia pirata definitiva.', 
'Sea of Thieves te ofrece la experiencia de pirata definitiva, desde la navegación y el combate hasta la exploración y el saqueo: todo lo necesario para vivir la vida de pirata y convertirte en una leyenda por derecho propio. Sin roles establecidos, tienes total libertad para enfrentarte al mundo y a otros jugadores como quieras.\n\nYa sea que navegues en grupo o en solitario, te encontrarás con otras tripulaciones en este mundo compartido, pero ¿serán amigos o enemigos? Explora un vasto mundo abierto lleno de islas vírgenes, barcos hundidos y artefactos misteriosos. Emprende travesías para las compañías comerciales, lucha contra esqueletos malditos y enfréntate a criaturas marinas legendarias como el Megalodón o el Kraken en un juego que evoluciona constantemente con nuevas actualizaciones.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1172620/logo.png', 82, 12, '2020-06-03', '2024-02-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Rare'), (SELECT id FROM distribuidores WHERE nombre = 'Microsoft Store'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 44. Assassin's Creed Valhalla
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2208920, 'Assassin\'s Creed Valhalla', 
'Conviértete en Eivor, una leyenda vikinga en busca de gloria en la Inglaterra medieval.', 
'Escribe tu propia saga vikinga en Assassin\'s Creed Valhalla. Ponte en la piel de Eivor, una fiera leyenda entre los vikingos, y lidera a tu clan desde las gélidas y misteriosas costas de Noruega hasta los exuberantes campos de las ricas tierras de la Inglaterra del siglo IX. Tu misión es fundar un nuevo asentamiento y conquistar una tierra hostil para ganarte un lugar en el Valhalla.\n\nExplora un mundo abierto dinámico y hermoso mientras te enfrentas a enemigos brutales, saqueas fortalezas sajonas y construyes tu influencia política. Cada decisión que tomes, desde alianzas militares hasta opciones de diálogo, alterará el futuro de tu asentamiento y de tu pueblo. El sistema de combate visceral te permite luchar con dos armas a la vez, capturando la esencia del estilo de lucha vikingo en una épica historia de conquista y destino.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2208920/logo.png', 82, 18, '2022-12-06', '2023-08-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Montreal'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 45. Hades
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1145360, 'Hades', 
'Desafía al dios de los muertos y ábrete paso a través del Inframundo en este roguelike.', 
'Hades es un juego de mazmorras de tipo roguelike que combina lo mejor de los aclamados títulos de Supergiant Games: la acción trepidante de Bastion, la atmósfera y profundidad de Transistor y la narrativa centrada en los personajes de Pyre. Como el príncipe inmortal del Inframundo, usarás los poderes y las armas míticas del Olimpo para liberarte de las garras del mismísimo dios de los muertos.\n\nCada intento de fuga es único, gracias a un sistema de bendiciones de los dioses olímpicos que te otorga mejoras temporales. Hazte amigo de dioses, fantasmas y monstruos mientras descubres la historia de una familia disfuncional a lo largo de miles de líneas de diálogo con doblaje profesional. Con una dirección artística espectacular y un sistema de combate adictivo, Hades redefine la forma en que se cuenta una historia en el género roguelike.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145360/logo.png', 93, 12, '2020-09-17', '2025-01-02', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Supergiant Games'), (SELECT id FROM desarrolladores WHERE nombre = 'Supergiant Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 46. Sekiro: Shadows Die Twice
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (814380, 'Sekiro: Shadows Die Twice', 
'Traza tu propio camino hacia la venganza en esta aventura de acción de FromSoftware.', 
'En Sekiro: Shadows Die Twice encarnas al "lobo manco", un guerrero desfigurado y repudiado que ha sido rescatado al borde de la muerte. Tras jurar proteger a un joven señor descendiente de un linaje antiguo, te conviertes en el objetivo de muchos enemigos despiadados, incluido el peligroso clan Ashina. Cuando el joven señor es capturado, nada te detendrá en tu aventura para recuperar tu honor, ni siquiera la muerte.\n\nExplora el Japón de la era Sengoku de finales del siglo XVI, un periodo brutal de constante conflicto a vida o muerte. Enfréntate a enemigos imponentes en combates de precisión donde el sistema de postura y desvío es vital. Utiliza una variedad de herramientas protésicas letales y habilidades ninja para combinar el sigilo, la exploración vertical y el combate visceral en una historia de traición y redención.', 
'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/logo.png', 88, 18, '2019-03-22', '2023-05-19', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'FromSoftware'), (SELECT id FROM distribuidores WHERE nombre = 'Activision'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 47. Hollow Knight
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (367520, 'Hollow Knight', 
'Forja tu propio camino en Hollow Knight, una aventura de acción épica a través de un reino en ruinas.', 
'Bajo la ciudad de Dirtmouth, en ruinas, duerme un antiguo reino olvidado. Muchos se ven atraídos bajo la superficie en busca de riquezas, gloria o respuestas a secretos ancestrales. Como un enigmático caballero, explorarás las cavernas retorcidas, lucharás contra criaturas corrompidas y entablarás amistad con bichos extraños en este metroidvania en 2D dibujado a mano.\n\nHollow Knight ofrece un mundo vasto e interconectado donde cada decisión de exploración cuenta. Adquiere nuevas habilidades poderosas para mejorar tus hechizos y movimientos. Equípate con amuletos, antiguas reliquias que ofrecen diversos poderes y habilidades, para adaptar tu estilo de juego a los desafiantes combates contra jefes y descubrir la trágica historia del reino de Hallownest.', 
'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/367520/logo.png', 87, 7, '2017-02-24', '2022-09-02', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Team Cherry'), (SELECT id FROM desarrolladores WHERE nombre = 'Team Cherry'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 48. Ori and the Will of the Wisps
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1057090, 'Ori and the Will of the Wisps', 
'Embárcate en una nueva aventura en un mundo vasto y exótico lleno de puzles y enemigos.', 
'El pequeño espíritu Ori no es ajeno al peligro, pero cuando un vuelo fatídico pone al búho Ku en peligro, hará falta algo más que valor para reunir a una familia, curar una tierra quebrantada y descubrir el verdadero destino de Ori. Esta esperada secuela del aclamado Ori and the Blind Forest ofrece una experiencia de plataformas y acción con un apartado visual deslumbrante.\n\nNavega por un entorno de una belleza sobrecogedora mientras dominas nuevas habilidades espirituales, armas y ataques. El sistema de combate ha sido completamente rediseñado, ofreciendo más profundidad y personalización a través de los fragmentos espirituales. Con una banda sonora orquestal conmovedora y una narrativa emocional, es una obra maestra del género que te llevará a través de paisajes inolvidables.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1057090/logo.png', 88, 7, '2020-03-11', '2024-01-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Moon Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Xbox Game Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 49. Resident Evil 2 (2019)
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (883710, 'Resident Evil 2', 
'Una obra maestra que redefine el género regresa completamente reconstruida.', 
'Publicado originalmente en 1998, Resident Evil 2, uno de los juegos más icónicos de todos los tiempos, regresa completamente reinventado para las consolas de nueva generación. Juega las campañas individuales tanto para Leon S. Kennedy como para Claire Redfield con una nueva vista en tercera persona mientras exploras las áreas infestadas de zombis de Raccoon City, ahora recreadas con el motor RE Engine de Capcom.\n\nLos nuevos puzles, historias y áreas significan que tanto los nuevos fans como los veteranos encontrarán sorpresas aterradoras esperándoles. La atmósfera es más agobiante que nunca, con un diseño de sonido envolvente y una gestión de recursos tensa que te obliga a decidir cuándo luchar y cuándo huir del imparable Mr. X. La supervivencia es más difícil que nunca en este clásico del horror moderno.', 
'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/883710/logo.png', 89, 18, '2019-01-25', '2022-11-30', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 50. Resident Evil 3 (2020)
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (952060, 'Resident Evil 3', 
'Jill Valentine es una de las pocas personas que quedan en Raccoon City que han presenciado las atrocidades de Umbrella.', 
'Jill Valentine es una de las pocas supervivientes de Raccoon City que ha sido testigo de los experimentos de Umbrella. Para detenerla, Umbrella lanza su arma secreta definitiva: ¡Nemesis! Jugando como Jill, debes navegar por las caóticas calles de la ciudad, ahora bajo un brote zombi, mientras eres perseguida por una criatura inteligente y letal que no se detendrá ante nada.\n\nEsta recreación del clásico de 1999 utiliza el RE Engine para ofrecer gráficos fotorrealistas y un sistema de combate de acción intensa. Acompaña a Jill y al mercenario Carlos Oliveira mientras intentan encontrar una salida de una ciudad condenada a la destrucción total. Experimenta la huida desesperada de Jill en una narrativa cinematográfica que expande los eventos que rodearon la caída de Raccoon City.', 
'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/952060/logo.png', 77, 18, '2020-04-03', '2023-03-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 51. Civilization VI
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (289070, 'Civilization VI', 
'Construye un imperio que resista el paso del tiempo en este galardonado juego de estrategia.', 
'Civilization VI ofrece nuevas formas de interactuar con tu mundo: las ciudades ahora se expanden físicamente por el mapa, la investigación activa en tecnología y cultura desbloquea nuevos potenciales, y los líderes rivales perseguirán sus propias agendas basadas en sus rasgos históricos mientras compites por una de las cinco formas de lograr la victoria.\n\nDesde la Edad de Piedra hasta la Era de la Información, deberás gestionar tus recursos, establecer rutas comerciales y dirigir a tu ejército en un tablero global donde cada turno cuenta. La expansión de las ciudades permite una planificación estratégica más profunda, aprovechando el terreno local para bonificaciones de distrito. Conviértete en el gobernante del mundo estableciendo y liderando una civilización a lo largo de los milenios.', 
'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/289070/logo.png', 88, 12, '2016-10-21', '2022-04-18', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Firaxis Games'), (SELECT id FROM distribuidores WHERE nombre = '2K Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 52. Final Fantasy VII Remake Intergrade
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1462040, 'Final Fantasy VII Remake Intergrade', 
'La espectacular reinvención del clásico de Square Enix llega con contenido expandido.', 
'Cloud Strife, un antiguo soldado de élite, llega a la ciudad de Midgar para ayudar al grupo de resistencia Avalancha en su lucha contra la corporación Shinra, que está drenando la energía vital del planeta. Este remake no solo actualiza los gráficos a un nivel asombroso, sino que reimagina la historia original dándole una profundidad narrativa y un sistema de combate que mezcla la acción en tiempo real con comandos estratégicos.\n\nEsta edición Intergrade incluye el nuevo episodio protagonizado por Yuffie Kisaragi, aportando una nueva perspectiva a la trama. Explora los suburbios de Midgar, forja vínculos con personajes inolvidables como Aeris y Tifa, y enfréntate a un destino que parece estar escrito en las estrellas. Es una obra maestra visual y sonora que respeta el legado del juego de 1997 mientras construye algo totalmente nuevo y emocionante.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1462040/logo.png', 89, 16, '2022-06-17', '2024-11-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Square Enix'), (SELECT id FROM distribuidores WHERE nombre = 'Square Enix'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 53. Crash Bandicoot 4: It\'s About Time
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1378990, 'Crash Bandicoot 4: It\'s About Time', 
'Crash y Coco regresan en una aventura que salta a través del tiempo y el espacio.', 
'Neo Cortex y N. Tropy han vuelto a las andadas y esta vez no solo planean conquistar el mundo, ¡sino todo el multiverso! Crash y Coco están aquí para salvar el día reuniendo las cuatro máscaras cuánticas y trastocando las leyes de la realidad. Esta entrega recupera la jugabilidad de plataformas clásica de la trilogía original pero con mecánicas modernas y un estilo visual vibrante.\n\nDescubre nuevas habilidades con las máscaras cuánticas, juega como diferentes personajes incluyendo al villano Dingodile o a Tawna, y enfréntate a niveles que pondrán a prueba tus reflejos. Con mundos inmensos y un diseño de niveles ingenioso, esta cuarta entrega numerada es la secuela que los fans esperaban desde hace décadas, manteniendo el humor y la dificultad característica de la saga.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1378990/logo.png', 85, 7, '2022-10-18', '2023-01-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Toys for Bob'), (SELECT id FROM distribuidores WHERE nombre = 'Activision'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 54. Spyro Reignited Trilogy
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (996580, 'Spyro Reignited Trilogy', 
'El maestro de las llamaradas ha vuelto. Disfruta de los tres juegos originales remasterizados.', 
'Spyro el Dragón ha regresado con un aspecto increíble en Spyro Reignited Trilogy. Revive la magia de Spyro the Dragon, Spyro 2: Ripto\'s Rage! y Spyro: Year of the Dragon, todos completamente recreados con un nivel de detalle asombroso. Explora los Reinos del Dragón, conoce a personajes pintorescos y recuerda que no hay aventura demasiado grande para un dragón pequeño con actitud.\n\nRecorre mundos inmensos, enfréntate a jefes memorables y recoge todas las gemas en esta colección definitiva. Cada nivel ha sido reconstruido fielmente basándose en los diseños originales, pero con una dirección artística moderna que llena de vida cada pradera y castillo. Es la forma perfecta de que los nuevos jugadores descubran a un icono de los videojuegos y para que los veteranos revivan su infancia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/logo.png', 82, 7, '2019-09-03', '2022-06-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Toys for Bob'), (SELECT id FROM distribuidores WHERE nombre = 'Activision'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 55. Age of Empires IV: Anniversary Edition
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1466860, 'Age of Empires IV', 
'Celebra el regreso de la legendaria saga de estrategia en tiempo real.', 
'Age of Empires IV te sitúa en el centro de batallas históricas épicas que moldearon el mundo. Combinando formas familiares pero innovadoras de expandir tu imperio en vastos paisajes con una fidelidad visual 4K impresionante, el juego lleva la estrategia en tiempo real a una nueva generación. Elige tu camino hacia la grandeza con civilizaciones diversas, desde los ingleses y los chinos hasta el Sultanato de Delhi.\n\nVive la historia a través de cuatro campañas distintas con 35 misiones que abarcan 500 años de historia, desde la Edad Oscura hasta el Renacimiento. Domina el arte de la guerra con mecánicas de asedio detalladas y unidades únicas para cada facción. La Edición Aniversario incluye contenido nuevo, civilizaciones adicionales y desafíos que amplían la experiencia de juego tanto para veteranos como para nuevos reclutas de la estrategia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1466860/logo.png', 81, 12, '2021-10-28', '2025-01-04', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Relic Entertainment'), (SELECT id FROM distribuidores WHERE nombre = 'Xbox Game Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 56. Street Fighter 6
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1364780, 'Street Fighter 6', 
'El nuevo estandarte de la lucha de Capcom llega con un estilo urbano rompedor.', 
'Impulsado por el motor RE ENGINE de Capcom, Street Fighter 6 ofrece una experiencia de lucha completa a través de tres modos de juego distintos: Fighting Ground, World Tour y Battle Hub. Con un sistema de combate renovado que introduce la mecánica "Drive System", el juego permite una creatividad sin precedentes en la ejecución de combos y estrategias defensivas.\n\nEmbárcate en el World Tour, un modo historia inmersivo para un solo jugador donde podrás crear tu propio avatar y explorar Metro City para aprender técnicas de los maestros legendarios. El Battle Hub ofrece un espacio social para que los jugadores se reúnan, compitan y demuestren sus habilidades. Con un elenco que mezcla rostros clásicos como Ryu y Chun-Li con nuevos contendientes vibrantes, es la evolución definitiva de la saga de lucha más icónica.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/logo.png', 92, 12, '2023-06-02', '2023-09-21', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 57. Immortals Fenyx Rising
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1341050, 'Immortals Fenyx Rising', 
'Vive una gran aventura mitológica como Fenyx, un nuevo semidiós alado.', 
'En Immortals Fenyx Rising, eres la última esperanza de los dioses griegos. Embárcate en una misión para salvarlos de Tifón, el titán más peligroso de la mitología, que ha maldecido a las deidades y ha sumido su mundo en el caos. Explora un mundo abierto vibrante y estilizado dividido en regiones inspiradas en los diferentes dioses, cada una llena de puzles, ruinas y secretos.\n\nUtiliza los poderes de los dioses, como las alas de Dédalo o la espada de Aquiles, para enfrentarte a criaturas mitológicas legendarias como cíclopes, medusas y minotauros en combates dinámicos tanto en tierra como en el aire. La narrativa, guiada por las constantes discusiones humorísticas entre Zeus y Prometeo, ofrece un tono ligero y épico a partes iguales, haciendo de esta aventura una experiencia fresca y accesible para todos los públicos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1341050/logo.png', 79, 12, '2020-12-03', '2022-05-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Quebec'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'JP');

-- 58. Tom Clancy\'s Rainbow Six Siege
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (359550, 'Tom Clancy\'s Rainbow Six Siege', 
'Domina el arte de la destrucción y los dispositivos en este shooter táctico de élite.', 
'Rainbow Six Siege es un shooter táctico realista por equipos donde la planificación y la ejecución precisas son la clave de la victoria. Enfréntate en combates de corto alcance en entornos altamente destructibles, donde cada pared reforzada o suelo de madera puede convertirse en un punto de entrada o una trampa mortal.\n\nElige entre una lista en constante crecimiento de agentes de fuerzas especiales de todo el mundo, cada uno con dispositivos y habilidades únicas. Como atacante, utiliza drones y cargas de demolición para asaltar el objetivo; como defensor, utiliza barricadas y sistemas de vigilancia para proteger tu posición. La comunicación con tu equipo y el uso inteligente del entorno hacen que cada ronda sea una experiencia de alta tensión donde la estrategia pesa más que los reflejos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/359550/logo.png', 79, 18, '2015-12-01', '2024-02-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Montreal'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'JP'), (@j_id, 'KR');

-- 59. Mirror's Edge
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (17410, 'Mirror\'s Edge', 
'En una ciudad donde la información se vigila de cerca, los corredores ágiles llamados Runners transportan datos sensibles.', 
'Mirror\'s Edge redefine el género de acción y aventuras con un enfoque revolucionario en el movimiento en primera persona y el combate. En una sociedad totalitaria donde la comunicación está monitorizada, eres Faith, una "Runner" que entrega mensajes privados evitando la vigilancia gubernamental. Cuando tu hermana es acusada de un crimen que no cometió, debes recorrer los deslumbrantes rascacielos de la ciudad para encontrar la verdad.\n\nExperimenta una sensación de inmersión sin precedentes combinando fluidez de movimiento, saltos vertiginosos y combates cuerpo a cuerpo. La estética minimalista, dominada por blancos puros y colores primarios vibrantes, no solo es un sello artístico, sino que guía tu camino a través del flujo. No es solo un juego de plataformas; es una prueba de reflejos y agilidad donde el entorno es tu mejor aliado para escapar de las fuerzas opresoras.', 
'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/17410/logo.png', 81, 16, '2009-01-13', '2023-11-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'DICE'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP');

-- 60. GRIS
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (682990, 'GRIS', 
'Una experiencia serena y evocadora sobre el dolor y la superación personal.', 
'Gris es una joven llena de esperanza que se ha perdido en su propio mundo debido a una experiencia dolorosa en su vida. Su viaje a través de la tristeza se manifiesta en su vestido, que le otorga nuevas habilidades para navegar por su realidad difuminada. A medida que la historia se desarrolla, Gris crece emocionalmente y aprende a ver su mundo de una manera diferente, desbloqueando nuevos caminos y colores.\n\nCon un apartado artístico espectacular que parece una acuarela en movimiento y una banda sonora conmovedora, GRIS es una experiencia de plataformas y puzles ligera, diseñada para ser disfrutada sin peligro ni frustración. Es una obra que utiliza el lenguaje visual y musical para narrar una historia profunda sobre la depresión y la sanación, convirtiéndose en uno de los juegos independientes más laureados de los últimos años por su sensibilidad y belleza.', 
'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/682990/logo.png', 84, 3, '2018-12-13', '2022-08-30', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Nomada Studio'), (SELECT id FROM distribuidores WHERE nombre = 'Devolver Digital'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 61. Alan Wake Remastered
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2904260, 'Alan Wake Remastered', 
'Disfruta de la experiencia completa de Alan Wake con gráficos mejorados.', 
'En este galardonado thriller de acción cinematográfico, el atribulado escritor Alan Wake se embarca en una búsqueda desesperada de su esposa desaparecida, Alice. Tras su misteriosa desaparición en el pueblo de Bright Falls, Alan descubre las páginas de una historia de terror que supuestamente él mismo ha escrito, pero de la que no recuerda nada.\n\nLa historia se vuelve realidad frente a sus ojos cuando una presencia oscura se apodera de los habitantes y del entorno. Armado solo con su linterna y una pistola, Wake debe enfrentarse a las sombras para desentrañar el misterio y no perder la cordura. Esta versión remasterizada ofrece la experiencia completa con efectos visuales renovados en 4K y los dos episodios especiales: "La señal" y "El escritor".', 
'https://cdn.akamai.steamstatic.com/steam/apps/2904260/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2904260/logo.png', 80, 16, '2021-10-05', '2024-03-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Remedy Entertainment'), (SELECT id FROM distribuidores WHERE nombre = 'Epic Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 62. Devil May Cry 5
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (601150, 'Devil May Cry 5', 
'El cazademonios definitivo regresa con estilo en el juego de acción más frenético.', 
'La amenaza del poder demoníaco ha vuelto a poner en peligro el mundo en esta nueva entrega de la mítica saga de acción. La invasión comienza cuando las semillas de un "árbol demoníaco" echan raíces en Red Grave City. Esta incursión infernal atrae la atención del joven cazador de demonios Nero, un aliado de Dante que ahora se encuentra sin su brazo demoníaco.\n\nCon tres personajes jugables diferentes (Nero, Dante y el misterioso V), cada uno con un estilo de combate radicalmente distinto, deberás enfrentarte a hordas de enemigos para llegar a la raíz del problema. Gracias al motor RE Engine, los gráficos alcanzan un nivel de detalle fotorealista que potencia la espectacularidad de los combos y la fluidez de la batalla. Es la culminación del género "hack and slash".', 
'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/601150/logo.png', 89, 18, '2019-03-08', '2023-01-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 63. F1 25
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (3300000, 'F1 25', 
'Domina la nueva era de la velocidad en el videojuego oficial de la Fórmula 1.', 
'F1 25 redefine la simulación de carreras con un motor físico renovado y una integración total con los datos de la temporada actual. Vive la adrenalina de los circuitos más icónicos del mundo con una fidelidad gráfica que borra la línea entre el juego y la realidad. Esta entrega incluye un modo Carrera Profesional expandido, permitiéndote gestionar cada aspecto de tu trayectoria desde la F2 hasta el estrellato mundial.\n\nExperimenta el nuevo sistema de desarrollo de monoplazas, donde tus decisiones técnicas afectan directamente al rendimiento en pista bajo condiciones variables. Con la inclusión de todos los pilotos, escuderías y reglamentaciones actualizadas, F1 25 es la experiencia definitiva para los entusiastas de la competición, ofreciendo además un multijugador competitivo más robusto y eventos en directo sincronizados con el calendario real de la FIA.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2488620/logo.png', 84, 3, '2025-05-30', '2025-06-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Codemasters'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'ZH');

-- 64. Microsoft Flight Simulator
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1250410, 'Microsoft Flight Simulator', 
'Explora el mundo entero con un nivel de detalle asombroso en el simulador definitivo.', 
'Desde avionetas hasta aviones comerciales, vuela aeronaves altamente detalladas y precisas en la nueva generación de Microsoft Flight Simulator. Pon a prueba tus habilidades de pilotaje frente a los desafíos del vuelo nocturno y las condiciones meteorológicas en tiempo real en un mundo dinámico y vivo.\n\nCrea tu propio plan de vuelo a cualquier parte del planeta. El mundo está a tu alcance con más de 37 000 aeropuertos, 2 millones de ciudades y paisajes infinitos. Gracias a los datos satelitales y la computación en la nube de Azure, el juego recrea la Tierra con una precisión fotorrealista. Siéntate en la cabina y experimenta lo que se siente al surcar los cielos en la experiencia de aviación más ambiciosa de la historia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1250410/logo.png', 91, 3, '2020-08-18', '2022-12-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Asobo Studio'), (SELECT id FROM distribuidores WHERE nombre = 'Xbox Game Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP');

-- 65. Frostpunk 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1601580, 'Frostpunk 2', 
'La ciudad no debe caer. Sobrevive al invierno eterno en una sociedad dividida.', 
'Frostpunk 2 lleva el género de supervivencia urbana a un nuevo nivel. Treinta años después de la tormenta de nieve apocalíptica, la Tierra sigue bajo un frío glacial eterno. Como líder de una metrópolis en expansión, ya no solo debes luchar contra el clima, sino contra la propia naturaleza humana. La escasez de carbón ha dado paso a la era del petróleo, pero el progreso trae nuevas tensiones sociales.\n\nGestiona facciones con ideales opuestos, promulga leyes en el consejo y decide el rumbo tecnológico de tu ciudad. El conflicto interno puede ser tan letal como las temperaturas bajo cero. Con una narrativa oscura y decisiones morales de gran peso, Frostpunk 2 te obliga a preguntarte qué estás dispuesto a sacrificar para que la humanidad sobreviva un día más en este infierno blanco.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1601580/logo.png', 86, 16, '2024-09-20', '2024-11-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = '11 bit studios'), (SELECT id FROM desarrolladores WHERE nombre = '11 bit studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 66. Palworld
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1623730, 'Palworld', 
'Sobrevive, construye y lucha junto a misteriosas criaturas llamadas Pals.', 
'Palworld es un juego de supervivencia y recolección de criaturas en un mundo abierto masivo. En este mundo, puedes vivir una vida tranquila junto a criaturas misteriosas conocidas como Pals o lanzarte a combates a vida o muerte contra cazadores furtivos. Los Pals pueden ser usados para luchar, reproducirse, ayudar en la agricultura o trabajar en fábricas.\n\nExplora diversos biomas, desde tundras heladas hasta desiertos abrasadores, y descubre cientos de Pals con habilidades únicas. Construye bases automatizadas, fabrica armas modernas y vuela sobre el lomo de tus compañeros para descubrir los secretos de las islas. La libertad es total: puedes ser un arquitecto pacífico, un explorador intrépido o un magnate industrial en este éxito que ha revolucionado el género de supervivencia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1623730/logo.png', 70, 12, '2024-01-19', '2024-12-28', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Pocketpair'), (SELECT id FROM desarrolladores WHERE nombre = 'Pocketpair'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 67. Star Wars Jedi: Survivor
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1774580, 'Star Wars Jedi: Survivor', 
'La historia de Cal Kestis continúa en esta aventura de acción galáctica.', 
'Star Wars Jedi: Survivor retoma la historia cinco años después de los eventos de Fallen Order. Cal Kestis debe mantenerse un paso por delante de la persecución incansable del Imperio mientras comienza a sentir el peso de ser uno de los últimos Jedi que quedan en la galaxia. Acompañado por su fiel droide BD-1, Cal conocerá a una serie de personajes únicos y formará alianzas en planetas nuevos y conocidos.\n\nDomina nuevas posturas de combate con sable de luz y habilidades de la Fuerza para derrotar a una variedad de enemigos más peligrosos. Explora biomas extensos con secretos ocultos y desafíos de plataformas mejorados. Como Caballero Jedi, deberás decidir hasta dónde estás dispuesto a llegar para proteger a tus seres queridos y preservar el legado de la Orden Jedi en los tiempos más oscuros de la galaxia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1774580/logo.png', 85, 12, '2023-04-28', '2023-10-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Respawn Entertainment'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'PL');

-- 68. Lords of the Fallen
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1501750, 'Lords of the Fallen', 
'Un vasto mundo te espera en este nuevo RPG de acción y fantasía oscura.', 
'Lords of the Fallen presenta una aventura RPG épica y totalmente nueva en un mundo vasto e interconectado, más de cinco veces más grande que el del juego original. Tras una época de la tiranía más cruel, el dios demonio Adyr fue finalmente derrotado. Pero los dioses no caen para siempre, y ahora, eones después, la resurrección de Adyr se aproxima.\n\nViaja a través de los reinos de los vivos y de los muertos como uno de los legendarios Cruzados de la Oscuridad. Domina un sistema de combate táctico, fluido y desafiante, y personaliza a tu personaje con una amplia gama de armas y hechizos. Utiliza tu linterna mágica para cruzar entre dimensiones, resolver acertijos ambientales y arrancar las almas de tus enemigos en esta experiencia visualmente impactante impulsada por Unreal Engine 5.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1501750/logo.png', 75, 18, '2023-10-13', '2024-05-22', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'HEXWORKS'), (SELECT id FROM distribuidores WHERE nombre = 'CI Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 69. Lies of P
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1627720, 'Lies of P', 
'Una versión oscura y elegante de la historia de Pinocho ambientada en la Belle Époque.', 
'Lies of P es un "soulslike" trepidante que toma la conocida historia de Pinocho y le da la vuelta en un escenario lúgubre y asombrosamente elegante. Te despiertas en la ciudad de Krat, un lugar antaño hermoso que ahora es una pesadilla llena de marionetas enloquecidas y una plaga misteriosa. Como una marioneta creada por Geppetto, debes luchar para encontrar a tu creador y comprender qué le ha sucedido a la ciudad.\n\nAdapta tu cuerpo mediante el sistema de "P-Organ" y combina diferentes tipos de armas para crear un arsenal único. En un mundo donde no puedes confiar en nadie, deberás elegir entre decir la verdad o mentir para sobrevivir y convertirte en humano. Con una dirección artística soberbia y combates de una precisión milimétrica, Lies of P ofrece un desafío inolvidable para los amantes del género.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/logo.png', 80, 16, '2023-09-18', '2024-02-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'NEOWIZ'), (SELECT id FROM desarrolladores WHERE nombre = 'NEOWIZ'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 70. Cult of the Lamb
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1313140, 'Cult of the Lamb', 
'Crea tu propia secta en una tierra de falsos profetas y conviértete en el Dios Cordero.', 
'Cult of the Lamb pone a los jugadores en el papel de un cordero poseído, salvado de la aniquilación por un extraño siniestro, y que debe pagar su deuda creando una secta de fieles seguidores en su nombre. Comienza tu propia secta en una tierra de falsos profetas, aventurándote en regiones misteriosas para construir una comunidad leal de adoradores del bosque y difundir tu Palabra para convertirte en la única secta verdadera.\n\nGestiona tus recursos para construir nuevas estructuras, realiza rituales oscuros para apaciguar a los dioses y da sermones para reforzar la fe de tu rebaño. Entrena a tu secta y embárcate en misiones para explorar un mundo generado procedimentalmente, lucha contra hordas de enemigos y derrota a los líderes de sectas rivales para absorber su poder y asegurar el dominio de tu culto.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1313140/logo.png', 82, 12, '2022-08-11', '2024-08-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Massive Monster'), (SELECT id FROM distribuidores WHERE nombre = 'Devolver Digital'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 71. Ghost of Tsushima DIRECTOR'S CUT
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2215430, 'Ghost of Tsushima DIRECTOR\'S CUT', 
'Forja un nuevo camino y libra una guerra poco convencional por la libertad de Tsushima.', 
'A finales del siglo XIII, el imperio mongol ha devastado naciones enteras en su campaña por conquistar el Oriente. La isla de Tsushima es todo lo que se interpone entre el Japón continental y una enorme flota de invasión mongola liderada por el despiadado general Khotun Khan. Mientras la isla arde tras la primera oleada de asalto, el guerrero samurái Jin Sakai emerge como uno de los últimos supervivientes de su clan.\n\nEstá decidido a hacer lo que sea necesario, a cualquier precio, para proteger a su gente y recuperar su hogar. Debe dejar de lado las tradiciones que lo formaron como guerrero para forjar un nuevo camino, el camino del Fantasma, y librar una guerra poco convencional por la libertad de Tsushima. Esta versión para PC incluye la expansión Iki Island y el modo multijugador cooperativo Legends.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2215430/logo.png', 88, 18, '2024-05-16', '2024-11-02', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Sucker Punch Productions'), (SELECT id FROM distribuidores WHERE nombre = 'PlayStation Publishing'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 72. Armored Core VI Fires of Rubicon
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1888160, 'Armored Core VI Fires of Rubicon', 
'Combina la maestría de FromSoftware en juegos de acción con su experiencia en mechas.', 
'En el remoto planeta Rubicón 3 se descubrió una nueva y misteriosa sustancia llamada Coral. Como fuente de energía, se esperaba que esta sustancia hiciera avanzar drásticamente las capacidades tecnológicas y de comunicación de la humanidad. En cambio, provocó una catástrofe que envolvió al planeta y a las estrellas circundantes en llamas y tormentas, formando un sistema estelar ardiente.\n\nCasi medio siglo después, el Coral ha resurgido en Rubicón 3, un planeta ahora contaminado y sellado por la catástrofe. Las corporaciones extraterrestres y los grupos de resistencia luchan por el control de la sustancia. El jugador se infiltra en Rubicón como un mercenario independiente y se encuentra en una lucha por la sustancia con las corporaciones y otras facciones. Pilota tu mecha en batallas vertiginosas y omnidireccionales, aprovechando la movilidad terrestre y aérea para asegurar la victoria.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1888160/logo.png', 86, 12, '2023-08-25', '2024-04-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'FromSoftware'), (SELECT id FROM distribuidores WHERE nombre = 'Bandai Namco Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 73. It Takes Two
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1426210, 'It Takes Two', 
'Embárcate en el viaje más loco de tu vida en esta aventura cooperativa de plataformas.', 
'Ponte en la piel de Cody y May, una pareja enfrentada que se ha convertido en muñecos por un hechizo mágico. Atrapados en un mundo fantástico donde lo impredecible se esconde tras cada esquina, deberán trabajar juntos para salvar su relación y regresar a su forma humana. Bajo la guía del excéntrico Dr. Hakim, el Libro del Amor, se verán envueltos en una gran variedad de desafíos de juego alegremente perturbadores.\n\nCada nivel ofrece habilidades de personaje únicas e interconectadas que requieren una cooperación total. Desde pilotar un calzoncillo volador hasta luchar contra ardillas mafiosas o hacer de DJ en una bola de nieve mágica, It Takes Two rompe los límites de los géneros y ofrece una experiencia puramente cooperativa que mezcla una narrativa emotiva con mecánicas de juego innovadoras y divertidas.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 88, 12, '2021-03-26', '2023-05-18', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Hazelight Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 74. The Callisto Protocol
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1544020, 'The Callisto Protocol', 
'Sobrevive a los horrores de la Prisión de Hierro Negro en la luna muerta de Júpiter.', 
'Ambientado en Calisto, la luna muerta de Júpiter, en el año 2320, The Callisto Protocol desafía a los jugadores a escapar de la Prisión de Hierro Negro y descubrir los oscuros secretos de la United Jupiter Company. Eres Jacob Lee, un prisionero que debe luchar por su vida cuando un brote misterioso transforma a los reclusos en criaturas monstruosas conocidas como biófagos.\n\nEl juego ofrece una mezcla única de combate cuerpo a cuerpo y a distancia, utilizando una herramienta gravitatoria llamada GRP para manipular el entorno y a los enemigos. En una atmósfera de tensión constante y terror visceral, Jacob deberá adaptar sus tácticas y mejorar su equipo para sobrevivir a los horrores que acechan en cada rincón de la prisión mientras su propia sanidad mental se pone a prueba.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1544020/logo.png', 69, 18, '2022-12-02', '2024-01-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Striking Distance Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Krafton'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 75. A Plague Tale: Requiem
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1182900, 'A Plague Tale: Requiem', 
'Embárcate en un viaje desgarrador hacia un mundo asombroso y despiadado.', 
'Tras escapar de su hogar devastado, Amicia y Hugo viajan al sur, hacia nuevas regiones y ciudades vibrantes para intentar comenzar una nueva vida y controlar la maldición de Hugo. Pero, cuando los poderes de Hugo vuelven a despertar, la muerte y la destrucción regresan en forma de una avalancha de ratas devoradoras. Obligados a huir de nuevo, los hermanos depositan sus esperanzas en una isla mística que podría tener la clave para salvar a Hugo.\n\nDescubre el coste de salvar a tus seres queridos en una lucha desesperada por la supervivencia. Ataca desde las sombras o desata un infierno, superando a tus enemigos y desafíos con una variedad de armas, herramientas y poderes sobrenaturales en esta secuela directa del aclamado Innocence, con un apartado técnico de vanguardia que te dejará sin aliento.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1182900/logo.png', 82, 18, '2022-10-18', '2023-11-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Asobo Studio'), (SELECT id FROM distribuidores WHERE nombre = 'Focus Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'PL'), (@j_id, 'KR');

-- 76. Silent Hill 2 (Remake)
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2124490, 'Silent Hill 2', 
'Experimenta una clase magistral de terror psicológico en esta aclamada recreación.', 
'Habiendo recibido una carta de su difunta esposa, James regresa al lugar donde compartieron tantos recuerdos, con la esperanza de verla una vez más: Silent Hill. Allí, junto al lago, encuentra a una mujer que se le parece extrañamente... "Me llamo... Maria", dice la mujer sonriendo. Su rostro, su voz... es igual que ella.\n\nDisfruta de una experiencia de survival horror de vanguardia con gráficos fotorrealistas y un diseño de sonido envolvente gracias al motor Unreal Engine 5. Explora entornos expandidos, enfréntate a monstruos icónicos rediseñados y descubre una narrativa profunda y perturbadora que ha sido recreada fielmente para una nueva generación, manteniendo la atmósfera de niebla y desesperación que hizo del original una obra de culto.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2124490/logo.png', 86, 18, '2024-10-08', '2025-02-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Bloober Team'), (SELECT id FROM distribuidores WHERE nombre = 'Konami'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 77. Need for Speed Unbound
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1849540, 'Need for Speed Unbound', 
'El mundo es tu lienzo. Demuestra que tienes lo necesario para ganar The Grand.', 
'En Need for Speed Unbound, el mundo es tu lienzo. Demuestra que tienes lo necesario para ganar The Grand, el desafío de carreras callejeras definitivo de Lakeshore. A lo largo de cuatro semanas de carreras intensas, gana lo suficiente para participar en las eliminatorias semanales, supera a la competencia y deja tu marca en la escena de las carreras callejeras mientras superas a la policía en astucia.\n\nPersonaliza tu garaje con coches tuneados con precisión y domina las calles con un estilo visual único que mezcla el arte callejero más realista con el grafiti más vibrante. Expresa tu identidad al máximo con nuevas opciones de personalización y una banda sonora que define el género. Compite en campañas separadas para un jugador y multijugador en esta entrega que revitaliza la saga con una estética rompedora y una jugabilidad frenética.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1849540/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1849540/logo.png', 73, 12, '2022-12-02', '2023-08-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Criterion Games'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 78. Manor Lords
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1363080, 'Manor Lords', 
'Un juego de estrategia medieval con construcción de ciudades y batallas tácticas.', 
'Manor Lords es un juego de estrategia medieval que ofrece una construcción de ciudades profunda, batallas tácticas en tiempo real y simulaciones económicas y sociales complejas. Gobierna tus tierras como un señor medieval: las estaciones pasan, el clima cambia y las ciudades surgen y caen según tu gestión. El sistema de construcción es orgánico, sin cuadrículas, permitiendo una expansión natural de las aldeas.\n\nDesde la gestión de las cadenas de suministro hasta el reclutamiento de milicias campesinas para defender tu territorio, cada decisión importa. Enfréntate a señores rivales en combates que tienen en cuenta el cansancio, el equipo y la posición táctica de tus tropas. Manor Lords busca la autenticidad histórica, reflejando fielmente la vida y el conflicto del siglo XIV en una experiencia visualmente impactante y mecánicamente rica.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1363080/logo.png', 82, 12, '2024-04-26', '2025-01-04', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Slavic Magic'), (SELECT id FROM distribuidores WHERE nombre = 'Hooded Horse'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 79. Monster Hunter Rise
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1446780, 'Monster Hunter Rise', 
'Acepta el desafío y únete a la caza en esta nueva entrega de la aclamada serie.', 
'Monster Hunter Rise te transporta a la colorida Aldea Kamura, un lugar que se prepara para el inminente "Frenesí", una catástrofe donde hordas de monstruos atacan a la vez. Como cazador, deberás utilizar nuevas herramientas como el "Cordóptero", que permite una movilidad vertical increíble y ataques especiales con cada una de las 14 armas disponibles, y los "Canyne", compañeros caninos que puedes montar para recorrer el mapa rápidamente.\n\nExplora mapas vastos e interconectados inspirados en el folclore japonés y enfréntate a monstruos nuevos y clásicos. El sistema de juego se centra en la recolección de materiales para fabricar armas y armaduras cada vez más poderosas. Ya sea jugando solo o con amigos en el modo cooperativo, Rise ofrece una experiencia de caza dinámica y accesible sin perder la profundidad táctica que caracteriza a la franquicia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1446780/logo.png', 87, 12, '2022-01-12', '2023-11-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 80. Nioh 2 – The Complete Edition
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1325200, 'Nioh 2', 
'Desata tu oscuridad y domina el poder de los Yokai en esta brutal aventura samurái.', 
'En esta precuela del Nioh original, asumes el papel de un mercenario mitad humano y mitad Yokai en el Japón de la era Sengoku. Nioh 2 perfecciona el sistema de combate de posturas de su predecesor e introduce la capacidad de transformarse en Yokai para desatar ataques devastadores. Derrota a feroces enemigos y recolecta "Núcleos de alma" de los demonios vencidos para utilizar sus propios poderes contra ellos.\n\nLa Edición Completa incluye el juego base y las tres expansiones de contenido descargable, ofreciendo cientos de horas de juego, una enorme variedad de armas y un sistema de personalización de personajes extremadamente detallado. Supera desafíos brutales, domina la gestión del Ki y explora un mundo donde la historia de Japón se mezcla con los mitos más oscuros en uno de los juegos de acción más exigentes y satisfactorios del mercado.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1325200/logo.png', 86, 18, '2021-02-05', '2022-06-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Team NINJA'), (SELECT id FROM distribuidores WHERE nombre = 'Koei Tecmo'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 81. Forza Horizon 5
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1551360, 'Forza Horizon 5', 
'Tu aventura Horizon definitiva te espera. Explora los paisajes vibrantes de México.', 
'Explora los paisajes vibrantes y en constante evolución del mundo abierto de México con una acción de conducción ilimitada y divertida en cientos de los mejores coches del mundo. Sumérgete en una campaña profunda con cientos de desafíos que te recompensan por participar en las actividades que te gustan. Conoce a nuevos personajes y elige el desenlace de sus misiones de Historias de Horizon.\n\nEnfréntate a eventos climáticos impresionantes, como enormes tormentas de polvo y fuertes tormentas tropicales, a medida que las estaciones únicas y dinámicas de México cambian el mundo cada semana. Crea tus propias expresiones de diversión con el nuevo conjunto de herramientas de juego EventLab, que incluye carreras personalizadas, desafíos, acrobacias y modos de juego completamente nuevos. Es la celebración definitiva de la cultura automovilística.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/logo.png', 92, 3, '2021-11-09', '2023-04-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Playground Games'), (SELECT id FROM distribuidores WHERE nombre = 'Xbox Game Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 82. Phasmophobia
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (739630, 'Phasmophobia', 
'Un horror psicológico cooperativo para 4 jugadores donde la investigación es clave.', 
'Phasmophobia es un horror psicológico cooperativo en línea para 4 jugadores. La actividad paranormal está en aumento y depende de ti y de tu equipo utilizar todo el equipo de caza de fantasmas a su disposición para recopilar la mayor cantidad de pruebas posible. Utilizarás cámaras de visión nocturna, termómetros y lectores EMF para identificar qué tipo de entidad está acechando el lugar.\n\nEs una experiencia inmersiva donde el fantasma te escucha a través del micrófono. Debes trabajar en equipo para sobrevivir mientras la cordura de los investigadores disminuye. Con más de 20 tipos de fantasmas diferentes, cada uno con rasgos y habilidades únicas, cada investigación será distinta. ¿Tendrás el valor de entrar en la oscuridad o te quedarás vigilando las cámaras desde el camión?', 
'https://cdn.akamai.steamstatic.com/steam/apps/739630/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/739630/logo.png', 80, 16, '2020-09-18', '2024-02-28', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Kinetic Games'), (SELECT id FROM desarrolladores WHERE nombre = 'Kinetic Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP');

-- 83. Hades II
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1145350, 'Hades II', 
'La primera secuela de Supergiant Games profundiza en la brujería y el Inframundo.', 
'Lucha más allá del Inframundo utilizando brujería oscura para enfrentarte al Titán del Tiempo en esta secuela del aclamado roguelike de exploración de mazmorras. Como Melinoë, la Princesa del Inframundo e hija de Hades, deberás dominar las artes oscuras y el poder del Olimpo para rescatar a tu familia de las garras de Cronos.\n\nEnfréntate a nuevos desafíos con un sistema de combate refinado, conoce a deidades nunca antes vistas y descubre una historia que se entrelaza con la mitología griega de forma magistral. Con una dirección artística soberbia y una jugabilidad adictiva que evoluciona con cada intento, Hades II expande todo lo que hizo grande a su predecesor, ofreciendo una experiencia mágica y desafiante por igual.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1145350/logo.png', 90, 12, '2024-05-06', '2024-12-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Supergiant Games'), (SELECT id FROM desarrolladores WHERE nombre = 'Supergiant Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'PL');

-- 84. Granblue Fantasy: Relink
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (881020, 'Granblue Fantasy: Relink', 
'Forma un grupo de cuatro y ábrete camino hacia la victoria en este RPG de acción.', 
'¡Surca los cielos en Granblue Fantasy: Relink! Forma un grupo de cuatro a partir de un elenco variado de navegantes y corta, dispara o hechiza para derrotar a enemigos traicioneros en este RPG de acción centrado en el combate cooperativo. Embárcate en una aventura a través del Reino del Cielo, un mundo donde las islas flotan en el mar de nubes, y descubre el misterio que rodea a la misteriosa chica Lyria.\n\nDomina sistemas de combate fluidos, personaliza a tus personajes con una profundidad estratégica inmensa y enfréntate a jefes colosales en batallas espectaculares. Ya sea que prefieras jugar solo con aliados controlados por la IA o unirte a otros jugadores en línea, el juego ofrece una experiencia visualmente deslumbrante que captura la esencia del anime con un apartado técnico impecable.', 
'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/881020/logo.png', 80, 12, '2024-02-01', '2024-06-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Cygames'), (SELECT id FROM desarrolladores WHERE nombre = 'Cygames'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 85. Persona 5 Royal
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1687950, 'Persona 5 Royal', 
'Ponte la máscara y únete a los Ladrones de Guante Blanco en el RPG definitivo.', 
'Persona 5 Royal presenta una historia profunda y elegante donde exploras Tokio, desbloqueas Personas, personalizas tu propia Guarida de los Ladrones y descubres un semestre nunca antes visto con un nuevo final. Esta edición definitiva incluye todo el contenido descargable lanzado anteriormente. Alterna entre tu vida escolar y la infiltración en Palacios mentales para cambiar el corazón de los corruptos en esta obra maestra del rol japonés con un estilo visual y sonoro inigualable.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/logo.png', 95, 16, '2022-10-21', '2024-05-30', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'ATLUS'), (SELECT id FROM distribuidores WHERE nombre = 'SEGA'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 86. Black Myth: Wukong
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2358720, 'Black Myth: Wukong', 
'Un RPG de acción basado en la mitología china y la novela Viaje al Oeste.', 
'Black Myth: Wukong es un RPG de acción inspirado en la mitología china. La historia se basa en "Viaje al Oeste", una de las cuatro grandes novelas clásicas de la literatura china. Te embarcarás como el Predestinado para aventurarte en los desafíos y maravillas que te esperan, para descubrir la verdad oscurecida bajo el velo de una gloriosa leyenda del pasado.\n\nComo el Predestinado, te enfrentarás a poderosos enemigos y rivales dignos. Además de dominar diversas técnicas de bastón, podrás combinar libremente diferentes hechizos, habilidades, armas y equipos para encontrar la estrategia que mejor se adapte a tu estilo de combate. Con un apartado visual asombroso impulsado por Unreal Engine 5, cada jefe y entorno cobra vida con un detalle sin precedentes.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2358720/logo.png', 81, 16, '2024-08-20', '2024-11-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Game Science'), (SELECT id FROM desarrolladores WHERE nombre = 'Game Science'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 87. DOOM Eternal
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (782330, 'DOOM Eternal', 
'Los ejércitos del infierno han invadido la Tierra. Eres el único que puede detenerlos.', 
'Experimenta la combinación definitiva de velocidad y potencia en DOOM Eternal, la próxima evolución del combate en primera persona. Como el DOOM Slayer, regresas a la Tierra para encontrar que ha sido invadida por demonios. Arrasa con el infierno y descubre los orígenes del Slayer y su eterna misión de "destrozar y desgarrar" hasta que no quede nada.\n\nCon un arsenal de armas devastadoras y habilidades mejoradas, el combate es más táctico que nunca: quema a tus enemigos para obtener armadura, ejecútalos para conseguir salud y córtalos con la motosierra para obtener munición. La banda sonora compuesta por Mick Gordon eleva la tensión en cada encuentro, convirtiendo cada batalla en una danza de destrucción frenética y satisfactoria.', 
'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/782330/logo.png', 88, 18, '2020-03-20', '2023-02-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'id Software'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 88. Outer Wilds
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (753640, 'Outer Wilds', 
'Un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal.', 
'Outer Wilds es un misterio de mundo abierto sobre un sistema solar atrapado en un bucle temporal infinito. Eres el nuevo recluta de Outer Wilds Ventures, un programa espacial incipiente que busca respuestas en un sistema solar extraño y en constante cambio. ¿Qué acecha en el corazón del peligroso planeta Gigante Gaseoso? ¿Quién construyó las ruinas alienígenas en la Luna? ¿Se puede detener el bucle temporal?\n\nExplora planetas que cambian con el tiempo: visita una ciudad subterránea antes de que sea tragada por la arena, o explora la superficie de un planeta mientras se desmorona bajo tus pies. Utiliza una variedad de herramientas para investigar tu entorno, rastrear señales misteriosas y descifrar antiguos escritos alienígenas para desentrañar el secreto más grande del universo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/753640/logo.png', 85, 7, '2019-05-30', '2024-06-21', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Mobius Digital'), (SELECT id FROM distribuidores WHERE nombre = 'Annapurna Interactive'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 89. Dragon's Dogma 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2054970, 'Dragon\'s Dogma 2', 
'Embárcate en tu gran aventura, Arisen, en este RPG de acción narrativo.', 
'Dragon\'s Dogma 2 es un RPG de acción narrativo que desafía a los jugadores a elegir su propia experiencia: desde la apariencia de su Arisen, su vocación, su grupo, cómo abordar diferentes situaciones y más. En este viaje, te acompañarán los Peones, seres misteriosos de otro mundo, en una aventura tan única que te sentirás como si estuvieras acompañado por otros jugadores en tu propia aventura.\n\nTodo esto se ve potenciado por las físicas, la inteligencia artificial y los gráficos de última generación de Capcom para crear un mundo de fantasía inmersivo y reactivo. Utiliza espadas, arcos y magia para derrotar a monstruos legendarios en combates que requieren ingenio y destreza. En este mundo de destino y dragones, cada decisión que tomes tendrá consecuencias en el desarrollo de tu historia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2054970/logo.png', 86, 18, '2024-03-22', '2024-08-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 90. NieR:Automata
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (524220, 'NieR:Automata', 
'La humanidad ha sido expulsada de la Tierra por formas de vida mecánicas.', 
'NieR:Automata narra la historia de los androides 2B, 9S y A2 y su batalla para recuperar una distopía dirigida por máquinas. La humanidad ha sido expulsada de la Tierra por formas de vida mecánicas de otro mundo. En un último esfuerzo por recuperar el planeta, la resistencia humana envía un ejército de soldados androides para destruir a los invasores. Ahora, la guerra entre las máquinas y los androides continúa... una guerra que pronto podría revelar una verdad del mundo olvidada hace mucho tiempo.\n\nCon un combate fluido que mezcla el estilo "hack and slash" de PlatinumGames con elementos de RPG y una narrativa filosófica profunda escrita por Yoko Taro, NieR:Automata es una experiencia emocional y visualmente única. Explora paisajes desolados pero hermosos y descubre múltiples finales que cambian por completo tu percepción de la historia y sus personajes.', 
'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/524220/logo.png', 88, 18, '2017-03-17', '2022-12-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'PlatinumGames'), (SELECT id FROM distribuidores WHERE nombre = 'Square Enix'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 91. Helldivers 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (553850, 'Helldivers 2', 
'La última línea de defensa de la galaxia. Únete a los Helldivers y lucha por la libertad.', 
'¡Libertad! ¡Paz! ¡Democracia gestionada! Helldivers 2 es un shooter por equipos en tercera persona en el que las fuerzas de élite de los Helldivers luchan para ganar una batalla intergaláctica y librar a la galaxia de las crecientes amenazas alienígenas. Enfréntate a los Terminidios, una plaga de insectos voraces, y a los Autómatas, un ejército de máquinas despiadadas.\n\nTrabaja en equipo con hasta tres amigos para completar misiones peligrosas y utilizar una potencia de fuego devastadora. Desde ataques orbitales hasta torretas defensivas, los Helldivers tienen acceso a lo mejor de la tecnología de la Supertierra. Pero ten cuidado: el fuego amigo siempre está activado, y la victoria requiere una coordinación perfecta y un sacrificio total por la causa de la democracia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/553850/logo.png', 82, 18, '2024-02-08', '2025-01-02', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Arrowhead Game Studios'), (SELECT id FROM distribuidores WHERE nombre = 'PlayStation Publishing'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP'), (@j_id, 'ZH');

-- 92. Disco Elysium - The Final Cut
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (632470, 'Disco Elysium', 
'Un RPG de mundo abierto revolucionario donde tú decides qué tipo de detective ser.', 
'Disco Elysium - The Final Cut es la edición definitiva del innovador juego de rol. Eres un detective con un sistema de habilidades único a tu disposición y toda una manzana de la ciudad para labrarte un camino. Interroga a personajes inolvidables, resuelve casos de asesinato o acepta sobornos. Sé un héroe o un ser humano absolutamente desastroso.\n\nCon un sistema de diálogo sin precedentes, tus propias ideas y pensamientos se convierten en herramientas para interactuar con el mundo de Revachol. Esta versión añade actuación de voz completa para todos los diálogos y nuevas misiones de visión política que profundizan en la ya de por sí rica narrativa filosófica y social del juego. Es una experiencia única donde tus decisiones moldean no solo el caso, sino tu propia cordura.', 
'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/632470/logo.png', 97, 18, '2019-10-15', '2024-03-22', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'ZA/UM'), (SELECT id FROM desarrolladores WHERE nombre = 'ZA/UM'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 93. Warhammer 40,000: Space Marine 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2183900, 'Warhammer 40,000: Space Marine 2', 
'Encarna la brutalidad sobrehumana de un Marine Espacial contra los Tiránidos.', 
'La galaxia está en peligro. Mundos enteros están cayendo. El Imperio te necesita. Encarna la habilidad y brutalidad sobrehumana de un Marine Espacial, el mayor de los guerreros del Emperador. Desata habilidades mortales y un arsenal de armas devastadoras para aniquilar a las implacables hordas tiránidas y a las fuerzas del Caos.\n\nSiente la escala de la guerra en misiones épicas a través de planetas lejanos. Disfruta de una acción intensa y sangrienta en tercera persona, tanto en solitario como en modo cooperativo para 3 jugadores. Gracias al motor de enjambre de Saber Interactive, te enfrentarás a cientos de enemigos en pantalla de forma simultánea, ofreciendo una de las experiencias más viscerales y espectaculares del universo Warhammer 40,000 jamás creadas.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2183900/logo.png', 82, 18, '2024-09-09', '2024-11-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Saber Interactive'), (SELECT id FROM distribuidores WHERE nombre = 'Focus Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP'), (@j_id, 'ZH');

-- 94. BioShock Infinite.
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (8870, 'BioShock Infinite', 
'Lleva a la chica y saldarás tu deuda. Una aventura inolvidable en la ciudad aérea de Columbia.', 
'Corre el año 1912. Booker DeWitt, con una deuda pendiente con la gente equivocada y su vida en peligro, solo tiene una oportunidad para limpiar su nombre: debe rescatar a Elizabeth, una misteriosa chica que lleva encerrada desde su infancia en la ciudad flotante de Columbia.\n\nObligados a confiar el uno en el otro, Booker y Elizabeth forman un vínculo poderoso durante su osada huida. Juntos, aprenderán a dominar un arsenal de armas y habilidades cada vez mayor, mientras luchan en naves aéreas, raíles de alta velocidad y las calles de Columbia, todo ello mientras sobreviven a las amenazas de la ciudad aérea y descubren un secreto oscuro que podría destrozar su mundo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/8870/logo.png', 94, 18, '2013-03-25', '2023-01-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Irrational Games'), (SELECT id FROM distribuidores WHERE nombre = '2K'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU');

-- 95. Hi-Fi RUSH
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1817230, 'Hi-Fi RUSH', 
'Siente el ritmo mientras el aspirante a estrella de rock Chai lucha contra una megacorporación.', 
'Siente el ritmo mientras el aspirante a estrella de rock Chai y su variopinto equipo de aliados se rebelan contra una malvada megacorporación de implantes robóticos en un mundo donde todo se sincroniza con la música. De la mano de Tango Gameworks llega Hi-Fi RUSH, un juego de acción donde el mundo entero se mueve al compás del ritmo.\n\nCombina ataques, esquivas y saltos para crear combos espectaculares que se potencian si sigues el tempo de la banda sonora. Enfréntate a jefes carismáticos en batallas rítmicas épicas y disfruta de una estética "cel-shaded" que parece sacada de un cómic vibrante. Con una banda sonora que incluye temas de Nine Inch Nails y The Black Keys, es una explosión de energía, humor y estilo que reinventa el género de acción.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1817230/logo.png', 89, 12, '2023-01-25', '2023-09-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Tango Gameworks'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'JP'), (@j_id, 'ZH');

-- 96. Cuphead
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (268910, 'Cuphead', 
'Un juego de acción clásico de "dispara y corre" centrado en batallas contra jefes.', 
'Cuphead es un juego de acción clásico de estilo "dispara y corre" que se centra en combates contra jefes finales. Inspirado en las caricaturas de la década de 1930, el apartado visual y sonoro se ha diseñado meticulosamente con las mismas técnicas de la época, es decir, animación tradicional dibujada a mano, fondos de acuarela y grabaciones originales de jazz.\n\nJuega como Cuphead o Mugman (en modo solitario o cooperativo local) y atraviesa mundos extraños, adquiere nuevas armas, aprende poderosos supermovimientos y descubre secretos ocultos mientras intentas saldar tu deuda con el mismísimo diablo. El juego es famoso por su alta dificultad y su diseño artístico inigualable, lo que lo convierte en una pieza de colección para cualquier amante de los videojuegos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/268910/logo.png', 88, 7, '2017-09-29', '2023-04-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Studio MDHR'), (SELECT id FROM desarrolladores WHERE nombre = 'Studio MDHR'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU');

-- 97. Balatro
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2379780, 'Balatro', 
'Un roguelike de póker hipnótico donde puedes crear combos ilegales.', 
'Balatro es un constructor de mazos roguelike con temática de póker que trata de crear combos poderosos y ganar a lo grande. Combina manos de póker reales con comodines (Jokers) únicos que tienen una amplia variedad de efectos. Crea sinergias tan potentes que podrás alcanzar puntuaciones astronómicas y superar las ciegas más exigentes.\n\nDescubre barajas ocultas, cartas de tarot, cartas de planetas y vales que te ayudarán en cada partida. Con un estilo visual psicodélico de baja fidelidad y una banda sonora sintética adictiva, Balatro es una experiencia de juego "solo una partida más" en su máxima expresión. No hace falta saber jugar al póker para quedar atrapado por su mecánica de juego profunda y satisfactoria.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2379780/logo.png', 90, 3, '2024-02-20', '2024-05-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'LocalThunk'), (SELECT id FROM distribuidores WHERE nombre = 'Playstack'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'JP'), (@j_id, 'ZH');

-- 98. Sekiro: Shadows Die Twice
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (814380, 'Sekiro: Shadows Die Twice', 
'Traza tu propio camino hacia la venganza en esta aventura de acción de FromSoftware.', 
'En Sekiro: Shadows Die Twice encarnas al "lobo manco", un guerrero desfigurado y caído en desgracia rescatado de las garras de la muerte. Tu destino es proteger a un joven señor, descendiente de un antiguo linaje, pero te convertirás en el objetivo de muchos enemigos despiadados, incluido el peligroso clan Ashina. Cuando el joven señor es capturado, nada te detendrá en tu aventura por recuperar tu honor, ni siquiera la muerte misma.\n\nExplora el Japón de la era Sengoku de finales del siglo XVI, un periodo brutal de constantes conflictos a vida o muerte, mientras te enfrentas a enemigos imponentes en un mundo oscuro y retorcido. Desata un arsenal de herramientas protésicas letales y poderosas habilidades ninja, combinando el sigilo, la exploración vertical y el combate visceral en una lucha sangrienta por la justicia y la redención.', 
'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/814380/logo.png', 88, 18, '2019-03-22', '2023-10-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'FromSoftware'), (SELECT id FROM distribuidores WHERE nombre = 'Activision'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 99. Pacific Drive.
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1458140, 'Pacific Drive', 
'Sobrevive a la Zona de Exclusión Olímpica con tu coche como única compañía.', 
'Pacific Drive es un juego de supervivencia de conducción en primera persona en el que tu coche es tu único compañero. Navega por una recreación surrealista del noroeste del Pacífico y enfréntate a peligros sobrenaturales en la Zona de Exclusión Olímpica. Cada excursión a la zona ofrece desafíos únicos y extraños mientras reparas y mejoras tu vehículo desde un garaje abandonado.\n\nRecoge recursos, investiga lo que quedó atrás y desentraña un misterio olvidado hace décadas mientras intentas sobrevivir en un entorno hostil y cambiante. Tu coche es tu vida: personalízalo para que resista las anomalías y asegúrate de tener siempre combustible para volver a la seguridad de tu base. Es una mezcla fascinante de gestión, exploración y atmósfera inquietante.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1458140/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1458140/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1458140/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1458140/logo.png', 79, 12, '2024-02-22', '2024-08-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ironwood Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Kepler Interactive'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT'), (@j_id, 'JP'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 100. Half-Life: Alyx
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (546560, 'Half-Life: Alyx', 
'El regreso de Valve a la serie Half-Life en una experiencia de realidad virtual pura.', 
'Half-Life: Alyx es el regreso en realidad virtual de Valve a la serie Half-Life. Es la historia de una lucha imposible contra una raza alienígena cruel conocida como la Alianza, situada entre los eventos de Half-Life y Half-Life 2. Jugando como Alyx Vance, eres la única oportunidad de supervivencia de la humanidad.\n\nLa resistencia contra el control de la Alianza sobre la Tierra está en sus inicios. Como fundadora de la incipiente resistencia, has continuado tu actividad científica clandestina: realizando investigaciones críticas y construyendo herramientas valiosas para los pocos humanos con el valor suficiente para enfrentarse a la Alianza. Sumérgete en interacciones ambientales profundas, resolución de acertijos, exploración del mundo y combates viscerales diseñados desde cero para la realidad virtual.', 
'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/546560/logo.png', 93, 16, '2020-03-23', '2022-11-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Valve'), (SELECT id FROM distribuidores WHERE nombre = 'Valve'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'PT'), (@j_id, 'RU'), (@j_id, 'ZH'), (@j_id, 'KR');

-- 101. EA SPORTS FC 25
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2669320, 'EA SPORTS FC 25', 
'Siente la emoción del fútbol con el nuevo modo Rush 5 contra 5 y FC IQ.', 
'EA SPORTS FC 25 te ofrece más formas de ganar por el club. Forma equipo en Rush de 5 contra 5, una nueva forma de jugar con amistades en los modos de juego Football Ultimate Team, Clubes y Patada inicial. Con FC IQ, las bases tácticas del juego se han renovado para ofrecer un mayor control estratégico y un movimiento colectivo más realista a nivel de equipo, mientras que una nueva IA impulsada por datos del mundo real influye en las tácticas a través de nuevos Roles de futbolista.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2669320/logo.png', 76, 3, '2024-09-27', '2025-01-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'EA Sports'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'JP');

-- 102. Madden NFL 25
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2582560, 'Madden NFL 25', 
'Golpea como si fuera en serio con FieldSENSE y la nueva tecnología BOOM Tech.', 
'En Madden NFL 25, experimenta un sistema de placajes dinámico y con base física que permite realizar animaciones realistas y un control sin precedentes. La nueva tecnología BOOM Tech mejora cada impacto, permitiéndote dominar el campo de juego como nunca antes. Con modos actualizados de Franchise y Ultimate Team, vive la experiencia más auténtica del fútbol americano profesional.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2582560/logo.png', 70, 3, '2024-08-16', '2024-11-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'EA Sports'), (SELECT id FROM distribuidores WHERE nombre = 'Electronic Arts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'EN'), (@j_id, 'ES'), (@j_id, 'FR');

-- 103. NBA 2K25
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2878980, 'NBA 2K25', 
'Domina cada cancha con autenticidad y realismo gracias a ProPLAY.', 
'Compite a tu manera mientras forjas tu legado en Mi CARRERA y Mi EQUIPO. Experimenta la jugabilidad con ProPLAY, que convierte imágenes reales de la NBA en jugadas envolventes. Personaliza tu experiencia en La Ciudad y conviértete en el mejor de todos los tiempos en una simulación de baloncesto que roza la perfección visual y técnica.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2878980/logo.png', 78, 3, '2024-09-06', '2024-12-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Visual Concepts'), (SELECT id FROM distribuidores WHERE nombre = '2K'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP');

-- 104. Dead by Daylight
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (381210, 'Dead by Daylight', 
'Un juego de terror multijugador de 4 contra 1 donde uno es el asesino.', 
'Dead by Daylight es un juego de terror multijugador (4 contra 1) en el que un jugador asume el rol de asesino despiadado y los otros cuatro juegan como supervivientes que intentan escapar para evitar ser capturados, torturados y asesinados. Los supervivientes juegan en tercera persona y tienen la ventaja de una mejor visión periférica.', 
'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/381210/logo.png', 71, 18, '2016-06-14', '2023-10-31', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Behaviour Interactive Inc.'), (SELECT id FROM desarrolladores WHERE nombre = 'Behaviour Interactive Inc.'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP');


-- 105. The Precinct
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2516900, 'The Precinct', 
'Una carta de amor a las películas policiales de los 80. Eres la ley en Averno City.', 
'Averno City, 1983. Eres Nick Cordell Jr. Como policía novato recién salido de la academia, estás en la primera línea de defensa de los ciudadanos. Sumérgete en un mundo de persecuciones de coches trepidantes, crímenes generados procedimentalmente y una buena dosis de estética noir de los años 80 en este simulador de acción policial con vista cenital.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2516900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2516900/logo.png', 80, 16, '2024-10-01', '2025-02-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Fallen Tree Games'), (SELECT id FROM distribuidores WHERE nombre = 'Kwalee'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE');

-- 106. Stellaris
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (281990, 'Stellaris', 
'Explora una galaxia llena de maravillas en este juego de gran estrategia de ciencia ficción.', 
'Prepárate para explorar, descubrir e interactuar con una multitud de especies mientras viajas por las estrellas. Forja un imperio galáctico enviando naves científicas a investigar y explorar, mientras que las naves de construcción erigen estaciones alrededor de los planetas recién descubiertos. Descubre tesoros enterrados y maravillas galácticas mientras determinas el rumbo de tu sociedad.', 
'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/281990/logo.png', 78, 7, '2016-05-09', '2023-06-15', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Paradox Development Studio'), (SELECT id FROM distribuidores WHERE nombre = 'Paradox Interactive'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'PT'), (@j_id, 'RU');

-- 107. Dispatch
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2800000, 'Dispatch', 
'Gestiona las llamadas de emergencia y sobrevive a la noche en este thriller de simulación.', 
'Dispatch te pone en el asiento de un operador de emergencias. Tu tarea es escuchar atentamente, enviar las unidades adecuadas y gestionar situaciones de vida o muerte bajo una presión constante. Pero cuidado, hay hilos narrativos que sugieren que no todas las llamadas son lo que parecen, y la ciudad oculta secretos que podrían ponerte en peligro.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2800000/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2800000/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2800000/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2800000/logo.png', 75, 12, '2024-06-01', '2025-01-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Unknown Developer'), (SELECT id FROM distribuidores WHERE nombre = 'Indie Publisher'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'EN'), (@j_id, 'ES');

-- 108. Watch Dogs
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (242700, 'Watch Dogs', 
'En Chicago, tú eres el hacker definitivo. El sistema es tu arma.', 
'Encarna a Aiden Pearce, un brillante hacker y antiguo matón, cuyo pasado delictivo provocó una violenta tragedia familiar. Ahora buscas a quienes hicieron daño a tu familia, y para ello podrás monitorizar y hackear a cuantos te rodean manipulando todo lo que esté conectado a la red de la ciudad (ctOS). Accede a cámaras de seguridad, descarga información personal y controla los semáforos para detener a tus enemigos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/242700/logo.png', 77, 18, '2014-05-27', '2022-10-05', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Montreal'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP');

-- 109. Watch Dogs 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (447040, 'Watch Dogs 2', 
'Hackea el mundo en San Francisco como miembro de DedSec.', 
'Juega como Marcus Holloway, un joven y brillante hacker que vive en la cuna de la revolución tecnológica, la zona de la bahía de San Francisco. Únete a DedSec, un grupo de hackers de renombre, y ejecuta el mayor hackeo de la historia: acabar con el ctOS 2.0, un sistema operativo invasivo utilizado por mentes criminales para monitorizar y manipular a los ciudadanos a gran escala.', 
'https://cdn.akamai.steamstatic.com/steam/apps/447040/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447040/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447040/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447040/logo.png', 75, 18, '2016-11-28', '2023-01-12', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Montreal'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP');

-- 110. Ghostrunner
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1139900, 'Ghostrunner', 
'Un juego de acción "slasher" en primera persona con estética cyberpunk.', 
'Ghostrunner ofrece una experiencia única para un solo jugador con combates vertiginosos y violentos, y una ambientación que combina la ciencia ficción con temas postapocalípticos. Cuenta la historia de un mundo que ya se ha acabado y de sus habitantes, que luchan por sobrevivir. Como el guerrero de cuchilla definitivo, siempre estás superado en número, pero nunca en habilidad.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1139900/logo.png', 81, 18, '2020-10-27', '2023-09-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'One More Level'), (SELECT id FROM distribuidores WHERE nombre = '505 Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'RU');

-- 111. Ghostrunner II
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (2144740, 'Ghostrunner II', 
'La sangre correrá en esta secuela del aclamado juego de acción cyberpunk.', 
'Ambientado un año después del primer juego, Ghostrunner II te pone de nuevo en la piel del cibernético Jack. Con un sistema de combate mejorado, niveles con vehículos (moto) y una narrativa más profunda, deberás enfrentarte a un culto de IA que se ha formado fuera de la Torre Dharma. La velocidad y la precisión siguen siendo las claves para sobrevivir a este infierno de neón.', 
'https://cdn.akamai.steamstatic.com/steam/apps/2144740/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2144740/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2144740/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/2144740/logo.png', 80, 18, '2023-10-26', '2024-04-22', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'One More Level'), (SELECT id FROM distribuidores WHERE nombre = '505 Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP'), (@j_id, 'RU'), (@j_id, 'ZH');

-- 112. Dragon Ball: Sparking! ZERO
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1790600, 'Dragon Ball: Sparking! ZERO', 
'¡El regreso de la legendaria saga Budokai Tenkaichi!', 
'Dragon Ball: Sparking! ZERO eleva a un nuevo nivel la jugabilidad legendaria de la serie Budokai Tenkaichi. Aprende y domina una lista increíble de personajes jugables, cada uno con habilidades, transformaciones y técnicas únicas. Siente el poder destructivo de los guerreros más fuertes de Dragon Ball en escenarios que se desmoronan bajo tu fuerza.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1790600/logo.png', 82, 12, '2024-10-11', '2024-11-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Spike Chunsoft'), (SELECT id FROM distribuidores WHERE nombre = 'Bandai Namco Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP');

-- 113. Dragon Ball Z: Kakarot
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (851850, 'Dragon Ball Z: Kakarot', 
'Vive la historia de Goku y otros guerreros Z en este RPG de acción.', 
'Más allá de las batallas épicas, experimenta la vida en el mundo de Dragon Ball Z mientras luchas, pescas, comes y entrenas con Goku, Gohan, Vegeta y otros. Explora nuevas zonas y aventuras a medida que avanzas en la historia y creas vínculos poderosos con otros héroes del universo de Dragon Ball.', 
'https://cdn.akamai.steamstatic.com/steam/apps/851850/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/851850/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/851850/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/851850/logo.png', 73, 12, '2020-01-17', '2023-05-10', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'CyberConnect2'), (SELECT id FROM distribuidores WHERE nombre = 'Bandai Namco Entertainment'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE'), (@j_id, 'JP');

-- 114. Euro Truck Simulator 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (227300, 'Euro Truck Simulator 2', 
'Viaja por Europa como el rey de la carretera, un camionero que entrega cargas importantes.', 
'Con docenas de ciudades para explorar en el Reino Unido, Bélgica, Alemania, Italia, los Países Bajos, Polonia y muchos más, tu resistencia, habilidad y velocidad se pondrán al límite. Si tienes lo que hay que tener para formar parte de una fuerza de transporte de élite, ponte al volante y demuéstralo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/227300/logo.png', 79, 3, '2012-10-18', '2022-09-20', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'SCS Software'), (SELECT id FROM desarrolladores WHERE nombre = 'SCS Software'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'PT');

-- 115. Goat Simulator
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (265930, 'Goat Simulator', 
'Sé una cabra y causa el mayor caos posible. Un juego de destrucción absurdo.', 
'Goat Simulator es lo último en tecnología de simulación de cabras, ¡y trae la simulación de cabras de próxima generación para TI! Ya no tienes que fantasear con ser una cabra; tus sueños por fin se han hecho realidad. En cuanto a la jugabilidad, Goat Simulator consiste en causar tanta destrucción como puedas siendo una cabra.', 
'https://cdn.akamai.steamstatic.com/steam/apps/265930/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/265930/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/265930/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/265930/logo.png', 62, 12, '2014-04-01', '2023-02-14', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Coffee Stain Studios'), (SELECT id FROM desarrolladores WHERE nombre = 'Coffee Stain Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE');



-- 118. Kerbal Space Program
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (220200, 'Kerbal Space Program', 
'Dirige el programa espacial de una raza alienígena y domina la astrofísica.', 
'En Kerbal Space Program, te pones al mando del programa espacial de la raza alienígena conocida como los Kerbals. Tienes acceso a una gran variedad de piezas para montar naves espaciales plenamente funcionales que vuelan basándose en leyes físicas reales.', 
'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/220200/logo.png', 88, 3, '2015-04-27', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Squad'), (SELECT id FROM distribuidores WHERE nombre = 'Private Division'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE');

-- 119. Universe Sandbox
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (230290, 'Universe Sandbox', 
'Un simulador espacial basado en la física que permite crear y destruir.', 
'Universe Sandbox combina la gravedad, el clima, las colisiones y las interacciones estelares para revelar la belleza de nuestro universo y la fragilidad de nuestro planeta. Crea sistemas solares completos y provoca supernovas.', 
'https://cdn.akamai.steamstatic.com/steam/apps/230290/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/230290/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/230290/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/230290/logo.png', 83, 3, '2015-08-24', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Giant Army'), (SELECT id FROM desarrolladores WHERE nombre = 'Giant Army'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE');

-- 120. Human Resource Machine
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (375820, 'Human Resource Machine', 
'Programa a pequeños oficinistas para resolver puzles.', 
'En cada nivel, tu jefe te da un trabajo. Automatízalo programando a tu pequeño oficinista. Si tienes éxito, serás ascendido al siguiente nivel para otro año de trabajo. No te preocupes si nunca has programado: programar no es más que resolver puzles.', 
'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/375820/logo.png', 78, 3, '2015-10-15', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Tomorrow Corporation'), (SELECT id FROM desarrolladores WHERE nombre = 'Tomorrow Corporation'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR');

-- 121. PC Building Simulator
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (621060, 'PC Building Simulator', 
'Aprende a montar y reparar ordenadores reales.', 
'Crea tu propio imperio de reparación de ordenadores. Aprende a diagnosticar, reparar y montar PCs con componentes reales de fabricantes oficiales. Es la herramienta educativa perfecta para entusiastas del hardware.', 
'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/621060/logo.png', 72, 3, '2019-01-29', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Claudiu Kiss'), (SELECT id FROM distribuidores WHERE nombre = 'The Irregular Corporation'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'PT');

-- 122. while True: learn()
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (619150, 'while True: learn()', 
'Un simulador de aprendizaje automático y redes neuronales.', 
'Eres un especialista en aprendizaje automático que crea redes neuronales pero cuyo gato parece ser mejor programador que tú. Resuelve puzles para construir un sistema de traducción del lenguaje de los gatos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/619150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/619150/logo.png', 74, 3, '2019-01-17', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Luden.io'), (SELECT id FROM distribuidores WHERE nombre = 'Nival'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'DE'), (@j_id, 'RU');

-- 123. Discovery Tour: Viking Age
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1613530, 'Discovery Tour: Viking Age', 
'Explora la historia vikinga sin combates en un museo viviente.', 
'Discovery Tour te permite viajar por el mundo de Assassin''s Creed Valhalla para aprender sobre su historia y cultura, diseñado por historiadores para ser una herramienta educativa inmersiva.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1613530/logo.png', 80, 12, '2021-10-19', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Montreal'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE');

-- 124. Poly Bridge 3
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1850240, 'Poly Bridge 3', 
'Aprende ingeniería construyendo puentes creativos.', 
'La ingeniería se encuentra con la creatividad. Diseña y construye puentes para que los vehículos lleguen a su destino. Una simulación de física que enseña conceptos fundamentales de estructuras.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1850240/logo.png', 82, 3, '2023-05-30', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Dry Cactus'), (SELECT id FROM distribuidores WHERE nombre = 'Dry Cactus'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'JP');

-- 125. Scribblenauts Unlimited
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (218680, 'Scribblenauts Unlimited', 
'Fomenta la creatividad invocando cualquier objeto imaginable.', 
'Ayuda a Maxwell a resolver puzles en un mundo abierto donde puedes crear cualquier objeto simplemente escribiendo su nombre. Una herramienta fantástica para practicar vocabulario y lógica.', 
'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/218680/logo.png', 75, 3, '2012-11-20', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = '5th Cell'), (SELECT id FROM distribuidores WHERE nombre = 'Warner Bros. Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT');

-- 126. Captain Toad: Treasure Tracker
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000004, 'Captain Toad: Treasure Tracker', 
'Puzles de perspectiva y lógica espacial en mundos miniatura.', 
'Explora niveles inspirados en los jardines japoneses. Tendrás que girar la cámara para encontrar el camino y los tesoros. Enseña a pensar en tres dimensiones y resolución de problemas.', 
'https://m.media-amazon.com/images/I/81fHIn+qD2L._AC_SL1500_.jpg', 'https://header_toad.jpg', 'https://hero_toad.jpg', 'https://logo_toad.png', 81, 3, '2014-11-13', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Nintendo EPD'), (SELECT id FROM distribuidores WHERE nombre = 'Nintendo'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 127. National Geographic Explore VR
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000010, 'National Geographic Explore VR', 
'Viaja a los lugares más remotos del planeta en realidad virtual.', 
'Conviértete en un explorador de National Geographic. Visita la Antártida o Machu Picchu para aprender sobre arqueología y geografía de una manera totalmente inmersiva y educativa.', 
'https://portada_natgeo.jpg', 'https://header_natgeo.jpg', 'https://hero_natgeo.jpg', 'https://logo_natgeo.png', 78, 3, '2019-05-21', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Force Field'), (SELECT id FROM distribuidores WHERE nombre = 'Disney'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR');

-- 128. Super Mario Odyssey
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000003, 'Super Mario Odyssey', 
'Acompaña a Mario en una aventura en 3D por todo el mundo.', 
'Explora enormes reinos en 3D llenos de secretos. Gracias a su nuevo amigo Cappy, Mario tiene nuevos movimientos para una aventura inolvidable apta para todas las edades.', 
'https://assets.nintendo.com/image/upload/f_auto/q_auto/ncom/software/switch/70010000001130/boxart', 'https://header_mario.jpg', 'https://hero_mario.jpg', 'https://logo_mario.png', 97, 3, '2017-10-27', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Nintendo EPD'), (SELECT id FROM distribuidores WHERE nombre = 'Nintendo'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 130. Fall Guys
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1097150, 'Fall Guys', 
'¡Tropieza hacia la victoria en este battle royale de plataformas!', 
'Compite a través de rondas de obstáculos cada vez más locas hasta que solo queda un vencedor. Diversión colorida y caótica ideal para jugar con amigos y familia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/logo.png', 80, 3, '2020-08-04', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Mediatonic'), (SELECT id FROM distribuidores WHERE nombre = 'Epic Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 131. Mario Kart 8 Deluxe
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000006, 'Mario Kart 8 Deluxe', 
'Carreras alocadas con los personajes de Nintendo.', 
'El juego de carreras definitivo para toda la familia. Compite en circuitos memorables con objetos locos y una jugabilidad perfecta para cualquier nivel de habilidad.', 
'https://m.media-amazon.com/images/I/918SjT8+xFL._AC_SL1500_.jpg', 'https://header_mk8.jpg', 'https://hero_mk8.jpg', 'https://logo_mk8.png', 92, 3, '2017-04-28', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Nintendo EPD'), (SELECT id FROM distribuidores WHERE nombre = 'Nintendo'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 132. Sackboy: A Big Adventure
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1426210, 'Sackboy: A Big Adventure', 
'Aventura de plataformas vibrante y creativa.', 
'Acompaña a Sackboy en una aventura épica en 3D. Juega solo o con amigos en niveles llenos de música, color y desafíos de plataformas muy divertidos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/logo.png', 79, 7, '2022-10-27', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Sumo Digital'), (SELECT id FROM distribuidores WHERE nombre = 'PlayStation Publishing'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'IT'), (@j_id, 'DE');

-- 133. LEGO Star Wars: The Skywalker Saga
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1443370, 'LEGO Star Wars: The Skywalker Saga', 
'Vive las nueve películas de la saga con el humor característico de LEGO.', 
'Juega a través de toda la saga Star Wars con cientos de personajes y vehículos. Una aventura enorme y graciosa para que padres e hijos disfruten juntos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1443370/logo.png', 82, 7, '2022-04-05', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'TT Games'), (SELECT id FROM distribuidores WHERE nombre = 'Warner Bros. Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT');

-- 134. Spyro Reignited Trilogy
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (996580, 'Spyro Reignited Trilogy', 
'El dragón más famoso regresa totalmente remasterizado.', 
'Salva los Reinos de los Dragones en las tres aventuras originales. Un clásico de las plataformas recreado con gráficos impresionantes que encantará a toda la familia.', 
'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/996580/logo.png', 82, 7, '2019-09-03', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Toys for Bob'), (SELECT id FROM distribuidores WHERE nombre = 'Activision'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE');

-- 135. Minecraft
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000007, 'Minecraft', 
'Construye y explora tu propio mundo infinito de bloques.', 
'Minecraft es el juego de construcción definitivo. Explora mundos infinitos, sobrevive a la noche o crea obras de arte arquitectónicas en el modo creativo.', 
'https://minecraft.net/images/share/social-share-default.jpg', 'https://header_mc.jpg', 'https://hero_mc.jpg', 'https://logo_mc.png', 93, 7, '2011-11-18', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Mojang Studios'), (SELECT id FROM xbox_game_studios WHERE nombre = 'Xbox Game Studios'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'PT');

-- 136. Stardew Valley
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (413150, 'Stardew Valley', 
'Hereda la granja de tu abuelo y comienza una nueva vida rural.', 
'Cultiva la tierra, cría animales y entabla amistad con los habitantes del pueblo en este relajante simulador de vida que promueve valores de paciencia y cuidado.', 
'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413150/logo.png', 89, 3, '2016-02-26', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'ConcernedApe'), (SELECT id FROM desarrolladores WHERE nombre = 'ConcernedApe'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 137. Animal Crossing: New Horizons
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000005, 'Animal Crossing: New Horizons', 
'Crea tu propio paraíso en una isla desierta con amigos animales.', 
'Relájate y decora tu isla, recolecta fósiles y convive con vecinos encantadores en tiempo real. Un juego pacífico e ideal para compartir con toda la familia.', 
'https://m.media-amazon.com/images/I/81N6A4-Lq8L._AC_SL1500_.jpg', 'https://header_ac.jpg', 'https://hero_ac.jpg', 'https://logo_ac.png', 90, 3, '2020-03-20', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Nintendo EPD'), (SELECT id FROM distribuidores WHERE nombre = 'Nintendo'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 138. Steins;Gate
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (412830, 'Steins;Gate', 
'Un grupo de estudiantes descubre cómo enviar mensajes al pasado.', 
'Steins;Gate es una de las novelas visuales de ciencia ficción más aclamadas. Sigue la historia de Rintaro Okabe y sus experimentos con el tiempo que cambiarán el destino del mundo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/412830/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/412830/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/412830/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/412830/logo.png', 87, 12, '2016-09-08', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'MAGES. Inc.'), (SELECT id FROM distribuidores WHERE nombre = 'Spike Chunsoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'EN'), (@j_id, 'JP');

-- 139. Danganronpa: Trigger Happy Havoc
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (413410, 'Danganronpa: Trigger Happy Havoc', 
'Investiga asesinatos y sobrevive a un juego mortal en la escuela.', 
'Encerrados en una escuela, los estudiantes deben cometer el crimen perfecto para escapar. Investiga, encuentra pistas y derrota al oso Monokuma en los juicios escolares.', 
'https://cdn.akamai.steamstatic.com/steam/apps/413410/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413410/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413410/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/413410/logo.png', 82, 16, '2016-02-18', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Spike Chunsoft'), (SELECT id FROM distribuidores WHERE nombre = 'Spike Chunsoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'EN'), (@j_id, 'JP');

-- 140. Phoenix Wright: Ace Attorney Trilogy
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (787480, 'Phoenix Wright: Ace Attorney Trilogy', 
'¡Protesta! Defiende a tus clientes en juicios llenos de giros.', 
'Vive las tres primeras entregas de la saga. Investiga escenas del crimen y presenta pruebas en el tribunal para salvar a tus clientes inocentes de condenas injustas.', 
'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/787480/logo.png', 81, 12, '2019-04-09', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Capcom'), (SELECT id FROM distribuidores WHERE nombre = 'Capcom'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 141. VA-11 Hall-A: Cyberpunk Bartender Action
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (447530, 'VA-11 Hall-A', 
'Sirve bebidas y escucha historias en un futuro cyberpunk distópico.', 
'Eres una camarera en un bar de mala muerte. El juego trata sobre preparar cócteles y cómo estos influyen en la vida de tus clientes en una ciudad decadente.', 
'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/447530/logo.png', 83, 16, '2016-06-21', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Sukeban Games'), (SELECT id FROM distribuidores WHERE nombre = 'Ysbryd Games'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'JP');

-- 142. Coffee Talk
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (914800, 'Coffee Talk', 
'Prepara café y charla con habitantes de una Seattle fantástica.', 
'Un juego sobre escuchar los problemas de la gente y ayudarles sirviéndoles una bebida caliente. Una experiencia narrativa relajante con toques de fantasía urbana.', 
'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/914800/logo.png', 75, 12, '2020-01-29', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Toge Productions'), (SELECT id FROM distribuidores WHERE nombre = 'Toge Productions'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 143. Doki Doki Literature Club Plus!
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1388880, 'Doki Doki Literature Club Plus!', 
'Únete al club de literatura en este thriller psicológico.', 
'Lo que parece un inocente club escolar pronto se revela como una experiencia de terror psicológico que rompe la cuarta pared de formas impactantes.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1388880/logo.png', 82, 18, '2021-06-30', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Team Salvato'), (SELECT id FROM distribuidores WHERE nombre = 'Serenity Forge'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 144. 13 Sentinels: Aegis Rim
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (0000008, '13 Sentinels: Aegis Rim', 
'Entrelaza trece historias de adolescentes y mechas en una trama épica.', 
'Una obra maestra que combina novela visual y estrategia. Descubre un misterio de ciencia ficción que abarca varias épocas para salvar a la humanidad.', 
'https://m.media-amazon.com/images/I/81P2p+rP9PL._AC_SL1500_.jpg', 'https://header_13s.jpg', 'https://hero_13s.jpg', 'https://logo_13s.png', 85, 12, '2019-11-28', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Vanillaware'), (SELECT id FROM distribuidores WHERE nombre = 'Sega'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'JP');

-- 145. Zero Escape: The Nonary Games
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (477740, 'Zero Escape: The Nonary Games', 
'Resuelve puzles mortales para escapar de un secuestro.', 
'Nueve personas son obligadas a participar en un juego mortal. Una mezcla tensa de novela visual y habitaciones de escape con múltiples finales.', 
'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/477740/logo.png', 86, 16, '2017-03-24', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Spike Chunsoft'), (SELECT id FROM distribuidores WHERE nombre = 'Spike Chunsoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'EN'), (@j_id, 'JP');

-- 146. SeaBed
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1392840, 'SeaBed', 
'Una novela visual de misterio psicológico y temática yuri.', 
'Una historia profunda contada a través de tres perspectivas cuyas vidas se entrelazan tras una desaparición. Una narrativa pausada y emocional.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1392840/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1392840/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1392840/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1392840/logo.png', 80, 12, '2017-12-19', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'PaleMono'), (SELECT id FROM distribuidores WHERE nombre = 'Fruitbat Factory'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'JP');

-- 147. Clannad
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (324160, 'Clannad', 
'Una historia conmovedora sobre la importancia de la familia.', 
'Sigue la vida de Tomoya Okazaki mientras conoce a diversas personas y descubre el valor de los lazos familiares en una de las historias más emotivas del género.', 
'https://cdn.akamai.steamstatic.com/steam/apps/324160/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/324160/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/324160/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/324160/logo.png', 84, 12, '2015-11-23', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Key'), (SELECT id FROM distribuidores WHERE nombre = 'VisualArts'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'EN'), (@j_id, 'JP');

-- 148. Hitman World of Assassination
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (1649240, 'Hitman World of Assassination', 
'Conviértete en el Agente 47, el asesino definitivo.', 
'Viaja por todo el mundo y elimina a tus objetivos de las formas más creativas y sigilosas imaginables en niveles sandbox inmensos.', 
'https://cdn.akamai.steamstatic.com/steam/apps/1649240/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/1649240/logo.png', 87, 18, '2022-01-20', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'IO Interactive'), (SELECT id FROM distribuidores WHERE nombre = 'IO Interactive'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT');

-- 149. Dishonored 2
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (403640, 'Dishonored 2', 
'Recupera lo que es tuyo con sigilo y poderes sobrenaturales.', 
'Juega como Emily o Corvo y usa habilidades únicas para infiltrarte en Karnaca. Un diseño de niveles soberbio que premia la creatividad y el sigilo.', 
'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/403640/logo.png', 88, 18, '2016-11-11', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Arkane Studios'), (SELECT id FROM distribuidores WHERE nombre = 'Bethesda Softworks'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE');

-- 150. Metal Gear Solid V: The Phantom Pain
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (287700, 'Metal Gear Solid V: The Phantom Pain', 
'Sigilo táctico de nueva generación en un mundo abierto.', 
'Snake regresa para una misión épica. Usa gadgets, entorno y estrategia para completar objetivos sin ser detectado en el mejor simulador de sigilo táctico.', 
'https://cdn.akamai.steamstatic.com/steam/apps/287700/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/287700/logo.png', 91, 18, '2015-09-01', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Kojima Productions'), (SELECT id FROM distribuidores WHERE nombre = 'Konami'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'JP');

-- 151. Thief
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (239160, 'Thief', 
'Garrett, el maestro de ladrones, sale de las sombras.', 
'En una ciudad gótica y decadente, el sigilo es tu única herramienta. Roba tesoros valiosos y descubre secretos sin que te vean.', 
'https://cdn.akamai.steamstatic.com/steam/apps/239160/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/239160/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/239160/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/239160/logo.png', 70, 18, '2014-02-25', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Eidos-Montréal'), (SELECT id FROM distribuidores WHERE nombre = 'Square Enix'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT');

-- 152. Splinter Cell Blacklist
INSERT INTO juegos (steam_id, titulo, descripcion_corta, descripcion_larga, portada_v, portada_h, hero, logo, metacritic, pegi, fecha_lanzamiento, fecha_publicacion, destacado, desarrollador_id, distribuidor_id) 
VALUES (235600, 'Splinter Cell Blacklist', 
'Sam Fisher regresa para detener una amenaza global.', 
'Detén ataques terroristas usando tecnología de vanguardia y el sigilo más letal. Elige tu estilo: Fantasma, Pantera o Asalto.', 
'https://cdn.akamai.steamstatic.com/steam/apps/235600/library_600x900_2x.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/header.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/library_hero.jpg', 'https://cdn.akamai.steamstatic.com/steam/apps/235600/logo.png', 82, 18, '2013-08-20', '2026-01-01', 0, 
(SELECT id FROM desarrolladores WHERE nombre = 'Ubisoft Toronto'), (SELECT id FROM distribuidores WHERE nombre = 'Ubisoft'));
SET @j_id = LAST_INSERT_ID();
INSERT INTO juego_idiomas VALUES (@j_id, 'ES'), (@j_id, 'EN'), (@j_id, 'FR'), (@j_id, 'DE'), (@j_id, 'IT');











INSERT INTO juego_categorias (juego_id, categoria_id) VALUES 
-- 1. Cities: Skylines II
(1, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
(1, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
-- 2. Project Zomboid
(2, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(2, (SELECT id FROM categorias WHERE nombre = 'Indie')),
(2, (SELECT id FROM categorias WHERE nombre = 'RPG')),
-- 3. Indiana Jones and the Great Circle
(3, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(3, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 4. Red Dead Redemption 2
(4, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(4, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(4, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 5. Star Wars Outlaws
(5, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(5, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(5, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 6. Marvel's Spider-Man 2
(6, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(6, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 7. Hogwarts Legacy
(7, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(7, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 8. Star Wars Jedi: Survivor
(8, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(8, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 9. Star Wars Jedi: Fallen Order
(9, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(9, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 10. The Expanse: A Telltale Series
(10, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 11. The Wolf Among Us
(11, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 12. Mafia: Definitive Edition
(12, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(12, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 13. Kingdom Come: Deliverance II
(13, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(13, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 14. Death Stranding Director's Cut
(14, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(14, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 15. Cyberpunk 2077
(15, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(15, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(15, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 16. Elden Ring
(16, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(16, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 17. Baldur's Gate 3
(17, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(17, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
-- 18. Starfield
(18, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(18, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 19. Forza Horizon 5
(19, (SELECT id FROM categorias WHERE nombre = 'Carreras')),
(19, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 20. Resident Evil 4
(20, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(20, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 21. ARC Raiders
(21, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(21, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 22. God of War Ragnarök
(22, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(22, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 23. Horizon Forbidden West
(23, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(23, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 24. The Last of Us Part II
(24, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(24, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(24, (SELECT id FROM categorias WHERE nombre = 'Terror')),
-- 25. Ghost of Tsushima
(25, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(25, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
¡Claro que sí! Vamos a completar el resto de las relaciones en un único bloque masivo. He asignado las categorías basándome en los géneros reales de cada juego que aparece en tu archivo init.sql y en los añadidos recientemente.

He mantenido el orden de los IDs y, por supuesto, respetando todos los acentos de las categorías para que las subconsultas funcionen perfectamente.

SQL
INSERT INTO juego_categorias (juego_id, categoria_id) VALUES 
-- 26. Returnal
(26, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(26, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(26, (SELECT id FROM categorias WHERE nombre = 'Roguelike')),
-- 27. Demon's Souls
(27, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(27, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 28. Bloodborne
(28, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(28, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(28, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 29. Sekiro: Shadows Die Twice
(29, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(29, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 30. Dark Souls III
(30, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(30, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 31. Stray
(31, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(31, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 32. It Takes Two
(32, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(32, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
(32, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
-- 33. Ratchet & Clank: Rift Apart
(33, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(33, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
-- 34. Deathloop
(34, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(34, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 35. Gran Turismo 7
(35, (SELECT id FROM categorias WHERE nombre = 'Carreras')),
(35, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 36. Doom Eternal
(36, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(36, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 37. Hi-Fi RUSH
(37, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(37, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
-- 38. Celeste
(38, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
(38, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 39. Ori and the Will of the Wisps
(39, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
(39, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(39, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 40. Slay the Spire
(40, (SELECT id FROM categorias WHERE nombre = 'Roguelike')),
(40, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
(40, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 41. Portal 2
(41, (SELECT id FROM categorias WHERE nombre = 'Puzzle')),
(41, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
-- 42. Terraria
(42, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(42, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(42, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 43. Subnautica
(43, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(43, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(43, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 44. Valheim
(44, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(44, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(44, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 45. Among Us
(45, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
(45, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 46. Phasmophobia
(46, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(46, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
(46, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 47. Dead by Daylight
(47, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(47, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
-- 48. Microsoft Flight Simulator
(48, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 49. Euro Truck Simulator 2
(49, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 50. Sea of Thieves
(50, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(50, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
(50, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 51. Civilization VI
(51, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
(51, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 52. Dead Space
(52, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(52, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
-- 53. Street Fighter 6
(53, (SELECT id FROM categorias WHERE nombre = 'Lucha')),
(53, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 54. Black Myth: Wukong
(54, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(54, (SELECT id FROM categorias WHERE nombre = 'RPG')),
-- 55. Dragon Ball: Sparking! ZERO
(55, (SELECT id FROM categorias WHERE nombre = 'Lucha')),
(55, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 56. Helldivers 2
(56, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(56, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(56, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
-- 57. Warhammer 40,000: Space Marine 2
(57, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(57, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
-- 58. Silent Hill 2
(58, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(58, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 59. Frostpunk 2
(59, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
(59, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 60. Manor Lords
(60, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
(60, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
(60, (SELECT id FROM categorias WHERE nombre = 'Medieval')),
-- 61. S.T.A.L.K.E.R. 2: Heart of Chornobyl
(61, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(61, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(61, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 62. Enshrouded
(62, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(62, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(62, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 63. Balatro
(63, (SELECT id FROM categorias WHERE nombre = 'Roguelike')),
(63, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 64. Palworld
(64, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(64, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(64, (SELECT id FROM categorias WHERE nombre = 'RPG')),
-- 65. Tekken 8
(65, (SELECT id FROM categorias WHERE nombre = 'Lucha')),
(65, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 66. Dragon's Dogma 2
(66, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(66, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(66, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 67. Pacific Drive
(67, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(67, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(67, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 68. Ghostrunner 2
(68, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(68, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 69. Lies of P
(69, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(69, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 70. Monster Hunter: World
(70, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(70, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(70, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
-- 71. Persona 5 Royal
(71, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(71, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 72. NieR:Automata
(72, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(72, (SELECT id FROM categorias WHERE nombre = 'RPG')),
-- 73. Dragon Ball FighterZ
(73, (SELECT id FROM categorias WHERE nombre = 'Lucha')),
(73, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 74. Dead Island 2
(74, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(74, (SELECT id FROM categorias WHERE nombre = 'Terror')),
-- 75. Assetto Corsa Competizione
(75, (SELECT id FROM categorias WHERE nombre = 'Carreras')),
(75, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 76. Sea of Stars
(76, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(76, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 77. Dave the Diver
(77, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(77, (SELECT id FROM categorias WHERE nombre = 'Indie')),
(77, (SELECT id FROM categorias WHERE nombre = 'RPG')),
-- 78. Grand Theft Auto V
(78, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(78, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 79. Watch Dogs
(79, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(79, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
(79, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 80. Watch Dogs 2
(80, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(80, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 81. Assassin's Creed Shadows
(81, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(81, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(81, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
-- 82. Tom Clancy's The Division
(82, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(82, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 83. Shadow of the Tomb Raider
(83, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(83, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 84. Dispatch
(84, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
(84, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 85. Mafia II
(85, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(85, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(85, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 86. Black Myth: Wukong
(86, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(86, (SELECT id FROM categorias WHERE nombre = 'RPG')),
-- 87. Doom Eternal
(87, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(87, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 88. Outer Wilds (Aparece en este hueco en el SQL)
(88, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(88, (SELECT id FROM categorias WHERE nombre = 'Puzzle')),
(88, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 89. Warhammer 40,000: Space Marine 2
(89, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(89, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
-- 90. Helldivers 2
(90, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(90, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(90, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
-- 91. BioShock Infinite (Reemplazo efectuado antes)
(91, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(91, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(91, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 92. Disco Elysium
(92, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(92, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 93. Hades
(93, (SELECT id FROM categorias WHERE nombre = 'Roguelike')),
(93, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(93, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 94. Kingdom Come: Deliverance II (O el reemplazo asignado en tu SQL)
(94, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(94, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(94, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 95. Alan Wake 2
(95, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(95, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(95, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 96. Cuphead
(96, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(96, (SELECT id FROM categorias WHERE nombre = 'Plataformas')),
(96, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 97. Balatro
(97, (SELECT id FROM categorias WHERE nombre = 'Roguelike')),
(97, (SELECT id FROM categorias WHERE nombre = 'Indie')),
(97, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
-- 98. Sekiro: Shadows Die Twice (Reemplazo de Spider-Man 2)
(98, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(98, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 99. Pacific Drive
(99, (SELECT id FROM categorias WHERE nombre = 'Supervivencia')),
(99, (SELECT id FROM categorias WHERE nombre = 'Indie')),
(99, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 100. Half-Life: Alyx
(100, (SELECT id FROM categorias WHERE nombre = 'Shooter')),
(100, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
-- 101. EA SPORTS FC 25
(101, (SELECT id FROM categorias WHERE nombre = 'Deportes')),
(101, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 102. Madden NFL 25
(102, (SELECT id FROM categorias WHERE nombre = 'Deportes')),
(102, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 103. NBA 2K25
(103, (SELECT id FROM categorias WHERE nombre = 'Deportes')),
(103, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 104. The Legend of Zelda: Breath of the Wild
(104, (SELECT id FROM categorias WHERE nombre = 'Aventura')),
(104, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(104, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 105. The Precinct
(105, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(105, (SELECT id FROM categorias WHERE nombre = 'Indie')),
(105, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 106. Stellaris
(106, (SELECT id FROM categorias WHERE nombre = 'Estrategia')),
(106, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 107. Dispatch
(107, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
(107, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 108. Watch Dogs
(108, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(108, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
(108, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
-- 109. Watch Dogs 2
(109, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(109, (SELECT id FROM categorias WHERE nombre = 'Mundo Abierto')),
-- 110. Ghostrunner
(110, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(110, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 111. Ghostrunner II
(111, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(111, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 112. Dragon Ball: Sparking! ZERO
(112, (SELECT id FROM categorias WHERE nombre = 'Lucha')),
(112, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 113. Dragon Ball Z: Kakarot
(113, (SELECT id FROM categorias WHERE nombre = 'RPG')),
(113, (SELECT id FROM categorias WHERE nombre = 'Acción')),
-- 114. Euro Truck Simulator 2
(114, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
-- 115. Goat Simulator
(115, (SELECT id FROM categorias WHERE nombre = 'Simulación')),
(115, (SELECT id FROM categorias WHERE nombre = 'Indie')),
-- 116. Dead by Daylight
(116, (SELECT id FROM categorias WHERE nombre = 'Terror')),
(116, (SELECT id FROM categorias WHERE nombre = 'Acción')),
(116, (SELECT id FROM categorias WHERE nombre = 'Cooperativo')),
-- 117. Gran Turismo 7
(117, (SELECT id FROM categorias WHERE nombre = 'Carreras')),
(117, (SELECT id FROM categorias WHERE nombre = 'Simulación'));
-- Educativos
(118, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(119, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(120, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(121, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(122, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(123, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(124, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(125, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(126, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
(127, (SELECT id FROM categorias WHERE nombre = 'Educativo')),
-- Familiares
(128, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(130, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(131, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(132, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(133, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(134, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(135, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(136, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
(137, (SELECT id FROM categorias WHERE nombre = 'Familiar')),
-- Novelas Visuales
(138, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(139, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(140, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(141, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(142, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(143, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(144, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(145, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(146, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
(147, (SELECT id FROM categorias WHERE nombre = 'Novela Visual')),
-- Sigilo
(148, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
(149, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
(150, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
(151, (SELECT id FROM categorias WHERE nombre = 'Sigilo')),
(152, (SELECT id FROM categorias WHERE nombre = 'Sigilo'));