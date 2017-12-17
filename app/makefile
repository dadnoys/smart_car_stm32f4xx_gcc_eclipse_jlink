CURSRC = ${wildcard *.c}
CUROBJ = $(patsubst %c,%o,$(CURSRC))

app:$(CUROBJ)
	$(ld)  -r  -o app $(CUROBJ)
$(CUROBJ): %.o:%.c
	$(cc) -c $(cflags) $^ -o $@
clean:
	rm -f ./*.o ./*.bin ./*.lib app







