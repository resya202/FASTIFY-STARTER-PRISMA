/*
  Warnings:

  - You are about to drop the `Cart` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CartItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Chat` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Discount` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MemberDetail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Message` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PaymentSource` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Product` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProductProcess` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProductReview` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Seller` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserPaymentAccount` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_DiscountToProduct` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "shippingStatus" AS ENUM ('UNPAID', 'NEED_TO_BE_SENT', 'SENDING', 'RECEIVED', 'INSTALLMENT', 'CANCELLED');

-- CreateEnum
CREATE TYPE "HistoryType" AS ENUM ('REQUEST', 'CALLBACK');

-- CreateEnum
CREATE TYPE "PaymentGateway" AS ENUM ('MIDTRANS', 'SPRINT');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'PAID', 'CANCEL', 'REFUND');

-- CreateEnum
CREATE TYPE "WalletType" AS ENUM ('POINT', 'FUNDS');

-- CreateEnum
CREATE TYPE "WalletTransType" AS ENUM ('INFLOW', 'OUTFLOW');

-- CreateEnum
CREATE TYPE "WalletTransName" AS ENUM ('EARNING', 'REDEEM', 'REFUND', 'COMMISSION');

-- DropForeignKey
ALTER TABLE "Cart" DROP CONSTRAINT "Cart_userId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_cartId_fkey";

-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_sellerId_fkey";

-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_userId_fkey";

-- DropForeignKey
ALTER TABLE "MemberDetail" DROP CONSTRAINT "MemberDetail_userId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_chatId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_sellerId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_userId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_sellerId_fkey";

-- DropForeignKey
ALTER TABLE "ProductReview" DROP CONSTRAINT "ProductReview_productId_fkey";

-- DropForeignKey
ALTER TABLE "ProductReview" DROP CONSTRAINT "ProductReview_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserPaymentAccount" DROP CONSTRAINT "UserPaymentAccount_paymentSourceId_fkey";

-- DropForeignKey
ALTER TABLE "UserPaymentAccount" DROP CONSTRAINT "UserPaymentAccount_userId_fkey";

-- DropForeignKey
ALTER TABLE "_DiscountToProduct" DROP CONSTRAINT "_DiscountToProduct_A_fkey";

-- DropForeignKey
ALTER TABLE "_DiscountToProduct" DROP CONSTRAINT "_DiscountToProduct_B_fkey";

-- DropTable
DROP TABLE "Cart";

-- DropTable
DROP TABLE "CartItem";

-- DropTable
DROP TABLE "Category";

-- DropTable
DROP TABLE "Chat";

-- DropTable
DROP TABLE "Discount";

-- DropTable
DROP TABLE "MemberDetail";

-- DropTable
DROP TABLE "Message";

-- DropTable
DROP TABLE "Notification";

-- DropTable
DROP TABLE "PaymentSource";

-- DropTable
DROP TABLE "Product";

-- DropTable
DROP TABLE "ProductProcess";

-- DropTable
DROP TABLE "ProductReview";

-- DropTable
DROP TABLE "Seller";

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "UserPaymentAccount";

-- DropTable
DROP TABLE "_DiscountToProduct";

-- DropEnum
DROP TYPE "Gender";

-- DropEnum
DROP TYPE "Religion";

-- DropEnum
DROP TYPE "paymentType";

-- CreateTable
CREATE TABLE "mst_new_order" (
    "mno_id" SERIAL NOT NULL,
    "mno_uuid" TEXT NOT NULL,
    "mno_user_uuid" TEXT NOT NULL,
    "mno_created_date" TIMESTAMP(3) NOT NULL,
    "mno_created_by" TEXT NOT NULL,
    "mno_updated_date" TIMESTAMP(3),
    "mno_updated_by" TEXT,
    "mno_invoice_id" TEXT,
    "mno_send_address" TEXT,
    "mno_received_address" TEXT,
    "mno_product_list_uuid" JSONB,
    "mno_shipper_id" TEXT,
    "mno_shipper_name" TEXT,
    "mno_payment_source_uuid" TEXT,
    "mno_payment_type" TEXT,
    "mno_payment_prove_url" TEXT,
    "mno_approved_by" TEXT,
    "mno_remark" TEXT,

    CONSTRAINT "mst_new_order_pkey" PRIMARY KEY ("mno_id")
);

-- CreateTable
CREATE TABLE "mst_order" (
    "mo_id" SERIAL NOT NULL,
    "mo_uuid" TEXT NOT NULL,
    "mo_user_uuid" TEXT NOT NULL,
    "mo_created_date" TIMESTAMP(3) NOT NULL,
    "mo_created_by" TEXT NOT NULL,
    "mo_updated_date" TIMESTAMP(3),
    "mo_updated_by" TEXT,
    "mo_invoice_id" TEXT,
    "mo_send_address" TEXT,
    "mo_received_address" TEXT,
    "mo_product_list_uuid" JSONB,
    "mo_shipper_id" TEXT,
    "mo_shipper_name" TEXT,
    "mo_shipping_number" TEXT,
    "mo_receipt_number" TEXT,
    "mo_status" "shippingStatus" NOT NULL DEFAULT 'NEED_TO_BE_SENT',
    "mo_is_cancelled" BOOLEAN NOT NULL DEFAULT false,
    "mo_cancelled_reason" TEXT,
    "mo_cancelled_action" TEXT,
    "mo_payment_source_uuid" TEXT,
    "mo_payment_type" TEXT,
    "mo_payment_prove_url" TEXT,
    "mo_approved_by" TEXT,
    "mo_remark" TEXT,

    CONSTRAINT "mst_order_pkey" PRIMARY KEY ("mo_id")
);

-- CreateTable
CREATE TABLE "mst_midtrans_transaction_log" (
    "mmtl_id" SERIAL NOT NULL,
    "mmtl_uuid" TEXT NOT NULL,
    "mmtl_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mmtl_user_uuid" TEXT NOT NULL,
    "mmtl_product_uuid" TEXT NOT NULL,
    "mmtl_product_name" TEXT NOT NULL,
    "mmtl_order_uuid" TEXT NOT NULL,
    "mmtl_status" "PaymentStatus" NOT NULL DEFAULT 'PENDING',

    CONSTRAINT "mst_midtrans_transaction_log_pkey" PRIMARY KEY ("mmtl_id")
);

-- CreateTable
CREATE TABLE "mst_sprint_transaction_log" (
    "mstl_id" SERIAL NOT NULL,
    "mstl_uuid" TEXT NOT NULL,
    "mstl_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mstl_user_uuid" TEXT NOT NULL,
    "mstl_product_uuid" TEXT NOT NULL,
    "mstl_product_name" TEXT NOT NULL,
    "mstl_order_uuid" TEXT NOT NULL,
    "mstl_status" "PaymentStatus" NOT NULL DEFAULT 'PENDING',

    CONSTRAINT "mst_sprint_transaction_log_pkey" PRIMARY KEY ("mstl_id")
);

-- CreateTable
CREATE TABLE "mst_payment_history" (
    "mph_id" SERIAL NOT NULL,
    "mph_uuid" TEXT NOT NULL,
    "mph_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mph_payment_gateway" "PaymentGateway" NOT NULL,
    "mph_payment_uuid" TEXT NOT NULL,
    "mph_history_type" "HistoryType" NOT NULL DEFAULT 'REQUEST',
    "mph_request_json" JSONB,
    "mph_response_json" JSONB,

    CONSTRAINT "mst_payment_history_pkey" PRIMARY KEY ("mph_id")
);

-- CreateTable
CREATE TABLE "mst_user_wallet" (
    "muw_id" SERIAL NOT NULL,
    "muw_uuid" TEXT NOT NULL,
    "muw_user_uuid" TEXT NOT NULL,
    "muw_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "muw_updated_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "muw_created_by" TEXT NOT NULL,
    "muw_updated_by" TEXT,
    "muw_user_name" TEXT NOT NULL,
    "muw_wallet_type" "WalletType" NOT NULL,
    "muw_latest_remark" TEXT,
    "muw_balance" DOUBLE PRECISION NOT NULL DEFAULT 0,

    CONSTRAINT "mst_user_wallet_pkey" PRIMARY KEY ("muw_id")
);

-- CreateTable
CREATE TABLE "mst_funds_wallet_log" (
    "mfwl_id" SERIAL NOT NULL,
    "mfwl_uuid" TEXT NOT NULL,
    "mfwl_wallet_uuid" TEXT NOT NULL,
    "mfwl_trans_type" "WalletTransType" NOT NULL,
    "mfwl_trans_name" "WalletTransName" NOT NULL,
    "mfwl_balance_before" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mfwl_balance_after" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mfwl_payment_source_id" TEXT,
    "mfwl_payment_source_name" TEXT,
    "mfwl_order_id" TEXT,
    "mfwl_approved_by" TEXT,
    "mfwl_remark" TEXT,

    CONSTRAINT "mst_funds_wallet_log_pkey" PRIMARY KEY ("mfwl_id")
);

-- CreateTable
CREATE TABLE "mst_points_wallet_log" (
    "mpwl_id" SERIAL NOT NULL,
    "mpwl_uuid" TEXT NOT NULL,
    "mpwl_wallet_uuid" TEXT NOT NULL,
    "mpwl_trans_type" "WalletTransType" NOT NULL,
    "mpwl_trans_name" "WalletTransName" NOT NULL,
    "mpwl_balance_before" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mpwl_balance_after" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mpwl_payment_source_id" TEXT,
    "mpwl_payment_source_name" TEXT,
    "mpwl_order_id" TEXT,
    "mpwl_approved_by" TEXT,
    "mpwl_remark" TEXT,

    CONSTRAINT "mst_points_wallet_log_pkey" PRIMARY KEY ("mpwl_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "mst_new_order_mno_uuid_key" ON "mst_new_order"("mno_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_order_mo_uuid_key" ON "mst_order"("mo_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_midtrans_transaction_log_mmtl_uuid_key" ON "mst_midtrans_transaction_log"("mmtl_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_sprint_transaction_log_mstl_uuid_key" ON "mst_sprint_transaction_log"("mstl_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_payment_history_mph_uuid_key" ON "mst_payment_history"("mph_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_wallet_muw_uuid_key" ON "mst_user_wallet"("muw_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_funds_wallet_log_mfwl_uuid_key" ON "mst_funds_wallet_log"("mfwl_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_points_wallet_log_mpwl_uuid_key" ON "mst_points_wallet_log"("mpwl_uuid");

-- AddForeignKey
ALTER TABLE "mst_funds_wallet_log" ADD CONSTRAINT "mst_funds_wallet_log_mfwl_wallet_uuid_fkey" FOREIGN KEY ("mfwl_wallet_uuid") REFERENCES "mst_user_wallet"("muw_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_points_wallet_log" ADD CONSTRAINT "mst_points_wallet_log_mpwl_wallet_uuid_fkey" FOREIGN KEY ("mpwl_wallet_uuid") REFERENCES "mst_user_wallet"("muw_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
