DROP DATABASE IF EXISTS VIAGEM_AEREA;
CREATE DATABASE `VIAGEM_AEREA`;

USE `VIAGEM_AEREA`;

CREATE TABLE `CLIENTE`(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(150),
    CPF VARCHAR(11),
    TELEFONE VARCHAR(25),
    CLIENTE_ESPECIAL CHAR(1)
);

CREATE TABLE `LOG_CLIENTE` (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CPF VARCHAR(11),
    ACAO VARCHAR(50),
    DATA_ACAO DATETIME
);

CREATE TABLE `AEROPORTO` (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(150),
    RUA VARCHAR(150),
    BAIRRO VARCHAR(150),
    CIDADE VARCHAR(150),
    UF VARCHAR(2),
    PAIS VARCHAR(3),
    CEP VARCHAR(8)
);


CREATE TABLE `LOG_AEROPORTO` (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(150),
    ACAO VARCHAR(50),
    DATA_ACAO DATETIME
);

CREATE TABLE `VOO`(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_AEROPORTO_ORIGEM INT,
    CONSTRAINT FK_ID_AEROPORTO_ORIGEM_VOO FOREIGN KEY(ID_AEROPORTO_ORIGEM) REFERENCES AEROPORTO(ID),
    ID_AEROPORTO_DESTINO INT,
    CONSTRAINT FK_ID_AEROPORTO_DESTINO_VOO FOREIGN KEY(ID_AEROPORTO_DESTINO) REFERENCES AEROPORTO(ID),
    HORARIO_PREVISTO_SAIDA DATETIME,
    HORARIO_SAIDA DATETIME,
    HORARIO_PREVISTO_CHEGADA DATETIME,
    HORARIO_CHEGADA DATETIME
);

CREATE TABLE `AERONAVE` (
ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
MODELO VARCHAR(200) NOT NULL,
NUM_POLTRONAS INT NOT NULL
);


CREATE TABLE `LOG_AERONAVE` (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_AERONAVE INT,
    ACAO VARCHAR(50),
    DATA_ACAO DATETIME,
    CONSTRAINT FK_ID_AERONAVE_LOG_AERONAVE FOREIGN KEY(ID_AERONAVE) REFERENCES AERONAVE(ID)
);

CREATE TABLE `POLTRONA` (
ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ID_AERONAVE INT NOT NULL,
LOCALIZACAO VARCHAR(100) NOT NULL,
CONSTRAINT FK_ID_AERONAVE_POLTRONA
FOREIGN KEY (ID_AERONAVE) REFERENCES AERONAVE (ID)
);

CREATE TABLE `RESERVA`(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_CLIENTE INT,
    CONSTRAINT FK_ID_CLIENTE_RESERVA FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID),
    ID_POLTRONA INT,
    CONSTRAINT FK_ID_POLTRONA_RESERVA FOREIGN KEY(ID_POLTRONA) REFERENCES POLTRONA(ID),
    ID_VOO INT,
    CONSTRAINT FK_ID_VOO_RESERVA FOREIGN KEY(ID_VOO) REFERENCES VOO(ID)
);

CREATE TABLE `TRAJETO`(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_VOO INT,
    CONSTRAINT FK_ID_VOO_TRAJETO FOREIGN KEY(ID_VOO) REFERENCES VOO(ID),
    ID_AERONAVE INT,
    CONSTRAINT FK_ID_AERONAVE_TRAJETO FOREIGN KEY(ID_AERONAVE) REFERENCES AERONAVE(ID),
    HORARIO_SAIDA DATETIME,
    HORARIO_CHEGADA DATETIME,
    ID_AEROPORTO_ORIGEM INT,
    CONSTRAINT FK_ID_AEROPORTO_ORIGEM_TRAJETO FOREIGN KEY(ID_AEROPORTO_ORIGEM) REFERENCES AEROPORTO(ID),
    ID_AEROPORTO_DESTINO INT,
    CONSTRAINT FK_ID_AEROPORTO_DESTINO_TRAJETO FOREIGN KEY(ID_AEROPORTO_DESTINO) REFERENCES AEROPORTO(ID)
);

-- Triggers para inserir o registro na tabela de LOG_CLIENTE

DELIMITER $$

CREATE TRIGGER TRG_INSERIR_CLIENTE
AFTER INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_CLIENTE (CPF, ACAO, DATA_ACAO)
    VALUES (NEW.CPF, 'INSERT', NOW());
END $$

DELIMITER $$

CREATE TRIGGER TRG_UPDATE_CLIENTE
AFTER UPDATE ON CLIENTE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_CLIENTE (CPF, ACAO, DATA_ACAO)
    VALUES (NEW.CPF, 'UPDATE', NOW());
END $$

DELIMITER $$

