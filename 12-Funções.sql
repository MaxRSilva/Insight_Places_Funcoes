DELIMITER $$

CREATE FUNCTION RetornoConstante() 
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN

RETURN 'Seja bem-vindo(a)';

END$$

DELIMITER ;

SELECT RetornoConstante();


SELECT ROUND(AVG(NOTA), 2) MediaNotas FROM avaliacoes;

DELIMITER $$
CREATE FUNCTION MediaAvalicoes()
RETURNS FLOAT DETERMINISTIC
BEGIN
DECLARE media FLOAT;

SELECT ROUND (AVG (nota), 2) MediaNotas 
INTO media
FROM avaliacoes;

RETURN media;
END$$

DELIMITER ;

SELECT MediaAvalicoes();


DELIMITER $$

CREATE FUNCTION CalcularOcupacaoMedia() RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE totalHospedagens INT;
    DECLARE totalOcupadas INT;
    DECLARE ocupacaoMedia DECIMAL(5,2);

    -- Calcula o número total de hospedagens listadas
    SELECT COUNT(*) INTO totalHospedagens FROM hospedagens;
    
    -- Calcula o número total de hospedagens ocupadas
    SELECT COUNT(*) INTO totalOcupadas FROM alugueis;

    -- Calcula a ocupação média como um percentual
    SET ocupacaoMedia = (totalOcupadas / totalHospedagens) * 100;

    RETURN ocupacaoMedia;
END$$

DELIMITER ;

SELECT CalcularOcupacaoMedia();