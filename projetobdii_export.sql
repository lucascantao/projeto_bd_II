-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01/04/2025 às 06:30
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `projetobdii`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `matricula` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `alunos`
--

INSERT INTO `alunos` (`id`, `nome`, `email`, `matricula`) VALUES
(1, 'José Lucas', 'cantao162@gmail.com', '201804940008'),
(2, 'Matheus Azevedo', 'matheus@email.com', '0000000000'),
(3, 'Lucas Souza', 'lucas@email.com', '00000000001');

-- --------------------------------------------------------

--
-- Estrutura para tabela `conta`
--

CREATE TABLE `conta` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `saldo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `conta`
--

INSERT INTO `conta` (`id`, `nome`, `saldo`) VALUES
(1, 'Conta A', 550.00),
(2, 'Conta B', 300.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `equipes`
--

CREATE TABLE `equipes` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `equipes`
--

INSERT INTO `equipes` (`id`, `nome`) VALUES
(1, 'Equipe LLM');

-- --------------------------------------------------------

--
-- Estrutura para tabela `equipe_alunos`
--

CREATE TABLE `equipe_alunos` (
  `equipe_id` int(11) NOT NULL,
  `aluno_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `equipe_alunos`
--

INSERT INTO `equipe_alunos` (`equipe_id`, `aluno_id`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `logs_testes`
--

CREATE TABLE `logs_testes` (
  `id` int(11) NOT NULL,
  `equipe_id` int(11) NOT NULL,
  `questao_id` int(11) NOT NULL,
  `evento` varchar(255) NOT NULL,
  `data_evento` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `logs_testes`
--

INSERT INTO `logs_testes` (`id`, `equipe_id`, `questao_id`, `evento`, `data_evento`) VALUES
(1, 1, 1, 'A equipe abriu um begin transaction e inseriu dois registros na tabela aluno com email duplicado', '2025-04-01 01:04:54'),
(2, 1, 1, '(nome, email, matricula) VALUES (\'Robin Willians\', \'rw@gmail.com\', \'0000\'), (nome, email, matricula) values (\'Jack Sparrow\', \'cantao162@gmail.com\', \'2012300130\')', '2025-04-01 01:11:37'),
(3, 1, 1, '#1062 - Entrada \'cantao162@gmail.com\' duplicada para a chave \'email\'', '2025-04-01 01:11:46'),
(4, 1, 1, 'USE ProjetoBDII;\r\nstart transaction;\r\nINSERT INTO Alunos (nome, email, matricula) VALUES (\'Robin Willians\', \'rw@gmail.com\', \'0000\');\r\nINSERT INTO Alunos (nome, email, matricula) values (\'Lucas Santos\', \'cantao162@gmail.com\', \'2012300130\');\r\ncommit;', '2025-04-01 01:24:33'),
(5, 1, 3, '-- T1\r\nSTART TRANSACTION;\r\nSELECT saldo FROM Conta WHERE id = 1;\r\n-- saldo = 500\r\nUPDATE Conta SET saldo = saldo + 100 WHERE id = 1;', '2025-04-01 04:07:58'),
(6, 1, 3, '-- T2\r\nSTART TRANSACTION;\r\nSELECT saldo FROM Conta WHERE id = 1;\r\n-- tbm retorna saldo = 500 (antes de T1 salvar)\r\nUPDATE Conta SET saldo = saldo - 50 WHERE id = 1;\r\nCOMMIT;', '2025-04-01 04:08:02'),
(7, 1, 2, 'A equipe criou uma tabela conta com atributos id e saldo;\r\nA seguir a equipe inseriu valores em duas contas diferentes:\r\nINSERT INTO Conta (nome, saldo) VALUES (\'Conta A\', 500.00);\r\nINSERT INTO Conta (nome, saldo) VALUES (\'Conta B\', 300.00);', '2025-04-01 04:20:37'),
(8, 1, 2, '-- T1\r\nSTART TRANSACTION;\r\nSELECT saldo FROM Conta WHERE id = 1;\r\nUPDATE Conta SET saldo = saldo + 100 WHERE id = 1;', '2025-04-01 04:23:39'),
(9, 1, 2, '-- T2\r\nSTART TRANSACTION;\r\nSELECT saldo FROM Conta WHERE id = 1;\r\nUPDATE Conta SET saldo = saldo - 50 WHERE id = 1;\r\nUPDATE Conta SET saldo = saldo + 50 WHERE id = 2;\r\nCOMMIT;\r\n', '2025-04-01 04:23:41');

-- --------------------------------------------------------

--
-- Estrutura para tabela `questoes`
--

CREATE TABLE `questoes` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `questoes`
--

INSERT INTO `questoes` (`id`, `titulo`, `descricao`) VALUES
(1, 'Estados e Propriedades das Transações (ACID)', 'Verifique a atomicidade e a consistência de uma transação.'),
(2, 'Tipos de Escalonamento de Transações', 'Teste a execução concorrente de transações e analise a ordem dos commits.'),
(3, 'Conflito de Transações', 'Simule duas transações concorrentes e observe os conflitos gerados.'),
(4, 'Seriabilidade de Escalonamento', 'Analise um escalonamento e verifique se ele é serializável.'),
(5, 'Técnicas de Bloqueio de Transações', 'Teste locks em registros para evitar acessos simultâneos indesejados.'),
(6, 'Conversão de Bloqueios', 'Verifique a conversão de bloqueios compartilhados para exclusivos.'),
(7, 'Bloqueios em Duas Fases (2PL)', 'Observe como funciona a fase de crescimento e liberação de bloqueios.'),
(8, 'Deadlock e Starvation', 'Crie um deadlock intencional entre duas transações e veja como o banco reage.'),
(9, 'Protocolos Baseados em Timestamps', 'Teste a execução de transações usando timestamps para escalonamento.'),
(10, 'Protocolos Multiversão (MVCC)', 'Verifique como o banco gerencia múltiplas versões de um mesmo dado.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tentativas`
--

CREATE TABLE `tentativas` (
  `id` int(11) NOT NULL,
  `equipe_id` int(11) NOT NULL,
  `questao_id` int(11) NOT NULL,
  `resposta` text NOT NULL,
  `data_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('CORRETA','INCORRETA','PENDENTE') DEFAULT 'PENDENTE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tentativas`
--

INSERT INTO `tentativas` (`id`, `equipe_id`, `questao_id`, `resposta`, `data_envio`, `status`) VALUES
(1, 1, 1, 'Abrimos uma transação com multiplas operações e induzimos uma ao erro, repetindo um email existente. Isso testa tanto a atomicidade fazendo o rollback de todas as transações quanto a consistência, por não permitir um mesmo valor em um campo unique', '2025-04-01 01:17:17', 'PENDENTE'),
(2, 1, 1, '\r\nActive: A transação está ativa e pronta pra receber operações como inserção, updates e etc;\r\nPartially Committed: As operações foram executadas sem erros e esperam um commit para se tornarem permanentes ou rollback para abortar;\r\nFailed: Acontece quando a transação falha por um motivo qualquer e o banco precisa dá rollback nas operaçoes da transação e voltar ao seu estado anterior para manter a consistencia;\r\nAborted: O rollback é executado e o banco está de volta ao seu estado anterior;\r\nCommited: As operações foram concluídas e a transação foi persistida no banco e não pode mais ser revertida.\r\n', '2025-04-01 01:47:27', 'PENDENTE'),
(3, 1, 2, 'Serial: as transações são feitas sequencialmente de forma integral e sem sobreposição;\r\nEquivalente a serial: As transações são executadas de forma concorrente desde que o resultado final seja o mesmo da serial.', '2025-04-01 02:50:17', 'PENDENTE'),
(4, 1, 3, 'Lost Update: duas trnasações leêm o mesmo valor de saldo e fazem commit, a segunda sobrescreve a primeira, apagando a alteração;\r\nDirty Read: Uma transação lê um valor de outra transação que ainda não foi confirmada, quando essa transação sofre um rollback, o valor lido anteriormente se torna comprometido.\r\nNon-Repeatable Read: Uma transação lê um valor, logo em seguida esse valor é alteradoe commitado por outra transação, ao ler o valor novamente a primeira transação encontra um valor diferente dentro da mesma transação.', '2025-04-01 03:21:47', 'PENDENTE'),
(5, 1, 3, 'A equipe abriu uma transação e execultou uma operação de update (saldo = saldo + 100) na conta de id = 1;\r\nApós isso, uma nova transação foi aberta subtraindo valor dessa conta (saldo = saldo - 50), após dar commit, o primeiro update é perdido', '2025-04-01 04:07:12', 'PENDENTE');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `matricula` (`matricula`);

--
-- Índices de tabela `conta`
--
ALTER TABLE `conta`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `equipes`
--
ALTER TABLE `equipes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `equipe_alunos`
--
ALTER TABLE `equipe_alunos`
  ADD PRIMARY KEY (`equipe_id`,`aluno_id`),
  ADD KEY `aluno_id` (`aluno_id`);

--
-- Índices de tabela `logs_testes`
--
ALTER TABLE `logs_testes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipe_id` (`equipe_id`),
  ADD KEY `questao_id` (`questao_id`);

--
-- Índices de tabela `questoes`
--
ALTER TABLE `questoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tentativas`
--
ALTER TABLE `tentativas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `equipe_id` (`equipe_id`),
  ADD KEY `questao_id` (`questao_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `conta`
--
ALTER TABLE `conta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `equipes`
--
ALTER TABLE `equipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `logs_testes`
--
ALTER TABLE `logs_testes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `questoes`
--
ALTER TABLE `questoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `tentativas`
--
ALTER TABLE `tentativas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `equipe_alunos`
--
ALTER TABLE `equipe_alunos`
  ADD CONSTRAINT `equipe_alunos_ibfk_1` FOREIGN KEY (`equipe_id`) REFERENCES `equipes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `equipe_alunos_ibfk_2` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `logs_testes`
--
ALTER TABLE `logs_testes`
  ADD CONSTRAINT `logs_testes_ibfk_1` FOREIGN KEY (`equipe_id`) REFERENCES `equipes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `logs_testes_ibfk_2` FOREIGN KEY (`questao_id`) REFERENCES `questoes` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tentativas`
--
ALTER TABLE `tentativas`
  ADD CONSTRAINT `tentativas_ibfk_1` FOREIGN KEY (`equipe_id`) REFERENCES `equipes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tentativas_ibfk_2` FOREIGN KEY (`questao_id`) REFERENCES `questoes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
