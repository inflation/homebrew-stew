# frozen_string_literal: true

# :nodoc:
class Reindeer < Formula
  desc 'This is a set of tools for importing Rust crates from crates.io, ' \
       'git repos, etc and generating Buck build rules for them.'
  url 'https://github.com/facebookincubator/reindeer.git', revision: '43a317c'
  version '43a317c'
  license 'MIT'

  depends_on 'rust' => :build

  def install
    system 'cargo', 'install', *std_cargo_args
  end
end
