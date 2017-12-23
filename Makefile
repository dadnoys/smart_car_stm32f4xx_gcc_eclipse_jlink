#write by haobo @ZhengZhou 2017��12��16��23:59:48
prefix = arm-none-eabi-
cc = $(prefix)gcc
ld = $(prefix)ld

		
dir_app =$(shell ls -l | grep ^d | awk '{if( $$9 == "app") print $$9}' )

subdir = $(dir_app)
dir_arch=$(shell ls -l | grep ^d | awk '{if( $$9 == "arch") print $$9}' )
subdir += $(dir_arch)
dir_bll =$(shell ls -l | grep ^d | awk '{if( $$9 == "bll") print $$9}')
subdir+=$(dir_bll)
dir_cmsis=$(shell ls -l | grep ^d | awk '{if( $$9 == "CMSIS") print $$9}')
subdir += $(dir_cmsis)
dir_driver=$(shell ls -l | grep ^d | awk '{if( $$9 == "driver") print $$9}')
subdir += $(dir_driver)
dir_OS =$(shell ls -l | grep ^d | awk '{if( $$9 == "rt_thread") print $$9}')
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
		-I /home/haobo/tools/arm-none-eabi/arm-none-eabi/include	\
		-mcpu=cortex-m4 -mthumb -Wall -mfloat-abi=hard -mfpu=fpv4-sp-d16\
		-ffunction-sections -fdata-sections



lditem=./app/app	\
		./arch/arch	\
		./CMSIS/cmsis	\
		./driver/driver	
		
gcc_libpath= -L /home/haobo/tools/arm-none-eabi/arm-none-eabi/lib/hard \
			 -L /home/haobo/tools/arm-none-eabi/lib/gcc/arm-none-eabi/7.2.1/hard


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
