NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

config := config.json
sources := $(wildcard src/*.c)
target := build/$(NAME)
tests := $(wildcard test/*.txt)
expecteds := $(tests:%.txt=%.expected)
actual := $(tests:%.txt=%.actual)

all: $(target)
check: $(actual)
$(target) : $(config) $(sources)
	mkdir -p build
	cc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' $(sources) -o build/$(NAME)

$(sources): $(config)

$(actual): %.actual: %.txt %.expected $(target)
	@./$(target) <$*.txt | diff $*.expected -

clean:
	rm -rf build

.PHONY: all test clean
