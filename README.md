# Teste para Data Analytics

Pequeno teste técnico para uma posição em Data Analytics. Separado nas seguintes etapas:

1. Ingestão de Dados;

2. Consultas SQL;

3. Consultas Python/Pandas;

4. Visualização de Dados (para acessar o link do dashboard, [clique aqui]());

5. Proposta de Arquitetura de Dados.



O teste contém quatro tipo de fonte de dados diferentes que tornam-se tabelas diferentes. Segue:

- **faturamento.parquet.gzip**: Dados das notas faturadas;

<table><colgroup><col width="135"><col width="489"></colgroup><tbody><tr><th><span><span>Campo</span></span></th><th><span><span>Descrição</span></span></th></tr><tr><td><span><span>id_nota</span></span></td><td><span><span>Id da nota.</span></span></td></tr><tr><td><span><span>sku</span></span></td><td><span><span>Código do produto.</span></span></td></tr><tr><td><span><span>dia_emissao_nota</span></span></td><td><span><span>Data de emissão da nota.</span></span></td></tr><tr><td><span><span>uf_entrega</span></span></td><td><span><span>UF de entrega da mercadoria.</span></span></td></tr><tr><td><span><span>quantidade</span></span></td><td><span><span>Quantidade faturada na nota.</span></span></td></tr><tr><td><span><span>receita</span></span></td><td><span><span>Valor faturado.</span></span></td></tr></tbody></table>

- **familiasetor.json:** Familia e setor por SKU;

<table><colgroup><col width="140"><col width="484"></colgroup><tbody><tr><th><span><span>Campo</span></span></th><th><span><span>Descrição</span></span></th></tr><tr><td><span><span>sku</span></span></td><td><span><span>Código do produto.</span></span></td></tr><tr><td><span><span>setor</span></span></td><td><span><span>Setor do produto (Ex: Alimentos, Brinquedos, e etc.)</span></span></td></tr><tr><td><span><span>familia</span></span></td><td><span><span>Agrupamento por tipo de pet (Ex.Gatos,Cachorros e peixes.)</span></span></td></tr></tbody></table>


- **peso_unitario.txt**: Peso unitário do SKU. Usado para o custo de frete;

<table><colgroup><col width="140"><col width="484"></colgroup><tbody><tr><th><span><span>Campo</span></span></th><th><span><span>Descrição</span></span></th></tr><tr><td><span><span>sku</span></span></td><td><span><span>Código do produto.</span></span></td></tr><tr><td><span><span>peso_unitario</span></span></td><td><span><span>Peso unitário do produto.</span></span></td></tr></tbody></table>


- **frete.csv:** Valor gasto com o frete.

<table><colgroup><col width="140"><col width="484"></colgroup><tbody><tr><th><span><span>Campo</span></span></th><th><span><span>Descrição</span></span></th></tr><tr><td><span><span>uf_entrega</span></span></td><td><span><span>UF de estado que foi entregue o produto.</span></span></td></tr><tr><td><span><span>dia</span></span></td><td><span><span>Data da entrega do produto.</span></span></td></tr><tr><td><span><span>custo_frete</span></span></td><td><span><span>Custo total do frete.</span></span></td></tr></tbody></table>

