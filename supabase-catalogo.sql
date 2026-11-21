-- Connect Pay: Catálogo de venda.
-- Execute UMA vez no Supabase (SQL Editor). Cria duas tabelas novas e não altera nenhuma existente.
--
--   cp_catalogo          modelo, valor de venda e entrada. Todos os usuários logados leem
--                        (usuário comum só enxerga os ativos). Só o administrador grava.
--   cp_catalogo_custos   custo e taxa mensal. Só o administrador lê e grava, para o
--                        usuário comum nunca receber o custo do aparelho.
--
-- Administrador: megairati2020@gmail.com

create table if not exists public.cp_catalogo (
  id uuid primary key default gen_random_uuid(),
  modelo text not null,
  condicao text not null default 'Seminovo',
  preco_vista numeric(12,2) not null check (preco_vista >= 0),
  entrada_min numeric(12,2) not null default 0 check (entrada_min >= 0),
  entrada_max numeric(12,2) check (entrada_max >= 0),
  ativo boolean not null default true,
  criado_em timestamptz not null default now()
);

create table if not exists public.cp_catalogo_custos (
  catalogo_id uuid primary key references public.cp_catalogo(id) on delete cascade,
  custo numeric(12,2) check (custo >= 0),
  taxa_mensal numeric(6,2) not null default 12 check (taxa_mensal >= 0 and taxa_mensal <= 100)
);

alter table public.cp_catalogo enable row level security;
alter table public.cp_catalogo_custos enable row level security;

-- Permissão de acesso às tabelas (sem isso o Supabase responde "permission denied for table").
-- A segurança por linha continua nas políticas abaixo.
grant usage on schema public to authenticated;
grant select, insert, update, delete on public.cp_catalogo to authenticated;
grant select, insert, update, delete on public.cp_catalogo_custos to authenticated;

create policy "cp_catalogo_ler" on public.cp_catalogo for select to authenticated
  using (ativo = true or lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

create policy "cp_catalogo_admin_inserir" on public.cp_catalogo for insert to authenticated
  with check (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');
create policy "cp_catalogo_admin_alterar" on public.cp_catalogo for update to authenticated
  using (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');
create policy "cp_catalogo_admin_excluir" on public.cp_catalogo for delete to authenticated
  using (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

create policy "cp_catalogo_custos_admin" on public.cp_catalogo_custos for all to authenticated
  using (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

-- Reversão (se necessário):
-- drop table public.cp_catalogo_custos;
-- drop table public.cp_catalogo;
