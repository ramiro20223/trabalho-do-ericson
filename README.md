# Biblioteca

Sistema simples de biblioteca feito com **HTML, CSS e JavaScript** puros.

## Funções

- **Cadastrar** livros (título, autor, ano, gênero e status)
- **Editar** livros já cadastrados
- **Excluir** livros (com confirmação)
- **Buscar** por título, autor ou gênero

Os dados ficam salvos no `localStorage` do navegador, então continuam lá mesmo depois de fechar a página.

## Como usar

Abra o arquivo `index.html` no navegador. Não precisa instalar nada.

## Arquivos

| Arquivo | Para que serve |
| --- | --- |
| `index.html` | Estrutura da página |
| `style.css` | Visual |
| `script.js` | Lógica (cadastrar, editar, excluir, buscar) |
| `banco/banco.sql` | Script do banco de dados (SQLite): cria a tabela `livros` e dados de exemplo |
| `banco/biblioteca.db` | Banco SQLite já pronto, gerado a partir do `banco.sql` |
| `banco/inserts.sql` | INSERTs: mais 10 livros para a tabela `livros` |
| `banco/selects.sql` | 17 SELECTs prontos (filtros, busca, ordenação, contagens e agrupamentos) |
| `banco/listas-sql/biblioteca_seunome.sql` | Listas de SQL da disciplina (Listas 1 a 5 e desafio), em sintaxe MySQL |

## Banco de dados

A tabela `livros` tem os mesmos campos do sistema:

| Campo | Tipo | Regra |
| --- | --- | --- |
| `id` | INTEGER | chave primária, automática |
| `titulo` | TEXT | obrigatório |
| `autor` | TEXT | obrigatório |
| `ano` | INTEGER | opcional, de 1 a 2100 |
| `genero` | TEXT | opcional |
| `status` | TEXT | `Disponível` ou `Emprestado` |
| `criado_em` | TEXT | data de cadastro, automática |

Para recriar o banco do zero:

```bash
sqlite3 banco/biblioteca.db < banco/banco.sql
```

Para adicionar mais livros e rodar as consultas:

```bash
sqlite3 banco/biblioteca.db < banco/inserts.sql
sqlite3 -header -column banco/biblioteca.db < banco/selects.sql
```

No final do `banco.sql` estão os comandos de cadastrar, editar, excluir, listar e buscar.

> Observação: a página `index.html` ainda guarda os dados no `localStorage`. O banco fica pronto para ser ligado a um servidor (Node, PHP, Python...) depois.