CREATE TRIGGER TRG_DELETE_CLIENTE
AFTER DELETE ON CLIENTE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_CLIENTE (CPF, ACAO, DATA_ACAO)
    VALUES (OLD.CPF, 'DELETE', NOW());
END $$

DELIMITER ;

-- Procedure para inserir Cliente

DELIMITER $$

CREATE PROCEDURE INSERIR_CLIENTE(
    IN P_NOME VARCHAR(150),
    IN P_CPF VARCHAR(11),
    IN P_TELEFONE VARCHAR(25),
    IN P_CLIENTE_ESPECIAL CHAR(1)
) 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM CLIENTE WHERE CPF = P_CPF) THEN
        INSERT INTO CLIENTE(NOME, CPF, TELEFONE, CLIENTE_ESPECIAL)
        VALUES (P_NOME, P_CPF, P_TELEFONE, P_CLIENTE_ESPECIAL);
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CPF já cadastrado!';
    END IF;
END $$

DELIMITER ;

CALL INSERIR_CLIENTE('Marcola', 09542312390, 49991223456, 'S');
SELECT * FROM CLIENTE;
DELETE FROM CLIENTE WHERE ID = 1;
SELECT * FROM LOG_CLIENTE;

-- Triggers para inserir o registro na tabela de LOG_AEROPORTO

DELIMITER $$

CREATE TRIGGER TRG_INSERIR_AEROPORTO
AFTER INSERT ON AEROPORTO
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AEROPORTO (NOME, ACAO, DATA_ACAO)
    VALUES (NEW.NOME, 'INSERT', NOW());
END $$

DELIMITER $$

CREATE TRIGGER TRG_UPDATE_AEROPORTO
AFTER UPDATE ON AEROPORTO
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AEROPORTO (NOME, ACAO, DATA_ACAO)
    VALUES (NEW.NOME, 'UPDATE', NOW());
END $$

DELIMITER $$

CREATE TRIGGER TRG_DELETE_AEROPORTO
AFTER DELETE ON AEROPORTO
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AEROPORTO (NOME, ACAO, DATA_ACAO)
    VALUES (OLD.NOME, 'DELETE', NOW());
END $$

DELIMITER ;

-- Procedure para inserir Aeroporto

DELIMITER $$

CREATE PROCEDURE INSERIR_AEROPORTO (
    IN P_NOME VARCHAR(150),
    IN P_RUA VARCHAR(150),
    IN P_BAIRRO VARCHAR(150),
    IN P_CIDADE VARCHAR(150),
    IN P_UF VARCHAR(2),
    IN P_PAIS VARCHAR(3),
    IN P_CEP VARCHAR(8)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM AEROPORTO WHERE NOME = P_NOME) THEN
        INSERT INTO AEROPORTO (NOME, RUA, BAIRRO, CIDADE, UF, PAIS, CEP)
        VALUES (P_NOME, P_RUA, P_BAIRRO, P_CIDADE, P_UF, P_PAIS, P_CEP);
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome de aeroporto já cadastrado!';
    END IF;
END $$

DELIMITER ;

CALL INSERIR_AEROPORTO('', 'RUA MATINAIBA', 'PETER JORDAN', 'SAO PEDRO', 'SC', 'BRA', 'CEP');

-- Triggers para inserir o registro na tabela de LOG_AERONAVE (POR ID)

DELIMITER $$

CREATE TRIGGER TRG_INSERIR_AERONAVE
AFTER INSERT ON AERONAVE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AERONAVE (ID_AERONAVE, ACAO, DATA_ACAO)
    VALUES (NEW.ID, 'INSERT', NOW());
END $$

DELIMITER $$

CREATE TRIGGER TRG_UPDATE_AERONAVE
AFTER UPDATE ON AERONAVE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AERONAVE (ID_AERONAVE, ACAO, DATA_ACAO)
    VALUES (NEW.ID, 'UPDATE', NOW());
END $$

DELIMITER $$

CREATE TRIGGER TRG_DELETE_AERONAVE
AFTER DELETE ON AERONAVE
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AERONAVE (ID_AERONAVE, ACAO, DATA_ACAO)
    VALUES (OLD.ID, 'DELETE', NOW());
END $$

DELIMITER ;

-- Procedure para inserir Aeronave

DELIMITER $$

CREATE PROCEDURE INSERIR_AERONAVE(
    IN P_MODELO VARCHAR(200),
    IN P_NUM_POLTRONAS INT
)
BEGIN
        INSERT INTO AERONAVE (MODELO, NUM_POLTRONAS)
        VALUES (P_MODELO, P_NUM_POLTRONAS);
END$$

DELIMITER ;

CALL INSERIR_AERONAVE('Boeing 747', 250);
SELECT * FROM AERONAVE;
SET FOREIGN_KEY_CHECKS = 0; -- Desativar conferência da FK
DELETE FROM AERONAVE WHERE ID = 1;
SELECT * FROM LOG_AERONAVE;
