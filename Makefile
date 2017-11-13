SAMPLE=./pandoc_dalibo_guidelines.sample
MD=$(SAMPLE).md
PDF=$(SAMPLE).pdf
TEX=$(SAMPLE).tex

FILTER=./pandoc_dalibo_guidelines.py

DIST=dist

sdist: 
	python setup.py sdist

install: 
	python setup.py install	

pypi:
	twine upload $(DIST)/*

test: basic_test  $(TEX) $(PDF) 

basic_test:
	echo 'hello world' | pandoc -t json | python -tt $(FILTER)

%.tex: %.md
	pandoc --filter $(FILTER) $(MD) -o $(TEX)

%.pdf:  %.md
	pandoc --filter $(FILTER) $(MD) -o $(PDF)

testpypi: sdist 
	twine upload $(DIST)/* -r testpypi
	#mkvirtualenv test-pandoc-latex-levelup
	#workon test-pandoc-latex-levelup
	pip install --user -i https://testpypi.python.org/pypi pandoc-dalibo-guidelines
	pip uninstall pandoc-dalibo-guidelines
	#rmvirtualenv test-pandoc-latex-levelup

docker: 
	docker build .

clean:
	rm -f $(PDF)
	rm -f $(TEX)
	rm -fr $(DIST)
