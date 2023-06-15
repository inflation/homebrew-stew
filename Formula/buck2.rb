# frozen_string_literal: true

# :nodoc:
class Buck2 < Formula
  desc 'Successor to Buck, a multi-language build tool'
  homepage 'https://buck2.build'
  url 'https://github.com/facebook/buck2/releases/download/latest/buck2-aarch64-apple-darwin.zst'
  version '74bbb99'
  sha256 'b1c7163b53fcd0b31c2956e6a95cab31b1f4b9f2ac3a1f0aa80a987978cdf1f9'
  license any_of: ['Apache-2.0', 'MIT']

  def install
    bin.install 'buck2-aarch64-apple-darwin' => 'buck2'
  end
end
