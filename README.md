# Guia CMD

Site: https://wallysondevs.github.io/guia-cmd/

Curso do Prompt de Comando (`cmd`) do Windows em português, feito para quem **nunca usou o terminal**. Funciona como uma escola: uma aula para cada comando, organizadas em **3 níveis** (47 páginas). Vai de `dir`, `cd`, copiar e apagar arquivos e curingas até redirecionamento, arquivos `.bat` e os comandos do dia a dia, como `ping`, `ipconfig`, `tasklist` e `robocopy`.

Cada aula explica o comando e mostra a saída real, conferida no `cmd` de verdade. As mensagens de erro aparecem exatamente como o Prompt de Comando escreve, sem tradução, com a explicação em português ao lado. Nos exemplos, a usuária é sempre a fictícia `ana`.

Para praticar, as páginas trazem a caixa **"Rode no Prompt de Comando"** (`.trycmd`). Ela não tem simulador: você usa o seu próprio `cmd`.

1. Leia a missão e clique em **Copiar código**.
2. Rode o código no Prompt de Comando do seu Windows.
3. Cole a saída na caixa e clique em **Conferir**: a caixa diz se você chegou ao resultado pedido.
4. Depois do primeiro **Conferir**, o botão **Ver solução** é liberado.

A caixa é montada por `assets/rode-local.js`. O código e a saída colada ficam só na página: nada é enviado nem guardado no navegador.

Site 100% estático (HTML + CSS + JS, sem build e sem dependências externas): abre direto no navegador e funciona no GitHub Pages.

## Estrutura

```
index.html                 página inicial
<tema>.html                uma aula por comando
assets/style.css           visual
assets/site.js             níveis/menu (lista NIVEIS), Anterior/Próximo, exercícios
assets/rode-local.js       a caixa "Rode no Prompt de Comando" (.trycmd)
assets/rode-local.css      visual da caixa
tools/testar-missoes.js    confere a estrutura de cada caixa e as metas do código
tools/testar-navegador.js  abre as páginas num Chrome sem janela e confere as caixas
tools/checar-privacidade.sh  procura dados de máquina real nas páginas e no histórico
.nojekyll                  faz o GitHub Pages servir os arquivos como estão
```

## Testes

```bash
node tools/testar-missoes.js                 # todas as caixas
node tools/testar-missoes.js --secao "Começando"   # só uma seção do menu
node tools/testar-navegador.js --todas       # todas as páginas num Chrome sem janela (precisa do puppeteer-core em tools/node_modules)
bash tools/checar-privacidade.sh             # privacidade: rode antes de todo commit
```

## Publicar no GitHub Pages

Envie a pasta para um repositório e ative **Settings → Pages → Deploy from a branch → main / (root)**.

## Adicionar uma aula

Inclua a página na lista `NIVEIS` de `assets/site.js` e rode `bash tools/checar-privacidade.sh` antes do commit.
