/*
  Warnings:

  - You are about to drop the `mst_funds_wallet_log` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_midtrans_transaction_log` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_new_order` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_order` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_payment_history` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_points_wallet_log` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_sprint_transaction_log` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mst_user_wallet` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('USER', 'MEMBER', 'RESELLER');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHERS');

-- CreateEnum
CREATE TYPE "MembershipLevel" AS ENUM ('SILVER', 'GOLD', 'PLATINUM');

-- CreateEnum
CREATE TYPE "Religion" AS ENUM ('ISLAM', 'CATHOLIC', 'PROTESTANT', 'BUDDHIST', 'HINDU', 'CONFUCIANISM');

-- CreateEnum
CREATE TYPE "StoreType" AS ENUM ('DC', 'STORE');

-- CreateEnum
CREATE TYPE "CouponVoucherType" AS ENUM ('FREE', 'PAID');

-- CreateEnum
CREATE TYPE "statusType" AS ENUM ('ACTIVE', 'NOT_ACTIVE');

-- CreateEnum
CREATE TYPE "ShowingType" AS ENUM ('SHOWN', 'NOT_SHOWN');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('INFO', 'PROMO', 'DISKON', 'FLASH');

-- CreateEnum
CREATE TYPE "NotificationTarget" AS ENUM ('ALL', 'PRODUCT_BOUGHT', 'PRODUCT_NOT_BOUGH', 'PRODUCT_IN_CART', 'CART_NOT_NULL');

-- CreateEnum
CREATE TYPE "PointType" AS ENUM ('REGULAR', 'CASHBACK', 'RESELLER');

-- CreateEnum
CREATE TYPE "TransactionCondition" AS ENUM ('MORE', 'MORE_EQUAL', 'LESS_EQUAL', 'LESS');

-- DropForeignKey
ALTER TABLE "mst_funds_wallet_log" DROP CONSTRAINT "mst_funds_wallet_log_mfwl_wallet_uuid_fkey";

-- DropForeignKey
ALTER TABLE "mst_points_wallet_log" DROP CONSTRAINT "mst_points_wallet_log_mpwl_wallet_uuid_fkey";

-- DropTable
DROP TABLE "mst_funds_wallet_log";

-- DropTable
DROP TABLE "mst_midtrans_transaction_log";

-- DropTable
DROP TABLE "mst_new_order";

-- DropTable
DROP TABLE "mst_order";

-- DropTable
DROP TABLE "mst_payment_history";

-- DropTable
DROP TABLE "mst_points_wallet_log";

-- DropTable
DROP TABLE "mst_sprint_transaction_log";

-- DropTable
DROP TABLE "mst_user_wallet";

-- DropEnum
DROP TYPE "HistoryType";

-- DropEnum
DROP TYPE "PaymentGateway";

-- DropEnum
DROP TYPE "PaymentStatus";

-- DropEnum
DROP TYPE "WalletTransName";

-- DropEnum
DROP TYPE "WalletTransType";

-- DropEnum
DROP TYPE "WalletType";

-- DropEnum
DROP TYPE "shippingStatus";

-- CreateTable
CREATE TABLE "mst_user" (
    "mu_id" SERIAL NOT NULL,
    "mu_user_uuid" TEXT NOT NULL,
    "mu_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mu_updated_date" TIMESTAMP(3) NOT NULL,
    "mu_full_name" TEXT,
    "mu_email" TEXT,
    "mu_phone_number" TEXT,
    "mu_password" TEXT,
    "mu_birth_place" TEXT,
    "mu_birth_date" TIMESTAMP(3),
    "mu_profile_picture" TEXT,
    "mu_gender" "Gender" DEFAULT 'OTHERS',
    "mu_type" "UserType" NOT NULL DEFAULT 'USER',
    "mu_session_auth" TEXT,
    "mu_referral_code" TEXT NOT NULL,
    "mu_referred_by" TEXT,
    "mu_current_location" TEXT,

    CONSTRAINT "mst_user_pkey" PRIMARY KEY ("mu_id")
);

-- CreateTable
CREATE TABLE "mst_membership_info" (
    "mmi_id" SERIAL NOT NULL,
    "mmi_user_uuid" TEXT NOT NULL,
    "mmi_membership_level" "MembershipLevel" NOT NULL DEFAULT 'SILVER',
    "mmi_created_date" TIMESTAMP(3) NOT NULL,
    "mmi_updated_date" TIMESTAMP(3) NOT NULL,
    "mmi_religion" "Religion" NOT NULL,
    "mmi_occupation" TEXT NOT NULL,
    "mmi_nik" TEXT NOT NULL,
    "mmi_main_address" TEXT NOT NULL,
    "mmi_postal_code" VARCHAR(6) NOT NULL,

    CONSTRAINT "mst_membership_info_pkey" PRIMARY KEY ("mmi_id")
);

-- CreateTable
CREATE TABLE "mst_user_address" (
    "mua_id" SERIAL NOT NULL,
    "mua_user_uuid" TEXT NOT NULL,
    "mua_label" TEXT NOT NULL,
    "mua_type" TEXT,
    "mua_status" TEXT NOT NULL,
    "mua_receiver_name" TEXT NOT NULL,
    "mua_receiver_number" TEXT NOT NULL,
    "mua_courier_note" TEXT,
    "mua_complete_address" TEXT NOT NULL,
    "mua_maps_info" JSONB,

    CONSTRAINT "mst_user_address_pkey" PRIMARY KEY ("mua_id")
);

-- CreateTable
CREATE TABLE "mst_reseller_info" (
    "mri_id" SERIAL NOT NULL,
    "mri_user_uuid" TEXT NOT NULL,
    "mri_full_name" TEXT NOT NULL,

    CONSTRAINT "mst_reseller_info_pkey" PRIMARY KEY ("mri_id")
);

-- CreateTable
CREATE TABLE "mst_store_dc" (
    "msd_id" SERIAL NOT NULL,
    "msd_uuid" TEXT NOT NULL,
    "msd_store_name" TEXT NOT NULL,
    "msd_store_description" TEXT,
    "msd_store_map_location" TEXT,
    "msd_place_id" TEXT,
    "msd_type" "StoreType" NOT NULL DEFAULT 'STORE',
    "msd_location" TEXT,
    "msd_operational_hours" TEXT,
    "msd_price_reference" TEXT,
    "msd_regions_uuid" TEXT NOT NULL,

    CONSTRAINT "mst_store_dc_pkey" PRIMARY KEY ("msd_id")
);

-- CreateTable
CREATE TABLE "mst_store_staff" (
    "mss_id" SERIAL NOT NULL,
    "mss_uuid" TEXT NOT NULL,
    "mss_store_uuid" TEXT NOT NULL,
    "mss_staff_name" TEXT NOT NULL,
    "mss_staff_level" TEXT NOT NULL,
    "mss_created_date" TIMESTAMP(3) NOT NULL,
    "mss_updated_date" TIMESTAMP(3),
    "mss_created_by" TEXT NOT NULL,
    "mss_updated_by" TEXT,
    "mss_working_hours" TEXT,
    "mss_start_end_working" TEXT,
    "mss_status" TEXT,
    "mss_address" TEXT,

    CONSTRAINT "mst_store_staff_pkey" PRIMARY KEY ("mss_id")
);

-- CreateTable
CREATE TABLE "mst_store_summary" (
    "mss_id" SERIAL NOT NULL,
    "mss_store_uuid" TEXT NOT NULL,
    "mss_store_name" TEXT NOT NULL,
    "mss_store_location" TEXT NOT NULL,
    "mss_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mss_inflow" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mss_outflow" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mss_product_sold" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "mst_store_summary_pkey" PRIMARY KEY ("mss_id")
);

-- CreateTable
CREATE TABLE "mst_coupon" (
    "mc_id" SERIAL NOT NULL,
    "mc_uuid" TEXT NOT NULL,
    "mc_store_uuid" TEXT NOT NULL,
    "mc_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mc_expired_date" TIMESTAMP(3),
    "mc_updated_date" TIMESTAMP(3),
    "mc_created_by" TEXT NOT NULL,
    "mc_coupon_name" TEXT NOT NULL,
    "mc_coupon_description" TEXT,
    "mc_coupon_discount" TEXT,
    "mc_coupon_discount_price" TEXT,
    "mc_coupon_code" TEXT,
    "mc_coupon_type" "CouponVoucherType" NOT NULL DEFAULT 'FREE',
    "mc_coupon_shipping_id" TEXT,
    "mc_coupon_use_limit" TEXT,
    "mc_coupon_show" "ShowingType" NOT NULL DEFAULT 'SHOWN',
    "mc_coupon_status" "statusType" NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT "mst_coupon_pkey" PRIMARY KEY ("mc_id")
);

-- CreateTable
CREATE TABLE "mst_voucher" (
    "mv_id" SERIAL NOT NULL,
    "mv_uuid" TEXT NOT NULL,
    "mv_created_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mv_expired_date" TIMESTAMP(3),
    "mv_updated_date" TIMESTAMP(3),
    "mv_created_by" TEXT NOT NULL,
    "mv_voucher_name" TEXT NOT NULL,
    "mv_voucher_description" TEXT,
    "mv_voucher_discount" TEXT,
    "mv_voucher_discount_price" TEXT,
    "mv_voucher_code" TEXT NOT NULL,
    "mv_voucher_type" "CouponVoucherType" NOT NULL DEFAULT 'FREE',
    "mv_voucher_shipping_id" TEXT,
    "mv_voucher_use_limit" INTEGER DEFAULT 1,
    "mv_voucher_show" "ShowingType" NOT NULL DEFAULT 'SHOWN',
    "mv_voucher_status" "statusType" NOT NULL DEFAULT 'ACTIVE',
    "mv_used_by" TEXT,
    "mv_used_order_uuid" TEXT,

    CONSTRAINT "mst_voucher_pkey" PRIMARY KEY ("mv_id")
);

-- CreateTable
CREATE TABLE "mst_user_cart" (
    "muc_id" SERIAL NOT NULL,
    "muc_uuid" TEXT NOT NULL,
    "muc_user_uuid" TEXT,
    "muc_status" "statusType" NOT NULL DEFAULT 'NOT_ACTIVE',

    CONSTRAINT "mst_user_cart_pkey" PRIMARY KEY ("muc_id")
);

-- CreateTable
CREATE TABLE "mst_cart_items" (
    "mci_id" SERIAL NOT NULL,
    "mci_cart_uuid" TEXT NOT NULL,
    "mci_product_uuid" TEXT NOT NULL,
    "mci_product_variant_uuid" TEXT,
    "mci_cart_items" INTEGER NOT NULL DEFAULT 0,
    "mci_item_note" TEXT NOT NULL,

    CONSTRAINT "mst_cart_items_pkey" PRIMARY KEY ("mci_id")
);

-- CreateTable
CREATE TABLE "mst_user_wishilist" (
    "muw_id" SERIAL NOT NULL,
    "muw_uuid" TEXT NOT NULL,
    "muw_user_uuid" TEXT,
    "muw_status" "statusType" NOT NULL DEFAULT 'NOT_ACTIVE',

    CONSTRAINT "mst_user_wishilist_pkey" PRIMARY KEY ("muw_id")
);

-- CreateTable
CREATE TABLE "mst_wishlist_items" (
    "mwi_id" SERIAL NOT NULL,
    "mwi_wishlist_uuid" TEXT NOT NULL,
    "mwi_product_uuid" TEXT NOT NULL,
    "mwi_product_variant_uuid" TEXT,
    "mwi_cart_items" INTEGER NOT NULL DEFAULT 0,
    "mwi_item_note" TEXT NOT NULL,

    CONSTRAINT "mst_wishlist_items_pkey" PRIMARY KEY ("mwi_id")
);

-- CreateTable
CREATE TABLE "mst_brands" (
    "mb_id" SERIAL NOT NULL,
    "mb_uuid" TEXT NOT NULL,
    "mb_name" TEXT NOT NULL,

    CONSTRAINT "mst_brands_pkey" PRIMARY KEY ("mb_id")
);

-- CreateTable
CREATE TABLE "mst_product" (
    "mp_id" SERIAL NOT NULL,
    "mp_uuid" TEXT NOT NULL,
    "mp_created_date" TIMESTAMP(3) NOT NULL,
    "mp_created_by" TEXT NOT NULL,
    "mp_updated_date" TIMESTAMP(3),
    "mp_updated_by" TEXT,
    "mp_product_sku" TEXT NOT NULL,
    "mp_product_name" TEXT NOT NULL,
    "mp_product_price" TEXT NOT NULL,
    "mp_product_brand_uuid" TEXT NOT NULL,
    "mp_product_brand" TEXT NOT NULL,
    "mp_product_base_price" DOUBLE PRECISION NOT NULL,
    "mp_product_discount_price" DOUBLE PRECISION NOT NULL,
    "mp_product_store_uuid" TEXT NOT NULL,
    "mp_product_stock" INTEGER NOT NULL,
    "mp_product_point_multiplication" DOUBLE PRECISION NOT NULL DEFAULT 0.25,
    "mp_product_status" TEXT NOT NULL,
    "mp_commision_affiliation_settings" JSONB,
    "mp_product_general_settings_uuid" TEXT,
    "mp_product_variant_uuid" TEXT,
    "mp_total_product_sold" INTEGER NOT NULL,
    "mp_product_is_preorder" BOOLEAN DEFAULT false,
    "mp_product_is_flashsale" BOOLEAN DEFAULT false,
    "mp_product_flashsale_price" DOUBLE PRECISION DEFAULT 0,

    CONSTRAINT "mst_product_pkey" PRIMARY KEY ("mp_id")
);

-- CreateTable
CREATE TABLE "mst_product_general_info" (
    "mpgi_id" SERIAL NOT NULL,
    "mpgi_uuid" TEXT NOT NULL,
    "mpgi_product_uuid" TEXT NOT NULL,
    "mpgi_description" TEXT,
    "mpgi_specification" TEXT,
    "mpgi_more_info" JSONB,

    CONSTRAINT "mst_product_general_info_pkey" PRIMARY KEY ("mpgi_id")
);

-- CreateTable
CREATE TABLE "mst_product_variant_info" (
    "mpvi_id" SERIAL NOT NULL,
    "mpvi_uuid" TEXT NOT NULL,
    "mpvi_product_uuid" TEXT NOT NULL,
    "mpvi_created_date" TIMESTAMP(3) NOT NULL,
    "mpvi_created_by" TEXT NOT NULL,
    "mpvi_updated_date" TIMESTAMP(3),
    "mpvi_updated_by" TEXT,
    "mpvi_variant_name" TEXT NOT NULL,
    "mpvi_variant_stok" INTEGER NOT NULL,
    "mpvi_variant_url" TEXT,
    "mpvi_variant_sold" INTEGER NOT NULL DEFAULT 0,
    "mpvi_is_flashsale" BOOLEAN NOT NULL DEFAULT false,
    "mpvi_flashsale_discount_percentage" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mpvi_flashsale_discount_price" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mpvi_flashsale_limit_stock" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "mst_product_variant_info_pkey" PRIMARY KEY ("mpvi_id")
);

-- CreateTable
CREATE TABLE "mst_product_review" (
    "mpr_id" SERIAL NOT NULL,
    "mpr_uuid" TEXT NOT NULL,
    "mpr_product_uuid" TEXT NOT NULL,
    "mpr_variant_uuid" TEXT,
    "mpr_star_value" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mpr_user_uuid" TEXT NOT NULL,
    "mpr_review_title" TEXT,
    "mpr_review_description" TEXT,
    "mpr_photo_url" JSONB,
    "mpr_video_url" TEXT NOT NULL,
    "mpr_reply_review_uuid" TEXT NOT NULL,
    "mpr_status" "statusType" NOT NULL,
    "mpr_is_reported" BOOLEAN NOT NULL DEFAULT false,
    "mpr_reported_description" TEXT,

    CONSTRAINT "mst_product_review_pkey" PRIMARY KEY ("mpr_id")
);

-- CreateTable
CREATE TABLE "mst_flash_sale_info" (
    "mfsi_id" SERIAL NOT NULL,
    "mfsi_uuid" TEXT NOT NULL,
    "mfsi_created_date" TIMESTAMP(3) NOT NULL,
    "mfsi_created_by" TEXT NOT NULL,
    "mfsi_updated_date" TIMESTAMP(3),
    "mfsi_updated_by" TEXT,
    "mfsi_product_uuid" TEXT NOT NULL,
    "mfsi_product_name" TEXT NOT NULL,
    "mfsi_discount_percentage" TEXT,
    "mfsi_discount_price" TEXT,
    "mfsi_limit_stock" INTEGER NOT NULL DEFAULT 0,
    "mfsi_status" "statusType" NOT NULL,
    "mfsi_description" TEXT,
    "mfsi_store_uuid" TEXT,
    "mfsi_session_uuid" TEXT,
    "mfsi_banner_url" TEXT,

    CONSTRAINT "mst_flash_sale_info_pkey" PRIMARY KEY ("mfsi_id")
);

-- CreateTable
CREATE TABLE "mst_product_preorder" (
    "mpp_id" SERIAL NOT NULL,
    "mpp_uuid" TEXT NOT NULL,
    "mpp_product_uuid" TEXT NOT NULL,
    "mpp_variant_uuid" TEXT,
    "mpp_limit_stock" INTEGER,
    "mpp_estimated_sent_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "mst_product_preorder_pkey" PRIMARY KEY ("mpp_id")
);

-- CreateTable
CREATE TABLE "mst_session" (
    "ms_id" SERIAL NOT NULL,
    "ms_uuid" TEXT NOT NULL,
    "ms_name" TEXT NOT NULL,
    "ms_start_session" TEXT NOT NULL,
    "ms_end_session" TEXT NOT NULL,

    CONSTRAINT "mst_session_pkey" PRIMARY KEY ("ms_id")
);

-- CreateTable
CREATE TABLE "mst_product_main_category" (
    "mpmc_id" SERIAL NOT NULL,
    "mpmc_uuid" TEXT NOT NULL,
    "mpmc_created_date" TIMESTAMP(3) NOT NULL,
    "mpmc_created_by" TEXT NOT NULL,
    "mpmc_updated_date" TIMESTAMP(3),
    "mpmc_updated_by" TEXT,
    "mpmc_name" TEXT NOT NULL,

    CONSTRAINT "mst_product_main_category_pkey" PRIMARY KEY ("mpmc_id")
);

-- CreateTable
CREATE TABLE "mst_product_sub_category" (
    "mpsc_id" SERIAL NOT NULL,
    "mpsc_uuid" TEXT NOT NULL,
    "mpsc_main_uuid" TEXT NOT NULL,
    "mpsc_created_date" TIMESTAMP(3) NOT NULL,
    "mpsc_created_by" TEXT NOT NULL,
    "mpsc_updated_date" TIMESTAMP(3),
    "mpsc_updated_by" TEXT,
    "mpsc_name" TEXT NOT NULL,

    CONSTRAINT "mst_product_sub_category_pkey" PRIMARY KEY ("mpsc_id")
);

-- CreateTable
CREATE TABLE "mst_notification" (
    "mn_id" SERIAL NOT NULL,
    "mn_uuid" TEXT NOT NULL,
    "mn_created_date" TIMESTAMP(3) NOT NULL,
    "mn_created_by" TEXT NOT NULL,
    "mn_updated_date" TIMESTAMP(3),
    "mn_updated_by" TEXT,
    "mn_type" "NotificationType" NOT NULL,
    "mn_title" TEXT NOT NULL,
    "mn_description" TEXT,
    "mn_target" "NotificationTarget" NOT NULL,
    "mn_executed_date" TIMESTAMP(3) NOT NULL,
    "mn_executed_platform" TEXT NOT NULL,
    "mn_user_uuid" TEXT,

    CONSTRAINT "mst_notification_pkey" PRIMARY KEY ("mn_id")
);

-- CreateTable
CREATE TABLE "mst_payment_source" (
    "mps_id" SERIAL NOT NULL,
    "mps_uuid" TEXT NOT NULL,
    "mps_name" TEXT NOT NULL,
    "mps_logo_url" TEXT NOT NULL,
    "mps_thumnail_url" TEXT NOT NULL,

    CONSTRAINT "mst_payment_source_pkey" PRIMARY KEY ("mps_id")
);

-- CreateTable
CREATE TABLE "mst_point_settings" (
    "mps_id" SERIAL NOT NULL,
    "mps_uuid" TEXT NOT NULL,
    "mps_name" TEXT NOT NULL,
    "mps_type" "PointType" NOT NULL,
    "mps_redeem_settings" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mps_discount_settings" DOUBLE PRECISION DEFAULT 0,
    "mps_status" "statusType" NOT NULL,
    "mps_store_id" TEXT,

    CONSTRAINT "mst_point_settings_pkey" PRIMARY KEY ("mps_id")
);

-- CreateTable
CREATE TABLE "mst_shippers" (
    "ms_id" SERIAL NOT NULL,
    "ms_uuid" TEXT NOT NULL,
    "ms_shipper_name" TEXT NOT NULL,
    "ms_shipper_type" TEXT NOT NULL,
    "ms_shipper_provider" TEXT NOT NULL,
    "ms_logo_url" TEXT NOT NULL,

    CONSTRAINT "mst_shippers_pkey" PRIMARY KEY ("ms_id")
);

-- CreateTable
CREATE TABLE "mst_shipping_fee_settings" (
    "msfs_id" SERIAL NOT NULL,
    "msfs_uuid" TEXT NOT NULL,
    "msfs_transaction_type" TEXT NOT NULL DEFAULT 'E-COMMERCE',
    "msfs_nominal_threshold" DOUBLE PRECISION NOT NULL,
    "msfs_regions" JSONB NOT NULL,
    "msfs_shipping_range" INTEGER NOT NULL DEFAULT 0,
    "msfs_shipping_fee_per_km" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "mst_shipping_fee_settings_pkey" PRIMARY KEY ("msfs_id")
);

-- CreateTable
CREATE TABLE "mst_references_regions" (
    "mrr_id" SERIAL NOT NULL,
    "mrr_uuid" TEXT NOT NULL,
    "mrr_region_name" TEXT NOT NULL,

    CONSTRAINT "mst_references_regions_pkey" PRIMARY KEY ("mrr_id")
);

-- CreateTable
CREATE TABLE "mst_list_provinces" (
    "mlp_id" SERIAL NOT NULL,
    "mlp_uuid" TEXT NOT NULL,
    "mlp_name" TEXT NOT NULL,

    CONSTRAINT "mst_list_provinces_pkey" PRIMARY KEY ("mlp_id")
);

-- CreateTable
CREATE TABLE "mst_list_city_regency" (
    "mlcr_id" SERIAL NOT NULL,
    "mlcr_uuid" TEXT NOT NULL,
    "mlcr_name" TEXT NOT NULL,
    "mlcr_provinces_uuid" TEXT NOT NULL,

    CONSTRAINT "mst_list_city_regency_pkey" PRIMARY KEY ("mlcr_id")
);

-- CreateTable
CREATE TABLE "mst_list_district" (
    "mld_id" SERIAL NOT NULL,
    "mld_uuid" TEXT NOT NULL,
    "mld_name" TEXT NOT NULL,
    "mld_city_uuid" TEXT NOT NULL,

    CONSTRAINT "mst_list_district_pkey" PRIMARY KEY ("mld_id")
);

-- CreateTable
CREATE TABLE "mst_list_subdistrict" (
    "mls_id" SERIAL NOT NULL,
    "mls_uuid" TEXT NOT NULL,
    "mls_name" TEXT NOT NULL,
    "mls_district_uuid" TEXT NOT NULL,

    CONSTRAINT "mst_list_subdistrict_pkey" PRIMARY KEY ("mls_id")
);

-- CreateTable
CREATE TABLE "mst_user_cms" (
    "muc_id" SERIAL NOT NULL,
    "muc_uuid" TEXT NOT NULL,
    "muc_username" TEXT NOT NULL,
    "muc_password" TEXT NOT NULL,
    "muc_ip_address" TEXT,
    "muc_device_type" TEXT,
    "muc_role_uuid" TEXT NOT NULL,
    "muc_role_name" TEXT,
    "muc_store_uuid" TEXT,

    CONSTRAINT "mst_user_cms_pkey" PRIMARY KEY ("muc_id")
);

-- CreateTable
CREATE TABLE "mst_role_cms" (
    "mrc_id" SERIAL NOT NULL,
    "mrc_uuid" TEXT NOT NULL,
    "mrc_user_uuid" TEXT NOT NULL,
    "mrc_role_name" TEXT NOT NULL,

    CONSTRAINT "mst_role_cms_pkey" PRIMARY KEY ("mrc_id")
);

-- CreateTable
CREATE TABLE "mst_menu_cms" (
    "mmmc_id" SERIAL NOT NULL,
    "mmmc_uuid" TEXT NOT NULL,
    "mmc_menu_name" TEXT NOT NULL,
    "mmc_parent_menu" TEXT,
    "mmc_menu_depth" VARCHAR(1) NOT NULL,

    CONSTRAINT "mst_menu_cms_pkey" PRIMARY KEY ("mmmc_id")
);

-- CreateTable
CREATE TABLE "mst_role_access_cms" (
    "mrac_id" SERIAL NOT NULL,
    "mrac_uuid" TEXT NOT NULL,
    "mrac_role_uuid" TEXT NOT NULL,
    "mrac_menu_uuid" TEXT NOT NULL,
    "mrc_clearence_level" TEXT NOT NULL,

    CONSTRAINT "mst_role_access_cms_pkey" PRIMARY KEY ("mrac_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_mu_user_uuid_key" ON "mst_user"("mu_user_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_mu_email_key" ON "mst_user"("mu_email");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_mu_phone_number_key" ON "mst_user"("mu_phone_number");

-- CreateIndex
CREATE INDEX "mst_user_mu_email_mu_phone_number_idx" ON "mst_user"("mu_email", "mu_phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "mst_membership_info_mmi_user_uuid_key" ON "mst_membership_info"("mmi_user_uuid");

-- CreateIndex
CREATE INDEX "mst_membership_info_mmi_user_uuid_idx" ON "mst_membership_info"("mmi_user_uuid");

-- CreateIndex
CREATE INDEX "mst_user_address_mua_user_uuid_idx" ON "mst_user_address"("mua_user_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_reseller_info_mri_user_uuid_key" ON "mst_reseller_info"("mri_user_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_store_dc_msd_uuid_key" ON "mst_store_dc"("msd_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_store_staff_mss_uuid_key" ON "mst_store_staff"("mss_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_coupon_mc_uuid_key" ON "mst_coupon"("mc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_voucher_mv_uuid_key" ON "mst_voucher"("mv_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_cart_muc_uuid_key" ON "mst_user_cart"("muc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_cart_muc_user_uuid_key" ON "mst_user_cart"("muc_user_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_wishilist_muw_uuid_key" ON "mst_user_wishilist"("muw_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_wishilist_muw_user_uuid_key" ON "mst_user_wishilist"("muw_user_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_mp_uuid_key" ON "mst_product"("mp_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_mp_product_general_settings_uuid_key" ON "mst_product"("mp_product_general_settings_uuid");

-- CreateIndex
CREATE INDEX "mst_product_mp_product_general_settings_uuid_idx" ON "mst_product"("mp_product_general_settings_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_general_info_mpgi_uuid_key" ON "mst_product_general_info"("mpgi_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_general_info_mpgi_product_uuid_key" ON "mst_product_general_info"("mpgi_product_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_variant_info_mpvi_uuid_key" ON "mst_product_variant_info"("mpvi_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_review_mpr_uuid_key" ON "mst_product_review"("mpr_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_flash_sale_info_mfsi_uuid_key" ON "mst_flash_sale_info"("mfsi_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_preorder_mpp_uuid_key" ON "mst_product_preorder"("mpp_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_session_ms_uuid_key" ON "mst_session"("ms_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_main_category_mpmc_uuid_key" ON "mst_product_main_category"("mpmc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_product_sub_category_mpsc_uuid_key" ON "mst_product_sub_category"("mpsc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_notification_mn_uuid_key" ON "mst_notification"("mn_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_payment_source_mps_uuid_key" ON "mst_payment_source"("mps_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_point_settings_mps_uuid_key" ON "mst_point_settings"("mps_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_shippers_ms_uuid_key" ON "mst_shippers"("ms_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_shipping_fee_settings_msfs_uuid_key" ON "mst_shipping_fee_settings"("msfs_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_references_regions_mrr_uuid_key" ON "mst_references_regions"("mrr_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_list_provinces_mlp_uuid_key" ON "mst_list_provinces"("mlp_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_list_city_regency_mlcr_uuid_key" ON "mst_list_city_regency"("mlcr_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_list_district_mld_uuid_key" ON "mst_list_district"("mld_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_list_subdistrict_mls_uuid_key" ON "mst_list_subdistrict"("mls_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_cms_muc_uuid_key" ON "mst_user_cms"("muc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_user_cms_muc_password_key" ON "mst_user_cms"("muc_password");

-- CreateIndex
CREATE UNIQUE INDEX "mst_role_cms_mrc_uuid_key" ON "mst_role_cms"("mrc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_menu_cms_mmmc_uuid_key" ON "mst_menu_cms"("mmmc_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "mst_role_access_cms_mrac_uuid_key" ON "mst_role_access_cms"("mrac_uuid");

-- AddForeignKey
ALTER TABLE "mst_membership_info" ADD CONSTRAINT "mst_membership_info_mmi_user_uuid_fkey" FOREIGN KEY ("mmi_user_uuid") REFERENCES "mst_user"("mu_user_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_user_address" ADD CONSTRAINT "mst_user_address_mua_user_uuid_fkey" FOREIGN KEY ("mua_user_uuid") REFERENCES "mst_user"("mu_user_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_reseller_info" ADD CONSTRAINT "mst_reseller_info_mri_user_uuid_fkey" FOREIGN KEY ("mri_user_uuid") REFERENCES "mst_user"("mu_user_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_store_dc" ADD CONSTRAINT "mst_store_dc_msd_regions_uuid_fkey" FOREIGN KEY ("msd_regions_uuid") REFERENCES "mst_references_regions"("mrr_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_store_staff" ADD CONSTRAINT "mst_store_staff_mss_store_uuid_fkey" FOREIGN KEY ("mss_store_uuid") REFERENCES "mst_store_dc"("msd_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_store_summary" ADD CONSTRAINT "mst_store_summary_mss_store_uuid_fkey" FOREIGN KEY ("mss_store_uuid") REFERENCES "mst_store_dc"("msd_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_coupon" ADD CONSTRAINT "mst_coupon_mc_store_uuid_fkey" FOREIGN KEY ("mc_store_uuid") REFERENCES "mst_store_dc"("msd_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_cart_items" ADD CONSTRAINT "mst_cart_items_mci_cart_uuid_fkey" FOREIGN KEY ("mci_cart_uuid") REFERENCES "mst_user_cart"("muc_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_wishlist_items" ADD CONSTRAINT "mst_wishlist_items_mwi_wishlist_uuid_fkey" FOREIGN KEY ("mwi_wishlist_uuid") REFERENCES "mst_user_wishilist"("muw_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_product" ADD CONSTRAINT "mst_product_mp_product_store_uuid_fkey" FOREIGN KEY ("mp_product_store_uuid") REFERENCES "mst_store_dc"("msd_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_product_general_info" ADD CONSTRAINT "mst_product_general_info_mpgi_product_uuid_fkey" FOREIGN KEY ("mpgi_product_uuid") REFERENCES "mst_product"("mp_uuid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_product_variant_info" ADD CONSTRAINT "mst_product_variant_info_mpvi_product_uuid_fkey" FOREIGN KEY ("mpvi_product_uuid") REFERENCES "mst_product"("mp_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_product_review" ADD CONSTRAINT "mst_product_review_mpr_product_uuid_fkey" FOREIGN KEY ("mpr_product_uuid") REFERENCES "mst_product"("mp_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_product_sub_category" ADD CONSTRAINT "mst_product_sub_category_mpsc_main_uuid_fkey" FOREIGN KEY ("mpsc_main_uuid") REFERENCES "mst_product_main_category"("mpmc_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_list_city_regency" ADD CONSTRAINT "mst_list_city_regency_mlcr_provinces_uuid_fkey" FOREIGN KEY ("mlcr_provinces_uuid") REFERENCES "mst_list_provinces"("mlp_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_list_district" ADD CONSTRAINT "mst_list_district_mld_city_uuid_fkey" FOREIGN KEY ("mld_city_uuid") REFERENCES "mst_list_city_regency"("mlcr_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mst_list_subdistrict" ADD CONSTRAINT "mst_list_subdistrict_mls_district_uuid_fkey" FOREIGN KEY ("mls_district_uuid") REFERENCES "mst_list_district"("mld_uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
