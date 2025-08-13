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


DELIMITER $$
CREATE FUNCTION FormatandoCPF (ClienteID INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
DECLARE NovoCPF VARCHAR(50);

SET NovoCPF = (
SELECT CONCAT(SUBSTRING (cpf, 1, 3), '.', SUBSTRING(cpf, 4, 3), '.', SUBSTRING(cpf, 7, 3), '-', SUBSTRING(cpf, 10, 2)) AS CPF_Mascarado
FROM clientes
WHERE cliente_id = ClienteID
);

RETURN NovoCPF;
END$$
DELIMITER ;

SELECT * FROM alugueis;

DELIMITER $$
CREATE FUNCTION InfoAluguel(IdAluguel INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN

DECLARE NomeCliente VARCHAR(100);
DECLARE PrecoTotal DECIMAL(10,2);
DECLARE Dias INT;
DECLARE ValorDiaria DECIMAL(10,2);
DECLARE Resultado VARCHAR(255);

SELECT c.nome, a.preco_total, DATEDIFF(data_fim, data_inicio)
INTO NomeCliente, PrecoTotal, Dias
FROM alugueis a
JOIN clientes c
ON a.cliente_id = c.cliente_id
WHERE a.aluguel_id = IdAluguel;

SET ValorDiaria = PrecoTotal / Dias;

SET Resultado = CONCAT('Nome: ', NomeCliente, ', Valor Diário: R$', FORMAT(ValorDiaria,2));

RETURN Resultado;

END$$

DELIMITER ;


SELECT InfoAluguel(1);


DELIMITER $$
CREATE FUNCTION CalcularDescontoPorDias(AluguelID INT)
RETURNS INT DETERMINISTIC

BEGIN
DECLARE Desconto INT;
SELECT
        CASE
                WHEN DATEDIFF(data_fim, data_inicio) BETWEEN 4 AND 6 THEN 5
                WHEN DATEDIFF(data_fim, data_inicio) BETWEEN 7 AND 9 THEN 10
                WHEN DATEDIFF(data_fim, data_inicio) >= 10 THEN 15
                ELSE 0
        END
        INTO Desconto
FROM alugueis
WHERE aluguel_id = AluguelID;
RETURN Desconto;
END$$

DELIMITER ;

SELECT CalcularDescontoPorDias(1);

DELIMITER $$

CREATE FUNCTION CalcularValorFinalComDesconto()
RETURNS DECIMAL(10,2) DETERMINISTIC

BEGIN
DECLARE ValorTotal DECIMAL(10,2);
DECLARE Desconto INT;
DECLARE ValorFinal DECIMAL(10,2);
SELECT preco_total INTO ValorTotal FROM alugueis WHERE aluguel_id = AluguelID;
SET Desconto = CalcularDescontoPorDias(AluguelID);
SET ValorFinal = ValorTotal - (ValorTotal * Desconto / 100);
RETURN ValorFinal;
END$$

DELIMITER ;


DELIMITER $$
USE `insightplaces`$$
CREATE FUNCTION `InfoAluguel` (IdAluguel INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
  DECLARE NomeCliente VARCHAR(100);
  DECLARE PrecoTotal DECIMAL(10,2);
  DECLARE Dias INT;
  DECLARE ValorDiaria DECIMAL(10,2);
  DECLARE Resultado VARCHAR(255);

  -- Busca os dados do aluguel
  SELECT c.nome, a.preco_total, DATEDIFF(data_fim, data_inicio)
  INTO NomeCliente, PrecoTotal, Dias
  FROM alugueis a
  JOIN clientes c
    ON a.cliente_id = c.cliente_id
  WHERE a.aluguel_id = IdAluguel;

  -- Tratamento para quando não existe ou dias inválidos
  IF NomeCliente IS NULL OR Dias IS NULL OR Dias <= 0 THEN 
      SET Resultado = '0';
  ELSE
      SET ValorDiaria = PrecoTotal / Dias;
      SET Resultado = CONCAT('Nome: ', NomeCliente, ', Valor Diário: R$', FORMAT(ValorDiaria, 2));
  END IF;

  RETURN Resultado;
END$$
DELIMITER ;




SELECT InfoAluguel(0);








