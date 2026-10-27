-- ============================================================
-- INSERTs da Biblioteca (SQLite)
-- Rode DEPOIS do banco.sql (que cria a tabela livros).
--   sqlite3 banco/biblioteca.db < banco/inserts.sql
-- ============================================================

-- Vários livros de uma vez
INSERT INTO livros (titulo, autor, ano, genero, status) VALUES
  ('Vidas Secas',                    'Graciliano Ramos',        1938, 'Romance',    'Disponível'),
  ('Capitães da Areia',              'Jorge Amado',             1937, 'Romance',    'Disponível'),
  ('Grande Sertão: Veredas',         'Guimarães Rosa',          1956, 'Romance',    'Emprestado'),
  ('A Hora da Estrela',              'Clarice Lispector',       1977, 'Romance',    'Disponível'),
  ('O Alienista',                    'Machado de Assis',        1882, 'Conto',      'Disponível'),
  ('Quarto de Despejo',              'Carolina Maria de Jesus', 1960, 'Diário',     'Emprestado'),
  ('O Quinze',                       'Rachel de Queiroz',       1930, 'Romance',    'Disponível'),
  ('Harry Potter e a Pedra Filosofal', 'J. K. Rowling',         2000, 'Fantasia',   'Disponível');

-- Um livro sem ano e sem gênero (esses campos são opcionais)
INSERT INTO livros (titulo, autor) VALUES ('Livro sem ficha completa', 'Autor desconhecido');

-- Um livro informando só o necessário; o status vira 'Disponível' sozinho
INSERT INTO livros (titulo, autor, ano, genero)
VALUES ('O Guarani', 'José de Alencar', 1857, 'Romance');
