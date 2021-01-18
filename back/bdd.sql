-- Création de la base de données. Il nous faut une table pour les utlisateurs et la possiblité de stocker son image d'avatar

-- Création d'une base de données
CREATE DATABASE IF NOT EXISTS smurf; 

-- Création d'un utilisateur MySQL spécifique à cette application 
CREATE USER IF NOT EXISTS  gargamel@localhost IDENTIFIED BY "azrael"; 

USE smurf; 

-- Donne les droits à mon utilisateur sur toutes les tables de cette base
GRANT ALL ON smurf.* TO gargamel@localhost; 

--Création de nos tables (notre table, il n'en faut qu'une pour cette application)
DROP TABLE IF EXISTS utilisateurs; 
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    pseudo VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) COMMENT "Le chemin relatif de l'image qui correspond à l'avatar"
); 
