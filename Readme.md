# Projeto Banco Oficina Matriz-Drill

Breve documentação das entregas (E1..E4) do projeto OficinaBanco. Contém o modelo lógico, DDL e massa de dados usados para avaliação.

Sumário
- [E1 - Modelo lógico](#e1)
- [E2 - DDL completo](#e2)
- [E3 - Massa de dados (seção 7)](#e3)
- [E4 - Consultas](#e4)
- [Dicionário E5](#dicionario-e5)

## E1:
### Modelo lógico: todas as tabelas, todos os campos, todas as relações com cardinalidade marcada

![alt text](<Captura de tela 2026-08-12 103503.png>)

## E2:
### DDL completo, num arquivo só, que roda do zero

```sql
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema oficinabanco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oficinabanco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficinabanco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `oficinabanco` ;

-- -----------------------------------------------------
-- Table `oficinabanco`.`_prisma_migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`_prisma_migrations` (
  `id` VARCHAR(36) NOT NULL,
  `checksum` VARCHAR(64) NOT NULL,
  `finished_at` DATETIME(3) NULL DEFAULT NULL,
  `migration_name` VARCHAR(255) NOT NULL,
  `logs` TEXT NULL DEFAULT NULL,
  `rolled_back_at` DATETIME(3) NULL DEFAULT NULL,
  `started_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(191) NOT NULL,
  `paiId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `Categoria_paiId_fkey` (`paiId` ASC),
  CONSTRAINT `Categoria_paiId_fkey`
    FOREIGN KEY (`paiId`)
    REFERENCES `oficinabanco`.`categoria` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`endereco` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(191) NOT NULL,
  `numero` VARCHAR(191) NOT NULL,
  `complemento` VARCHAR(191) NULL DEFAULT NULL,
  `bairro` VARCHAR(191) NOT NULL,
  `cidade` VARCHAR(191) NOT NULL,
  `cep` VARCHAR(191) NOT NULL,
  `observacao` VARCHAR(191) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`cliente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(191) NULL DEFAULT NULL,
  `enderecoId` INT(11) NOT NULL,
  `dataNascimento` DATETIME(3) NULL DEFAULT NULL,
  `documento` VARCHAR(191) NOT NULL,
  `nome` VARCHAR(191) NOT NULL,
  `tipoPessoa` ENUM('FISICA', 'JURIDICA') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Cliente_documento_key` (`documento` ASC) ,
  INDEX `Cliente_enderecoId_fkey` (`enderecoId` ASC) ,
  CONSTRAINT `Cliente_enderecoId_fkey`
    FOREIGN KEY (`enderecoId`)
    REFERENCES `oficinabanco`.`endereco` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`unidade_oficina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`unidade_oficina` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `endereco` VARCHAR(191) NOT NULL,
  `telefone` VARCHAR(191) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  `gerenteId` INT(11) NULL DEFAULT NULL,
  `nome` VARCHAR(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Unidade_Oficina_gerenteId_key` (`gerenteId` ASC) ,
  CONSTRAINT `Unidade_Oficina_gerenteId_fkey`
    FOREIGN KEY (`gerenteId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`colaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`colaborador` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(191) NOT NULL,
  `email` VARCHAR(191) NOT NULL,
  `cpf` VARCHAR(191) NOT NULL,
  `senha` VARCHAR(191) NOT NULL,
  `perfil` ENUM('ADMIN', 'DIRETORIA', 'GERENTE', 'CHEFE_DE_OFICINA', 'ATENDIMENTO', 'MECANICO') NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  `dataAdmissao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `supervisorId` INT(11) NULL DEFAULT NULL,
  `unidadeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Colaborador_email_key` (`email` ASC) ,
  UNIQUE INDEX `Colaborador_cpf_key` (`cpf` ASC) ,
  INDEX `Colaborador_unidadeId_fkey` (`unidadeId` ASC) ,
  INDEX `Colaborador_supervisorId_fkey` (`supervisorId` ASC) ,
  CONSTRAINT `Colaborador_supervisorId_fkey`
    FOREIGN KEY (`supervisorId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Colaborador_unidadeId_fkey`
    FOREIGN KEY (`unidadeId`)
    REFERENCES `oficinabanco`.`unidade_oficina` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`fornecedor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(191) NOT NULL,
  `email` VARCHAR(191) NOT NULL,
  `telefone` VARCHAR(191) NOT NULL,
  `razaoSocial` VARCHAR(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Fornecedor_email_key` (`email` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`veiculo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(191) NOT NULL,
  `marca` VARCHAR(191) NOT NULL,
  `modelo` VARCHAR(191) NOT NULL,
  `cor` VARCHAR(191) NOT NULL,
  `combustivel` ENUM('COMBUSTIVEL', 'DIESEL', 'ETANOL', 'FLEX', 'GNV', 'ELETRICO', 'HIBRIDO') NOT NULL,
  `km_ultima_vez` INT(11) NULL DEFAULT NULL,
  `anoFabricacao` INT(11) NOT NULL,
  `clienteId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Veiculo_placa_key` (`placa` ASC) ,
  INDEX `Veiculo_clienteId_fkey` (`clienteId` ASC) ,
  CONSTRAINT `Veiculo_clienteId_fkey`
    FOREIGN KEY (`clienteId`)
    REFERENCES `oficinabanco`.`cliente` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`ordem_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`ordem_servico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `numero_os` VARCHAR(191) NOT NULL,
  `veiculoId` INT(11) NOT NULL,
  `abertura` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `previsao_entrega` DATETIME(3) NULL DEFAULT NULL,
  `observacao` TEXT NULL DEFAULT NULL,
  `etapa` ENUM('ABERTA', 'ORCAMENTO', 'APROVADA', 'EM_EXECUCAO', 'AGUARDANDO_PECA', 'FINALIZADO', 'ENTREGUE', 'CANCELADA') NOT NULL DEFAULT 'ABERTA',
  `KmEntrada` INT(11) NOT NULL,
  `atendenteId` INT(11) NOT NULL,
  `desconto` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `mecanincoId` INT(11) NULL DEFAULT NULL,
  `unidadeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Ordem_Servico_numero_os_key` (`numero_os` ASC) ,
  INDEX `Ordem_Servico_veiculoId_fkey` (`veiculoId` ASC) ,
  INDEX `Ordem_Servico_unidadeId_fkey` (`unidadeId` ASC) ,
  INDEX `Ordem_Servico_atendenteId_fkey` (`atendenteId` ASC) ,
  INDEX `Ordem_Servico_mecanincoId_fkey` (`mecanincoId` ASC) ,
  CONSTRAINT `Ordem_Servico_atendenteId_fkey`
    FOREIGN KEY (`atendenteId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `Ordem_Servico_mecanincoId_fkey`
    FOREIGN KEY (`mecanincoId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Ordem_Servico_unidadeId_fkey`
    FOREIGN KEY (`unidadeId`)
    REFERENCES `oficinabanco`.`unidade_oficina` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `Ordem_Servico_veiculoId_fkey`
    FOREIGN KEY (`veiculoId`)
    REFERENCES `oficinabanco`.`veiculo` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`peca` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(191) NOT NULL,
  `nome` VARCHAR(191) NOT NULL,
  `precoCusto` DECIMAL(10,2) NOT NULL,
  `precoVenda` DECIMAL(10,2) NOT NULL,
  `estoqueMinimo` INT(11) NOT NULL,
  `estoqueAtual` INT(11) NOT NULL DEFAULT 0,
  `fornecedorId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Peca_codigo_key` (`codigo` ASC) ,
  INDEX `Peca_fornecedorId_fkey` (`fornecedorId` ASC) ,
  CONSTRAINT `Peca_fornecedorId_fkey`
    FOREIGN KEY (`fornecedorId`)
    REFERENCES `oficinabanco`.`fornecedor` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`itemospeca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`itemospeca` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quantidade` INT(11) NOT NULL,
  `precoCobrado` DECIMAL(10,2) NOT NULL,
  `osId` INT(11) NOT NULL,
  `pecaId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ItemOSPeca_osId_key` (`osId` ASC) ,
  UNIQUE INDEX `ItemOSPeca_pecaId_key` (`pecaId` ASC) ,
  CONSTRAINT `ItemOSPeca_osId_fkey`
    FOREIGN KEY (`osId`)
    REFERENCES `oficinabanco`.`ordem_servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ItemOSPeca_pecaId_fkey`
    FOREIGN KEY (`pecaId`)
    REFERENCES `oficinabanco`.`peca` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`servico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(191) NOT NULL,
  `descricao` TEXT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  `categoriaId` INT(11) NOT NULL,
  `codigo` VARCHAR(191) NOT NULL,
  `precoTabela` DECIMAL(10,2) NOT NULL,
  `tempoEstimado` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Servico_codigo_key` (`codigo` ASC) ,
  INDEX `Servico_categoriaId_fkey` (`categoriaId` ASC) ,
  CONSTRAINT `Servico_categoriaId_fkey`
    FOREIGN KEY (`categoriaId`)
    REFERENCES `oficinabanco`.`categoria` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`itemosservico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`itemosservico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quantidade` INT(11) NOT NULL,
  `precoCobrado` DECIMAL(10,2) NOT NULL,
  `osId` INT(11) NOT NULL,
  `servicoId` INT(11) NOT NULL,
  `mecanicaId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ItemOSServico_osId_key` (`osId` ASC) ,
  INDEX `ItemOSServico_servicoId_fkey` (`servicoId` ASC) ,
  INDEX `ItemOSServico_mecanicaId_fkey` (`mecanicaId` ASC) ,
  CONSTRAINT `ItemOSServico_mecanicaId_fkey`
    FOREIGN KEY (`mecanicaId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `ItemOSServico_osId_fkey`
    FOREIGN KEY (`osId`)
    REFERENCES `oficinabanco`.`ordem_servico` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ItemOSServico_servicoId_fkey`
    FOREIGN KEY (`servicoId`)
    REFERENCES `oficinabanco`.`servico` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`movimentacaoestoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`movimentacaoestoque` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('ENTRADA', 'SAIDA') NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `motivo` VARCHAR(191) NOT NULL,
  `dataHora` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `pecaId` INT(11) NOT NULL,
  `responsavelId` INT(11) NOT NULL,
  `odId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `MovimentacaoEstoque_pecaId_fkey` (`pecaId` ASC) ,
  INDEX `MovimentacaoEstoque_responsavelId_fkey` (`responsavelId` ASC) ,
  INDEX `MovimentacaoEstoque_odId_fkey` (`odId` ASC) ,
  CONSTRAINT `MovimentacaoEstoque_odId_fkey`
    FOREIGN KEY (`odId`)
    REFERENCES `oficinabanco`.`ordem_servico` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `MovimentacaoEstoque_pecaId_fkey`
    FOREIGN KEY (`pecaId`)
    REFERENCES `oficinabanco`.`peca` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `MovimentacaoEstoque_responsavelId_fkey`
    FOREIGN KEY (`responsavelId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`pagamento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `valor` DECIMAL(10,2) NOT NULL,
  `num_parcelas` INT(11) NOT NULL DEFAULT 1,
  `data_hora` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `forma` ENUM('DINHEIRO', 'PIX', 'DEBIDO', 'CREDITO', 'BOLETO') NOT NULL,
  `osId` INT(11) NOT NULL,
  `quemRecebeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Pagamento_osId_fkey` (`osId` ASC) ,
  INDEX `Pagamento_quemRecebeId_fkey` (`quemRecebeId` ASC) ,
  CONSTRAINT `Pagamento_osId_fkey`
    FOREIGN KEY (`osId`)
    REFERENCES `oficinabanco`.`ordem_servico` (`id`)
    ON UPDATE CASCADE,
  CONSTRAINT `Pagamento_quemRecebeId_fkey`
    FOREIGN KEY (`quemRecebeId`)
    REFERENCES `oficinabanco`.`colaborador` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `oficinabanco`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficinabanco`.`telefone` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `clienteId` INT(11) NOT NULL,
  `numero` VARCHAR(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Telefone_numero_key` (`numero` ASC) ,
  UNIQUE INDEX `Telefone_clienteId_key` (`clienteId` ASC) ,
  CONSTRAINT `Telefone_clienteId_fkey`
    FOREIGN KEY (`clienteId`)
    REFERENCES `oficinabanco`.`cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE `oficinabanco`;

-- -------------------------------------------------------------
-- 1. CORRIGINDO A TABELA TELEFONE
-- -------------------------------------------------------------
ALTER TABLE `telefone` DROP FOREIGN KEY `Telefone_clienteId_fkey`;
ALTER TABLE `telefone` DROP INDEX `Telefone_clienteId_key`;
ALTER TABLE `telefone` ADD CONSTRAINT `Telefone_clienteId_fkey` 
  FOREIGN KEY (`clienteId`) REFERENCES `cliente` (`id`) 
  ON DELETE CASCADE ON UPDATE CASCADE;

-- -------------------------------------------------------------
-- 2. CORRIGINDO A TABELA ITEMOSPECA
-- -------------------------------------------------------------
ALTER TABLE `itemospeca` DROP FOREIGN KEY `ItemOSPeca_osId_fkey`;
ALTER TABLE `itemospeca` DROP INDEX `ItemOSPeca_osId_key`;
ALTER TABLE `itemospeca` ADD CONSTRAINT `ItemOSPeca_osId_fkey` 
  FOREIGN KEY (`osId`) REFERENCES `ordem_servico` (`id`) 
  ON DELETE CASCADE ON UPDATE CASCADE;

-- -------------------------------------------------------------
-- 3. CORRIGINDO A TABELA ITEMOSSERVICO
-- -------------------------------------------------------------
ALTER TABLE `itemosservico` DROP FOREIGN KEY `ItemOSServico_osId_fkey`;
ALTER TABLE `itemosservico` DROP INDEX `ItemOSServico_osId_key`;
ALTER TABLE `itemosservico` ADD CONSTRAINT `ItemOSServico_osId_fkey` 
  FOREIGN KEY (`osId`) REFERENCES `ordem_servico` (`id`) 
  ON DELETE CASCADE ON UPDATE CASCADE;
```

## E3:
### A massa da seção 7
```sql
    -- =================================================================================
-- MASSA DE DADOS REALISTA - OFICINABANCO
-- =================================================================================

USE `oficinabanco`;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `movimentacaoestoque`;
TRUNCATE TABLE `pagamento`;
TRUNCATE TABLE `itemospeca`;
TRUNCATE TABLE `itemosservico`;
TRUNCATE TABLE `ordem_servico`;
TRUNCATE TABLE `telefone`;
TRUNCATE TABLE `veiculo`;
TRUNCATE TABLE `cliente`;
TRUNCATE TABLE `endereco`;
TRUNCATE TABLE `colaborador`;
TRUNCATE TABLE `unidade_oficina`;
TRUNCATE TABLE `peca`;
TRUNCATE TABLE `servico`;
TRUNCATE TABLE `categoria`;
TRUNCATE TABLE `fornecedor`;

SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------
-- 1. UNIDADE_OFICINA (Min 3, 1 sem gerente)
-- NOTA: `gerenteId` inserido como NULL inicialmente para evitar erro de FK circular com Colaborador
-- -----------------------------------------------------
INSERT INTO `unidade_oficina` (`endereco`, `telefone`, `status`, `nome`, `gerenteId`) VALUES
('Av. Ipiranga, 1230, Porto Alegre - RS', '(51) 3333-1111', 1, 'Matriz Ipiranga', NULL),
('Rua 24 de Outubro, 500, Porto Alegre - RS', '(51) 3333-2222', 1, 'Filial Moinhos', NULL),
('Av. Assis Brasil, 4500, Porto Alegre - RS', '(51) 3333-3333', 1, 'Filial Zona Norte', NULL);

-- -----------------------------------------------------
-- 2. COLABORADOR (Min 12, 4 perfis min, hierarquia 3 níveis, 1 sem supervisor)
-- Níveis: ADMIN -> DIRETORIA -> GERENTE -> CHEFE_DE_OFICINA -> MECANICO/ATENDIMENTO
-- -----------------------------------------------------
-- Nível 1: Admin (Sem supervisor)
INSERT INTO `colaborador` (`nome_completo`, `email`, `cpf`, `senha`, `perfil`, `status`, `supervisorId`, `unidadeId`) VALUES
('Carlos Drummond de Andrade', 'carlos.admin@oficina.com.br', '00100200304', 'senha123', 'ADMIN', 1, NULL, 1);

-- Nível 2: Diretoria e Gerentes
INSERT INTO `colaborador` (`nome_completo`, `email`, `cpf`, `senha`, `perfil`, `status`, `supervisorId`, `unidadeId`) VALUES
('Marina Silva', 'marina.diretoria@oficina.com.br', '00100200305', 'senha123', 'DIRETORIA', 1, 1, 1),
('Roberto Justus', 'roberto.gerente@oficina.com.br', '00100200306', 'senha123', 'GERENTE', 1, 2, 1),
('Luiza Trajano', 'luiza.gerente@oficina.com.br', '00100200307', 'senha123', 'GERENTE', 1, 2, 2);

-- Nível 3: Chefes de Oficina
INSERT INTO `colaborador` (`nome_completo`, `email`, `cpf`, `senha`, `perfil`, `status`, `supervisorId`, `unidadeId`) VALUES
('Ayrton Senna', 'ayrton.chefe@oficina.com.br', '00100200308', 'senha123', 'CHEFE_DE_OFICINA', 1, 3, 1),
('Rubens Barrichello', 'rubens.chefe@oficina.com.br', '00100200309', 'senha123', 'CHEFE_DE_OFICINA', 1, 4, 2),
('Felipe Massa', 'felipe.chefe@oficina.com.br', '00100200310', 'senha123', 'CHEFE_DE_OFICINA', 1, 3, 3);

-- Nível 4: Atendimento e Mecânicos
INSERT INTO `colaborador` (`nome_completo`, `email`, `cpf`, `senha`, `perfil`, `status`, `supervisorId`, `unidadeId`) VALUES
('Fernanda Montenegro', 'fernanda.atendimento@oficina.com.br', '00100200311', 'senha123', 'ATENDIMENTO', 1, 5, 1),
('Rodrigo Hilbert', 'rodrigo.atendimento@oficina.com.br', '00100200312', 'senha123', 'ATENDIMENTO', 1, 6, 2),
('Juliana Paes', 'juliana.atendimento@oficina.com.br', '00100200313', 'senha123', 'ATENDIMENTO', 1, 7, 3),
('Antônio Fagundes', 'antonio.mecanico@oficina.com.br', '00100200314', 'senha123', 'MECANICO', 1, 5, 1),
('Lima Duarte', 'lima.mecanico@oficina.com.br', '00100200315', 'senha123', 'MECANICO', 1, 5, 1),
('Tony Ramos', 'tony.mecanico@oficina.com.br', '00100200316', 'senha123', 'MECANICO', 1, 6, 2),
('Selton Mello', 'selton.mecanico@oficina.com.br', '00100200317', 'senha123', 'MECANICO', 1, 7, 3),
('Wagner Moura', 'wagner.mecanico@oficina.com.br', '00100200318', 'senha123', 'MECANICO', 1, 7, 3);

-- Atualizar unidades com seus respectivos gerentes (1 unidade fica sem gerente propositalmente: a ID 3)
UPDATE `unidade_oficina` SET `gerenteId` = 3 WHERE `id` = 1;
UPDATE `unidade_oficina` SET `gerenteId` = 4 WHERE `id` = 2;

-- -----------------------------------------------------
-- 3. ENDEREÇO (Para 25 clientes)
-- -----------------------------------------------------
INSERT INTO `endereco` (`logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `cep`, `observacao`) VALUES
('Rua dos Andradas', '123', 'Apt 12', 'Centro Histórico', 'Porto Alegre', '90020-001', NULL),
('Av. Borges de Medeiros', '456', NULL, 'Praia de Belas', 'Porto Alegre', '90110-150', NULL),
('Rua da Praia', '789', 'Bloco B', 'Centro', 'Porto Alegre', '90020-002', NULL),
('Av. Padre Cacique', '100', NULL, 'Menino Deus', 'Porto Alegre', '90810-240', NULL),
('Rua Fernando Machado', '230', 'Casa 1', 'Centro Histórico', 'Porto Alegre', '90010-320', NULL),
('Av. Goethe', '50', NULL, 'Rio Branco', 'Porto Alegre', '90430-100', NULL),
('Rua Mostardeiro', '110', 'Sala 201', 'Independência', 'Porto Alegre', '90430-001', NULL),
('Rua Anita Garibaldi', '550', NULL, 'Mont''Serrat', 'Porto Alegre', '90450-000', NULL),
('Av. Carlos Gomes', '1000', 'Conjunto 505', 'Boa Vista', 'Porto Alegre', '90480-001', NULL),
('Rua Nilo Peçanha', '1200', NULL, 'Bela Vista', 'Porto Alegre', '90470-001', NULL),
('Av. Wenceslau Escobar', '3000', NULL, 'Tristeza', 'Porto Alegre', '91900-000', NULL),
('Rua Otto Niemeyer', '400', 'Loja 2', 'Camaquã', 'Porto Alegre', '91910-001', NULL),
('Av. Cavalhada', '2500', NULL, 'Cavalhada', 'Porto Alegre', '91740-000', NULL),
('Av. Juca Batista', '5000', NULL, 'Ipanema', 'Porto Alegre', '91770-001', NULL),
('Av. Eduardo Prado', '800', NULL, 'Vila Nova', 'Porto Alegre', '91751-000', NULL),
('Rua 24 de Outubro', '1500', NULL, 'Auxiliadora', 'Porto Alegre', '90510-001', NULL),
('Rua Quintino Bocaiuva', '80', NULL, 'Floresta', 'Porto Alegre', '90440-050', NULL),
('Av. Cristóvão Colombo', '2000', NULL, 'Floresta', 'Porto Alegre', '90560-001', NULL),
('Rua Ramiro Barcelos', '1800', NULL, 'Rio Branco', 'Porto Alegre', '90035-002', NULL),
('Rua Domingos José de Almeida', '90', NULL, 'Rio Branco', 'Porto Alegre', '90420-200', NULL),
('Av. Osvaldo Aranha', '100', NULL, 'Bom Fim', 'Porto Alegre', '90035-190', NULL),
('Rua Vasco da Gama', '500', NULL, 'Rio Branco', 'Porto Alegre', '90420-111', NULL),
('Rua Henrique Dias', '23', NULL, 'Bom Fim', 'Porto Alegre', '90035-100', NULL),
('Av. Independência', '750', 'Apto 90', 'Independência', 'Porto Alegre', '90035-072', NULL),
('Rua Garibaldi', '1000', NULL, 'Floresta', 'Porto Alegre', '90035-050', NULL);

-- -----------------------------------------------------
-- 4. CLIENTE (Min 20, exigências: PF, PJ e Nomes com Acento)
-- -----------------------------------------------------
INSERT INTO `cliente` (`email`, `enderecoId`, `dataNascimento`, `documento`, `nome`, `tipoPessoa`) VALUES
('antonio.silva@gmail.com', 1, '1980-05-15', '11122233344', 'Antônio Silva', 'FISICA'),
('conceicao.pereira@gmail.com', 2, '1975-08-22', '22233344455', 'Maria da Conceição', 'FISICA'),
('muller.transportes@muller.com', 3, '2010-01-10', '12345678000199', 'Müller Logística Ltda', 'JURIDICA'),
('joao.gomes@gmail.com', 4, '1990-12-01', '33344455566', 'João Gomes', 'FISICA'),
('sandra.regina@gmail.com', 5, '1985-03-30', '44455566677', 'Sandra Regina', 'FISICA'),
('empresa.alfa@alfa.com', 6, '2005-06-15', '98765432000188', 'Comércio Alfa SA', 'JURIDICA'),
('carlos.eduardo@gmail.com', 7, '1992-07-08', '55566677788', 'Carlos Eduardo', 'FISICA'),
('fernanda.lima@gmail.com', 8, '1988-09-12', '66677788899', 'Fernanda Lima', 'FISICA'),
('rodrigo.faro@gmail.com', 9, '1973-10-20', '77788899900', 'Rodrigo Faro', 'FISICA'),
('luciano.huck@gmail.com', 10, '1971-09-03', '88899900011', 'Luciano Huck', 'FISICA'),
('taxi.saojoao@taxi.com', 11, '2015-02-28', '11222333000144', 'Cooperativa Táxi São João', 'JURIDICA'),
('paula.fernandes@gmail.com', 12, '1984-08-28', '99900011122', 'Paula Fernandes', 'FISICA'),
('roberto.carlos@gmail.com', 13, '1941-04-19', '00011122233', 'Roberto Carlos', 'FISICA'),
('marcos.mion@gmail.com', 14, '1979-06-20', '12131415161', 'Marcos Mion', 'FISICA'),
('transporte.rapido@rapido.com', 15, '2018-11-11', '55666777000122', 'Transportes Rápido Ltda', 'JURIDICA'),
('tatiana.silveira@gmail.com', 16, '1995-12-25', '17181920212', 'Tatiana Silveira', 'FISICA'),
('bruno.gagliasso@gmail.com', 17, '1982-04-13', '22232425262', 'Bruno Gagliasso', 'FISICA'),
('frotas.sul@frotas.com.br', 18, '2020-03-10', '88999000000177', 'Frotas Sul Locação', 'JURIDICA'),
('marilia.mendonca@gmail.com', 19, '1995-07-22', '27282930313', 'Marília Mendonça', 'FISICA'),
('gusttavo.lima@gmail.com', 20, '1989-09-03', '32333435363', 'Gusttavo Lima', 'FISICA'),
('anitta.machado@gmail.com', 21, '1993-03-30', '37383940414', 'Larissa Machado', 'FISICA'),
('ivete.sangalo@gmail.com', 22, '1972-05-27', '42434445464', 'Ivete Sangalo', 'FISICA'),
('claudia.leitte@gmail.com', 23, '1980-07-10', '47484950515', 'Claudia Leitte', 'FISICA'),
('sem.veiculo1@gmail.com', 24, '1999-01-01', '99988877766', 'Cliente Sem Veículo Um', 'FISICA'),
('sem.veiculo2@gmail.com', 25, '1998-02-02', '88877766655', 'Cliente Sem Veículo Dois', 'FISICA');

-- -----------------------------------------------------
-- 5. TELEFONE (Min 28. Pelo menos 3 com >=2 núms, pelo menos 2 sem nenhum)
-- Clientes 24 e 25 ficam sem telefone.
-- Clientes 1, 2, 3, 4 e 5 terão 2 números cada.
-- -----------------------------------------------------
INSERT INTO `telefone` (`clienteId`, `numero`) VALUES
(1, '(51) 99999-1111'),
(1, '(51) 99999-1112'),
(2, '(51) 99999-2222'),
(2, '(51) 99999-2223'),
(3, '(51) 99999-3333'),
(3, '(51) 99999-3334'),
(4, '(51) 99999-4444'),
(4, '(51) 99999-4445'),
(5, '(51) 99999-5555'),
(5, '(51) 99999-5556'),
(6, '(51) 98888-0006'),
(7, '(51) 98888-0007'),
(8, '(51) 98888-0008'),
(9, '(51) 98888-0009'),
(10, '(51) 98888-0010'),
(11, '(51) 98888-0011'),
(12, '(51) 98888-0012'),
(13, '(51) 98888-0013'),
(14, '(51) 98888-0014'),
(15, '(51) 98888-0015'),
(16, '(51) 98888-0016'),
(17, '(51) 98888-0017'),
(18, '(51) 98888-0018'),
(19, '(51) 98888-0019'),
(20, '(51) 98888-0020'),
(21, '(51) 98888-0021'),
(22, '(51) 98888-0022'),
(23, '(51) 98888-0023');

-- -----------------------------------------------------
-- 6. VEÍCULO (Min 25. 1 cliente c/ 3 veic, 2 clientes sem veic)
-- Cliente 3 (Müller) terá 3 veículos. Clientes 24 e 25 não terão veículos.
-- -----------------------------------------------------
INSERT INTO `veiculo` (`placa`, `marca`, `modelo`, `cor`, `combustivel`, `km_ultima_vez`, `anoFabricacao`, `clienteId`) VALUES
('IXE-1001', 'Ford', 'Ka', 'Branco', 'FLEX', 45000, 2018, 1),
('IXE-1002', 'Chevrolet', 'Onix', 'Preto', 'FLEX', 32000, 2020, 2),
('IXE-1003', 'Volkswagen', 'Gol', 'Prata', 'FLEX', 85000, 2015, 3),
('IXE-1004', 'Volkswagen', 'Saveiro', 'Branco', 'FLEX', 120000, 2016, 3),
('IXE-1005', 'Mercedes', 'Sprinter', 'Branco', 'DIESEL', 210000, 2017, 3),
('IXE-1006', 'Hyundai', 'HB20', 'Cinza', 'FLEX', 15000, 2022, 4),
('IXE-1007', 'Toyota', 'Corolla', 'Preto', 'HIBRIDO', 10000, 2023, 5),
('IXE-1008', 'Honda', 'Civic', 'Prata', 'FLEX', 60000, 2019, 6),
('IXE-1009', 'Fiat', 'Argo', 'Vermelho', 'FLEX', 22000, 2021, 7),
('IXE-1010', 'Jeep', 'Renegade', 'Verde', 'DIESEL', 40000, 2020, 8),
('IXE-1011', 'Nissan', 'Kicks', 'Branco', 'FLEX', 30000, 2021, 9),
('IXE-1012', 'Renault', 'Kwid', 'Laranja', 'FLEX', 12000, 2022, 10),
('IXE-1013', 'Chevrolet', 'Spin', 'Amarelo', 'GNV', 180000, 2018, 11),
('IXE-1014', 'Chevrolet', 'Cobalt', 'Amarelo', 'GNV', 200000, 2017, 11),
('IXE-1015', 'BYD', 'Dolphin', 'Rosa', 'ELETRICO', 5000, 2024, 12),
('IXE-1016', 'Volvo', 'XC40', 'Azul', 'HIBRIDO', 25000, 2022, 13),
('IXE-1017', 'BMW', '320i', 'Preto', 'COMBUSTIVEL', 35000, 2021, 14),
('IXE-1018', 'Fiat', 'Ducato', 'Branco', 'DIESEL', 150000, 2019, 15),
('IXE-1019', 'Ford', 'Transit', 'Prata', 'DIESEL', 130000, 2018, 15),
('IXE-1020', 'Peugeot', '208', 'Azul', 'FLEX', 28000, 2022, 16),
('IXE-1021', 'Audi', 'A3', 'Branco', 'COMBUSTIVEL', 40000, 2020, 17),
('IXE-1022', 'Volkswagen', 'T-Cross', 'Preto', 'FLEX', 18000, 2023, 18),
('IXE-1023', 'Chevrolet', 'Tracker', 'Prata', 'FLEX', 20000, 2022, 18),
('IXE-1024', 'Hyundai', 'Creta', 'Branco', 'FLEX', 25000, 2021, 18),
('IXE-1025', 'Ford', 'Ranger', 'Vermelho', 'DIESEL', 55000, 2020, 19),
('IXE-1026', 'Toyota', 'Hilux', 'Preto', 'DIESEL', 80000, 2019, 20),
('IXE-1027', 'Porsche', 'Macan', 'Branco', 'COMBUSTIVEL', 15000, 2023, 21),
('IXE-1028', 'Land Rover', 'Evoque', 'Cinza', 'DIESEL', 45000, 2020, 22),
('IXE-1029', 'Mini', 'Cooper', 'Azul', 'FLEX', 32000, 2019, 23),
('IXE-1030', 'Fiat', 'Mobi', 'Preto', 'FLEX', 10000, 2023, 23);

-- -----------------------------------------------------
-- 7. CATEGORIA (Min 15, com pelo menos 2 níveis)
-- -----------------------------------------------------
INSERT INTO `categoria` (`nome`, `paiId`) VALUES
('Mecânica Geral', NULL),
('Elétrica', NULL),
('Estética Automotiva', NULL),
('Borracharia', NULL),
('Revisão Preventiva', NULL),
('Motor', 1),
('Suspensão', 1),
('Freios', 1),
('Bateria', 2),
('Iluminação', 2),
('Polimento', 3),
('Higienização Interna', 3),
('Pneus', 4),
('Troca de Óleo e Filtros', 5),
('Alinhamento e Balanceamento', 5);

-- -----------------------------------------------------
-- 8. SERVIÇO (Min 25)
-- -----------------------------------------------------
INSERT INTO `servico` (`nome`, `descricao`, `status`, `categoriaId`, `codigo`, `precoTabela`, `tempoEstimado`) VALUES
('Retífica de Motor', 'Serviço completo de motor', 1, 6, 'SRV-001', 3500.00, 2400),
('Troca de Correia Dentada', 'Substituição da correia', 1, 6, 'SRV-002', 450.00, 180),
('Troca de Amortecedores Dianteiros', 'Par de amortecedores', 1, 7, 'SRV-003', 300.00, 120),
('Troca de Amortecedores Traseiros', 'Par de amortecedores', 1, 7, 'SRV-004', 250.00, 100),
('Troca de Pastilha de Freio', 'Pastilhas dianteiras', 1, 8, 'SRV-005', 120.00, 60),
('Passe no Disco de Freio', 'Retífica do disco', 1, 8, 'SRV-006', 180.00, 90),
('Substituição de Bateria', 'Instalação de bateria nova', 1, 9, 'SRV-007', 50.00, 20),
('Revisão de Alternador', 'Limpeza e troca de escovas', 1, 9, 'SRV-008', 250.00, 150),
('Troca de Lâmpada do Farol', 'Lâmpada H4/H7', 1, 10, 'SRV-009', 30.00, 15),
('Polimento Comercial', 'Polimento simples da pintura', 1, 11, 'SRV-010', 350.00, 240),
('Cristalização de Pintura', 'Polimento + vitrificação', 1, 11, 'SRV-011', 800.00, 480),
('Higienização de Ar Condicionado', 'Limpeza do sistema', 1, 12, 'SRV-012', 150.00, 60),
('Lavagem de Bancos a Seco', 'Limpeza profunda', 1, 12, 'SRV-013', 200.00, 180),
('Conserto de Furo Pneu', 'Remendo a frio', 1, 13, 'SRV-014', 40.00, 20),
('Troca de Pneu', 'Desmontagem e montagem', 1, 13, 'SRV-015', 50.00, 30),
('Troca de Óleo do Motor', 'Mão de obra', 1, 14, 'SRV-016', 60.00, 30),
('Troca de Filtro de Combustível', 'Mão de obra', 1, 14, 'SRV-017', 40.00, 20),
('Troca de Filtro de Ar', 'Mão de obra', 1, 14, 'SRV-018', 20.00, 10),
('Alinhamento 3D', 'Alinhamento computadorizado', 1, 15, 'SRV-019', 100.00, 45),
('Balanceamento 4 Rodas', 'Balanceamento de rodas', 1, 15, 'SRV-020', 80.00, 40),
('Limpeza de Bicos Injetores', 'Limpeza via ultrassom', 1, 6, 'SRV-021', 180.00, 90),
('Troca de Velas', 'Substituição das 4 velas', 1, 6, 'SRV-022', 80.00, 45),
('Troca de Fluido de Freio', 'Sangria e fluido novo', 1, 8, 'SRV-023', 150.00, 60),
('Revisão Elétrica Básica', 'Teste de carga e fuga', 1, 2, 'SRV-024', 120.00, 60),
('Checkup 40 Itens', 'Inspeção geral', 1, 5, 'SRV-025', 200.00, 120);

-- -----------------------------------------------------
-- 9. FORNECEDOR (Min 5)
-- -----------------------------------------------------
INSERT INTO `fornecedor` (`cnpj`, `email`, `telefone`, `razaoSocial`) VALUES
('11222333000100', 'vendas@bosch.com.br', '(11) 4000-1111', 'Bosch Auto Parts SA'),
('44555666000199', 'contato@skf.com.br', '(11) 4000-2222', 'SKF Rolamentos Ltda'),
('77888999000188', 'distribuicao@moura.com.br', '(81) 3000-3333', 'Baterias Moura SA'),
('10203040000177', 'pedidos@ngk.com.br', '(11) 4000-4444', 'NGK Velas Automotivas'),
('50607080000166', 'vendas@autopeçassilva.com.br', '(51) 3333-5555', 'Auto Peças Silva Ltda');

-- -----------------------------------------------------
-- 10. PEÇA (Min 30. Pelo menos 5 abaixo do estoque. Pelo menos 2 sem fornecedor)
-- Gerando 50 para satisfazer aos 50 OS e ao requisito de constraint UNIQUE por peça
-- -----------------------------------------------------
INSERT INTO `peca` (`codigo`, `nome`, `precoCusto`, `precoVenda`, `estoqueMinimo`, `estoqueAtual`, `fornecedorId`) VALUES
('PEC-001', 'Correia Dentada Gates', 80.00, 150.00, 10, 15, 1),
('PEC-002', 'Amortecedor Monroe Dianteiro', 150.00, 280.00, 4, 1, 1), -- Abaixo min (1)
('PEC-003', 'Amortecedor Monroe Traseiro', 120.00, 220.00, 4, 2, 1), -- Abaixo min (2)
('PEC-004', 'Pastilha de Freio Cobreq', 45.00, 90.00, 10, 20, 5),
('PEC-005', 'Disco de Freio Fremax', 90.00, 160.00, 6, 12, 5),
('PEC-006', 'Bateria Moura 60Ah', 250.00, 400.00, 5, 8, 3),
('PEC-007', 'Lâmpada H4 Osram', 15.00, 35.00, 20, 15, 1), -- Abaixo min (3)
('PEC-008', 'Filtro de Óleo Fram', 18.00, 35.00, 15, 30, 1),
('PEC-009', 'Óleo Motor 5W30 Mobil', 25.00, 45.00, 50, 40, 1), -- Abaixo min (4)
('PEC-010', 'Filtro de Ar Tecfil', 20.00, 40.00, 10, 25, 5),
('PEC-011', 'Vela de Ignição NGK', 12.00, 25.00, 40, 60, 4),
('PEC-012', 'Fluido de Freio Varga', 22.00, 45.00, 12, 5, 1), -- Abaixo min (5)
('PEC-013', 'Bucha de Suspensão Axios', 35.00, 70.00, 10, 15, 5),
('PEC-014', 'Rolamento SKF Roda', 70.00, 140.00, 8, 12, 2),
('PEC-015', 'Kit Embreagem Luk', 350.00, 650.00, 3, 5, 5),
('PEC-016', 'Cabo de Vela NGK', 65.00, 120.00, 5, 8, 4),
('PEC-017', 'Bomba D Água Urba', 95.00, 180.00, 4, 6, 5),
('PEC-018', 'Válvula Termostática Wahler', 45.00, 90.00, 5, 10, 1),
('PEC-019', 'Radiador Valeo', 280.00, 520.00, 2, 4, 1),
('PEC-020', 'Aditivo Paraíso (Sem Fornecedor)', 15.00, 35.00, 20, 25, NULL), -- Sem forn (1)
('PEC-021', 'Cheirinho Carro (Sem Fornecedor)', 5.00, 15.00, 50, 60, NULL), -- Sem forn (2)
('PEC-022', 'Palheta Limpador Bosch', 30.00, 65.00, 15, 20, 1),
('PEC-023', 'Filtro Combustível Mahle', 22.00, 48.00, 10, 18, 5),
('PEC-024', 'Bomba de Combustível Bosch', 120.00, 250.00, 4, 7, 1),
('PEC-025', 'Coxim Motor', 85.00, 160.00, 6, 9, 5),
('PEC-026', 'Junta Tampa Válvula', 25.00, 55.00, 10, 15, 5),
('PEC-027', 'Retentor Comando', 18.00, 40.00, 10, 14, 5),
('PEC-028', 'Sensor Rotação', 95.00, 190.00, 3, 5, 1),
('PEC-029', 'Atuador Marcha Lenta', 110.00, 220.00, 3, 5, 1),
('PEC-030', 'Sensor Lambda', 180.00, 350.00, 4, 6, 1),
('PEC-031', 'Bobina Ignição', 150.00, 280.00, 4, 8, 1),
('PEC-032', 'Tensionador Correia', 85.00, 170.00, 6, 10, 2),
('PEC-033', 'Pivo Suspensão', 40.00, 85.00, 8, 12, 5),
('PEC-034', 'Terminal Direção', 45.00, 95.00, 8, 12, 5),
('PEC-035', 'Kit Batente Amortecedor', 55.00, 110.00, 8, 12, 5),
('PEC-036', 'Homocinética', 130.00, 260.00, 4, 7, 5),
('PEC-037', 'Coifa Homocinética', 25.00, 50.00, 10, 18, 5),
('PEC-038', 'Cabo de Embreagem', 35.00, 75.00, 6, 9, 5),
('PEC-039', 'Cilindro Mestre Freio', 180.00, 340.00, 3, 5, 1),
('PEC-040', 'Cilindro Roda', 45.00, 90.00, 6, 10, 5),
('PEC-041', 'Sapata Freio', 65.00, 130.00, 4, 8, 5),
('PEC-042', 'Cabo Freio Mão', 35.00, 75.00, 6, 10, 5),
('PEC-043', 'Bieleta Suspensão', 30.00, 65.00, 10, 20, 5),
('PEC-044', 'Carter Motor', 150.00, 300.00, 2, 4, 5),
('PEC-045', 'Bujão Carter', 8.00, 20.00, 20, 30, 5),
('PEC-046', 'Relé Injeção', 25.00, 55.00, 8, 12, 1),
('PEC-047', 'Fusível 10A (Pacote)', 5.00, 15.00, 30, 50, 1),
('PEC-048', 'Calota Aro 14', 20.00, 45.00, 12, 20, 5),
('PEC-049', 'Lâmpada Pingo', 5.00, 15.00, 40, 60, 1),
('PEC-050', 'Lâmpada Pisca', 8.00, 20.00, 30, 45, 1);

-- -----------------------------------------------------
-- 11. ORDEM_SERVICO (Min 40. Todos 8 status. 3 meses dif. 3 abertas > 7 dias. 2 sem mecânico)
-- Gerando 50 para poder ter 100 itens (pois UNIQUE limita 1 de cada por OS)
-- Meses: Junho, Julho e Agosto de 2026.
-- Status: 'ABERTA', 'ORCAMENTO', 'APROVADA', 'EM_EXECUCAO', 'AGUARDANDO_PECA', 'FINALIZADO', 'ENTREGUE', 'CANCELADA'
-- -----------------------------------------------------
INSERT INTO `ordem_servico` (`numero_os`, `veiculoId`, `abertura`, `previsao_entrega`, `observacao`, `etapa`, `KmEntrada`, `atendenteId`, `desconto`, `mecanincoId`, `unidadeId`) VALUES
-- ENTREGUES (Agosto - Pagas depois)
('OS-1001', 1, '2026-08-01 08:00:00', '2026-08-02 18:00:00', 'Troca de óleo rápida', 'ENTREGUE', 45100, 7, 0.00, 10, 1),
('OS-1002', 2, '2026-08-02 09:00:00', '2026-08-03 18:00:00', 'Revisão geral', 'ENTREGUE', 32100, 8, 50.00, 11, 2),
('OS-1003', 3, '2026-08-03 10:00:00', '2026-08-05 18:00:00', 'Barulho suspensão', 'ENTREGUE', 85200, 9, 0.00, 13, 3),
('OS-1004', 4, '2026-08-04 11:00:00', '2026-08-04 18:00:00', 'Lâmpada queimada', 'ENTREGUE', 120100, 7, 0.00, 10, 1),
('OS-1005', 5, '2026-08-05 08:30:00', '2026-08-06 18:00:00', 'Bateria fraca', 'ENTREGUE', 210100, 8, 10.00, 11, 2),
('OS-1006', 6, '2026-08-05 14:00:00', '2026-08-07 18:00:00', 'Polimento', 'ENTREGUE', 15100, 9, 0.00, 14, 3),
('OS-1007', 7, '2026-08-06 09:15:00', '2026-08-07 18:00:00', 'Alinhamento', 'ENTREGUE', 10100, 7, 0.00, 10, 1),
('OS-1008', 8, '2026-08-07 10:30:00', '2026-08-08 18:00:00', 'Freio assobiando', 'ENTREGUE', 60100, 8, 25.00, 12, 2),
('OS-1009', 9, '2026-08-08 11:45:00', '2026-08-09 18:00:00', 'Troca filtro', 'ENTREGUE', 22100, 9, 0.00, 13, 3),
('OS-1010', 10, '2026-08-09 13:00:00', '2026-08-10 18:00:00', 'Checkup diesel', 'ENTREGUE', 40100, 7, 0.00, 11, 1),
('OS-1011', 11, '2026-08-10 14:15:00', '2026-08-11 18:00:00', 'Vazamento', 'ENTREGUE', 30100, 8, 0.00, 12, 2),
('OS-1012', 12, '2026-08-11 15:30:00', '2026-08-12 18:00:00', 'Suspensão dura', 'ENTREGUE', 12100, 9, 0.00, 13, 3),
('OS-1013', 13, '2026-08-11 16:45:00', '2026-08-12 18:00:00', 'Regulagem GNV', 'ENTREGUE', 180100, 7, 0.00, 10, 1),
('OS-1014', 14, '2026-08-12 08:00:00', '2026-08-13 18:00:00', 'Troca cabos', 'ENTREGUE', 200100, 8, 0.00, 11, 2),
('OS-1015', 15, '2026-08-12 09:15:00', '2026-08-13 18:00:00', 'Checkup elétrico', 'ENTREGUE', 5100, 9, 0.00, 14, 3),

-- FINALIZADAS SEM PAGAMENTO (3 Mínimo exigido)
('OS-1016', 16, '2026-08-10 10:00:00', '2026-08-11 18:00:00', 'Troca de pastilhas', 'FINALIZADO', 25100, 7, 0.00, 10, 1),
('OS-1017', 17, '2026-08-10 11:30:00', '2026-08-11 18:00:00', 'Troca pneu', 'FINALIZADO', 35100, 8, 0.00, 11, 2),
('OS-1018', 18, '2026-08-11 13:45:00', '2026-08-12 18:00:00', 'Cristalização', 'FINALIZADO', 15100, 9, 0.00, 14, 3),

-- ABERTAS > 7 DIAS (Hoje é Ago 12, então abertura em Julho, não finalizadas)
('OS-1019', 19, '2026-07-25 08:00:00', '2026-08-01 18:00:00', 'Motor fundido - cliente enrolando p/ aprovar', 'ABERTA', 130100, 7, 0.00, NULL, 1), -- Sem mecânico (1) e > 7 dias (1)
('OS-1020', 20, '2026-07-28 09:00:00', '2026-08-05 18:00:00', 'Caixa de marcha travada', 'EM_EXECUCAO', 28100, 8, 0.00, 12, 2), -- > 7 dias (2)
('OS-1021', 21, '2026-07-30 10:00:00', '2026-08-06 18:00:00', 'Refazer chicote elétrico', 'ABERTA', 40100, 9, 0.00, NULL, 3), -- Sem mecânico (2) e > 7 dias (3)

-- OUTROS STATUS / MESES (Junho e Julho)
('OS-1022', 22, '2026-06-15 08:00:00', '2026-06-16 18:00:00', 'Troca óleo', 'CANCELADA', 18100, 7, 0.00, 10, 1),
('OS-1023', 23, '2026-06-20 09:00:00', '2026-06-22 18:00:00', 'Barulho roda', 'CANCELADA', 20100, 8, 0.00, 11, 2),
('OS-1024', 24, '2026-07-10 14:00:00', '2026-07-15 18:00:00', 'Batida traseira', 'ORCAMENTO', 25100, 9, 0.00, 14, 3),
('OS-1025', 25, '2026-07-12 10:00:00', '2026-07-16 18:00:00', 'Vazamento óleo', 'ORCAMENTO', 55100, 7, 0.00, 10, 1),
('OS-1026', 26, '2026-08-11 08:00:00', '2026-08-15 18:00:00', 'Limpeza de bicos', 'APROVADA', 80100, 8, 0.00, 12, 2),
('OS-1027', 27, '2026-08-12 09:00:00', '2026-08-16 18:00:00', 'Troca buchas', 'APROVADA', 15100, 9, 0.00, 13, 3),
('OS-1028', 28, '2026-08-01 10:00:00', '2026-08-20 18:00:00', 'Peça importada', 'AGUARDANDO_PECA', 45100, 7, 0.00, 11, 1),
('OS-1029', 29, '2026-08-05 11:00:00', '2026-08-25 18:00:00', 'Módulo injeção', 'AGUARDANDO_PECA', 32100, 8, 0.00, 12, 2),
('OS-1030', 30, '2026-08-12 14:00:00', '2026-08-12 18:00:00', 'Revisão viagem', 'EM_EXECUCAO', 10100, 9, 0.00, 14, 3),

-- RESTANTE PARA COMPLETAR 50 OS
('OS-1031', 1, '2026-08-01 08:00:00', '2026-08-01 18:00:00', 'Lâmpada', 'ENTREGUE', 45050, 7, 0.00, 10, 1),
('OS-1032', 2, '2026-08-02 08:00:00', '2026-08-02 18:00:00', 'Filtro ar', 'ENTREGUE', 32050, 8, 0.00, 11, 2),
('OS-1033', 3, '2026-08-03 08:00:00', '2026-08-03 18:00:00', 'Palheta', 'ENTREGUE', 85050, 9, 0.00, 13, 3),
('OS-1034', 4, '2026-08-04 08:00:00', '2026-08-04 18:00:00', 'Fusível', 'ENTREGUE', 120050, 7, 0.00, 10, 1),
('OS-1035', 5, '2026-08-05 08:00:00', '2026-08-05 18:00:00', 'Óleo', 'ENTREGUE', 210050, 8, 0.00, 12, 2),
('OS-1036', 6, '2026-08-06 08:00:00', '2026-08-06 18:00:00', 'Filtro combustível', 'ENTREGUE', 15050, 9, 0.00, 14, 3),
('OS-1037', 7, '2026-08-07 08:00:00', '2026-08-07 18:00:00', 'Alinhamento', 'ENTREGUE', 10050, 7, 0.00, 11, 1),
('OS-1038', 8, '2026-08-08 08:00:00', '2026-08-08 18:00:00', 'Velas', 'ENTREGUE', 60050, 8, 0.00, 12, 2),
('OS-1039', 9, '2026-08-09 08:00:00', '2026-08-09 18:00:00', 'Cabo vela', 'ENTREGUE', 22050, 9, 0.00, 13, 3),
('OS-1040', 10, '2026-08-10 08:00:00', '2026-08-10 18:00:00', 'Disco freio', 'ENTREGUE', 40050, 7, 0.00, 10, 1),
('OS-1041', 11, '2026-08-11 08:00:00', '2026-08-11 18:00:00', 'Pastilha', 'ENTREGUE', 30050, 8, 0.00, 11, 2),
('OS-1042', 12, '2026-08-12 08:00:00', '2026-08-12 18:00:00', 'Amortecedor', 'ENTREGUE', 12050, 9, 0.00, 14, 3),
('OS-1043', 13, '2026-08-11 10:00:00', '2026-08-12 18:00:00', 'Correia', 'FINALIZADO', 180050, 7, 0.00, 10, 1),
('OS-1044', 14, '2026-08-11 11:00:00', '2026-08-12 18:00:00', 'Bomba d água', 'FINALIZADO', 200050, 8, 0.00, 12, 2),
('OS-1045', 15, '2026-08-11 12:00:00', '2026-08-12 18:00:00', 'Válvula', 'FINALIZADO', 5050, 9, 0.00, 13, 3),
('OS-1046', 16, '2026-08-12 09:00:00', '2026-08-13 18:00:00', 'Radiador', 'EM_EXECUCAO', 25050, 7, 0.00, 10, 1),
('OS-1047', 17, '2026-08-12 10:00:00', '2026-08-14 18:00:00', 'Coxim', 'EM_EXECUCAO', 40050, 8, 0.00, 11, 2),
('OS-1048', 18, '2026-08-12 11:00:00', '2026-08-15 18:00:00', 'Retentor', 'APROVADA', 18050, 9, 0.00, 14, 3),
('OS-1049', 19, '2026-08-12 13:00:00', '2026-08-16 18:00:00', 'Junta', 'APROVADA', 130050, 7, 0.00, 10, 1),
('OS-1050', 20, '2026-08-12 14:00:00', '2026-08-17 18:00:00', 'Sensor', 'ORCAMENTO', 28050, 8, 0.00, 12, 2);

-- -----------------------------------------------------
-- 12. ITENS DE OS (Min 100 somando serviços e peças)
-- Inserindo 50 serviços (1 por OS) e 50 peças (1 por OS), totalizando 100 itens.
-- -----------------------------------------------------

-- SERVIÇOS
INSERT INTO `itemosservico` (`quantidade`, `precoCobrado`, `osId`, `servicoId`, `mecanicaId`) VALUES
(1, 60.00, 1, 16, 10), (1, 200.00, 2, 25, 11), (1, 300.00, 3, 3, 13),
(1, 30.00, 4, 9, 10), (1, 50.00, 5, 7, 11), (1, 350.00, 6, 10, 14),
(1, 100.00, 7, 19, 10), (1, 120.00, 8, 5, 12), (1, 40.00, 9, 17, 13),
(1, 200.00, 10, 25, 11), (1, 150.00, 11, 23, 12), (1, 300.00, 12, 3, 13),
(1, 120.00, 13, 24, 10), (1, 80.00, 14, 22, 11), (1, 120.00, 15, 24, 14),
(1, 120.00, 16, 5, 10), (1, 50.00, 17, 15, 11), (1, 800.00, 18, 11, 14),
(1, 3500.00, 19, 1, 10), (1, 450.00, 20, 2, 12), (1, 120.00, 21, 24, 13),
(1, 60.00, 22, 16, 10), (1, 300.00, 23, 3, 11), (1, 350.00, 24, 10, 14),
(1, 60.00, 25, 16, 10), (1, 180.00, 26, 21, 12), (1, 300.00, 27, 3, 13),
(1, 200.00, 28, 25, 11), (1, 120.00, 29, 24, 12), (1, 200.00, 30, 25, 14),
(1, 30.00, 31, 9, 10), (1, 20.00, 32, 18, 11), (1, 40.00, 33, 14, 13),
(1, 120.00, 34, 24, 10), (1, 60.00, 35, 16, 12), (1, 40.00, 36, 17, 14),
(1, 100.00, 37, 19, 11), (1, 80.00, 38, 22, 12), (1, 120.00, 39, 24, 13),
(1, 180.00, 40, 6, 10), (1, 120.00, 41, 5, 11), (1, 300.00, 42, 3, 14),
(1, 450.00, 43, 2, 10), (1, 3500.00, 44, 1, 12), (1, 450.00, 45, 2, 13),
(1, 150.00, 46, 23, 10), (1, 300.00, 47, 3, 11), (1, 3500.00, 48, 1, 14),
(1, 3500.00, 49, 1, 10), (1, 120.00, 50, 24, 12);

-- PEÇAS
INSERT INTO `itemospeca` (`quantidade`, `precoCobrado`, `osId`, `pecaId`) VALUES
(4, 45.00, 1, 9), (1, 40.00, 2, 10), (2, 280.00, 3, 2),
(1, 35.00, 4, 7), (1, 400.00, 5, 6), (1, 35.00, 6, 20),
(1, 15.00, 7, 21), (1, 90.00, 8, 4), (1, 48.00, 9, 23),
(1, 35.00, 10, 8), (1, 55.00, 11, 26), (2, 220.00, 12, 3),
(1, 120.00, 13, 16), (1, 25.00, 14, 11), (1, 55.00, 15, 46),
(1, 160.00, 16, 5), (1, 250.00, 17, 24), (1, 520.00, 18, 19),
(1, 300.00, 19, 44), (1, 650.00, 20, 15), (1, 15.00, 21, 47),
(1, 20.00, 22, 45), (1, 140.00, 23, 14), (1, 45.00, 24, 48),
(1, 40.00, 25, 27), (1, 190.00, 26, 28), (2, 70.00, 27, 13),
(1, 220.00, 28, 29), (1, 350.00, 29, 30), (1, 280.00, 30, 31),
(1, 15.00, 31, 49), (1, 170.00, 32, 32), (1, 85.00, 33, 33),
(1, 95.00, 34, 34), (1, 110.00, 35, 35), (1, 260.00, 36, 36),
(1, 50.00, 37, 37), (1, 75.00, 38, 38), (1, 340.00, 39, 39),
(1, 90.00, 40, 40), (1, 130.00, 41, 41), (1, 75.00, 42, 42),
(1, 150.00, 43, 1), (1, 180.00, 44, 17), (1, 90.00, 45, 18),
(1, 65.00, 46, 43), (1, 160.00, 47, 25), (1, 65.00, 48, 22),
(1, 45.00, 49, 12), (1, 20.00, 50, 50);

-- -----------------------------------------------------
-- 13. PAGAMENTO (Min 25. OS entregues pagas, >=2 parceladas, 3 finalizadas sem pgto - já tratado via não inserção das OS 16, 17 e 18)
-- Pagando as 15 primeiras (ENTREGUES da OS 1 a 15) e mais 10 da OS 31 a 40 (também ENTREGUES)
-- -----------------------------------------------------
INSERT INTO `pagamento` (`valor`, `num_parcelas`, `data_hora`, `forma`, `osId`, `quemRecebeId`) VALUES
(240.00, 1, '2026-08-02 18:05:00', 'PIX', 1, 7),
(240.00, 1, '2026-08-03 18:05:00', 'DEBIDO', 2, 8),
(860.00, 3, '2026-08-05 18:05:00', 'CREDITO', 3, 9), -- Parcelado 1
(65.00, 1, '2026-08-04 18:05:00', 'DINHEIRO', 4, 7),
(450.00, 2, '2026-08-06 18:05:00', 'CREDITO', 5, 8), -- Parcelado 2
(385.00, 1, '2026-08-07 18:05:00', 'PIX', 6, 9),
(115.00, 1, '2026-08-07 18:05:00', 'DEBIDO', 7, 7),
(210.00, 1, '2026-08-08 18:05:00', 'PIX', 8, 8),
(88.00, 1, '2026-08-09 18:05:00', 'DINHEIRO', 9, 9),
(235.00, 1, '2026-08-10 18:05:00', 'BOLETO', 10, 7),
(205.00, 1, '2026-08-11 18:05:00', 'PIX', 11, 8),
(740.00, 3, '2026-08-12 18:05:00', 'CREDITO', 12, 9), -- Parcelado 3
(240.00, 1, '2026-08-12 18:05:00', 'PIX', 13, 7),
(105.00, 1, '2026-08-13 18:05:00', 'DEBIDO', 14, 8),
(175.00, 1, '2026-08-13 18:05:00', 'PIX', 15, 9),
(45.00, 1, '2026-08-01 18:05:00', 'DINHEIRO', 31, 7),
(190.00, 1, '2026-08-02 18:05:00', 'PIX', 32, 8),
(125.00, 1, '2026-08-03 18:05:00', 'DEBIDO', 33, 9),
(215.00, 1, '2026-08-04 18:05:00', 'PIX', 34, 7),
(170.00, 1, '2026-08-05 18:05:00', 'CREDITO', 35, 8),
(300.00, 1, '2026-08-06 18:05:00', 'PIX', 36, 9),
(150.00, 1, '2026-08-07 18:05:00', 'DEBIDO', 37, 7),
(155.00, 1, '2026-08-08 18:05:00', 'PIX', 38, 8),
(460.00, 1, '2026-08-09 18:05:00', 'CREDITO', 39, 9),
(270.00, 1, '2026-08-10 18:05:00', 'PIX', 40, 7);

-- -----------------------------------------------------
-- 14. MOVIMENTACAOESTOQUE (Min 40. Entradas e Saídas, saídas ligadas a OS)
-- 20 Entradas sem OS (Compra com Fornecedor)
-- 20 Saídas com OS
-- -----------------------------------------------------
INSERT INTO `movimentacaoestoque` (`tipo`, `quantidade`, `motivo`, `dataHora`, `pecaId`, `responsavelId`, `odId`) VALUES
-- 20 Entradas
('ENTRADA', 10, 'Compra Reposição', '2026-07-01 10:00:00', 9, 3, NULL),
('ENTRADA', 5, 'Compra Reposição', '2026-07-01 10:15:00', 10, 3, NULL),
('ENTRADA', 2, 'Compra Urgente', '2026-07-02 14:00:00', 2, 4, NULL),
('ENTRADA', 15, 'Compra Reposição', '2026-07-05 09:00:00', 7, 5, NULL),
('ENTRADA', 4, 'Compra Reposição', '2026-07-10 11:00:00', 6, 3, NULL),
('ENTRADA', 20, 'Compra Atacado', '2026-07-12 15:30:00', 20, 4, NULL),
('ENTRADA', 30, 'Compra Atacado', '2026-07-12 15:45:00', 21, 4, NULL),
('ENTRADA', 8, 'Compra Reposição', '2026-07-15 08:30:00', 4, 5, NULL),
('ENTRADA', 10, 'Compra Reposição', '2026-07-18 10:00:00', 23, 3, NULL),
('ENTRADA', 5, 'Compra Reposição', '2026-07-20 11:20:00', 8, 4, NULL),
('ENTRADA', 12, 'Compra Reposição', '2026-07-22 14:10:00', 26, 5, NULL),
('ENTRADA', 4, 'Compra Reposição', '2026-07-25 16:00:00', 3, 3, NULL),
('ENTRADA', 6, 'Compra Urgente', '2026-07-28 09:30:00', 16, 4, NULL),
('ENTRADA', 10, 'Compra Reposição', '2026-07-30 13:45:00', 11, 5, NULL),
('ENTRADA', 2, 'Compra Reposição', '2026-08-01 10:00:00', 46, 3, NULL),
('ENTRADA', 5, 'Compra Reposição', '2026-08-02 11:15:00', 5, 4, NULL),
('ENTRADA', 3, 'Compra Reposição', '2026-08-03 14:30:00', 24, 5, NULL),
('ENTRADA', 4, 'Compra Reposição', '2026-08-04 16:45:00', 19, 3, NULL),
('ENTRADA', 6, 'Compra Reposição', '2026-08-05 09:10:00', 44, 4, NULL),
('ENTRADA', 2, 'Compra Urgente', '2026-08-06 10:20:00', 15, 5, NULL),
-- 20 Saídas (Ligadas às OS correspondentes, com os mecânicos sendo os responsáveis ou chefes)
('SAIDA', 4, 'Aplicação em OS', '2026-08-01 14:00:00', 9, 10, 1),
('SAIDA', 1, 'Aplicação em OS', '2026-08-02 14:00:00', 10, 11, 2),
('SAIDA', 2, 'Aplicação em OS', '2026-08-03 14:00:00', 2, 13, 3),
('SAIDA', 1, 'Aplicação em OS', '2026-08-04 14:00:00', 7, 10, 4),
('SAIDA', 1, 'Aplicação em OS', '2026-08-05 14:00:00', 6, 11, 5),
('SAIDA', 1, 'Aplicação em OS', '2026-08-06 14:00:00', 20, 14, 6),
('SAIDA', 1, 'Aplicação em OS', '2026-08-07 14:00:00', 21, 10, 7),
('SAIDA', 1, 'Aplicação em OS', '2026-08-08 14:00:00', 4, 12, 8),
('SAIDA', 1, 'Aplicação em OS', '2026-08-09 14:00:00', 23, 13, 9),
('SAIDA', 1, 'Aplicação em OS', '2026-08-10 14:00:00', 8, 11, 10),
('SAIDA', 1, 'Aplicação em OS', '2026-08-11 14:00:00', 26, 12, 11),
('SAIDA', 2, 'Aplicação em OS', '2026-08-12 14:00:00', 3, 13, 12),
('SAIDA', 1, 'Aplicação em OS', '2026-08-12 10:00:00', 16, 10, 13),
('SAIDA', 1, 'Aplicação em OS', '2026-08-12 11:00:00', 11, 11, 14),
('SAIDA', 1, 'Aplicação em OS', '2026-08-12 12:00:00', 46, 14, 15),
('SAIDA', 1, 'Aplicação em OS', '2026-08-11 14:00:00', 5, 10, 16),
('SAIDA', 1, 'Aplicação em OS', '2026-08-11 15:00:00', 24, 11, 17),
('SAIDA', 1, 'Aplicação em OS', '2026-08-12 14:00:00', 19, 14, 18),
('SAIDA', 1, 'Aplicação em OS', '2026-08-12 15:00:00', 44, 10, 19),
('SAIDA', 1, 'Aplicação em OS', '2026-08-12 16:00:00', 15, 12, 20);
```


## E4:
### As 16 consultas, numeradas, cada uma com a pergunta em comentário acima

C01	Quantas OS existem em cada status, numa unidade específica.

SELECT 
    u.nome AS Unidade,
    os.etapa AS Status_OS,
    COUNT(os.id) AS Quantidade_OS
FROM ordem_servico os
JOIN unidade_oficina u ON os.unidadeId = u.id
WHERE u.id = 2
GROUP BY u.nome, os.etapa
ORDER BY Quantidade_OS DESC;

C02	Faturamento recebido no mês corrente, por unidade, do maior pro menor.

SELECT 
    u.nome AS Unidade,
    SUM(p.valor) AS Faturamento_Total
FROM pagamento p
JOIN ordem_servico os ON p.osId = os.id
JOIN unidade_oficina u ON os.unidadeId = u.id
WHERE MONTH(p.data_hora) = MONTH(CURRENT_DATE()) 
  AND YEAR(p.data_hora) = YEAR(CURRENT_DATE())
GROUP BY u.id, u.nome
ORDER BY Faturamento_Total DESC;

C03	Ticket médio das OS entregues por unidade.

SELECT 
    u.nome AS Unidade,
    COUNT(DISTINCT os.id) AS Qtd_OS_Entregues,
    SUM(p.valor) AS Faturamento_Total,
    (SUM(p.valor) / COUNT(DISTINCT os.id)) AS Ticket_Medio
FROM ordem_servico os
JOIN unidade_oficina u ON os.unidadeId = u.id
JOIN pagamento p ON p.osId = os.id
WHERE os.etapa = 'ENTREGUE'
GROUP BY u.id, u.nome
ORDER BY Ticket_Medio DESC;

C04	Os 5 serviços mais vendidos no período, com quantidade e receita gerada.

SELECT 
    s.nome AS Servico,
    SUM(ios.quantidade) AS Quantidade_Vendida,
    SUM(ios.quantidade * ios.precoCobrado) AS Receita_Gerada
FROM itemosservico ios
JOIN servico s ON ios.servicoId = s.id
JOIN ordem_servico os ON ios.osId = os.id
WHERE os.abertura BETWEEN '2026-08-01 00:00:00' AND '2026-08-31 23:59:59'
GROUP BY s.id, s.nome
ORDER BY Quantidade_Vendida DESC
LIMIT 5;

C05	Peças que estão abaixo do estoque mínimo, com quanto falta pra repor.

SELECT 
    p.codigo AS Codigo_Peca,
    p.nome AS Peca,
    p.estoqueAtual AS Estoque_Atual,
    p.estoqueMinimo AS Estoque_Minimo,
    (p.estoqueMinimo - p.estoqueAtual) AS Quantidade_Para_Repor,
    f.razaoSocial AS Fornecedor
FROM peca p
LEFT JOIN fornecedor f ON p.fornecedorId = f.id
WHERE p.estoqueAtual < p.estoqueMinimo
ORDER BY Quantidade_Para_Repor DESC;

C06	OS abertas há mais de 7 dias que ainda não foram finalizadas, com quantos dias de casa.

SELECT 
    os.numero_os AS Numero_OS,
    c.nome AS Cliente,
    v.placa AS Placa_Veiculo,
    os.etapa AS Status_Atual,
    os.abertura AS Data_Abertura,
    DATEDIFF(CURRENT_DATE(), os.abertura) AS Dias_Na_Oficina
FROM ordem_servico os
JOIN veiculo v ON os.veiculoId = v.id
JOIN cliente c ON v.clienteId = c.id
WHERE os.etapa NOT IN ('FINALIZADO', 'ENTREGUE', 'CANCELADA')
  AND DATEDIFF(CURRENT_DATE(), os.abertura) > 7
ORDER BY Dias_Na_Oficina DESC;

C07	Clientes que nunca abriram nenhuma OS.

SELECT 
    nome AS Cliente,
    documento AS CPF_CNPJ,
    email AS Email
FROM cliente
WHERE id NOT IN (
    SELECT v.clienteId 
    FROM ordem_servico os
    JOIN veiculo v ON os.veiculoId = v.id
);

C08	Clientes cadastrados sem nenhum telefone.

SELECT 
    c.nome AS Cliente,
    c.documento AS CPF_CNPJ,
    c.email AS Email
FROM cliente c
LEFT JOIN telefone t ON c.id = t.clienteId
WHERE t.id IS NULL;

C09	O total de cada OS: soma dos serviços, soma das peças, desconto e valor final.

SELECT 
    os.numero_os AS Numero_OS,
    COALESCE(TotalServicos.Total_S, 0) AS Total_Servicos,
    COALESCE(TotalPecas.Total_P, 0) AS Total_Pecas,
    os.desconto AS Desconto,
    (COALESCE(TotalServicos.Total_S, 0) + COALESCE(TotalPecas.Total_P, 0) - os.desconto) AS Valor_Final
FROM ordem_servico os
LEFT JOIN (
    SELECT osId, SUM(quantidade * precoCobrado) AS Total_S 
    FROM itemosservico 
    GROUP BY osId
) AS TotalServicos ON os.id = TotalServicos.osId
LEFT JOIN (
    SELECT osId, SUM(quantidade * precoCobrado) AS Total_P 
    FROM itemospeca 
    GROUP BY osId
) AS TotalPecas ON os.id = TotalPecas.osId;

C10	Mecânicos que finalizaram 5 ou mais OS no mês, ordenados por quantidade.

SELECT 
    c.nome_completo AS Mecanico,
    COUNT(os.id) AS Quantidade_OS_Finalizadas
FROM ordem_servico os
JOIN colaborador c ON os.mecanincoId = c.id
WHERE os.etapa IN ('FINALIZADO', 'ENTREGUE')
  AND MONTH(os.abertura) = MONTH(CURRENT_DATE())
  AND YEAR(os.abertura) = YEAR(CURRENT_DATE())
GROUP BY c.id, c.nome_completo
HAVING COUNT(os.id) >= 5
ORDER BY Quantidade_OS_Finalizadas DESC;

C11	Cada colaborador com o nome do supervisor direto ao lado (quem não tem supervisor aparece mesmo assim).

SELECT 
    c.nome_completo AS Colaborador,
    COALESCE(s.nome_completo, 'Sem Supervisor') AS Supervisor_Direto
FROM colaborador c
LEFT JOIN colaborador s ON c.supervisorId = s.id;

C12	Cada subcategoria de serviço com o nome da categoria pai.

SELECT 
    filha.nome AS Subcategoria,
    pai.nome AS Categoria_Pai
FROM categoria filha
JOIN categoria pai ON filha.paiId = pai.id;

C13	Serviços com preço acima da média do catálogo.

SELECT 
    codigo AS Codigo,
    nome AS Servico,
    precoTabela AS Preco
FROM servico
WHERE precoTabela > (
    SELECT AVG(precoTabela) FROM servico
)
ORDER BY Preco DESC;

C14	Movimentações de estoque agrupadas por dia, com total de entradas e de saídas.

SELECT 
    DATE(dataHora) AS Dia,
    SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE 0 END) AS Total_Entradas,
    SUM(CASE WHEN tipo = 'SAIDA' THEN quantidade ELSE 0 END) AS Total_Saidas
FROM movimentacaoestoque
GROUP BY DATE(dataHora)
ORDER BY Dia DESC;

C15	Etiqueta do pátio: placa, modelo, nome do cliente e o status da OS escrito por extenso, em uma coluna só.

SELECT 
    CONCAT(v.placa, ' - ', v.modelo, ' | Cliente: ', c.nome, ' | Status: ', os.etapa) AS Etiqueta_Patio
FROM ordem_servico os
JOIN veiculo v ON os.veiculoId = v.id
JOIN cliente c ON v.clienteId = c.id
WHERE os.etapa NOT IN ('ENTREGUE', 'CANCELADA');    

C16	Para cada OS não entregue: quantos dias faltam pra previsão de entrega, marcando "atrasada" quando o prazo já passou.

SELECT 
    numero_os AS Numero_OS,
    previsao_entrega AS Previsao,
    CASE 
        WHEN previsao_entrega IS NULL THEN 'Sem Previsão'
        WHEN DATEDIFF(previsao_entrega, CURRENT_DATE()) < 0 THEN 'Atrasada'
        WHEN DATEDIFF(previsao_entrega, CURRENT_DATE()) = 0 THEN 'Entrega Hoje'
        ELSE CONCAT(DATEDIFF(previsao_entrega, CURRENT_DATE()), ' dia(s) restante(s)')
    END AS Status_Prazo
FROM ordem_servico
WHERE etapa NOT IN ('ENTREGUE', 'CANCELADA');


## E5:
### Toda tabela, toda coluna: tipo, obrigatoriedade, chave, descrição

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
- documento: String — único
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

## E6:
### As seis decisões defendidas da seção 9

### 1: Por que a tabela de telefone existe em vez de três colunas no cliente.
### De acordo com a normalização 1FN não pode ter varias colunas contendo os mesmos dados por isso criei a tabela telefone que ai vo armazenando os telefones do cliente

### 2: Por que o preço fica repetido dentro do item da OS, se ele já está no catálogo. Isso não fere a normalização?
### Porque tenho que ter armazenado o valor especificamente de quando teve aquela saida. Caso nao tivesse o valor seria sobreescrevido quando alternasse o valor por unidade na data atual

### 3: Como você resolveu o nó entre unidade e colaborador (RN31), e por que escolheu esse lado pra quebrar.
### Deixando o Gerente como NULL assim podendo ter uma Unidade mesmo nao tendo ja um Supervisor certo

### 4: Por que cada regra de exclusão da seção 5.3 é a que você escolheu. Cite pelo menos um caso de cada: apagar em cascata, barrar a exclusão e anular a referência.

### Em oficina na relaçao com colaborador coloquei SET NULL porque o colaborador pode ficar sem uma oficina e nao sao dependentes
### em Cliente coloquei a relaçao com o endereço como CASCADE para apagar o endereço tambem caso apague o Cliente
### Na Ordem_Servico coloquei RESTRICT em Colaborador, Veiculo e na Unidade_Oficina porque não pode apagar um serviço que ja tenha aparecido em uma OS

### 5: Estoque atual: guardado ou calculado? Defenda a sua, sabendo que a outra também tem defesa.
### No banco deixei como guardado porque eu vou calcular na API

### 6: Quais regras da seção 5 o banco não consegue garantir sozinho, e por quê. Essa é a pergunta que separa quem entendeu constraint de quem decorou sintaxe.
### RN23	OS "entregue" ou "cancelada" não aceita item novo.  "Acredito que esse tipo de verificação só se faz no front ai faço um if()"
### RN28	A nota da avaliação fica entre 0 e 10. "Outra validação da API"
### RN29	O ano de fabricação do veículo fica entre 1900 e o ano que vem. "Outra validação da API"



