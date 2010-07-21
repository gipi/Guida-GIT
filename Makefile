SRC_TEX=$(wildcard *.tex)
GENERATED_SRC += versione.tex
GENERATED_SRC += githelp.tex
GENERATED_SRC += commit-dag.tex
GENERATED_SRC += tree-dag.tex
GENERATED_SRC += reflog.tex
GENERATED_SRC += merge-conflict.tex
GENERATED_SRC += hello-conflict.tex
GENERATED_SRC += blame.tex
SRC += guida-git.tex $(GENERATED_SRC)

SHA1_FIRST_COMMIT=$(shell git log --reverse --pretty=%H | head -n 1)

FRASE="(La versione installata da chi ha compilato questo documento \`e "

GUIDA += guida-git.pdf

all: $(GUIDA)

%.ps: %.dvi
	dvips $^ -o

$(GUIDA): $(SRC) $(SRC_TEX)
	pdftex -output-format pdf $<

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
	git cat-file -p $(SHA1_FIRST_COMMIT) > $@

tree-dag.tex:
	git cat-file -p $(SHA1_FIRST_COMMIT)^{tree} > $@

reflog.tex:
	git reflog | head -n 10 > $@

merge-conflict.tex hello-conflict.tex:
	git diff --exit-code > /dev/null
	git diff --cached --exit-code > /dev/null
	git checkout -f merge-conflict
	git merge fucking-merge-conflict > merge-conflict.tex \
		|| { cp hello.c hello-conflict.tex && git checkout -f master; }

blame.tex:
	git blame -L /VERBATIM\ STUFFS/,/END\ VERBATIM/  -s macro.tex > $@

clean:
	rm -vf $(GUIDA) *.pgf *.log $(GENERATED_SRC) hyplain*
