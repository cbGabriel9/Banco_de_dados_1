CREATE DATABASE EMPRESA_VETERINARIA;

USE EMPRESA_VETERINARIA;

CREATE TABLE TIPO_ANIMAL (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    TIPO_ANIMAL VARCHAR(100) NOT NULL
);

CREATE TABLE ANIMAL (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    ID_TIPO_ANIMAL INT NOT NULL,
	CONSTRAINT FK_TIPO_ANIMAL_ANIMAL
        FOREIGN KEY (ID_TIPO_ANIMAL)
        REFERENCES TIPO_ANIMAL(ID),
	DATA_NASCIMENTO DATETIME NOT NULL,
    COR VARCHAR(50) NOT NULL,
    PESO FLOAT NOT NULL,
    ALTURA FLOAT NOT NULL
);

CREATE TABLE VACINA (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    DATA_APLICACAO DATETIME NOT NULL,
    ID_ANIMAL INT NOT NULL,
    CONSTRAINT FK_ID_ANIMAL_VACINA
		FOREIGN KEY (ID_ANIMAL)
		REFERENCES ANIMAL(ID)
);

INSERT INTO TIPO_ANIMAL (TIPO_ANIMAL) VALUES ('RÉPTIL'), ('CAPRINO'), ('SUINO'), ('EQUINO'), ('BOVINO');

SELECT * FROM TIPO_ANIMAL;

INSERT INTO ANIMAL (NOME, ID_TIPO_ANIMAL, DATA_NASCIMENTO, COR, PESO, ALTURA) VALUES ('TOY', 5, '2025-03-16', 'BRANCO', 67, 100);

INSERT INTO ANIMAL (NOME, ID_TIPO_ANIMAL, DATA_NASCIMENTO, COR, PESO, ALTURA) VALUES ('VACA', 5, '2025-05-11', 'PRETO', 66, 120), ('LAGARTO', 1, '2022-01-06', 'VERDE', 66, 120);

SELECT * FROM ANIMAL;

INSERT INTO VACINA (NOME, DATA_APLICACAO, ID_ANIMAL) VALUES ('CINOMOSE', '2025-03-29', '3'), ('PARVOVIROSE', '2025-02-27', '1'), ('ADENOVIROSE', '2025-03-28', '1');

SELECT * FROM VACINA;