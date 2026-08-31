#!/bin/sh

set -eu

if [ "$(uname -s)" != "Darwin" ]; then
  printf 'error: this script supports macOS only\n' >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  printf 'error: Homebrew is required. Install it from https://brew.sh/\n' >&2
  exit 1
fi

for formula in astyle clang-format isort ruby; do
  if brew list --formula "$formula" >/dev/null 2>&1; then
    printf 'skip: %s is already installed\n' "$formula"
  else
    brew install "$formula"
  fi
done

brew_prefix=$(brew --prefix)
ruby_prefix=$(brew --prefix ruby)

if [ -x "$brew_prefix/bin/rubocop" ]; then
  printf 'skip: rubocop is already installed\n'
else
  "$ruby_prefix/bin/gem" install rubocop \
    --bindir "$brew_prefix/bin" \
    --no-document
fi

printf '\nInstalled tools:\n'
for command_name in astyle clang-format isort rubocop; do
  "$command_name" --version
done
