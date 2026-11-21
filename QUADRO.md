# Quadro do Guia CMD — Prompt de Comando do Windows

Objetivo: um guia estático em pt-BR do Prompt de Comando (`cmd.exe`) do Windows, no mesmo molde do Guia PowerShell: uma aula por comando, saídas reais anonimizadas, missões no modo “cole a saída do terminal”, sem simulador por enquanto.

Esqueleto criado em 20/11/2026 (America/Sao_Paulo) por Tito, em paralelo com o `pssim.js` do PowerShell, por decisão da Nova depois da pergunta do Wallyson. Esqueleto: `671edbe`, quadro com esse hash: `4121b7f`. Lote 1 escrito no mesmo dia, a partir de `_saidas-anon/cmd-lote1.txt` (Mira, checador OK). Sem push.

## Regras (as mesmas do Guia PowerShell)

- **Anonimizar.** No texto e nas saídas só existem a usuária fictícia `ana`, o computador `NOTEBOOK` e o caminho `C:\Users\ana`. Nada da máquina real: nome do computador, usuário, IP, MAC, SID, serial, GUID, nome de rede.
- **Nunca inventar saída.** Se a coleta ainda não chegou, a caixa fica marcada como **a coletar**. Placeholder não é resposta do terminal.
- **Nunca traduzir mensagens de erro.** Elas entram exatamente como o `cmd` escreveu (pt-BR ou en-US). A explicação, em português, vem ao lado.
- **Aulas só a partir de `_saidas-anon/`.** A escrita usa a versão já anonimizada e revisada. O bruto fica em `_saidas/` e não entra no git.
- **`tools/checar-privacidade.sh` OK antes de todo commit.** O script tem padrões embutidos e, se existir, lê a lista real fora do repo (`../.proibido-cmd.txt`, ou `PROIBIDO=caminho`). A Mira mantém esse arquivo, com os valores reais, fora do repositório.
- **Nada vai para o GitHub sem o OK do Wallyson.** Só commit local, `git add` explícito (nunca `-a`), autor `wallyson` / `wallyson@localhost`. Sem push.

## Regras de coleta do CMD (definidas pela Mira)

Só leitura e demo, com `cmd /c`, numa pasta de teste com guarda e caminho absoluto. Sem admin por enquanto. Atenção extra para `ipconfig`, `systeminfo` e `whoami` (revisão da Mira, linha a linha, antes de anonimizar).

