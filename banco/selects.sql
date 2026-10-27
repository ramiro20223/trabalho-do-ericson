-- ============================================================
-- SELECTs da Biblioteca (SQLite)
--   sqlite3 -header -column banco/biblioteca.db < banco/selects.sql
-- Funcionam melhor depois de rodar o inserts.sql
-- ============================================================

-- 1) Todos os livros
SELECT * FROM livros;

-- 2) Só título e autor
SELECT titulo, autor FROM livros;

-- 3) Livros disponíveis para empréstimo
SELECT titulo, autor FROM livros WHERE status = 'Disponível';

-- 4) Livros emprestados
SELECT titulo, autor FROM livros WHERE status = 'Emprestado';

-- 5) Livros de um autor
SELECT titulo, ano FROM livros WHERE autor = 'Machado de Assis';

-- 6) Livros publicados antes de 1900
SELECT titulo, ano FROM livros WHERE ano < 1900 ORDER BY ano;

-- 7) Títulos que começam com a letra O
SELECT titulo FROM livros WHERE titulo LIKE 'O%';

-- 8) Busca por título, autor ou gênero (igual à busca da página)
SELECT * FROM livros
 WHERE titulo LIKE '%machado%' OR autor LIKE '%machado%' OR genero LIKE '%machado%';

-- 9) Do livro mais antigo para o mais novo (os sem ano ficam por último)
SELECT titulo, ano FROM livros ORDER BY ano IS NULL, ano ASC;

-- 10) Os 3 livros mais antigos
SELECT titulo, ano FROM livros WHERE ano IS NOT NULL ORDER BY ano ASC LIMIT 3;

-- 11) Autores sem repetição
SELECT DISTINCT autor FROM livros ORDER BY autor;

-- 12) Livros sem gênero cadastrado
SELECT titulo FROM livros WHERE genero IS NULL;

-- 13) Quantos livros existem
SELECT COUNT(*) AS total_livros FROM livros;

-- 14) Quantos livros há em cada status
SELECT status, COUNT(*) AS total FROM livros GROUP BY status;

-- 15) Quantos livros há de cada autor (do que tem mais para o que tem menos)
SELECT autor, COUNT(*) AS total_livros
  FROM livros
 GROUP BY autor
 ORDER BY total_livros DESC, autor;

-- 16) Só os autores com mais de um livro
SELECT autor, COUNT(*) AS total_livros
  FROM livros
 GROUP BY autor
HAVING COUNT(*) > 1;

-- 17) Quantos livros há em cada gênero
SELECT COALESCE(genero, '(sem gênero)') AS genero, COUNT(*) AS total
  FROM livros
 GROUP BY genero
 ORDER BY total DESC;
