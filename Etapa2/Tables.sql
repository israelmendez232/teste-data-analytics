CREATE TABLE "faturamento" (
  "id_nota" INT,
  "sku" INT,
  "dia_emissao_nota" DATE,
  "uf_entrega" VARCHAR,
  "quantidade" INT,
  "receita" DECIMAL
);

CREATE TABLE "familiasetor" (
  "sku" INT PRIMARY KEY,
  "setor" VARCHAR,
  "familia" VARCHAR
);

CREATE TABLE "peso_unitario" (
  "sku" INT PRIMARY KEY,
  "peso_unitario" DECIMAL
);

CREATE TABLE "frete" (
  "uf_entrega" VARCHAR,
  "dia" DATE,
  "custo_frete" DECIMAL
);

ALTER TABLE "faturamento" ADD FOREIGN KEY ("sku") REFERENCES "familiasetor" ("sku");

ALTER TABLE "faturamento" ADD FOREIGN KEY ("sku") REFERENCES "peso_unitario" ("sku");

ALTER TABLE "familiasetor" ADD FOREIGN KEY ("sku") REFERENCES "peso_unitario" ("sku");

ALTER TABLE "faturamento" ADD FOREIGN KEY ("uf_entrega") REFERENCES "frete" ("uf_entrega");
