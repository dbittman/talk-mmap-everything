
preproc: preproc.c

preproc.c: preproc.lex
	flex -o preproc.c preproc.lex

present: preproc 
	./preproc < main.roff | nroff -t -mman | less -R
