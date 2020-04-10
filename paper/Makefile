MAIN=paper
SRCS=$(wildcard *.tex *.sty *.bib)

.PHONY: all clean reallyclearn
all: ${MAIN}.pdf
clean:
	latexmk -c
reallyclean:
	latexmk -C

%.pdf: %.tex ${SRCS}
	latexmk -pdf $<
