-- Connect Pay: detalhes, bateria e foto no Catálogo de venda.
-- Execute UMA vez no Supabase (SQL Editor), depois de supabase-catalogo.sql.
-- Só acrescenta colunas e uma pasta de fotos; não apaga nem altera dados existentes.
--
-- Fotos: pasta pública "cp-catalogo" (fotos de produto, sem dados pessoais), com
-- JPG/PNG/WEBP de até 3 MB. Somente o administrador envia, troca e apaga fotos.

alter table public.cp_catalogo
  add column if not exists detalhes text,
  add column if not exists bateria smallint check (bateria between 0 and 100),
  add column if not exists foto_path text;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('cp-catalogo', 'cp-catalogo', true, 3145728,
        array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true;

create policy "cp_catalogo_fotos_inserir" on storage.objects for insert to authenticated
  with check (bucket_id = 'cp-catalogo' and lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

create policy "cp_catalogo_fotos_alterar" on storage.objects for update to authenticated
  using (bucket_id = 'cp-catalogo' and lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com')
  with check (bucket_id = 'cp-catalogo' and lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

create policy "cp_catalogo_fotos_excluir" on storage.objects for delete to authenticated
  using (bucket_id = 'cp-catalogo' and lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');

-- Reversão (se necessário):
-- drop policy "cp_catalogo_fotos_inserir" on storage.objects;
-- drop policy "cp_catalogo_fotos_alterar" on storage.objects;
-- drop policy "cp_catalogo_fotos_excluir" on storage.objects;
-- alter table public.cp_catalogo drop column detalhes, drop column bateria, drop column foto_path;
-- (esvazie a pasta cp-catalogo pelo painel Storage antes de removê-la)
