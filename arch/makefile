SUBDIR = $(shell ls -l | grep ^d | awk '{print $$9}')
CURSRC = ${wildcard *.c}
CUROBJ = $(patsubst %c,%o,$(CURSRC))

$(CUROBJ): %.o:%.c
	$(cc) -c $(cflags) $^ -o $@
	
arch:$(SUBDIR) $(CUROBJ)
	$(ld)  -r  -o arch $(CUROBJ) ./gnu/start
$(SUBDIR):ECHO
	make -C $@
ECHO:
	@echo $(SUBDIR)
clean:
	rm -f ./*.o ./*.bin ./*.lib
	$(foreach N, $(SUBDIR),make clean -C $(N);) arch