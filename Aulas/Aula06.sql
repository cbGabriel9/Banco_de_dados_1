SELECT * FROM nota_fiscal_normalizada.produto;

use nota_fiscal_normalizada;

DELIMITER $$

CREATE TRIGGER PROMO_CHECK
BEFORE UPDATE ON produto
FOR EACH ROW

BEGIN

	DECLARE NOME VARCHAR(256);
    
	SELECT DESC_PRODUTO
    INTO NOME
    FROM PRODUTO
    WHERE COD_PRODUTO = NEW.COD_PRODUTO; -- Esse new é uma cópia que o sistema cria na memória do que vai ser alterado, única coisa que vai ficar diferente é o valor que vai ser novo
    
    IF NEW.VL_PRODUTO < 100 THEN
		SET NEW.DESC_PRODUTO =
			CONCAT ('PROMOÇÃO', ' ', NOME);
	ELSEIF NEW.VL_PRODUTO >= 100 AND
		NEW.VL_PRODUTO <= 200 THEN
	SET NEW.DESC_PRODUTO =
		CONCAT('OFERTA ', ' ', NOME);
	END IF;
END$$
    
DELIMITER ;

DROP TRIGGER PROMO_CHECK;