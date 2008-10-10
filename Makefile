
SRC += guida-git.tex

GUIDA += guida-git.ps

all: $(GUIDA)

%.ps: %.dvi
	dvips $^ -o

%.dvi: %.tex
	tex $^

clean:
	rm -vf $(GUIDA)
