SELECT * FROM clientes;

SELECT nome, contato FROM clientes;

SELECT CONCAT(nome, contato) FROM clientes;

SELECT CONCAT(nome, ' O email é: ' , contato) FROM clientes;

SELECT CONCAT(TRIM(nome), ' O email é: ' , contato) NomeContato FROM clientes;