CREATE TABLE resumo_aluguel (
    aluguel_id VARCHAR(255),
    cliente_id VARCHAR(255),
    valor_total DECIMAL(10,2),
    desconto_aplicado DECIMAL(10,2),
    valor_final DECIMAL(10,2),
		PRIMARY KEY (aluguel_id, cliente_id),
    FOREIGN KEY (aluguel_id) REFERENCES alugueis(aluguel_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);