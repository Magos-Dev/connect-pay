-- Connect Pay: disponibilidade e simulação de entrada no Catálogo de venda.
-- Execute UMA vez no Supabase (SQL Editor), depois de supabase-catalogo.sql.
-- Não apaga nem altera dados.
--
-- 1) Usuário comum passa a ver TODOS os aparelhos do catálogo (com selo Disponível ou
--    Indisponível), em vez de só os ativos. Escrita continua só do administrador.
-- 2) Cria a função cp_simular_catalogo: calcula a parcela de cada prazo a partir da
--    entrada informada, SEM expor a taxa mensal nem o custo ao usuário comum.

drop policy if exists "cp_catalogo_ler" on public.cp_catalogo;
create policy "cp_catalogo_ler" on public.cp_catalogo for select to authenticated
  using (true);

create or replace function public.cp_simular_catalogo(p_id uuid, p_entrada numeric)
returns table (parcelas int, parcela numeric, total numeric)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_preco numeric; v_emin numeric; v_emax numeric; v_ativo boolean; v_taxa numeric;
  v_base numeric; v_r numeric; v_parc numeric; n int;
begin
  select c.preco_vista, c.entrada_min, c.entrada_max, c.ativo, coalesce(k.taxa_mensal, 12)
    into v_preco, v_emin, v_emax, v_ativo, v_taxa
    from public.cp_catalogo c
    left join public.cp_catalogo_custos k on k.catalogo_id = c.id
   where c.id = p_id;

  if not found then raise exception 'Aparelho não encontrado'; end if;
  if not v_ativo then raise exception 'Aparelho indisponível'; end if;
  if p_entrada is null or p_entrada < v_emin then
    raise exception 'A entrada mínima deste aparelho é R$ %', v_emin;
  end if;
  if p_entrada > coalesce(v_emax, v_preco) then
    raise exception 'A entrada máxima deste aparelho é R$ %', coalesce(v_emax, v_preco);
  end if;

  v_base := v_preco - p_entrada;
  v_r := v_taxa / 100;

  foreach n in array array[4, 6, 8, 12, 16, 18, 24] loop
    if v_base <= 0 then
      v_parc := 0;
    elsif v_r > 0 then
      v_parc := round(v_base * v_r / (1 - power(1 + v_r, -n)), 2);
    else
      v_parc := round(v_base / n, 2);
    end if;
    parcelas := n;
    parcela := v_parc;
    total := p_entrada + v_parc * n;
    return next;
  end loop;
end;
$$;

revoke all on function public.cp_simular_catalogo(uuid, numeric) from public;
grant execute on function public.cp_simular_catalogo(uuid, numeric) to authenticated;

-- Reversão (se necessário):
-- drop function public.cp_simular_catalogo(uuid, numeric);
-- drop policy "cp_catalogo_ler" on public.cp_catalogo;
-- create policy "cp_catalogo_ler" on public.cp_catalogo for select to authenticated
--   using (ativo = true or lower(auth.jwt() ->> 'email') = 'megairati2020@gmail.com');
