START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
-- tbm retorna saldo = 500 (antes de T1 salvar)
UPDATE Conta SET saldo = saldo - 50 WHERE id = 1;
COMMIT;
