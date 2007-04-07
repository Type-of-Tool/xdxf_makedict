#!/bin/sh

source funcs.sh
set_md_plugin_dir

convert() {
	if ! ../src/makedict --verbose=3 --parser-option "remove-duplication=yes" -i sdict -o xdxf --work-dir /tmp "${1}"; then
		echo "makedict return error" >&2
		exit 1
	fi

	if ! diff -u "${2}/dict.xdxf" "${3}"; then
		echo "${2}/dict.xdxf ${3} are not the same" >&2
		exit 1
	fi

	rm -fr "${2}"
}

convert ./sample-dicts/sample1.dct /tmp/sample1 ./sample-dicts/sample1_sdict_std.xdxf
convert ./sample-dicts/sample2.dct /tmp/sample2 ./sample-dicts/sample2_sdict_std.xdxf