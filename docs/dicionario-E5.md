 # Dicionário E5 — Entidades e campos (versão gerada)

Este dicionário foi gerado automaticamente a partir de `prisma/schema.prisma`. Para cada modelo listamos os campos, tipos e observações básicas.

---

## categoria

- id: Int — PK, autoincrement
- nome: String
- paiId: Int? — FK para `categoria.id`
- servico: relação com `servico[]`

## cliente

- id: Int — PK, autoincrement
- email: String? — email do cliente
- enderecoId: Int — FK para `endereco.id`
- dataNascimento: DateTime?
- documento: String — único (CPF ou CNPJ)
- nome: String
- tipoPessoa: Enum `cliente_tipoPessoa` (FISICA, JURIDICA)
- telefone: relação com `telefone[]`
- veiculo: relação com `veiculo[]`

## colaborador

- id: Int — PK, autoincrement
- nome_completo: String
- email: String — único
- cpf: String — único
- senha: String
- perfil: Enum `colaborador_perfil` (ADMIN, DIRETORIA, GERENTE, CHEFE_DE_OFICINA, ATENDIMENTO, MECANICO)
- status: Boolean
- dataAdmissao: DateTime
- supervisorId: Int? — self-FK para `colaborador.id`
- unidadeId: Int — FK para `unidade_oficina.id`

## endereco

- id: Int — PK
- logradouro: String
- numero: String
- complemento: String?
- bairro: String
- cidade: String
- cep: String
- observacao: String?

## fornecedor

- id: Int — PK
- cnpj: String
- email: String — único
- telefone: String
- razaoSocial: String

## itemospeca

- id: Int — PK
- quantidade: Int
- precoCobrado: Decimal(10,2)
- osId: Int — FK para `ordem_servico.id`
- pecaId: Int — FK para `peca.id` (único por design no schema)

## itemosservico

- id: Int — PK
- quantidade: Int
- precoCobrado: Decimal(10,2)
- osId: Int — FK para `ordem_servico.id`
- servicoId: Int — FK para `servico.id`
- mecanicaId: Int — FK para `colaborador.id` (mecânico responsável)

## movimentacaoestoque

- id: Int — PK
- tipo: Enum `movimentacaoestoque_tipo` (ENTRADA, SAIDA)
- quantidade: Int
- motivo: String
- dataHora: DateTime
- pecaId: Int — FK para `peca.id`
- responsavelId: Int — FK para `colaborador.id`
- odId: Int? — FK opcional para `ordem_servico.id`

## ordem_servico

- id: Int — PK
- numero_os: String — único
- veiculoId: Int — FK para `veiculo.id`
- abertura: DateTime
- previsao_entrega: DateTime?
- observacao: Text?
- etapa: Enum `ordem_servico_etapa` (ABERTA, ORCAMENTO, APROVADA, EM_EXECUCAO, AGUARDANDO_PECA, FINALIZADO, ENTREGUE, CANCELADA)
- KmEntrada: Int
- atendenteId: Int — FK para `colaborador.id`
- desconto: Decimal(10,2)
- mecanincoId: Int? — FK opcional para `colaborador.id` (nota: nome do campo no schema: `mecanincoId`)
- unidadeId: Int — FK para `unidade_oficina.id`

## pagamento

- id: Int — PK
- valor: Decimal(10,2)
- num_parcelas: Int
- data_hora: DateTime
- forma: Enum `pagamento_forma` (DINHEIRO, PIX, DEBIDO, CREDITO, BOLETO)
- osId: Int — FK para `ordem_servico.id`
- quemRecebeId: Int — FK para `colaborador.id`

## peca

- id: Int — PK
- codigo: String — único
- nome: String
- precoCusto: Decimal(10,2)
- precoVenda: Decimal(10,2)
- estoqueMinimo: Int
- estoqueAtual: Int
- fornecedorId: Int?

## servico

- id: Int — PK
- nome: String
- descricao: Text
- status: Boolean
- categoriaId: Int — FK para `categoria.id`
- codigo: String — único
- precoTabela: Decimal(10,2)
- tempoEstimado: Int (minutos)

## telefone

- id: Int — PK
- clienteId: Int — FK para `cliente.id`
- numero: String — único

## unidade_oficina

- id: Int — PK
- endereco: String
- telefone: String
- status: Boolean
- gerenteId: Int? — FK opcional para `colaborador.id` (único)
- nome: String

## veiculo

- id: Int — PK
- placa: String — único
- marca: String
- modelo: String
- cor: String
- combustivel: Enum `veiculo_combustivel` (COMBUSTIVEL, DIESEL, ETANOL, FLEX, GNV, ELETRICO, HIBRIDO)
- km_ultima_vez: Int?
- anoFabricacao: Int
- clienteId: Int — FK para `cliente.id`

---

## Enums

- movimentacaoestoque_tipo: ENTRADA, SAIDA
- pagamento_forma: DINHEIRO, PIX, DEBIDO, CREDITO, BOLETO
- colaborador_perfil: ADMIN, DIRETORIA, GERENTE, CHEFE_DE_OFICINA, ATENDIMENTO, MECANICO
- veiculo_combustivel: COMBUSTIVEL, DIESEL, ETANOL, FLEX, GNV, ELETRICO, HIBRIDO
- cliente_tipoPessoa: FISICA, JURIDICA
- ordem_servico_etapa: ABERTA, ORCAMENTO, APROVADA, EM_EXECUCAO, AGUARDANDO_PECA, FINALIZADO, ENTREGUE, CANCELADA

---

Observação: o campo `mecanincoId` (em `ordem_servico`) no schema contém esse nome exato — preservei conforme o schema original.

---

## Exemplos de formato

- `documento`: CPF (11 dígitos, somente números) ou CNPJ (14 dígitos). Ex.: 11122233344 ou 12345678000199
- `email`: endereço válido (ex.: usuario@dominio.com)
- `telefone`: formato sugerido: (DDD) 99999-9999
- `cep`: formato sugerido: 00000-000
- campos monetários (`precoCusto`, `precoVenda`, `valor`, `desconto`): `Decimal(10,2)` representando reais (ex.: 150.00)
- `data`/`datetime`: armazenados como `DateTime`, ex.: `2026-08-12 14:00:00`

## Observações e recomendações rápidas

- O campo `mecanincoId` mantém o nome presente no schema; se desejar uniformizar, recomendo renomear para `mecanicoId` no schema e migrar.
- Senhas na massa de teste (ex.: `senha123`) são aceitáveis para exercício, mas sempre evitar em ambientes reais.
- Se quiser, eu posso gerar um `CSV` desse dicionário ou uma versão em tabela mais detalhada.
