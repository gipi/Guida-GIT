SRC_TEX=$(wildcard *.tex)
SRC += guida-git.tex versione.tex githelp.tex

FRASE="(La versione installata da chi ha compilato questo documento \`e "

GUIDA += guida-git.pdf

all: $(GUIDA)

%.ps: %.dvi
	dvips $^ -o

%.pdf: $(SRC) $(SRC_TEX)
	pdftex $<

%.dvi: %.tex
	tex $^

versione.tex:
	VERSIONE=$$(git --version 2>/dev/null | sed -n 's/git version //p'); \
					 if [ "$$VERSIONE" != "" ]; then echo $(FRASE) $$VERSIONE")"; fi \
					 > versione.tex

githelp.tex:
	git --help > $@

clean:
	rm -vf $(GUIDA) *.pgf *.log versione.tex githelp.tex
