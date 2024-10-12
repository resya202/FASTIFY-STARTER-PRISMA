/*
  Warnings:

  - Made the column `mu_password` on table `mst_user` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "mst_user" ALTER COLUMN "mu_password" SET NOT NULL,
ALTER COLUMN "mu_referral_code" DROP NOT NULL;
