all: json2opack opack2json

json2opack: json2opack.m
	xcrun clang -fobjc-arc -fmodules -mmacosx-version-min=10.6 -F /System/Library/PrivateFrameworks/ -framework CoreUtils $< -o $@

opack2json: opack2json.m
	xcrun clang -fobjc-arc -fmodules -mmacosx-version-min=10.6 -F /System/Library/PrivateFrameworks/ -framework CoreUtils $< -o $@

clean:
	rm -f json2opack opack2json