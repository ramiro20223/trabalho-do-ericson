-- =====================================================================
-- Arquivo: biblioteca_seunome.sql
-- Banco de Dados - Listas de SQL: Projeto Biblioteca
-- Aluno(a): SEU NOME AQUI          Turma: SUA TURMA
-- SGBD: MySQL (comandos CREATE DATABASE, USE e SHOW TABLES)
--
-- Execute na ordem e não apague o banco entre uma lista e outra.
-- Os comandos 2.6 e 4.10b DEVEM dar erro (é o objetivo do exercício).
-- Se você rodar o arquivo inteiro de uma vez, o cliente pode parar nesses erros:
-- rode esses dois comandos separados ou use 'mysql --force'.
-- =====================================================================


-- =====================================================================
-- LISTA 1 - CRIANDO A ESTRUTURA (DDL)
-- =====================================================================

-- 1.1) Criar o banco biblioteca e selecioná-lo
CREATE DATABASE biblioteca;
USE biblioteca;

-- 1.2) Criar a tabela editora
CREATE TABLE editora (
  codigo INT PRIMARY KEY,
  nome   VARCHAR(60) NOT NULL,
  cidade VARCHAR(40)
);

-- 1.3) Criar a tabela livro (com a FK para editora)
CREATE TABLE livro (
  codigo  INT PRIMARY KEY,
  titulo  VARCHAR(100) NOT NULL,
  autor   VARCHAR(60)  NOT NULL,
  ano     INT,
  preco   DECIMAL(8,2),
  editora INT,
  CONSTRAINT fk_livro_editora FOREIGN KEY (editora) REFERENCES editora (codigo)
);

-- 1.4) Criar a tabela leitor
CREATE TABLE leitor (
  matricula INT PRIMARY KEY,
  nome      VARCHAR(80) NOT NULL,
  turma     VARCHAR(20),
  telefone  VARCHAR(15)
);

-- 1.5) Criar a tabela emprestimo (FKs para leitor e livro, PK composta)
CREATE TABLE emprestimo (
  leitor   INT,
  livro    INT,
  data_emp DATE,
  data_dev DATE,
  PRIMARY KEY (leitor, livro, data_emp),
  CONSTRAINT fk_emprestimo_leitor FOREIGN KEY (leitor) REFERENCES leitor (matricula),
  CONSTRAINT fk_emprestimo_livro  FOREIGN KEY (livro)  REFERENCES livro (codigo)
);

-- 1.6) Listar todas as tabelas do banco (devem aparecer as 4)
SHOW TABLES;
-- Resultado: 4 linhas
--   name
--   editora
--   emprestimo
--   leitor
--   livro

-- 1.7) Adicionar a coluna email (texto até 80) à tabela leitor
ALTER TABLE leitor ADD COLUMN email VARCHAR(80);
-- Atenção: como leitor agora tem 5 colunas, os INSERTs da Lista 2 usam a lista de colunas
-- (INSERT INTO leitor (matricula, nome, turma, telefone) ...) para não dar erro de quantidade de valores.


-- =====================================================================
-- LISTA 2 - POPULANDO AS TABELAS (INSERT)
-- =====================================================================

-- 2.1) Inserir as 6 editoras
INSERT INTO editora (codigo, nome, cidade) VALUES
  (1, 'Companhia das Letras', 'São Paulo'),
  (2, 'Record',               'Rio de Janeiro'),
  (3, 'Ática',                'São Paulo'),
  (4, 'Moderna',              'São Paulo'),
  (5, 'Rocco',                'Rio de Janeiro'),
  (6, 'Saraiva',              'São Paulo');

-- 2.2) Inserir os 12 livros
INSERT INTO livro (codigo, titulo, autor, ano, preco, editora) VALUES
  (1,  'Dom Casmurro',                     'Machado de Assis',        1899, 39.90, 3),
  (2,  'Memórias Póstumas de Brás Cubas',  'Machado de Assis',        1881, 34.50, 3),
  (3,  'Capitães da Areia',                'Jorge Amado',             1937, 45.00, 2),
  (4,  'Vidas Secas',                      'Graciliano Ramos',        1938, 42.00, 2),
  (5,  'O Cortiço',                        'Aluísio Azevedo',         1890, 38.00, 4),
  (6,  'Grande Sertão: Veredas',           'Guimarães Rosa',          1956, 89.90, 1),
  (7,  'A Hora da Estrela',                'Clarice Lispector',       1977, 49.90, 2),
  (8,  'Iracema',                          'José de Alencar',         1865, 29.90, 4),
  (9,  'O Alienista',                      'Machado de Assis',        1882, 27.50, 3),
  (10, 'Harry Potter e a Pedra Filosofal', 'J. K. Rowling',           2000, 59.90, 5),
  (11, 'Quarto de Despejo',                'Carolina Maria de Jesus', 1960, 52.00, 1),
  (12, 'O Quinze',                         'Rachel de Queiroz',       1930, 36.00, NULL);

