# frozen_string_literal: true

Spring.watch(
  '.ruby-version',
  'tmp/restart.txt',
  'tmp/caching-dev.txt'
)
