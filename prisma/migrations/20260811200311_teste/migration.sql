/*
  Warnings:

  - You are about to drop the column `documento` on the `cliente` table. All the data in the column will be lost.
  - Added the required column `pessoa_FisicaId` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pessoa_JuridicaId` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pessoa_fisica_id` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pessoa_juridica_id` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `catalogoId` to the `Ordem_Servico` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `ordem_servico` DROP FOREIGN KEY `Ordem_Servico_servicoId_fkey`;

-- DropIndex
DROP INDEX `Cliente_documento_key` ON `cliente`;

-- DropIndex
DROP INDEX `Ordem_Servico_servicoId_fkey` ON `ordem_servico`;

-- AlterTable
ALTER TABLE `cliente` DROP COLUMN `documento`,
    ADD COLUMN `pessoa_FisicaId` INTEGER NOT NULL,
    ADD COLUMN `pessoa_JuridicaId` INTEGER NOT NULL,
    ADD COLUMN `pessoa_fisica_id` INTEGER NOT NULL,
    ADD COLUMN `pessoa_juridica_id` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `ordem_servico` ADD COLUMN `catalogoId` INTEGER NOT NULL,
    MODIFY `servicoId` INTEGER NULL;

-- CreateTable
CREATE TABLE `Catalogo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `servicoId` INTEGER NOT NULL,
    `pecasId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Cliente` ADD CONSTRAINT `Cliente_pessoa_JuridicaId_fkey` FOREIGN KEY (`pessoa_JuridicaId`) REFERENCES `Pessoa_Juridica`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cliente` ADD CONSTRAINT `Cliente_pessoa_FisicaId_fkey` FOREIGN KEY (`pessoa_FisicaId`) REFERENCES `Pessoa_Fisica`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_catalogoId_fkey` FOREIGN KEY (`catalogoId`) REFERENCES `Catalogo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ordem_Servico` ADD CONSTRAINT `Ordem_Servico_servicoId_fkey` FOREIGN KEY (`servicoId`) REFERENCES `Servico`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Catalogo` ADD CONSTRAINT `Catalogo_servicoId_fkey` FOREIGN KEY (`servicoId`) REFERENCES `Servico`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Catalogo` ADD CONSTRAINT `Catalogo_pecasId_fkey` FOREIGN KEY (`pecasId`) REFERENCES `Pecas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
