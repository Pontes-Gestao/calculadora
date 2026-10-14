# Calculadora de CMV · v3.0 · Pontes

Calculadora de CMV (Custo de Mercadoria Vendida) e ficha técnica para confeitarias e restaurantes,
da **Pontes – Consultoria e Gestão de iFood**.

Endereço único para todas as clientes: <https://pontes-gestao.github.io/calculadora/>

## O que a calculadora faz

1. **Produto e ingredientes:** quantidade × valor, com custo automático. Unidades **kg**, **lt**, **und** e **g**
   (em gramas: preço do pacote ÷ gramas do pacote × quantidade usada — ex.: R$ 40 / 250 g, usando 100 g).
2. **Rendimento da receita:** divide o custo da receita em porções (ex.: bolo de 8 fatias → custo ÷ 8).
3. **Preço de balcão** com CMV de 30% (custo ÷ 0,3).
4. **Preço iFood** com as taxas do plano básico: comissão 12% + pagamento 3,49% + antecipação 1,99% = 17,48%,
   arredondado para 18% (balcão ÷ 0,82). As taxas podem ser ajustadas.
5. **Alavancas do iFood** (taxa grátis, campanha inteligente, hits): se usa, preço ÷ 0,88.
6. **Embalagens** somadas no final, a preço de custo, nos preços de balcão e iFood (não entram no CMV).

Também tem:

- Avisos para valores fora do normal (ex.: 300 kg em vez de 0,3 kg ou da unidade g)
- Exportação da ficha em PDF com a marca Pontes
- Login por e-mail e senha, com as fichas salvas na nuvem (as mesmas no computador e no celular)
- Lista "Minhas fichas" com filtro por nome, e backup/restauração em arquivo JSON

## Privacidade

Uma cliente **nunca** vê as fichas de outra. Isso é garantido pelo próprio banco de dados (regras de segurança
RLS em [`supabase/setup.sql`](supabase/setup.sql)): cada conta só vê, cria, altera e exclui as próprias fichas.

**Fichas antigas guardadas só no navegador** (de antes do login): no primeiro login em cada aparelho, a calculadora
mostra a lista e **pergunta** se essas fichas são da pessoa. Só com o OK elas vão para a conta. Se a pessoa cancelar,
nada é enviado nem apagado. A cópia do navegador só é apagada depois de estar salva na conta.
Assim, num computador compartilhado, a ficha de uma empresa não vai parar na conta de outra.

## Como está montado

- `index.html` — o site inteiro (HTML + CSS + JavaScript, sem etapa de build)
- `assets/pontes-logo.webp` — logo da Pontes
- `supabase/setup.sql` — cria a tabela `fichas` e as regras de segurança no Supabase

Hospedagem no GitHub Pages: **publicar = enviar para o branch `main`** (o site atualiza em cerca de 1 minuto).

## Modo local × modo nuvem

No topo do `<script>` do `index.html` há duas constantes (hoje já preenchidas, ou seja, em modo nuvem):

```js
const SUPABASE_URL = 'https://....supabase.co';
const SUPABASE_KEY = 'sb_publishable_...';
```

- **Em branco:** modo local, igual à v1 — as fichas ficam só no navegador de quem usa, sem login.
- **Preenchidas:** modo nuvem — pede login e guarda as fichas no Supabase.

## Configurar a nuvem (Supabase, plano gratuito)

1. Crie um projeto em <https://supabase.com> (região São Paulo).
2. **SQL Editor → New query**: cole o conteúdo de [`supabase/setup.sql`](supabase/setup.sql) e clique em **Run**.
3. **Authentication → URL Configuration**:
   - *Site URL*: `https://pontes-gestao.github.io/calculadora/`
   - *Redirect URLs*: adicione o mesmo endereço.
4. **Authentication → Sign In / Providers → Email**: desligue *Allow new users to sign up*
   (só você cria as contas das clientes).
5. **Authentication → Users → Add user**:
   - *Send invitation*: a cliente recebe um e-mail, clica no link e cria a própria senha; ou
   - *Create new user*: você define e-mail e senha (marque *Auto Confirm User*).
6. **Project Settings → API**: copie a *Project URL* e a chave pública (*anon* / *publishable*) para as constantes acima.

> A chave pública pode ficar no código: quem protege os dados é o login + as regras de segurança (RLS) do `setup.sql`.
> Nunca coloque a chave `service_role` / `secret` no `index.html`.

> No plano gratuito, o Supabase pausa o projeto depois de 7 dias sem nenhum acesso. Se isso acontecer, é só entrar no painel e clicar em **Restore**.
> Continue usando o botão **Backup** de vez em quando.

## Histórico

- **v1.0** — calculadora local (fichas só no navegador).
- **v2.0** — login e fichas na nuvem (Supabase); etapa de rendimento da receita.
- **v3.0** — visual Pontes para todas as clientes (fundo animado, ciano), PDF com a marca Pontes;
  fichas antigas do navegador só vão para a conta com confirmação; unidade em gramas.
