-- 1 --
-- Simulando uma tentativa de resposta de uma equipe para uma questão
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 1, "Abrimos uma transação com multiplas operações e induzimos uma ao erro, repetindo um email existente. Isso testa tanto a atomicidade fazendo o rollback de todas as transações quanto a consistência, por não permitir um mesmo valor em um campo unique");

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 1, "
Active: A transação está ativa e pronta pra receber operações como inserção, updates e etc;
Partially Committed: As operações foram executadas sem erros e esperam um commit para se tornarem permanentes ou rollback para abortar;
Failed: Acontece quando a transação falha por um motivo qualquer e o banco precisa dá rollback nas operaçoes da transação e voltar ao seu estado anterior para manter a consistencia;
Aborted: O rollback é executado e o banco está de volta ao seu estado anterior;
Commited: As operações foram concluídas e a transação foi persistida no banco e não pode mais ser revertida.
");

-- Log de uma transação realizada na questão
INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 1, "A equipe abriu um begin transaction e inseriu dois registros na tabela aluno com email duplicado");

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 1, "USE ProjetoBDII;
start transaction;
INSERT INTO Alunos (nome, email, matricula) VALUES ('Robin Willians', 'rw@gmail.com', '0000');
INSERT INTO Alunos (nome, email, matricula) values ('Lucas Santos', 'cantao162@gmail.com', '2012300130');
commit;");

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 1, "#1062 - Entrada 'cantao162@gmail.com' duplicada para a chave 'email'");
-- Log de uma transação realizada na questão



-- 2 --
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 2, "Serial: as transações são feitas sequencialmente de forma integral e sem sobreposição;
Equivalente a serial: As transações são executadas de forma concorrente desde que o resultado final seja o mesmo da serial.");

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 2, "A equipe criou uma tabela conta com atributos id e saldo;
A seguir a equipe inseriu valores em duas contas diferentes:
INSERT INTO Conta (nome, saldo) VALUES ('Conta A', 500.00);
INSERT INTO Conta (nome, saldo) VALUES ('Conta B', 300.00);");

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 2, "-- T1
START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
UPDATE Conta SET saldo = saldo + 100 WHERE id = 1;");

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 2, "-- T2
START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
UPDATE Conta SET saldo = saldo - 50 WHERE id = 1;
UPDATE Conta SET saldo = saldo + 50 WHERE id = 2;
COMMIT;
");



-- 3 --
INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 3, "Lost Update: duas trnasações leêm o mesmo valor de saldo e fazem commit, a segunda sobrescreve a primeira, apagando a alteração;
Dirty Read: Uma transação lê um valor de outra transação que ainda não foi confirmada, quando essa transação sofre um rollback, o valor lido anteriormente se torna comprometido.
Non-Repeatable Read: Uma transação lê um valor, logo em seguida esse valor é alteradoe commitado por outra transação, ao ler o valor novamente a primeira transação encontra um valor diferente dentro da mesma transação.");

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 3, "A equipe abriu uma transação e execultou uma operação de update (saldo = saldo + 100) na conta de id = 1;
Após isso, uma nova transação foi aberta subtraindo valor dessa conta (saldo = saldo - 50), após dar commit, o primeiro update é perdido");

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 3, "-- T1
START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
-- saldo = 500
UPDATE Conta SET saldo = saldo + 100 WHERE id = 1;")

INSERT INTO Logs_Testes (equipe_id, questao_id, evento) VALUES
(1, 3, "-- T2
START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
-- tbm retorna saldo = 500 (antes de T1 salvar)
UPDATE Conta SET saldo = saldo - 50 WHERE id = 1;
COMMIT;");

-- 5 --

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 5, "Bloqueio exclusivo: transações que tentem ler ou escrever em um campo bloqueado devem esperar na fila até que o valor seja liberado
Bloqueio compartilhado: Permite que outras transações leiam o mesmo valor ao mesmo tempo, mas impede operações de escrita");

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 5, "A equipe abriu uma transação e execultou atribuio um lock, após isso foi executado uma outra transação de leitura e escrita, onde a escrita ficou travada até a liberação da operação anterior");

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 5, "START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1 LOCK IN SHARE MODE;");

INSERT INTO Tentativas (equipe_id, questao_id, resposta) VALUES
(1, 5, "START TRANSACTION;
SELECT saldo FROM Conta WHERE id = 1;
UPDATE Conta SET saldo = saldo - 50 WHERE id = 1;");