-- Connect Pay: várias fotos por aparelho no Catálogo de venda.
-- Execute UMA vez no Supabase (SQL Editor), depois de supabase-catalogo-fotos.sql.
-- Só acrescenta uma coluna e copia a foto antiga para a nova lista; não apaga nada.
-- O limite de 8 fotos por aparelho é aplicado pela tela.

alter table public.cp_catalogo
  add column if not exists fotos text[] not null default '{}';

-- Aparelhos que já tinham 1 foto passam a ter essa foto como capa da lista.
update public.cp_catalogo
   set fotos = array[foto_path]
 where foto_path is not null and cardinality(fotos) = 0;

-- Reversão (se necessário):
-- alter table public.cp_catalogo drop column fotos;
-- (a coluna foto_path continua com a capa de cada aparelho)
