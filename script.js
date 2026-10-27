// ====== Biblioteca: cadastrar, editar e excluir livros ======
// Os dados ficam salvos no localStorage do navegador.

const CHAVE = "biblioteca-livros";

const form = document.getElementById("form-livro");
const campoId = document.getElementById("livro-id");
const campoTitulo = document.getElementById("titulo");
const campoAutor = document.getElementById("autor");
const campoAno = document.getElementById("ano");
const campoGenero = document.getElementById("genero");
const campoStatus = document.getElementById("status");
const btnSalvar = document.getElementById("btn-salvar");
const btnCancelar = document.getElementById("btn-cancelar");
const tituloForm = document.getElementById("titulo-form");
const lista = document.getElementById("lista");
const vazio = document.getElementById("vazio");
const contador = document.getElementById("contador");
const busca = document.getElementById("busca");

let livros = carregar();

// ---------- Armazenamento ----------
function carregar() {
  try {
    const dados = JSON.parse(localStorage.getItem(CHAVE));
    return Array.isArray(dados) ? dados : [];
  } catch (erro) {
    return [];
  }
}

function salvar() {
  localStorage.setItem(CHAVE, JSON.stringify(livros));
}

function novoId() {
  return Date.now().toString(36) + Math.random().toString(36).slice(2, 7);
}

// ---------- Segurança: evita injetar HTML pelos campos ----------
function escapar(texto) {
  const div = document.createElement("div");
  div.textContent = texto;
  return div.innerHTML;
}

// ---------- Renderização ----------
function renderizar() {
  const termo = busca.value.trim().toLowerCase();

  const filtrados = livros.filter((l) =>
    [l.titulo, l.autor, l.genero].some((c) => (c || "").toLowerCase().includes(termo))
  );

  lista.innerHTML = filtrados
    .map((l) => {
      const classeSelo = l.status === "Disponível" ? "selo-disponivel" : "selo-emprestado";
      const editando = l.id === campoId.value ? "editando" : "";
      return `
        <tr class="${editando}">
          <td>${escapar(l.titulo)}</td>
          <td>${escapar(l.autor)}</td>
          <td>${l.ano ? escapar(String(l.ano)) : "-"}</td>
          <td>${l.genero ? escapar(l.genero) : "-"}</td>
          <td><span class="selo ${classeSelo}">${escapar(l.status)}</span></td>
          <td class="acoes">
            <button class="btn btn-editar" data-acao="editar" data-id="${l.id}">Editar</button>
            <button class="btn btn-excluir" data-acao="excluir" data-id="${l.id}">Excluir</button>
          </td>
        </tr>`;
    })
    .join("");

  contador.textContent = livros.length;
  vazio.hidden = filtrados.length > 0;
  vazio.textContent = livros.length === 0
    ? "Nenhum livro cadastrado ainda. Use o formulário acima!"
    : "Nenhum livro encontrado para essa busca.";
}

// ---------- Cadastrar / Editar ----------
form.addEventListener("submit", (evento) => {
  evento.preventDefault();

  const dados = {
    titulo: campoTitulo.value.trim(),
    autor: campoAutor.value.trim(),
    ano: campoAno.value ? Number(campoAno.value) : "",
    genero: campoGenero.value.trim(),
    status: campoStatus.value,
  };

  if (!dados.titulo || !dados.autor) {
    return;
  }

  if (campoId.value) {
    // Editar
    const indice = livros.findIndex((l) => l.id === campoId.value);
    if (indice !== -1) {
      livros[indice] = { ...livros[indice], ...dados };
    }
  } else {
    // Cadastrar
    livros.push({ id: novoId(), ...dados });
  }

  salvar();
  sairDoModoEdicao();
  renderizar();
});

function entrarNoModoEdicao(id) {
  const livro = livros.find((l) => l.id === id);
  if (!livro) return;

  campoId.value = livro.id;
  campoTitulo.value = livro.titulo;
  campoAutor.value = livro.autor;
  campoAno.value = livro.ano;
  campoGenero.value = livro.genero;
  campoStatus.value = livro.status;

  tituloForm.textContent = "Editar livro";
  btnSalvar.textContent = "Salvar alterações";
  btnCancelar.hidden = false;

  renderizar();
  form.scrollIntoView({ behavior: "smooth", block: "start" });
  campoTitulo.focus();
}

function sairDoModoEdicao() {
  form.reset();
  campoId.value = "";
  tituloForm.textContent = "Cadastrar livro";
  btnSalvar.textContent = "Cadastrar";
  btnCancelar.hidden = true;
}

btnCancelar.addEventListener("click", () => {
  sairDoModoEdicao();
  renderizar();
});

// ---------- Excluir ----------
function excluir(id) {
  const livro = livros.find((l) => l.id === id);
  if (!livro) return;

  if (!confirm(`Excluir o livro "${livro.titulo}"?`)) return;

  livros = livros.filter((l) => l.id !== id);
  salvar();

  // Se estava editando justamente esse livro, limpa o formulário
  if (campoId.value === id) {
    sairDoModoEdicao();
  }
  renderizar();
}

// ---------- Cliques nos botões da tabela ----------
lista.addEventListener("click", (evento) => {
  const botao = evento.target.closest("button[data-acao]");
  if (!botao) return;

  const { acao, id } = botao.dataset;
  if (acao === "editar") entrarNoModoEdicao(id);
  if (acao === "excluir") excluir(id);
});

// ---------- Busca ----------
busca.addEventListener("input", renderizar);

// ---------- Início ----------
renderizar();
