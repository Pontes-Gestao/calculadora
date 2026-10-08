# Calculadora de CMV · v2.0

Calculadora de CMV (Custo de Mercadoria Vendida) e ficha técnica para confeitarias e restaurantes.

- Ficha técnica com ingredientes, quantidades, unidades (kg, lt, und) e custo automático
- Preço de balcão com CMV de 30% (custo ÷ 0,3)
- Preço iFood com taxas (padrão do plano básico: 18% → ÷ 0,82) e alavancas (÷ 0,88)
- Embalagens somadas a preço de custo nos preços de balcão e iFood
- Avisos para valores fora do normal (ex.: 300 kg em vez de 0,3 kg)
- Exportação da ficha em PDF
- **Novo na v2:** login por e-mail e senha, fichas salvas na nuvem (as mesmas no computador e no celular)
- Filtro por nome e backup/restauração em arquivo JSON

## Modo local × modo nuvem

No topo do `<script>` do `index.html` há duas constantes:

```js
const SUPABASE_URL = '';
const SUPABASE_KEY = '';
```

- **Em branco:** modo local, igual à v1 — as fichas ficam só no navegador de quem usa.
- **Preenchidas:** modo nuvem — pede login e guarda as fichas no Supabase.
  No primeiro login em cada aparelho, as fichas que estavam salvas só no navegador são enviadas automaticamente para a conta.

## Configurar a nuvem (Supabase, plano gratuito)

1. Crie um projeto em <https://supabase.com> (região São Paulo).
2. **SQL Editor → New query**: cole o conteúdo de [`supabase/setup.sql`](supabase/setup.sql) e clique em **Run**.
3. **Authentication → URL Configuration**:
   - *Site URL*: `https://performancevendas01-hash.github.io/calculadora-cmv/`
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
