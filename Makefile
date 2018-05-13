# main latexmk rule

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

TAR := evfs-paper

paper.pdf: paper.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make paper.tex

clean:
	latexmk -CA
	rm paper.bbl paper-full*

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: paper.pdf clean

.PHONY: tar
tar:
	git ls-tree --full-tree -r HEAD | awk '{ print $$4 }' | xargs tar czvf $(TAR).tar.gz

