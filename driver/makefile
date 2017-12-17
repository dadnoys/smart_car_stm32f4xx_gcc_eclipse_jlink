SUBDIR = $(shell ls -l | grep ^d | awk '{print $$9}')
CURSRCC = ${wildcard *.c}
CUROBJc = $(patsubst %c,%o,$(CURSRCC))

CURSRCs = ${wildcard *.s}
CUROBJs = $(patsubst %s,%o,$(CURSRCs))


driver:$(SUBDIR) $(CUROBJc) $(CUROBJs)
	$(ld) -r -o $@ $(CUROBJc) $(CUROBJs)
all:$(SUBDIR) $(CUROBJc) $(CUROBJs)
$(CUROBJc): %.o:%.c
	$(cc) -c $(cflags) $^ -o $@
$(CUROBJs): %.o:%.s
	$(cc) -c $(cflags) $^ -o $@	

$(SUBDIR):ECHO
	make -C $@
ECHO:
	@echo $(SUBDIR)
clean:
	rm -f ./*.o ./*.bin ./*.lib
	$(foreach N, $(SUBDIR),make clean -C $(N);)
