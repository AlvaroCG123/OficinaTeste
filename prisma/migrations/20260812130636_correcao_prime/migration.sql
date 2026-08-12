/*
  Warnings:

  - You are about to drop the column `data_criacao` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `nome_completo` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `pessoa_FisicaId` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `pessoa_JuridicaId` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `pessoa_fisica_id` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `pessoa_juridica_id` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `telefoneId` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `veiculoId` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `data_entrada` on the `colaborador` table. All the data in the column will be lost.
  - You are about to alter the column `status` on the `colaborador` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(5))` to `TinyInt`.
  - You are about to drop the column `razao_social` on the `fornecedor` table. All the data in the column will be lost.
  - You are about to drop the column `catalogoId` on the `ordem_servico` table. All the data in the column will be lost.
  - You are about to drop the column `colaboradorId` on the `ordem_servico` table. All the data in the column will be lost.
  - You are about to drop the column `pagamentoId` on the `ordem_servico` table. All the data in the column will be lost.
  - You are about to drop the column `servicoId` on the `ordem_servico` table. All the data in the column will be lost.
  - You are about to drop the column `unidade_OficinaId` on the `ordem_servico` table. All the data in the column will be lost.
  - You are about to drop the column `colaboradorId` on the `pagamento` table. All the data in the column will be lost.
  - You are about to drop the column `desconto` on the `pagamento` table. All the data in the column will be lost.
  - You are about to drop the column `forma_pagamento` on the `pagamento` table. All the data in the column will be lost.
  - You are about to drop the column `quem_recebe_id` on the `pagamento` table. All the data in the column will be lost.
  - You are about to drop the column `cod_servico` on the `servico` table. All the data in the column will be lost.
  - You are about to drop the column `preco` on the `servico` table. All the data in the column will be lost.
  - You are about to drop the column `tempo_estimado` on the `servico` table. All the data in the column will be lost.
  - You are about to alter the column `status` on the `servico` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(3))` to `TinyInt`.
  - You are about to drop the column `numero_telefone` on the `telefone` table. All the data in the column will be lost.
  - You are about to drop the column `texto` on the `telefone` table. All the data in the column will be lost.
  - You are about to drop the column `colaboradorId` on the `unidade_oficina` table. All the data in the column will be lost.
  - You are about to alter the column `status` on the `unidade_oficina` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(1))` to `TinyInt`.
  - You are about to drop the column `ano_criacao` on the `veiculo` table. All the data in the column will be lost.
  - The values [DIESELS500,DIESELS10,ALCOOL] on the enum `Veiculo_combustivel` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `catalogo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pecas` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pessoa_fisica` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pessoa_juridica` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[documento]` on the table `Cliente` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[numero_os]` on the table `Ordem_Servico` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[codigo]` on the table `Servico` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[numero]` on the table `Telefone` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[clienteId]` on the table `Telefone` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[gerenteId]` on the table `Unidade_Oficina` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `documento` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipoPessoa` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unidadeId` to the `Colaborador` table without a default value. This is not possible if the table is not empty.
  - Added the required column `razaoSocial` to the `Fornecedor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `KmEntrada` to the `Ordem_Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `atendenteId` to the `Ordem_Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unidadeId` to the `Ordem_Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `forma` to the `Pagamento` table without a default value. This is not possible if the table is not empty.
  - Added the required column `osId` to the `Pagamento` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quemRecebeId` to the `Pagamento` table without a default value. This is not possible if the table is not empty.
  - Made the column `num_parcelas` on table `pagamento` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `categoriaId` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codigo` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `precoTabela` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tempoEstimado` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clienteId` to the `Telefone` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numero` to the `Telefone` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `Unidade_Oficina` table without a default value. This is not possible if the table is not empty.
  - Added the required column `anoFabricacao` to the `Veiculo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clienteId` to the `Veiculo` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `catalogo` DROP FOREIGN KEY `Catalogo_pecasId_fkey`;

-- DropForeignKey
ALTER TABLE `catalogo` DROP FOREIGN KEY `Catalogo_servicoId_fkey`;

-- DropForeignKey
ALTER TABLE `cliente` DROP FOREIGN KEY `Cliente_pessoa_FisicaId_fkey`;

-- DropForeignKey
ALTER TABLE `cliente` DROP FOREIGN KEY `Cliente_pessoa_JuridicaId_fkey`;

-- DropForeignKey
ALTER TABLE `cliente` DROP FOREIGN KEY `Cliente_telefoneId_fkey`;

-- DropForeignKey
ALTER TABLE `cliente` DROP FOREIGN KEY `Cliente_veiculoId_fkey`;

-- DropForeignKey
ALTER TABLE `ordem_servico` DROP FOREIGN KEY `Ordem_Servico_catalogoId_fkey`;

-- DropForeignKey
ALTER TABLE `ordem_servico` DROP FOREIGN KEY `Ordem_Servico_colaboradorId_fkey`;

-- DropForeignKey
ALTER TABLE `ordem_servico` DROP FOREIGN KEY `Ordem_Servico_pagamentoId_fkey`;

-- DropForeignKey
ALTER TABLE `ordem_servico` DROP FOREIGN KEY `Ordem_Servico_servicoId_fkey`;

-- DropForeignKey
ALTER TABLE `ordem_servico` DROP FOREIGN KEY `Ordem_Servico_unidade_OficinaId_fkey`;

-- DropForeignKey
ALTER TABLE `pagamento` DROP FOREIGN KEY `Pagamento_colaboradorId_fkey`;

-- DropForeignKey
ALTER TABLE `pecas` DROP FOREIGN KEY `Pecas_fornecedorId_fkey`;

-- DropForeignKey
ALTER TABLE `unidade_oficina` DROP FOREIGN KEY `Unidade_Oficina_colaboradorId_fkey`;

-- DropIndex
DROP INDEX `Cliente_email_key` ON `cliente`;

-- DropIndex
DROP INDEX `Cliente_pessoa_FisicaId_fkey` ON `cliente`;

-- DropIndex
DROP INDEX `Cliente_pessoa_JuridicaId_fkey` ON `cliente`;

-- DropIndex
DROP INDEX `Cliente_telefoneId_fkey` ON `cliente`;

-- DropIndex
DROP INDEX `Cliente_veiculoId_fkey` ON `cliente`;

-- DropIndex
DROP INDEX `Ordem_Servico_catalogoId_fkey` ON `ordem_servico`;

-- DropIndex
DROP INDEX `Ordem_Servico_colaboradorId_fkey` ON `ordem_servico`;

-- DropIndex
DROP INDEX `Ordem_Servico_pagamentoId_fkey` ON `ordem_servico`;

-- DropIndex
DROP INDEX `Ordem_Servico_servicoId_fkey` ON `ordem_servico`;

-- DropIndex
DROP INDEX `Ordem_Servico_unidade_OficinaId_fkey` ON `ordem_servico`;

-- DropIndex
DROP INDEX `Pagamento_colaboradorId_fkey` ON `pagamento`;

-- DropIndex
DROP INDEX `Servico_cod_servico_key` ON `servico`;

-- DropIndex
DROP INDEX `Unidade_Oficina_colaboradorId_fkey` ON `unidade_oficina`;

-- AlterTable
ALTER TABLE `cliente` DROP COLUMN `data_criacao`,
    DROP COLUMN `nome_completo`,
    DROP COLUMN `pessoa_FisicaId`,
    DROP COLUMN `pessoa_JuridicaId`,
    DROP COLUMN `pessoa_fisica_id`,
    DROP COLUMN `pessoa_juridica_id`,
    DROP COLUMN `telefoneId`,
    DROP COLUMN `veiculoId`,
    ADD COLUMN `dataNascimento` DATETIME(3) NULL,
    ADD COLUMN `documento` VARCHAR(191) NOT NULL,
    ADD COLUMN `nome` VARCHAR(191) NOT NULL,
    ADD COLUMN `tipoPessoa` ENUM('FISICA', 'JURIDICA') NOT NULL,
    MODIFY `email` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `colaborador` DROP COLUMN `data_entrada`,
    ADD COLUMN `dataAdmissao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `supervisorId` INTEGER NULL,
    ADD COLUMN `unidadeId` INTEGER NOT NULL,
    MODIFY `status` BOOLEAN NOT NULL DEFAULT true;

-- AlterTable
ALTER TABLE `fornecedor` DROP COLUMN `razao_social`,
    ADD COLUMN `razaoSocial` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `ordem_servico` DROP COLUMN `catalogoId`,
    DROP COLUMN `colaboradorId`,
    DROP COLUMN `pagamentoId`,
    DROP COLUMN `servicoId`,
    DROP COLUMN `unidade_OficinaId`,
    ADD COLUMN `KmEntrada` INTEGER NOT NULL,
    ADD COLUMN `atendenteId` INTEGER NOT NULL,
    ADD COLUMN `desconto` DECIMAL(10, 2) NOT NULL DEFAULT 0,
    ADD COLUMN `mecanincoId` INTEGER NULL,
    ADD COLUMN `unidadeId` INTEGER NOT NULL,
    MODIFY `observacao` TEXT NULL;

-- AlterTable
ALTER TABLE `pagamento` DROP COLUMN `colaboradorId`,
    DROP COLUMN `desconto`,
    DROP COLUMN `forma_pagamento`,
    DROP COLUMN `quem_recebe_id`,
    ADD COLUMN `forma` ENUM('DINHEIRO', 'PIX', 'DEBIDO', 'CREDITO', 'BOLETO') NOT NULL,
    ADD COLUMN `osId` INTEGER NOT NULL,
    ADD COLUMN `quemRecebeId` INTEGER NOT NULL,
    MODIFY `num_parcelas` INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE `servico` DROP COLUMN `cod_servico`,
    DROP COLUMN `preco`,
    DROP COLUMN `tempo_estimado`,
    ADD COLUMN `categoriaId` INTEGER NOT NULL,
    ADD COLUMN `codigo` VARCHAR(191) NOT NULL,
    ADD COLUMN `precoTabela` DECIMAL(10, 2) NOT NULL,
    ADD COLUMN `tempoEstimado` INTEGER NOT NULL,
    MODIFY `descricao` TEXT NOT NULL,
    MODIFY `status` BOOLEAN NOT NULL DEFAULT true;

-- AlterTable
ALTER TABLE `telefone` DROP COLUMN `numero_telefone`,
    DROP COLUMN `texto`,
    ADD COLUMN `clienteId` INTEGER NOT NULL,
    ADD COLUMN `numero` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `unidade_oficina` DROP COLUMN `colaboradorId`,
    ADD COLUMN `gerenteId` INTEGER NULL,
    ADD COLUMN `nome` VARCHAR(191) NOT NULL,
    MODIFY `status` BOOLEAN NOT NULL DEFAULT true;

-- AlterTable
ALTER TABLE `veiculo` DROP COLUMN `ano_criacao`,
    ADD COLUMN `anoFabricacao` INTEGER NOT NULL,
    ADD COLUMN `clienteId` INTEGER NOT NULL,
    MODIFY `combustivel` ENUM('COMBUSTIVEL', 'DIESEL', 'ETANOL', 'FLEX', 'GNV', 'ELETRICO', 'HIBRIDO') NOT NULL;

-- DropTable
DROP TABLE `catalogo`;

-- DropTable
DROP TABLE `pecas`;

-- DropTable
DROP TABLE `pessoa_fisica`;

-- DropTable
DROP TABLE `pessoa_juridica`;

-- CreateTable
CREATE TABLE `Categoria` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `paiId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Peca` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `codigo` VARCHAR(191) NOT NULL,
    `nome` VARCHAR(191) NOT NULL,
    `precoCusto` DECIMAL(10, 2) NOT NULL,
    `precoVenda` DECIMAL(10, 2) NOT NULL,
    `estoqueMinimo` INTEGER NOT NULL,
    `estoqueAtual` INTEGER NOT NULL DEFAULT 0,
    `fornecedorId` INTEGER NULL,

    UNIQUE INDEX `Peca_codigo_key`(`codigo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ItemOSServico` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `quantidade` INTEGER NOT NULL,
    `precoCobrado` DECIMAL(10, 2) NOT NULL,
    `osId` INTEGER NOT NULL,
    `servicoId` INTEGER NOT NULL,
    `mecanicaId` INTEGER NOT NULL,

    UNIQUE INDEX `ItemOSServico_osId_key`(`osId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ItemOSPeca` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `quantidade` INTEGER NOT NULL,
    `precoCobrado` DECIMAL(10, 2) NOT NULL,
    `osId` INTEGER NOT NULL,
    `pecaId` INTEGER NOT NULL,

    UNIQUE INDEX `ItemOSPeca_osId_key`(`osId`),
    UNIQUE INDEX `ItemOSPeca_pecaId_key`(`pecaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MovimentacaoEstoque` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tipo` ENUM('ENTRADA', 'SAIDA') NOT NULL,
    `quantidade` INTEGER NOT NULL,
    `motivo` VARCHAR(191) NOT NULL,
    `dataHora` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `pecaId` INTEGER NOT NULL,
    `responsavelId` INTEGER NOT NULL,
    `odId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Cliente_documento_key` ON `Cliente`(`documento`);

-- CreateIndex
CREATE UNIQUE INDEX `Ordem_Servico_numero_os_key` ON `Ordem_Servico`(`numero_os`);

-- CreateIndex
CREATE UNIQUE INDEX `Servico_codigo_key` ON `Servico`(`codigo`);

-- CreateIndex
CREATE UNIQUE INDEX `Telefone_numero_key` ON `Telefone`(`numero`);

-- CreateIndex
CREATE UNIQUE INDEX `Telefone_clienteId_key` ON `Telefone`(`clienteId`);

-- CreateIndex
CREATE UNIQUE INDEX `Unidade_Oficina_gerenteId_key` ON `Unidade_Oficina`(`gerenteId`);

-- AddForeignKey
ALTER TABLE `Unidade_Oficina` ADD CONSTRAINT `Unidade_Oficina_gerenteId_fkey` FOREIGN KEY (`gerenteId`) REFERENCES `Colaborador`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Colaborador` ADD CONSTRAINT `Colaborador_unidadeId_fkey` FOREIGN KEY (`unidadeId`) REFERENCES `Unidade_Oficina`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Colaborador` ADD CONSTRAINT `Colaborador_supervisorId_fkey` FOREIGN KEY (`supervisorId`) REFERENCES `Colaborador`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Telefone` ADD CONSTRAINT `Telefone_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Veiculo` ADD CONSTRAINT `Veiculo_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Categoria` ADD CONSTRAINT `Categoria_paiId_fkey` FOREIGN KEY (`paiId`) REFERENCES `Categoria`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Servico` ADD CONSTRAINT `Servico_categoriaId_fkey` FOREIGN KEY (`categoriaId`) REFERENCES `Categoria`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Peca` ADD CONSTRAINT `Peca_fornecedorId_fkey` FOREIGN KEY (`fornecedorId`) REFERENCES `Fornecedor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_unidadeId_fkey` FOREIGN KEY (`unidadeId`) REFERENCES `Unidade_Oficina`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_atendenteId_fkey` FOREIGN KEY (`atendenteId`) REFERENCES `Colaborador`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_mecanincoId_fkey` FOREIGN KEY (`mecanincoId`) REFERENCES `Colaborador`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemOSServico` ADD CONSTRAINT `ItemOSServico_osId_fkey` FOREIGN KEY (`osId`) REFERENCES `Ordem_Servico`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemOSServico` ADD CONSTRAINT `ItemOSServico_servicoId_fkey` FOREIGN KEY (`servicoId`) REFERENCES `Servico`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemOSServico` ADD CONSTRAINT `ItemOSServico_mecanicaId_fkey` FOREIGN KEY (`mecanicaId`) REFERENCES `Colaborador`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemOSPeca` ADD CONSTRAINT `ItemOSPeca_osId_fkey` FOREIGN KEY (`osId`) REFERENCES `Ordem_Servico`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ItemOSPeca` ADD CONSTRAINT `ItemOSPeca_pecaId_fkey` FOREIGN KEY (`pecaId`) REFERENCES `Peca`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pagamento` ADD CONSTRAINT `Pagamento_osId_fkey` FOREIGN KEY (`osId`) REFERENCES `Ordem_Servico`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pagamento` ADD CONSTRAINT `Pagamento_quemRecebeId_fkey` FOREIGN KEY (`quemRecebeId`) REFERENCES `Colaborador`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MovimentacaoEstoque` ADD CONSTRAINT `MovimentacaoEstoque_pecaId_fkey` FOREIGN KEY (`pecaId`) REFERENCES `Peca`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MovimentacaoEstoque` ADD CONSTRAINT `MovimentacaoEstoque_responsavelId_fkey` FOREIGN KEY (`responsavelId`) REFERENCES `Colaborador`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MovimentacaoEstoque` ADD CONSTRAINT `MovimentacaoEstoque_odId_fkey` FOREIGN KEY (`odId`) REFERENCES `Ordem_Servico`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
