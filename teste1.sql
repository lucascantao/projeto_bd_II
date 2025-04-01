CREATE TABLE Conta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;  -- InnoDB é necessário para transações

INSERT INTO Conta (nome, saldo) VALUES ('Conta A', 500.00);
INSERT INTO Conta (nome, saldo) VALUES ('Conta B', 300.00);

START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
-- saldo = 500
UPDATE Conta SET saldo = saldo + 100 WHERE id = 1;

commit;
rollback;
SELECT * FROM Conta;
-- Aguarde antes do COMMIT para simular concorrência
-- SHOW VARIABLES LIKE 'tx_isolation';
-- SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1 for update;

START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1 LOCK IN SHARE MODE;




-- START TRANSACTION;
-- LOCK TABLE Conta write;
-- SELECT saldo FROM Conta WHERE id = 1; -- Bloqueia a Conta A
-- UPDATE Conta SET saldo = saldo + 100 WHERE id = 1;
-- UNLOCK TABLES;
-- -- Aguarde antes de dar COMMIT para simular concorrência
-- -- COMMIT;
-- 
-- rollback;
-- 
-- START TRANSACTION;
-- SELECT saldo FROM Conta WHERE id = 1 ; -- Também tenta acessar a Conta A
-- UPDATE Conta SET saldo = saldo - 50 WHERE id = 1;
-- UPDATE Conta SET saldo = saldo + 50 WHERE id = 2;
-- 
-- -- Aguarde antes de dar COMMIT
-- COMMIT;
-- 

-- SHOW CREATE TABLE Conta;
-- 


