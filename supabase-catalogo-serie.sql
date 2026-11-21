-- Connect Pay: número de série e IMEI no Catálogo de venda.
-- Execute UMA vez no Supabase (SQL Editor), depois de supabase-catalogo.sql.
-- Só acrescenta colunas; não apaga nem altera dados existentes.
--
-- Ficam na tabela cp_catalogo_custos, que só o administrador lê. Assim o usuário
-- comum não recebe série nem IMEI do catálogo.

alter table public.cp_catalogo_custos
  add column if not exists serie text,
  add column if not exists imei text check (imei is null or imei ~ '^[0-9]{15}$');

-- Impede cadastrar o mesmo IMEI em dois aparelhos do catálogo.
create unique index if not exists cp_catalogo_imei_unico
  on public.cp_catalogo_custos (imei) where imei is not null;

-- Reversão (se necessário):
-- drop index if exists public.cp_catalogo_imei_unico;
-- alter table public.cp_catalogo_custos drop column serie, drop column imei;
