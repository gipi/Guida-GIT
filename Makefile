
SRC += guida-git.tex
SRC_MACRO += macro.tex
SRC_CAP += getting-started.tex
SRC_CAP += comandi.tex
SRC_CAP += workflow.tex

GUIDA += guida-git.pdf

all: $(GUIDA)

%.ps: %.dvi
	dvips $^ -o

%.pdf: $(SRC) $(SRC_CAP) $(SRC_MACRO)
	pdftex $<

%.dvi: %.tex
	tex $^

clean:
	rm -vf $(GUIDA) *.pgf *.log
