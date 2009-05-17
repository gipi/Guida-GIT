SRC_TEX=$(wildcard *.tex)
GENERATED_SRC = versione.tex githelp.tex commit-dag.tex tree-dag.tex reflog.tex
SRC += guida-git.tex $(GENERATED_SRC)

FRASE="(La versione installata da chi ha compilato questo documento \`e "

GUIDA += guida-git.pdf

all: $(GUIDA)

%.ps: %.dvi
	dvips $^ -o

%.pdf: $(SRC) $(SRC_TEX) hyplain
	pdftex -fmt hyplain -output-format pdf $<

%.dvi: %.tex
	tex $^

hyplain:
	pdftex -ini -etex hyplain

versione.tex:
	VERSIONE=$$(git --version 2>/dev/null | sed -n 's/git version //p'); \
					 if [ "$$VERSIONE" != "" ]; then echo $(FRASE) $$VERSIONE")"; fi \
					 > versione.tex

githelp.tex:
	git --help > $@

commit-dag.tex:
	git cat-file -p HEAD > $@

tree-dag.tex:
	git cat-file -p HEAD^{tree} > $@

reflog.tex:
	git reflog | head -n 10 > $@

clean:
	rm -vf $(GUIDA) *.pgf *.log $(GENERATED_SRC) hyplain*
