HUGO_BIN=hugo

.PHONY: prepare release build demo clean

build: prepare
	$(HUGO_BIN) --source demo

demo: prepare
	$(HUGO_BIN) server --buildDrafts --source demo

release: build
	rm -rf ./resources && cp -r ./demo/resources ./resources

prepare: clean
	mkdir -p demo/themes/hugo-coder
	rsync -av site/ demo
	rsync -av --exclude='demo' --exclude='site' --exclude='.git' . demo/themes/hugo-coder

clean:
	rm -rf demo