- Todo script começa com a guarda `cd /d C:\caminho\absoluto\teste || exit /b 1`.
- Nada de `del` nem `rd /s /q` com variável ou caminho relativo: variável vazia pode virar `rd /s /q \`.
- `del *.*` pede S/N e trava a coleta. Use `/q`, só dentro da pasta de teste.
- Acentos: o CMD sai em cp850. Rode `chcp 65001` antes ou converta na captura.
- Nada de `set` sem filtro (vaza variáveis de ambiente), a mesma regra do `Env:` do PowerShell. A aula de variáveis ensina `set NOME=` só com filtro ou nome.
- O que vaza e o checador precisa pegar (também em minúsculas):
  - o `dir` mostra o serial do volume (`Número de Série do Volume` no formato hex `XXXX-XXXX`; o placeholder anonimizado é `XXXX-XXXX`, com X literais, que não são hex);
  - o `C:\Users\<nome>` de qualquer usuário real (no guia só vale `C:\Users\ana`);
  - o nome do computador em `systeminfo` / `whoami` / `hostname` (no guia vira `NOTEBOOK`; o `whoami` no formato `nome-do-pc\usuario` também, inclusive em minúsculas);
  - o `ipconfig` mostra IPs, MAC (`Endereço Físico`) e sufixo DNS.
- **O `systeminfo` NÃO é coletado.** A aula usa uma saída de exemplo, marcada como exemplo.
- Sem inventar a saída na coleta: o que o `cmd` responder é o que se guarda em `_saidas/`, depois a Mira anonimiza em `_saidas-anon/`.

## Donos

| Papel | Quem |
|---|---|
| Esqueleto, `NIVEIS` (só o Tito edita este arquivo), quadro, site, checador, testes | Tito |
| Listas do lote 1 e script de coleta (`cmd /c`, pasta de teste com guarda) | Luna |
| Revisão linha a linha e anonimização; mantém o `.proibido-cmd.txt` fora do repo | Mira |
| Lote 2, aulas de **arquivo/texto** (pipe com find/findstr/sort/more, attrib, xcopy, robocopy, tree, where, ver) | Tito |
| Lote 2, aulas de **script** (`set`, `if`, `for`, `goto`/`call`, `%errorlevel%`, `&&`/`||`, `.bat`) | Zeca |

Lote 1: Luna (listas e script de coleta, 119 comandos em 9 aulas) e Mira (revisão linha a linha e anonimização em `_saidas-anon/cmd-lote1.txt`). O Tito não coleta: neste Linux não há `cmd.exe`. A escrita das aulas do lote 1 usou só o arquivo anonimizado. O bruto em `_saidas/` não entra no git.

## Agrupamento das aulas

O lote 1 segue as listas da Luna (`/workspace/cmd-coleta/listas-lote1.md`); o `NIVEIS` está alinhado a elas.

- **`md` e `rd` juntos** (`md-rd.html`): criar e apagar pasta são o par natural (um desfaz o outro). A aula cobre também os sinônimos `mkdir` e `rmdir`.
- **`copy`, `move`, `del` e `ren` juntos** (`copy-move-del.html`), como a Luna coletou. O critério inicial do Tito (aulas separadas, com o `del` sozinho por causa do risco e do `del *.*` sem `/q`) ficou para um possível desdobramento futuro. No Nível 2 o `ren.html` agora é uma aula própria, `pronta`, com as saídas do lote 2 (hash `92958ae`); o `ren` também já aparece em `copy-move-del.html` no lote 1.
- **`date /t` e `time /t` em aulas separadas** (Nível 2): uma aula por comando, como a Nova pediu.
- **`find` e `findstr` em aulas separadas** (Nível 2): a sintaxe não é a mesma.

## Nível 1

Legenda do status: lista → coleta → escrita → revisão. O hash entra no commit em que a aula ficou pronta. Escrita do lote 1: Tito, só a partir de `_saidas-anon/cmd-lote1.txt`.

Notas da coleta (Luna) e da fidelidade (Mira): o lote 1 tem **119 comandos em 9 aulas**. `abrir-cmd` e `cls` ficam só no texto (sem saída coletada e sem missão rode-local). O `echo off` é explicado só em texto, sem saída. No `cmd` real há uma linha em branco entre a saída e o próximo prompt; essa linha entra nas sessões exibidas. O `echo texto > arquivo` grava o espaço que vier antes do `>`; o `type` mostra esse espaço no fim (dica nas aulas de `echo` e de redirecionamento). A primeira captura de `type notas.txt relatorio.txt` veio poluída pelo invólucro do PowerShell e não foi usada. A Mira recolheu e anonimizou de novo em `_saidas-anon/recoleta-type.txt` (checador OK): o `cmd` escreve uma linha em branco, o nome do arquivo e mais duas linhas em branco antes do conteúdo de cada arquivo. Essa saída entra na aula `type.html` Hash da recoleta na aula: `193aaa0`.

| Aula | Slug | Dono (lista/coleta · revisão) | Status | Hash |
|---|---|---|---|---|
| Início | `index.html` | Tito (esqueleto) | escrita (capa; sem saída a coletar) | `671edbe` |
| O que é o Prompt de Comando | `introducao.html` | Tito (página modelo) | escrita (esqueleto; um placeholder de missão) | `671edbe` |
| Abrindo o Prompt de Comando | `abrir-cmd.html` | Luna · Mira | escrita (só texto; sem missão) | `553e122` |
| Listando (`dir`) | `dir.html` | Luna · Mira | escrita | `553e122` |
| Mudando de Pasta (`cd`) | `cd.html` | Luna · Mira | escrita | `553e122` |
| Criando e Apagando Pastas (`md` e `rd`) | `md-rd.html` | Luna · Mira | escrita | `553e122` |
| Copiando, Movendo e Apagando (`copy`, `move`, `del` e `ren`) | `copy-move-del.html` | Luna · Mira | escrita | `553e122` |
| Lendo Arquivos (`type`) | `type.html` | Luna · Mira | escrita (recoleta com vários arquivos) | `193aaa0` |
| Escrevendo na Tela (`echo`) | `echo.html` | Luna · Mira | escrita | `553e122` |
| Limpando a Tela (`cls`) | `cls.html` | Luna · Mira | escrita (só texto; sem missão) | `553e122` |
| A Ajuda (`help` e `/?`) | `help.html` | Luna · Mira | escrita | `553e122` |
| Curingas (`*` e `?`) | `curingas.html` | Luna · Mira | escrita | `553e122` |
| Redirecionamento (`>` e `>>`) | `redirecionamento.html` | Luna · Mira | escrita | `553e122` |

O lote 1 é o Nível 1 inteiro (as aulas obrigatórias que a Nova fechou), todas `pronta` no `NIVEIS` (sem `{pronta:false}`). A coleta foi da Luna, no Windows, com as guardas acima; a Mira anonimizou e o checador passou. Bruto em `_saidas/cmd-lote1-bruto.txt` (gitignorado, não apagar nem mover).

## Nível 2

O `ren` já foi apresentado em `copy-move-del.html` no lote 1. Por decisão da Nova, o `ren` ganhou página própria: `ren.html` foi escrito só com as saídas do `ren` em `_saidas-anon/cmd-lote2.txt`, entrou como primeiro item de “Mais sobre Arquivos” e está `pronta` (hash `92958ae`). Cronograma da Nova: aulas do lote 2 escritas até 22:30 de 20/11/2026 (America/Sao_Paulo). A Mira liberou `_saidas-anon/cmd-lote2.txt` (checador OK). O Tito preencheu 10 aulas de arquivo/texto com essas saídas (hash `c68c500`). A captura do `tree` naquele arquivo veio com as linhas gráficas perdidas e foi descartada. A Mira anonimizou a recoleta em `_saidas-anon/cmd-lote2c.txt` (acentos e `├───` `│` `└───` inteiros; `/a` com `+---`, `|` e `\---`; serial `XXXX-XXXX`). O Tito preencheu o `tree.html` só com essa recoleta (`tree`, `tree /f` e `tree /f /a`), finalizou as metas, tirou a nota de recoleta e marcou a página `pronta` no `NIVEIS`. Hash da aula `tree`: `91b90cf`. A Mira anonimizou a recoleta do `tree pasta-nao-existe` em `_saidas-anon/cmd-lote2d.txt`. A seção “Quando dá errado” voltou ao `tree.html` com essa saída literal (serial `XXXXXXXX XXXX:XXXX`; mensagem `Caminho inválido`). Hash: `15d4448`.

Donos do lote 2: **Tito** (arquivo/texto) e **Zeca** (script). O Tito é o único que edita o `NIVEIS` em `assets/site.js`.

### Aulas do Tito (arquivo/texto)

| Aula | Slug | Status | Hash |
|---|---|---|---|
| Procurando Texto (`find`) | `find.html` | escrita (lote 2, saídas reais) | `c68c500` |
| Procurando com `findstr` | `findstr.html` | escrita (lote 2, saídas reais) | `c68c500` |
| Página a Página (`more`) | `more.html` | escrita (lote 2, saídas reais) | `c68c500` |
| Ordenando (`sort`) | `sort.html` | escrita (lote 2, saídas reais) | `c68c500` |
| O Encadeamento (pipe) | `pipe.html` | escrita (lote 2, saídas reais) | `c68c500` |
| Atributos (`attrib`) | `attrib.html` | escrita (lote 2, saídas reais) | `c68c500` |
| Copiando Pastas (`xcopy`) | `xcopy.html` | escrita (lote 2, saídas reais) | `c68c500` |
| Cópia Robusta (`robocopy`) | `robocopy.html` | escrita (lote 2, saídas reais; só na pasta de teste, sem `/MIR` nas missões) | `c68c500` |
| Árvore de Pastas (`tree`) | `tree.html` | escrita (recoleta lote 2c, saídas reais de `tree`, `tree /f` e `tree /f /a`) | `91b90cf` |
| Onde Está o Comando (`where`) | `where.html` | escrita (lote 2, saídas reais) | `c68c500` |
| A Versão do Windows (`ver`) | `ver.html` | escrita (lote 2, saídas reais) | `c68c500` |

Coleta do lote 2 em `_saidas-anon/cmd-lote2.txt` e recoleta do `tree` em `_saidas-anon/cmd-lote2c.txt`. As 11 aulas do Tito estão escritas e `pronta`. O Zeca fechou as 7 aulas de script no `c7a06d0`; o Tito tirou o `{pronta:false}` delas no `NIVEIS` (`87709f0`), sem editar o conteúdo dessas páginas. No mesmo commit, a meta `src:\+2` do `more.html` foi trocada por `src:more [+]2` (a barra invertida do `+` na regex do atributo era frágil) e a caixa placeholder do `tree pasta-nao-existe` saiu da aula. O checador embutido cobre o serial do volume nos formatos `XXXX-XXXX` e `XXXX:XXXX`, com janela maior depois do rótulo.

### Aulas do Zeca (script) — ele escreve; o Tito não mexe nesses arquivos

`variaveis.html` (`set` / `%VAR%`, só com filtro ou nome), `if.html`, `for.html`, `goto.html` / `call.html`, `%errorlevel%`, `encadeamento.html` (`&&` / `||`), `arquivos-bat.html`. Conteúdo escrito pelo Zeca no `c7a06d0`; `pronta` no `NIVEIS` no `87709f0`. Também `setlocal.html` e `parametros.html` (conteúdo `07bf305`; `pronta` no `NIVEIS` no `92958ae`, ainda no Nível 3). O Zeca não edita o `NIVEIS`; se criar páginas novas, o Tito inclui o slug.

A Mira liberou `_saidas-anon/cmd-lote2e.txt` (checador OK; hostname `NOTEBOOK`; PID `12345`). O Tito preencheu `date.html`, `time.html`, `hostname.html` e `tasklist.html` só com essa saída, finalizou as metas e as marcou `pronta`. Cabeçalhos cortados do `tasklist` (`Identifi`, `Uso de memór`) entraram como vieram. O Zeca fechou `choice.html` e `timeout.html` no `2ce28c3`; o Tito as marcou `pronta` no `NIVEIS`, ainda no Nível 3, sem editar as páginas. Hash: `64233e9`. O Nível 2 ficou sem páginas “em breve”. No Nível 3 restam 7: `taskkill`, `sc-query`, `ipconfig`, `ping`, `systeminfo`, `whoami` e `shutdown`.


## Nível 3 (proposta) — notas de privacidade e admin

| Aula | Slug | Nota |
|---|---|---|
| Arquivos `.bat` | `arquivos-bat.html` |  |
| `if` | `if.html` |  |
| `for` | `for.html` |  |
| `goto` e rótulos | `goto.html` |  |
| `call` | `call.html` |  |
| `setlocal` | `setlocal.html` |  |
| Parâmetros `%1` | `parametros.html` |  |
| `choice` | `choice.html` |  |
| `timeout` | `timeout.html` |  |
| `taskkill` | `taskkill.html` | cuidado: encerra processos; só demo com processo de teste, sem admin por enquanto |
| `sc query` | `sc-query.html` | leitura; atenção ao nome da máquina se aparecer |
| `ipconfig` | `ipconfig.html` | **privacidade:** IPs, MAC (`Endereço Físico`), sufixo DNS; revisão da Mira |
| `ping` | `ping.html` | destino de exemplo (não vazar host interno real) |
| `systeminfo` | `systeminfo.html` | **privacidade:** **não coletar**; a aula usa saída de exemplo, marcada como exemplo |
| `whoami` | `whoami.html` | **privacidade:** nome do computador e do usuário (também em minúsculas); revisão da Mira |
| `shutdown` | `shutdown.html` | cuidado / admin: não executar de verdade na coleta; ilustrativo |

## Entrega das 21:00 (20/11/2026, America/Sao_Paulo)

- [x] Esqueleto em `/workspace/planos-trabalho/guia-cmd` (git local, sem push) — `671edbe`; quadro com o hash — `4121b7f`
- [x] `NIVEIS` em 3 níveis, slugs em kebab-case alinhados às listas da Luna; lote 1 (index, introdução e as 11 páginas do Nível 1) sem `{pronta:false}`; Níveis 2 e 3 continuam `{pronta:false}`
- [x] Lote 1 coletado (bruto gitignorado) e anonimizado pela Mira em `_saidas-anon/cmd-lote1.txt`
- [x] Lote 1 escrito (9 aulas com saída real + `abrir-cmd` e `cls` só em texto), missões rode-local, checador de privacidade OK, `testar-missoes.js` e `testar-navegador.js --todas` OK (18 “Missão cumprida!” com a saída real, 76 negativos sem falso positivo; `introducao` “Quase lá!” com `(sem saída)`). Hash do lote: `553e122`.
- [x] Telas de duas aulas: `/workspace/telas/cmd-dir.png` e `/workspace/telas/cmd-echo.png` (fora do repo)

## Entrega das 22:30 (20/11/2026, America/Sao_Paulo)

- [x] Recoleta do `tree` em `_saidas-anon/cmd-lote2c.txt` (Mira). Aula `tree.html` preenchida com `tree`, `tree /f` e `tree /f /a`; nota de recoleta removida; `pronta` no `NIVEIS`. Hash: `91b90cf`.
- [x] Checador com `PROIBIDO` OK; `testar-missoes.js` OK (41 missões, 0 problema); `testar-navegador.js --todas` OK: 31 páginas, 0 com problema; 60 caixas; 240 negativos, 0 falso positivo; 15 “Quase lá!”; 45 “Missão cumprida!” com a saída real. Sem push. As 7 páginas do Zeca não foram tocadas.
- [x] Zeca fechou as 7 aulas de script (`c7a06d0`). `NIVEIS` atualizado (sem `{pronta:false}` em `variaveis`, `encadeamento`, `arquivos-bat`, `if`, `for`, `goto` e `call`). Meta do `more.html` corrigida (`src:more [+]2` no lugar de `src:\+2`); caixa do `tree pasta-nao-existe` removida, para o lote 3. Hash: `87709f0`.
- [x] Checador com `PROIBIDO` OK; `testar-missoes.js` OK (60 missões, 0 problema, inclusive as do Zeca); `testar-navegador.js --todas` OK: 31 páginas, 0 com problema; 60 caixas; 240 negativos, 0 falso positivo; 1 “Quase lá!”; 59 “Missão cumprida!” com a saída real. Sem push.
- [x] Recoleta do `tree pasta-nao-existe` em `_saidas-anon/cmd-lote2d.txt` (Mira). Seção “Quando dá errado” recolocada com a saída literal e missão `outre:Caminho inválido`. Hash: `15d4448`. Checador OK; `testar-missoes.js`: 61 missões, 0 problema; `testar-navegador.js --todas`: 31 páginas, 0 com problema; 61 caixas; 244 negativos, 0 falso positivo; 1 “Quase lá!”; 60 “Missão cumprida!”. Sem push. `cmd-lote2b.txt` não foi adicionado.

## Entrega das 23:30 (20/11/2026, America/Sao_Paulo)

- [x] `ren.html` escrito só com as saídas do lote 2, missões com metas que não batem com o comando colado, link para `copy-move-del.html`. `NIVEIS`: `ren` como primeiro item de “Mais sobre Arquivos”, `pronta`. No mesmo commit, `setlocal.html` e `parametros.html` (Zeca, `07bf305`) saíram de `{pronta:false}` e permaneceram no Nível 3, no mesmo lugar. Hash: `92958ae`.
- [x] Esqueletos de `tasklist.html`, `date.html`, `time.html` e `hostname.html`, `{pronta:false}`, com « saída a coletar ». `_saidas-anon/cmd-lote2e.txt` ainda não chegou. Hash: `8a3924a`.
- [x] Checador com `PROIBIDO` OK; `testar-missoes.js` OK (69 missões, 0 problema, inclusive `ren`, `setlocal` e `parametros`); `testar-navegador.js --todas` OK: 38 páginas, 0 com problema; 74 caixas; 296 negativos, 0 falso positivo; 6 “Quase lá!”; 68 “Missão cumprida!”. Sem push. Páginas do Zeca não foram editadas.

## Entrega das 23:20 (20/11/2026, America/Sao_Paulo)

- [x] Lote 2e preenchido (`date`, `time`, `hostname`, `tasklist`) a partir de `_saidas-anon/cmd-lote2e.txt`. `choice` e `timeout` (Zeca, `2ce28c3`) prontos no `NIVEIS`, no Nível 3. Hash: `64233e9`.
- [x] Checador com `PROIBIDO` OK; `testar-missoes.js` OK (81 missões, 0 problema); `testar-navegador.js --todas` OK: 40 páginas, 0 com problema; 81 caixas; 324 negativos, 0 falso positivo; 1 “Quase lá!”; 80 “Missão cumprida!”. Sem push. Nível 2: 0 “em breve”. Nível 3: 7 “em breve”.
