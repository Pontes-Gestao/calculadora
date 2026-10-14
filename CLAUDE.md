# Calculadora de CMV · Pontes

App da **Pontes – Consultoria e Gestão de iFood**, vendido para restaurantes e confeitarias.
Um único link para todas as clientes: https://pontes-gestao.github.io/calculadora/

Converse sempre em português, de forma simples (a dona do projeto não é programadora).

## Como está montado
- Tudo em um único `index.html` (HTML + CSS + JS, sem build). Logo em `assets/pontes-logo.webp`.
- Hospedagem: GitHub Pages do repositório `Pontes-Gestao/calculadora`. **Publicar = enviar para o branch `main`**
  (o site atualiza em ~1 min). Trabalhe num branch e só envie para `main` com o OK da dona.
- Login e fichas na nuvem: Supabase (projeto `ygxxlavwcpkssqmdrxsr`). Tabela `public.fichas` guarda a ficha inteira
  em `dados` (jsonb), com RLS: cada conta só vê/cria/altera/exclui as próprias fichas. SQL em `supabase/setup.sql`.
  O cadastro aberto fica **desligado**: só a dona cria contas (Authentication → Users → Add user).
- No código só vai a chave **pública** do Supabase. Nunca colocar a chave `service_role`/`secret`.

## Regras de negócio (não mudar sem pedir)
1. Ingredientes: quantidade × valor. Unidades kg, lt, und e g (em g: preço do pacote ÷ gramas do pacote × quantidade).
2. Rendimento: pode dividir o custo da receita em porções (ex.: bolo de 8 fatias → ÷ 8).
3. Preço de balcão = CMV ÷ 0,3 (CMV de 30%).
4. iFood: comissão 12% + pagamento 3,49% + antecipação 1,99% = 17,48% → arredonda para 18% → balcão ÷ 0,82.
5. Alavancas (taxa grátis, campanha inteligente, hits): se usa, ÷ 0,88.
6. Embalagens somadas no final, a preço de custo, no balcão e no iFood (não entram no CMV).
- Avisos para valores exorbitantes (ex.: 300 com a unidade kg → sugerir 0,3 ou a unidade g).
- PDF com a marca Pontes (jsPDF). Visual escuro, ciano #2CC5D0, fundo animado estilo Matrix.

## Prioridade máxima: privacidade
Uma cliente **nunca** pode ver a ficha de outra (risco jurídico). Qualquer mudança em dados, login ou Supabase
deve preservar o RLS. Fichas antigas guardadas só no navegador nunca vão sozinhas para a nuvem e nunca são apagadas
sem estarem salvas na conta.

## Histórico
- v1.0 (07/10/2026): calculadora local. v2.0: login + nuvem (Supabase), etapa de rendimento.
- v3.0 (12/10/2026): marca Pontes para todos. Unidade em gramas (13/10/2026).
- Primeira cliente: Mais Doce por Amor (marca Ana Lourenço) — também usa o visual Pontes.
