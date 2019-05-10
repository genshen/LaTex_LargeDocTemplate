document.pdf:
	latexmk -e '$$max_repeat=6' document.tex -xelatex
	# xelatex document.tex 

clean:
	rm -f *.pdf *.out *.aux *.bbl *.bcf *.blg *.dvi *.fdb_latexmk *.fls *.lof *.log *.ptb *.run.xml *.sta *.synctex.gz *.toc *.tod *.xdv