-- 2.3) Inserir os 8 leitores
INSERT INTO leitor (matricula, nome, turma, telefone) VALUES
  (101, 'Ana Lima',      '1 ano A', '85999990001'),
  (102, 'Bruno Sá',      '1 ano A', '85999990002'),
  (103, 'Carla Reis',    '1 ano B', '85999990003'),
  (104, 'Diego Alves',   '2 ano A', '85999990004'),
  (105, 'Elisa Nunes',   '2 ano A', NULL),
  (106, 'Felipe Rocha',  '1 ano B', '85999990006'),
  (107, 'Gabriela Dias', '3 ano A', '85999990007'),
  (108, 'Hugo Martins',  '3 ano A', '85999990008');

-- 2.4) Inserir os 15 empréstimos
INSERT INTO emprestimo (leitor, livro, data_emp, data_dev) VALUES
  (101, 1,  '2026-03-02', '2026-03-16'),
  (101, 6,  '2026-03-20', NULL),
  (102, 1,  '2026-03-05', '2026-03-19'),
  (102, 3,  '2026-04-01', '2026-04-15'),
  (103, 7,  '2026-03-10', '2026-03-24'),
  (103, 10, '2026-04-02', NULL),
  (104, 2,  '2026-03-12', '2026-03-26'),
  (104, 4,  '2026-04-05', NULL),
  (105, 10, '2026-03-15', '2026-03-29'),
  (106, 1,  '2026-04-08', NULL),
  (106, 5,  '2026-03-18', '2026-04-01'),
  (107, 11, '2026-03-22', '2026-04-05'),
  (107, 6,  '2026-04-10', NULL),
  (108, 9,  '2026-03-25', '2026-04-08'),
  (108, 3,  '2026-04-12', NULL);

-- 2.5a) Conferir: SELECT na tabela editora
SELECT * FROM editora;
-- Resultado: 6 linhas

-- 2.5b) Conferir: SELECT na tabela livro
SELECT * FROM livro;
-- Resultado: 12 linhas

-- 2.5c) Conferir: SELECT na tabela leitor
SELECT * FROM leitor;
-- Resultado: 8 linhas

-- 2.5d) Conferir: SELECT na tabela emprestimo
SELECT * FROM emprestimo;
-- Resultado: 15 linhas

-- 2.6) Tentar inserir um livro com editora = 99 (ESTE COMANDO DEVE DAR ERRO)
INSERT INTO livro (codigo, titulo, autor, ano, preco, editora)
VALUES (13, 'Livro de Teste', 'Autor de Teste', 2020, 10.00, 99);
-- Mensagem de erro (MySQL 8):
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
-- (`biblioteca`.`livro`, CONSTRAINT `fk_livro_editora` FOREIGN KEY (`editora`) REFERENCES `editora` (`codigo`))
--
-- Explicação: a coluna livro.editora é chave estrangeira de editora.codigo. Isso significa que só pode
-- receber um valor que já exista em editora (ou NULL). Como não existe editora 99, o banco recusou o
-- INSERT para não deixar um livro ligado a uma editora que não existe (integridade referencial).

-- 2.7) Inserir um novo leitor com os seus próprios dados
INSERT INTO leitor (matricula, nome, turma, telefone)
VALUES (109, 'SEU NOME AQUI', 'SUA TURMA', '85999990009');
-- TROQUE 'SEU NOME AQUI' e 'SUA TURMA' pelos seus dados e invente a sua matrícula.
-- Nos resultados anotados abaixo, o leitor 109 foi considerado com a turma '2 ano B' (turma que ainda não existia).


