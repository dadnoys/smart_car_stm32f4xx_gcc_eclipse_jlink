#write by haobo @ZhengZhou 2017年12月16日23:59:48
prefix = arm-none-eabi-
cc = $(prefix)gcc
ld = $(prefix)ld

		
#一些目录名
dir_app =$(shell ls -l | grep ^d | awk '{if( $$9 == "app") print $$9}' )
#编译用到的文件夹
subdir = $(dir_app)
dir_arch=$(shell ls -l | grep ^d | awk '{if( $$9 == "arch") print $$9}' )
subdir += $(dir_arch)
dir_bll =$(shell ls -l | grep ^d | awk '{if( $$9 == "bll") print $$9}')
subdir+=$(dir_bll)
dir_cmsis=$(shell ls -l | grep ^d | awk '{if( $$9 == "CMSIS") print $$9}')
subdir += $(dir_cmsis)
dir_driver=$(shell ls -l | grep ^d | awk '{if( $$9 == "driver") print $$9}')
subdir += $(dir_driver)
dir_OS =$(shell ls -l | grep ^d | awk '{if( $$9 == "freeRTOS") print $$9}')
subdir += $(dir_OS)
dir_inc=$(shell ls -l | grep ^d | awk '{if( $$9 == "include") print $$9}')

dir_root = $(shell pwd)

BINFILE_NAME= smart_car.bin
cflags=	-I $(dir_root)/$(dir_inc)/bll	\
		-I $(dir_root)/$(dir_inc)/CMSIS/core	\
		-I $(dir_root)/$(dir_inc)/CMSIS/drv	\
		-I $(dir_root)/$(dir_inc)/CMSIS/	\
		-I $(dir_root)/$(dir_inc)/app	\
		-I $(dir_root)/$(dir_inc)/arch  \
		-I $(dir_root)/$(dir_inc)/driver \
		-I $(dir_root)/$(dir_inc)/freeRTOS	\
		-mcpu=cortex-m4 -mthumb -Wall -mfloat-abi=hard -mfpu=fpv4-sp-d16\
		-ffunction-sections -fdata-sections
		
#		./freeRTOS/OS	\		
#		./bll/bll		\	

lditem=./app/app	\
		./arch/arch	\
		./CMSIS/cmsis	\
		./driver/driver	
gcc_libpath=/usr/lib/arm-none-eabi/newlib/

CURSRC = ${wildcard *.c}
CUROBJ = $(patsubst %c,%o,$(CURSRC))
export cc ld dir_arch dir_bll dir_cmsis dir_driver dir_OS dir_inc dir_root  cflags
all: app arch bll cmsis driver OS 
	$(ld) $(lditem) -Tldscript -lgcc -lc -L$(gcc_libpath) -o  smart_car.elf
	$(prefix)objcopy  -O binary -S smart_car.elf $(BINFILE_NAME)
	$(prefix)objdump -S -D -m arm smart_car.elf>DUMP_INFO
app:ECHOAPP
	make -C $(dir_app)
ECHOAPP:
	@echo $(dir_app)

arch:ECHOARCH
	make -C $(dir_arch)
ECHOARCH:
	@echo $(dir_arch)

bll:ECHOBLL
	make -C $(dir_bll)
ECHOBLL:
	@echo $(dir_bll)

cmsis:ECHOCMSIS
	make -C $(dir_cmsis)
ECHOCMSIS:
	@echo $(dir_cmsis)	

driver:ECHODRIVER
	make -C $(dir_driver)
ECHODRIVER:
	@echo $(dir_driver)

OS:ECHOOS
	make -C $(dir_OS)
ECHOOS:
	@echo $(dir_OS)	
	
$(CUROBJ): %.o:%.c
	$(cc) -c $(cflags) $^ -o $(ROOTDIR)/$(OBJDIR)/$@	

load2board:
	./jlink_loader.pl

clean:
	rm -f *.o *.bin
	$(foreach N, $(subdir),make clean -C $(N);)
