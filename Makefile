# Hello emacs, this is -*- makefile -*-
# $Id: latex.mak,v 1.2 2000/11/13 21:43:08 andre Exp $

# Este makefile, constrói os alvos do latex para este diretório
# no diretório atual. O arquivo principal deve se chamar main.tex
# por default ou você deverá trocar o valor da variável TEXFILE
# abaixo para o nome correto. A seção PROGRAMAS não deve ser mexida
# a não ser que a localização dos programas que você use não seja
# a indicada. O restante não deve ser mudado, a não ser que você 
# saiba o que está fazendo.
#
# Para usar este makefile de forma automática, faça:
# (seu prompt)>> mv latex.mak Makefile
# (seu prompt)>> make

# André Rabello <Andre.Rabello@ufrj.br>

# ------------
# SEÇÃO: NOMES (mude os nomes dos arquivos)
# ------------

TEXFILE=main.tex

# FIM DA SEÇÃO NOMES

# ----------------
# SEÇÃO: PROGRAMAS (sintonize o que você acha necessário)
# ----------------

LATEX=/usr/bin/latex
BIBTEX=/usr/bin/bibtex

DVIPS=/usr/bin/dvips
DVIPSOPTS=-ta4
DVIPDFM=/usr/bin/dvipdfm
DVIPDFMOPTS=-p a4

# FIM DA SEÇÃO PROGRAMAS

# -------------
# SEÇÃO: REGRAS (procure não alterar daqui para baixo)
# -------------

DVIFILE=$(TEXFILE:%.tex=%.dvi)
PSFILE=$(TEXFILE:%.tex=%.ps)
PDFFILE=$(TEXFILE:%.tex=%.pdf)

# Esta regra implícita define como fazer um .dvi de um .tex

%.dvi: %.tex
	$(LATEX) $<
	$(BIBTEX) $(<:%.tex=%)
	makeindex $(<:%.tex=%.idx)
	$(LATEX) $<
	$(LATEX) $<

all: ps 

# Se você quiser somente construir o dvi do arquivo, então
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

# FIM DA SEÇÃO REGRAS