-- =====================================================================
-- LISTA 3 - CONSULTANDO OS DADOS (SELECT)
-- =====================================================================

-- 3.1) Todos os dados de todos os livros
SELECT * FROM livro;
-- Resultado: 12 linhas

-- 3.2) Apenas título e autor de todos os livros
SELECT titulo, autor FROM livro;
-- Resultado: 12 linhas

-- 3.3) Nome e turma dos leitores da turma '1 ano A'
SELECT nome, turma FROM leitor WHERE turma = '1 ano A';
-- Resultado: 2 linhas

-- 3.4) Título e ano dos livros publicados antes de 1900
SELECT titulo, ano FROM livro WHERE ano < 1900;
-- Resultado: 5 linhas

-- 3.5) Título e preço dos livros entre R$ 30,00 e R$ 50,00
SELECT titulo, preco FROM livro WHERE preco BETWEEN 30 AND 50;
-- Resultado: 7 linhas

-- 3.6) Título de todos os livros de Machado de Assis
SELECT titulo FROM livro WHERE autor = 'Machado de Assis';
-- Resultado: 3 linhas

-- 3.7) Título dos livros cujo nome começa com a letra O
SELECT titulo FROM livro WHERE titulo LIKE 'O%';
-- Resultado: 3 linhas

-- 3.8) Nome dos leitores das turmas '1 ano A' ou '1 ano B' (com IN)
SELECT nome FROM leitor WHERE turma IN ('1 ano A', '1 ano B');
-- Resultado: 4 linhas

-- 3.9) Título e preço de todos os livros, do mais caro para o mais barato
SELECT titulo, preco FROM livro ORDER BY preco DESC;
-- Resultado: 12 linhas

-- 3.10) Título e ano dos três livros mais antigos do acervo
SELECT titulo, ano FROM livro ORDER BY ano ASC LIMIT 3;
-- Resultado: 3 linhas

-- 3.11) Lista de autores sem repetição
SELECT DISTINCT autor FROM livro;
-- Resultado: 10 linhas

-- 3.12) Nome dos leitores sem telefone cadastrado
SELECT nome FROM leitor WHERE telefone IS NULL;
-- Resultado: 1 linha
-- Use IS NULL (e não = NULL), porque NULL não é um valor, é ausência de valor.


-- =====================================================================
-- LISTA 4 - ALTERANDO DADOS E RESUMINDO (UPDATE, DELETE E AGREGAÇÃO)
-- =====================================================================

-- 4.1a) Conferir antes: qual livro será alterado (Dom Casmurro)
SELECT codigo, titulo, preco FROM livro WHERE codigo = 1;
-- Resultado: 1 linha
--   codigo | titulo | preco
--   1 | Dom Casmurro | 39.90

-- 4.1b) Atualizar o preço de Dom Casmurro para R$ 44,90
UPDATE livro SET preco = 44.90 WHERE codigo = 1;

-- 4.2a) Conferir antes: leitora Elisa Nunes
SELECT matricula, nome, telefone FROM leitor WHERE matricula = 105;
-- Resultado: 1 linha
--   matricula | nome | telefone
--   105 | Elisa Nunes | NULL

-- 4.2b) Atualizar o telefone de Elisa Nunes
UPDATE leitor SET telefone = '85999990005' WHERE matricula = 105;

-- 4.3a) Conferir antes: editora Rocco
SELECT codigo, nome, cidade FROM editora WHERE codigo = 5;
-- Resultado: 1 linha
--   codigo | nome | cidade
--   5 | Rocco | Rio de Janeiro

-- 4.3b) Atualizar a cidade da editora Rocco para São Paulo
UPDATE editora SET cidade = 'São Paulo' WHERE codigo = 5;

-- 4.4) Quantos livros existem no acervo?
SELECT COUNT(*) AS total_livros FROM livro;
-- Resultado: 1 linha
--   total_livros
--   12

-- 4.5) Qual é o preço médio dos livros?
SELECT ROUND(AVG(preco), 2) AS preco_medio FROM livro;
-- Resultado: 1 linha
--   preco_medio
--   45.79
-- Calculado já com o preço atualizado de Dom Casmurro (44,90).

-- 4.6) Preço do livro mais caro e do mais barato
SELECT MAX(preco) AS mais_caro, MIN(preco) AS mais_barato FROM livro;
-- Resultado: 1 linha
--   mais_caro | mais_barato
--   89.90 | 27.50

