
PANDOC=pandoc

all: resume

resume: resume.txt index.html resume.odt

resume.txt: resume.rst
	cp resume.rst resume.txt

index.html: resume.rst style.css
	$(PANDOC) --base-header=2 -f rst+smart -t html -s -c style.css \
	          -o index.html resume.rst

resume.odt: resume.rst
	$(PANDOC) -f rst -t odt -o resume.odt resume.txt

clean:
	rm resume.txt index.html resume.odt

publish: resume
	rm -rf /tmp/resume/
	git clone -b gh-pages https://github.com/devxoul/resume.git /tmp/resume/
	cp resume.rst index.html resume.txt resume.odt /tmp/resume/
	cd /tmp/resume; \
		git add -f resume.rst index.html resume.txt resume.odt; \
		git commit -am "Publish"; \
		git push -f origin gh-pages
	rm -rf /tmp/resume
