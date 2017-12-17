SUBDIR = $(shell ls -l | grep ^d | awk '{print $$9}')
CURSRC = ${wildcard *.c}
CUROBJ = $(patsubst %c,%o,$(CURSRC))



$(CUROBJ): %.o:%.c
	$(cc) -c $(cflags) $^ -o $@
	
all:$(SUBDIR) $(CUROBJ)
$(SUBDIR):ECHO
	make -C $@
ECHO:
	@echo $(SUBDIR)
clean:
	rm -f ./*.o ./*.bin ./*.lib boot
	$(foreach N, $(SUBDIR),make clean -C $(N);)