-- 4.7) Quantos livros há de cada autor, do que tem mais para o que tem menos
SELECT autor, COUNT(*) AS total_livros
FROM livro
GROUP BY autor
ORDER BY total_livros DESC, autor;
-- Resultado: 10 linhas
--   autor | total_livros
--   Machado de Assis | 3
--   Aluísio Azevedo | 1
--   Carolina Maria de Jesus | 1
--   Clarice Lispector | 1
--   Graciliano Ramos | 1
--   Guimarães Rosa | 1
--   J. K. Rowling | 1
--   Jorge Amado | 1
--   José de Alencar | 1
--   Rachel de Queiroz | 1

-- 4.8) Quantos leitores há em cada turma
SELECT turma, COUNT(*) AS total_leitores
FROM leitor
GROUP BY turma
ORDER BY turma;
-- Resultado: 5 linhas
--   turma | total_leitores
--   1 ano A | 2
--   1 ano B | 2
--   2 ano A | 2
--   2 ano B | 1
--   3 ano A | 2

-- 4.9) Apenas os autores com mais de um livro no acervo
SELECT autor, COUNT(*) AS total_livros
FROM livro
GROUP BY autor
HAVING COUNT(*) > 1;
-- Resultado: 1 linha
--   autor | total_livros
--   Machado de Assis | 3

-- 4.10a) Antes de apagar o leitor 108: ele tem empréstimo registrado?
SELECT * FROM emprestimo WHERE leitor = 108;
-- Resultado: 2 linhas
--   leitor | livro | data_emp | data_dev
--   108 | 3 | 2026-04-12 | NULL
--   108 | 9 | 2026-03-25 | 2026-04-08

-- 4.10b) Tentar apagar o leitor 108 (ESTE COMANDO DEVE DAR ERRO)
DELETE FROM leitor WHERE matricula = 108;
-- Mensagem de erro (MySQL 8):
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails
-- (`biblioteca`.`emprestimo`, CONSTRAINT `fk_emprestimo_leitor` FOREIGN KEY (`leitor`) REFERENCES `leitor` (`matricula`))
--
-- Explicação: o leitor 108 tem 2 empréstimos na tabela emprestimo, que referencia leitor pela chave
-- estrangeira. Apagar o leitor deixaria empréstimos 'órfãos' (ligados a alguém que não existe), então o
-- banco recusa. Para apagar de verdade, primeiro seria preciso apagar os empréstimos dele
-- (DELETE FROM emprestimo WHERE leitor = 108;) e só depois o leitor, ou criar a FK com ON DELETE CASCADE.


-- =====================================================================
-- LISTA 5 - JUNTANDO TABELAS (JOIN)
-- =====================================================================

-- 5.1) Título de cada livro com o nome da editora
SELECT li.titulo, ed.nome AS editora
FROM livro li
INNER JOIN editora ed ON li.editora = ed.codigo;
-- Resultado: 11 linhas
-- O Quinze não aparece porque a editora dele é NULL (INNER JOIN só traz quem tem par). Para listar os 12 livros,
-- troque INNER JOIN por LEFT JOIN.

-- 5.2) Nome do leitor e título do livro de cada empréstimo
SELECT le.nome AS leitor, li.titulo AS livro
FROM emprestimo em
INNER JOIN leitor le ON em.leitor = le.matricula
INNER JOIN livro  li ON em.livro  = li.codigo;
-- Resultado: 15 linhas

-- 5.3) Nome do leitor, título do livro e data do empréstimo, só dos livros NÃO devolvidos
SELECT le.nome AS leitor, li.titulo AS livro, em.data_emp
FROM emprestimo em
INNER JOIN leitor le ON em.leitor = le.matricula
INNER JOIN livro  li ON em.livro  = li.codigo
WHERE em.data_dev IS NULL;
-- Resultado: 6 linhas
--   leitor | livro | data_emp
--   Ana Lima | Grande Sertão: Veredas | 2026-03-20
--   Carla Reis | Harry Potter e a Pedra Filosofal | 2026-04-02
--   Diego Alves | Vidas Secas | 2026-04-05
--   Felipe Rocha | Dom Casmurro | 2026-04-08
--   Gabriela Dias | Grande Sertão: Veredas | 2026-04-10
--   Hugo Martins | Capitães da Areia | 2026-04-12

