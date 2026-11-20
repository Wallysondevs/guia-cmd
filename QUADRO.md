# Quadro do Guia CMD — Prompt de Comando do Windows

Objetivo: um guia estático em pt-BR do Prompt de Comando (`cmd.exe`) do Windows, no mesmo molde do Guia PowerShell: uma aula por comando, saídas reais anonimizadas, missões no modo “cole a saída do terminal”, sem simulador por enquanto.

Esqueleto criado em 20/11/2026 (America/Sao_Paulo) por Tito, em paralelo com o `pssim.js` do PowerShell, por decisão da Nova depois da pergunta do Wallyson. Primeira entrega: 21:00 do mesmo dia (esqueleto + `NIVEIS` + lote 1 coletado). Sem push.

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
| Esqueleto, `NIVEIS`, quadro, site, checador, testes | Tito |
| Listas do lote 1 e script de coleta (`cmd /c`, pasta de teste com guarda) | Luna |
| Revisão linha a linha e anonimização; mantém o `.proibido-cmd.txt` fora do repo | Mira |
| Entra no CMD só depois do `pssim.js` do PowerShell | Zeca |

Lote 1: Luna (listas e script de coleta) e Mira (revisão linha a linha e anonimização). O Tito não coleta neste esqueleto: neste Linux não há `cmd.exe`. A pasta `_saidas/` está pronta para a Luna colar o bruto.

## Agrupamento das aulas (critério do Tito)

- **`md` e `rd` juntos** (`md-rd.html`): criar e apagar pasta são o par natural (um desfaz o outro). A aula cobre também os sinônimos `mkdir` e `rmdir`.
- **`copy`, `move` e `del` em aulas separadas:** são operações diferentes, e o `del` merece aula só dele por causa do risco de apagar demais e do `del *.*`, que pede confirmação e trava a coleta se vier sem `/q`.
- **`date /t` e `time /t` em aulas separadas:** uma aula por comando, como a Nova pediu.
- **`find` e `findstr` em aulas separadas:** a sintaxe não é a mesma, e misturar os dois na primeira leitura atrapalha.

## Nível 1

Legenda do status: lista → coleta → escrita → revisão. O hash entra no commit em que a aula ficou pronta. Autor da escrita ainda não está dividido (Zeca entra depois do `pssim.js`).

| Aula | Slug | Dono (lista/coleta · revisão) | Status | Hash |
|---|---|---|---|---|
| Início | `index.html` | Tito (esqueleto) | escrita (capa; sem saída a coletar) | (commit inicial) |
| O que é o Prompt de Comando | `introducao.html` | Tito (página modelo) · Luna/Mira (saídas) | escrita (placeholders “a coletar”) | (commit inicial) |
| Abrindo o Prompt de Comando | `abrir-cmd.html` | Luna · Mira | lista |  |
| Listando (`dir`) | `dir.html` | Luna · Mira | lista |  |
| Mudando de Pasta (`cd`) | `cd.html` | Luna · Mira | lista |  |
| Criando e Apagando Pastas (`md` e `rd`) | `md-rd.html` | Luna · Mira | lista |  |
| Copiando (`copy`) | `copy.html` | Luna · Mira | lista |  |
| Movendo (`move`) | `move.html` | Luna · Mira | lista |  |
| Apagando Arquivos (`del`) | `del.html` | Luna · Mira | lista |  |
| Lendo Arquivos (`type`) | `type.html` | Luna · Mira | lista |  |
| Escrevendo na Tela (`echo`) | `echo.html` | Luna · Mira | lista |  |
| Limpando a Tela (`cls`) | `cls.html` | Luna · Mira | lista |  |
| A Ajuda (`help` e `/?`) | `help.html` | Luna · Mira | lista |  |
| Curingas (`*` e `?`) | `curingas.html` | Luna · Mira | lista |  |
| Redirecionamento (`>` e `>>`) | `redirecionamento.html` | Luna · Mira | lista |  |

O lote 1 é o Nível 1 inteiro (as aulas obrigatórias que a Nova fechou). A coleta em si fica com a Luna, no Windows do Wallyson, com as guardas acima. Este esqueleto deixa `_saidas/` e `_saidas-anon/` prontos; às 21:00 a coleta só entra no quadro se a Luna já tiver colado o bruto.

## Nível 2 (proposta)

`ren`, `xcopy`, `robocopy`, `attrib`, `tree`, `find`, `findstr`, `more`, `sort`, pipe `|`, `&&` / `||`, variáveis `%VAR%` com `set NOME=` (só com filtro ou nome), `where`, `tasklist`, `ver`, `date /t`, `time /t`, `hostname`.

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

- [x] Esqueleto em `/workspace/planos-trabalho/guia-cmd` (git local, sem push)
- [x] `NIVEIS` em 3 níveis, uma aula por comando, slugs em kebab-case; só `index.html` e `introducao.html` com `pronta` implícita (as outras com `{pronta:false}`)
- [ ] Lote 1 coletado — fica com a Luna, no Windows, depois da revisão da Mira nas listas; este esqueleto não inventa saída e não roda `cmd` daqui
