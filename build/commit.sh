#!/usr/bin/env bash

# GitHub Action runner
if [ -v GITHUB_RUN_ID ]; then
	echo "» Set git username and email"
	git config user.name "github-actions[bot]"
	git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
fi

MY_TXT="last_build.txt"
date > "$MY_TXT"

if ! git diff --exit-code "$MY_TXT"; then
	git add "$MY_TXT"
	git commit -m "Last build" || exit 9
	git push || exit 9
fi

echo "DONE"