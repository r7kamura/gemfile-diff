# gemfile-diff

Custom action to check difference of 2 Gemfile.lock.

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
      - uses: r7kamura/gemfile-diff
        with:
          gemfile_lock_a: Gemfile.lock
          gemfile_lock_b: Gemfile-rails-7-0.lock
          ignore:
            actionmailer
            actionpack
            actionview
            activemodel
            activerecord
            activesupport
            globalid
            mini_mime
            rails
            railties
```