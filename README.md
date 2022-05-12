# gemfile-diff

[![rubocop](https://github.com/r7kamura/gemfile-diff/actions/workflows/rubocop.yml/badge.svg)](https://github.com/r7kamura/gemfile-diff/actions/workflows/rubocop.yml)

Custom action to check difference of 2 Gemfile.lock.

If there is a difference, it outputs the ANSI-colored diff and terminates with exit code 1.

## Usage

```yaml
# .github/workflows/gemfile-diff.yml
name: gemfile-diff

on:
  pull_request:
  push:
    branches:
      - main

jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: r7kamura/gemfile-diff@v0
        with:
          gemfile_lock_a: Gemfile.lock
          gemfile_lock_b: Gemfile-rails-7-0.lock
          ignore:
            actioncable
            actionmailbox
            actionmailer
            actionpack
            actiontext
            actionview
            activejob
            activemodel
            activerecord
            activestorage
            activesupport
            digest
            globalid
            io-wait
            mini_mime
            net-imap
            net-pop
            net-protocol
            net-smtp
            rails
            railties
            scanf
            strscan
            timeout
```
