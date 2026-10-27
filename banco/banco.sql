-- ============================================================
-- Banco de dados da Biblioteca (SQLite)
-- Mesmos campos usados no sistema: título, autor, ano, gênero e status
-- ============================================================

DROP TABLE IF EXISTS livros;

CREATE TABLE livros (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  titulo    TEXT    NOT NULL,
  autor     TEXT    NOT NULL,
  ano       INTEGER CHECK (ano IS NULL OR ano BETWEEN 1 AND 2100),
  genero    TEXT,
  status    TEXT    NOT NULL DEFAULT 'Disponível'
                    CHECK (status IN ('Disponível', 'Emprestado')),
  criado_em TEXT    NOT NULL DEFAULT (datetime('now', 'localtime'))
);

CREATE INDEX idx_livros_titulo ON livros (titulo);
CREATE INDEX idx_livros_autor  ON livros (autor);

-- ------------------------------------------------------------
-- Dados de exemplo
-- ------------------------------------------------------------
INSERT INTO livros (titulo, autor, ano, genero, status) VALUES
  ('Dom Casmurro',                 'Machado de Assis',  1899, 'Romance', 'Disponível'),
  ('Memórias Póstumas de Brás Cubas', 'Machado de Assis', 1881, 'Romance', 'Emprestado'),
  ('O Cortiço',                    'Aluísio Azevedo',   1890, 'Romance', 'Disponível'),
  ('Iracema',                      'José de Alencar',   1865, 'Romance', 'Disponível');

-- ============================================================
-- COMANDOS PRINCIPAIS (use como modelo)
-- ============================================================

-- CADASTRAR
-- INSERT INTO livros (titulo, autor, ano, genero, status)
-- VALUES ('Vidas Secas', 'Graciliano Ramos', 1938, 'Romance', 'Disponível');

-- EDITAR (troque o 1 pelo id do livro)
-- UPDATE livros
--    SET titulo = 'Novo título', autor = 'Novo autor', ano = 1900,
--        genero = 'Novo gênero', status = 'Emprestado'
--  WHERE id = 1;

-- EXCLUIR (troque o 1 pelo id do livro)
-- DELETE FROM livros WHERE id = 1;

-- LISTAR TODOS
-- SELECT * FROM livros ORDER BY titulo;

-- BUSCAR por título, autor ou gênero
-- SELECT * FROM livros
--  WHERE titulo LIKE '%casmurro%' OR autor LIKE '%casmurro%' OR genero LIKE '%casmurro%';
