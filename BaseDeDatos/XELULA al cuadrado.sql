CREATE DATABASE xelula;
USE xelula;
CREATE TABLE usuarios (
	id INT UNIQUE NOT NULL auto_increment,
    nombre_completo VARCHAR (100) NOT NULL,
    correo VARCHAR (100) UNIQUE,
	contraseña VARCHAR (30) NOT NULL, 
    rol ENUM ('alumno', 'profesor', 'escuela'),
    matricula VARCHAR (200) UNIQUE, 
    fotoperfil VARCHAR (300) DEFAULT NULL,
    creado_a_las timestamp DEFAULT current_timestamp,
    primary key (id)
);
CREATE TABLE grupos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    grupo VARCHAR (20) UNIQUE NOT NULL,
    turno ENUM ('matutino', 'vespertino')
);
CREATE TABLE materias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_materia VARCHAR(100) NOT NULL,
    semestre INT NOT NULL,
    tipo_materia ENUM('basica', 'modulo') NOT NULL
);
CREATE TABLE grupo_materias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    grupo_id INT NOT NULL,
    materia_id INT NOT NULL,
    FOREIGN KEY (grupo_id) REFERENCES grupos(id),
    FOREIGN KEY (materia_id) REFERENCES materias(id)
);
CREATE TABLE horarios (
id INT NOT NULL AUTO_INCREMENT,
docente_id INT AUTO_INCREMENT,
FOREIGN KEY (docente_id)
REFERENCES usuarios (id),
grupo_id INT AUTO_INCREMENT, 
FOREIGN KEY (grupo_id)
REFERENCES grupos (id),
materia_id INT,
FOREIGN KEY (materia_id)
REFERENCES materias (id),
dias ENUM ('lunes', 'martes', 'miercoles', 'jueves', 'viernes'),
hora_ini TIME NOT NULL,
hora_fin TIME NOT NULL,
primary key (id)
);
CREATE TABLE tareas (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
profesor_id INT,
materia_id INT,
grupo_id INT,
titulo VARCHAR (150),
descripcion TEXT,
tipo_tarea ENUM ('pagina_libro', 'apunte', 'trabajo_equipo'),
xp_recompensa INT (5),
fecha_limite DATETIME,
created_at TIMESTAMP,
FOREIGN KEY (profesor_id)
REFERENCES usuarios(id),
FOREIGN KEY (materia_id)
REFERENCES materias(id),
FOREIGN KEY (grupo_id)
REFERENCES grupos(id)
);
CREATE TABLE tareas_alumno (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
alumno_id INT,
FOREIGN KEY (alumno_id)
REFERENCES usuarios (id),
tarea_id INT,
FOREIGN KEY (tarea_id)
REFERENCES tareas(id),
estado ENUM ('pendiente', 'completado', 'atrasada'),
fecha_completado DATETIME NOT NULL,
evidencias VARCHAR (20) DEFAULT NULL
);
CREATE TABLE progreso_alumno (
id INT PRIMARY KEY AUTO_INCREMENT,
alumno_id INT UNIQUE,
FOREIGN KEY (alumno_id)
REFERENCES usuarios (id),
xp_total INT DEFAULT 0,
nivel_actual INT DEFAULT 1,
dias_racha INT default 0,
ultimo_dia_activo DATE 
);
CREATE TABLE periodos_parciales(
id INT PRIMARY KEY,
nombre VARCHAR (100),
fecha_iniciada DATE,
fecha_fin DATE,
activo BOOLEAN
);
CREATE TABLE cupones (
id INT PRIMARY KEY auto_increment,
alumno_id INT,
FOREIGN KEY (alumno_id)
REFERENCES usuarios (id),
codigo_qr VARCHAR (300) DEFAULT NULL,
descuento_description VARCHAR (100),
estado ENUM ('disponible', 'canjeado'),
fecha_expiracion DATETIME
);
CREATE TABLE comunicados (
id INT PRIMARY KEY auto_increment,
remitente_id INT, 
titulo VARCHAR (100),
contenido TEXT,
dirigido_a ENUM ('todos', 'alumnos', 'profesores'),
created_at TIMESTAMP,
FOREIGN KEY (remitente_id)
REFERENCES usuarios (id)
);