-- 5.4) Quantos empréstimos cada leitor fez (nome e total), do maior para o menor
SELECT le.nome, COUNT(*) AS total_emprestimos
FROM emprestimo em
INNER JOIN leitor le ON em.leitor = le.matricula
GROUP BY le.matricula, le.nome
ORDER BY total_emprestimos DESC, le.nome;
-- Resultado: 8 linhas
--   nome | total_emprestimos
--   Ana Lima | 2
--   Bruno Sá | 2
--   Carla Reis | 2
--   Diego Alves | 2
--   Felipe Rocha | 2
--   Gabriela Dias | 2
--   Hugo Martins | 2
--   Elisa Nunes | 1
-- Vários leitores empatam com 2 empréstimos, por isso o nome entrou como critério de desempate.

-- 5.5) Os três livros mais emprestados (título e número de empréstimos)
SELECT li.titulo, COUNT(*) AS total_emprestimos
FROM emprestimo em
INNER JOIN livro li ON em.livro = li.codigo
GROUP BY li.codigo, li.titulo
ORDER BY total_emprestimos DESC, li.titulo
LIMIT 3;
-- Resultado: 3 linhas
--   titulo | total_emprestimos
--   Dom Casmurro | 3
--   Capitães da Areia | 2
--   Grande Sertão: Veredas | 2
-- Dom Casmurro é o 1º com 3 empréstimos. Há empate em 2 empréstimos entre Capitães da Areia, Grande Sertão: Veredas
-- e Harry Potter e a Pedra Filosofal, e o LIMIT 3 corta no desempate (aqui, por ordem alfabética do título).

-- 5.6) Quantos livros cada editora tem (LEFT JOIN, incluindo editoras sem livros)
SELECT ed.nome AS editora, COUNT(li.codigo) AS total_livros
FROM editora ed
LEFT JOIN livro li ON li.editora = ed.codigo
GROUP BY ed.codigo, ed.nome
ORDER BY total_livros DESC, ed.nome;
-- Resultado: 6 linhas
--   editora | total_livros
--   Record | 3
--   Ática | 3
--   Companhia das Letras | 2
--   Moderna | 2
--   Rocco | 1
--   Saraiva | 0
-- COUNT(li.codigo) (e não COUNT(*)) conta só os livros de verdade: a Saraiva aparece com 0.

-- 5.7) Quais livros nunca foram emprestados
SELECT li.codigo, li.titulo
FROM livro li
LEFT JOIN emprestimo em ON em.livro = li.codigo
WHERE em.livro IS NULL;
-- Resultado: 2 linhas
--   codigo | titulo
--   8 | Iracema
--   12 | O Quinze

-- 5.8) Qual turma pegou mais livros emprestados (turma e total, em ordem decrescente)
SELECT le.turma, COUNT(*) AS total_emprestimos
FROM emprestimo em
INNER JOIN leitor le ON em.leitor = le.matricula
GROUP BY le.turma
ORDER BY total_emprestimos DESC, le.turma;
-- Resultado: 4 linhas
--   turma | total_emprestimos
--   1 ano A | 4
--   1 ano B | 4
--   3 ano A | 4
--   2 ano A | 3
-- Há empate: 1 ano A, 1 ano B e 3 ano A pegaram 4 livros cada, e 2 ano A pegou 3.


-- =====================================================================
-- DESAFIO FINAL
-- =====================================================================

-- DF) Quais leitores estão com livro atrasado? (sem data_dev e emprestado antes de 09/04/2026)
SELECT le.nome AS leitor, li.titulo AS livro, em.data_emp
FROM emprestimo em
INNER JOIN leitor le ON em.leitor = le.matricula
INNER JOIN livro  li ON em.livro  = li.codigo
WHERE em.data_dev IS NULL
  AND em.data_emp < '2026-04-09'
ORDER BY em.data_emp;
-- Resultado: 4 linhas
--   leitor | livro | data_emp
--   Ana Lima | Grande Sertão: Veredas | 2026-03-20
--   Carla Reis | Harry Potter e a Pedra Filosofal | 2026-04-02
--   Diego Alves | Vidas Secas | 2026-04-05
--   Felipe Rocha | Dom Casmurro | 2026-04-08

