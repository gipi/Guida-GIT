
SRC += guida-git.tex
SRC_MACRO += macro.tex
SRC_CAP += getting-started.tex
SRC_CAP += comandi.tex
SRC_CAP += workflow.tex
SRC_CAP += informazioni.tex
SRC_CAP += sharing.tex

SRC_FIG += rebase-start.tex
SRC_FIG += rebase-onto-inizio.tex
SRC_FIG += rebase-onto-fine.tex
SRC_FIG += stash-tree.tex
SRC_FIG += merge-scheme.tex

GIT_VERS += versione.tex
GIT_HELP += githelp.tex

FRASE="(La versione installata da chi ha compilato questo documento \`e "

GUIDA += guida-git.pdf

all: $(GUIDA)

%.ps: %.dvi
	dvips $^ -o

%.pdf: $(SRC) $(SRC_CAP) $(SRC_MACRO) $(SRC_FIG) $(GIT_VERS) $(GIT_HELP)
	pdftex $<

%.dvi: %.tex
	tex $^

versione.tex:
	VERSIONE=$$(git --version 2>/dev/null | sed -n 's/git version //p'); \
					 if [ "$$VERSIONE" != "" ]; then echo $(FRASE) $$VERSIONE")"; fi \
					 > versione.tex

githelp.tex:
	echo "\verbatim" > $@
	git --help >> $@
	echo "|endverbatim" >> $@

clean:
	rm -vf $(GUIDA) *.pgf *.log versione.tex githelp.tex
