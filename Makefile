# Hello emacs, this is -*- makefile -*-
# $Id: latex.mak,v 1.2 2000/11/13 21:43:08 andre Exp $

# Este makefile, constr�i os alvos do latex para este diret�rio
# no diret�rio atual. O arquivo principal deve se chamar main.tex
# por default ou voc� dever� trocar o valor da vari�vel TEXFILE
# abaixo para o nome correto. A se��o PROGRAMAS n�o deve ser mexida
# a n�o ser que a localiza��o dos programas que voc� use n�o seja
# a indicada. O restante n�o deve ser mudado, a n�o ser que voc� 
# saiba o que est� fazendo.
#
# Para usar este makefile de forma autom�tica, fa�a:
# (seu prompt)>> mv latex.mak Makefile
# (seu prompt)>> make

# Andr� Rabello <Andre.Rabello@ufrj.br>

# ------------
# SE��O: NOMES (mude os nomes dos arquivos)
# ------------

TEXFILE=main.tex

# FIM DA SE��O NOMES

# ----------------
# SE��O: PROGRAMAS (sintonize o que voc� acha necess�rio)
# ----------------

LATEX=/usr/bin/latex
BIBTEX=/usr/bin/bibtex

DVIPS=/usr/bin/dvips
DVIPSOPTS=-ta4
DVIPDFM=/usr/bin/dvipdfm
DVIPDFMOPTS=-p a4

# FIM DA SE��O PROGRAMAS

# -------------
# SE��O: REGRAS (procure n�o alterar daqui para baixo)
# -------------

DVIFILE=$(TEXFILE:%.tex=%.dvi)
PSFILE=$(TEXFILE:%.tex=%.ps)
PDFFILE=$(TEXFILE:%.tex=%.pdf)

# Esta regra impl�cita define como fazer um .dvi de um .tex

%.dvi: %.tex
	$(LATEX) $<
	$(BIBTEX) $(<:%.tex=%)
	makeindex $(<:%.tex=%.idx)
	$(LATEX) $<
	$(LATEX) $<

all: ps 

# Se voc� quiser somente construir o dvi do arquivo, ent�o
# tens esta regra.
dvi: $(DVIFILE)

ps: $(DVIFILE)
	$(DVIPS) $(DVIPSOPTS) $(DVIFILE) -o $(PSFILE)

pdf: $(DVIFILE)
	$(DVIPDFM) $(DVIPDFMOPTS) $(DVIFILE) -o $(PDFFILE)

.PHONY: clean update bib sclean pack

bib:
	$(MAKE) -C biblio mybib

update:
	$(LATEX) $(TEXFILE) 
	$(BIBTEX) $(TEXFILE:%.tex=%)
	makeindex $(TEXFILE:%.tex=%.idx)
	$(LATEX) $(TEXFILE)
	$(LATEX) $(TEXFILE)
	$(DVIPS) $(DVIPSOPTS) $(DVIFILE) -o $(PSFILE)

slides:
	$(LATEX) presentation.tex
	$(DVIPS) presentation.dvi -o presentation.ps

sclean:
	rm -f presentation.{log,aux,dvi,ps}

clean:
	rm -f $(DVIFILE) $(PSFILE)
	rm -f *.log *~ *.aux *.bbl *.blg
	rm -f *.lo[tfa] *.toc *.idx *.glo 
	rm -f *.inc *.ilg *.ind

pack: sclean clean
	rm -f *.ps
	cd ..; tar cvfz thesis.tar.gz thesis; cd thesis

# FIM DA SE��O REGRAS

