CREATE DATABASE `REAL STATE AGENCY`;

USE `REAL STATE AGENCY`;

CREATE TABLE `PROPERTY`(
`ID` INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY `PK_PROPERY` (`ID`),
`NAME` CHAR(50) NOT NULL,
`DESCRIPTION` TEXT(300),
`NUMBER_ROOM` INT NOT NULL,
`VALUE` FLOAT NOT NULL
);

INSERT INTO PROPERTY (NAME, DESCRIPTION, NUMBER_ROOM, VALUE)
VALUES ('Apartamento', 'Localizado no Farroupilha, muito seguro', 301, 875.55),
	   ('Casa', 'Casa ocupada por apenas um morador desde a construção', 855, 550000),
       ('Conjugado', 'Morador super tranquilo, gente fina demais', 140, 1000),
       ('Kitnet', 'Pequeno mas muito confortável', 440, 600),
       ('Sobrado', 'Sobrou e alguém precisa comprar', 110, 600),
       ('Casa geminada', 'As casas se multiplicaram e agora estão o dobro melhores', 666, 750.90),
       ('Bangalô', 'Parece o nome de um lugarzinho de venda mas é um lugar bom pra dormir e morar', 1050, 500),
       ('Flat', 'Nome em inglês para parecer ser mais bonito', 210, 800),
       ('Cobertura', 'Localizado em Balneário Camboriú', 701, 60000),
       ('Duplex', 'Possui o dobro de conforto', 401, 5000);

SELECT * FROM PROPERTY;

SELECT * FROM PROPERTY
WHERE NAME = 'Casa';

SELECT * FROM PROPERTY
WHERE NUMBER_ROOM <> 301 AND VALUE = 500;

SELECT * FROM PROPERTY
WHERE NUMBER_ROOM > 300 AND VALUE < 800;