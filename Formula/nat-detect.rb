# frozen_string_literal: true

# :nodoc:
class NatDetect < Formula
  desc 'A simple nat detect implementation for rust'
  url 'https://github.com/blazood/nat-detect.git', revision: '5d937de'
  version '0.1.7'
  license 'MIT'

  depends_on 'rust' => :build

  def install
    system 'cargo', 'install', *std_cargo_args
  end
end
