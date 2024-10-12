/*
  Warnings:

  - You are about to drop the column `passwordHash` on the `MemberDetail` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "MemberDetail" DROP COLUMN "passwordHash",
ALTER COLUMN "NIK" DROP NOT NULL,
ALTER COLUMN "gender" DROP NOT NULL,
ALTER COLUMN "birthPlace" DROP NOT NULL,
ALTER COLUMN "birthDate" DROP NOT NULL,
ALTER COLUMN "religion" DROP NOT NULL,
ALTER COLUMN "postalCode" DROP NOT NULL,
ALTER COLUMN "occupation" DROP NOT NULL,
ALTER COLUMN "whatsAppNumber" DROP NOT NULL;
