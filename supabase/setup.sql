-- Calculadora de CMV v2.0 · banco de dados na nuvem (Supabase)
-- Cole este arquivo inteiro em: Supabase → SQL Editor → New query → Run.
-- Pode ser executado mais de uma vez sem problema.

create table if not exists public.fichas (
  user_id    uuid        not null default auth.uid() references auth.users (id) on delete cascade,
  id         text        not null,
  produto    text        not null default '',
  dados      jsonb       not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

create index if not exists fichas_user_updated_idx on public.fichas (user_id, updated_at desc);

-- Segurança: cada pessoa só enxerga e altera as próprias fichas.
alter table public.fichas enable row level security;

drop policy if exists "fichas: ver as próprias"      on public.fichas;
drop policy if exists "fichas: criar as próprias"    on public.fichas;
drop policy if exists "fichas: alterar as próprias"  on public.fichas;
drop policy if exists "fichas: excluir as próprias"  on public.fichas;

create policy "fichas: ver as próprias"     on public.fichas for select to authenticated using ((select auth.uid()) = user_id);
create policy "fichas: criar as próprias"   on public.fichas for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "fichas: alterar as próprias" on public.fichas for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "fichas: excluir as próprias" on public.fichas for delete to authenticated using ((select auth.uid()) = user_id);

revoke all on public.fichas from anon;
grant select, insert, update, delete on public.fichas to authenticated;
