ifndef TARGET_BOARD_PLATFORM
  $(error TARGET_BOARD_PLATFORM is not defined)
endif
ifndef MTK_PTGEN_CHIP
  $(error MTK_PTGEN_CHIP is not defined)
endif
ifndef MTK_PTGEN_OUT_DIR
  $(error MTK_PTGEN_OUT_DIR is not defined)
endif


MTK_PTGEN_PERL := device/mediatek/build/build/tools/ptgen/$(MTK_PTGEN_CHIP)/ptgen.pl
MTK_PTGEN_XLS := $(wildcard device/mediatek/build/build/tools/ptgen/$(MTK_PTGEN_CHIP)/*.xls)
MTK_PTGEN_COMMAND := \
	PLATFORM=${MTK_PTGEN_CHIP} \
	MTK_TARGET_PROJECT=${MTK_TARGET_PROJECT} \
	TARGET_BUILD_VARIANT=${TARGET_BUILD_VARIANT} \
	MTK_NAND_PAGE_SIZE=${MTK_NAND_PAGE_SIZE} \
	MTK_YAML_SCATTER_FILE_SUPPORT=${MTK_YAML_SCATTER_FILE_SUPPORT} \
	MTK_EMMC_SUPPORT=${MTK_EMMC_SUPPORT} \
	MTK_TC1_FEATURE=${MTK_TC1_FEATURE} \
	MTK_LDVT_SUPPORT=${MTK_LDVT_SUPPORT} \
	MTK_EMMC_SUPPORT_OTP=${MTK_EMMC_SUPPORT_OTP} \
	MTK_SHARED_SDCARD=${MTK_SHARED_SDCARD} \
	MTK_CIP_SUPPORT=${MTK_CIP_SUPPORT} \
	MTK_FAT_ON_NAND=${MTK_FAT_ON_NAND} \
	MTK_SPI_NAND_SUPPORT=${MTK_SPI_NAND_SUPPORT} \
	MTK_NAND_UBIFS_SUPPORT=${MTK_NAND_UBIFS_SUPPORT} \
	MTK_COMBO_NAND_SUPPORT=${MTK_COMBO_NAND_SUPPORT} \
	PL_MODE=${PL_MODE} \
	MTK_PARTITION_TABLE_PLAIN_TEXT=${MTK_PARTITION_TABLE_PLAIN_TEXT} \
	MTK_ATF_SUPPORT=${MTK_ATF_SUPPORT} \
	MTK_TEE_SUPPORT=${MTK_TEE_SUPPORT} \
	MTK_PERSIST_PARTITION_SUPPORT=${MTK_PERSIST_PARTITION_SUPPORT} \
	MTK_DRM_KEY_MNG_SUPPORT=${MTK_DRM_KEY_MNG_SUPPORT} \
	MTK_BASE_PROJECT=${MTK_BASE_PROJECT} \
	PTGEN_ENV="PROJECT" \
	PTGEN_MK_OUT=${MTK_PTGEN_OUT} \
	TMP_OUT_PATH=${MTK_PTGEN_TMP_OUT} \
	OUT_DIR=${MTK_PTGEN_OUT_DIR} \
	PRELOADER_TARGET=${PRELOADER_TARGET_PRODUCT} \
	MTK_FACTORY_RESET_PROTECTION_SUPPORT=${MTK_FACTORY_RESET_PROTECTION_SUPPORT} \
	MTK_EFUSE_WRITER_SUPPORT=${MTK_EFUSE_WRITER_SUPPORT} \
	perl $(MTK_PTGEN_PERL)

ifneq ($(CALLED_FROM_SETUP),true)
ifeq ($(wildcard $(MTK_PTGEN_OUT)/partition_size.mk),)
  MTK_PTGEN_RES := $(shell $(MTK_PTGEN_COMMAND) 2>/dev/null >/dev/null; echo $$?)
  ifneq ($(strip $(MTK_PTGEN_RES)),0)
    $(error ptgen error=$(MTK_PTGEN_RES): $(MTK_PTGEN_COMMAND))
  endif
endif
endif
