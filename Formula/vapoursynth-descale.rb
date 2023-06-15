# frozen_string_literal: true

# :nodoc:
class VapoursynthDescale < Formula
  desc 'Video/Image filter to undo upscaling'
  homepage 'https://github.com/Irrational-Encoding-Wizardry/descale'
  url 'https://github.com/Irrational-Encoding-Wizardry/descale/archive/refs/tags/r8.tar.gz'
  version 'r8'
  sha256 '317d955cc2dfbc3fd1aecef2ea2d56e4f1cd99434492d71c6a1d48213ff35972'
  license 'MIT'

  depends_on 'meson' => :build
  depends_on 'ninja' => :build

  depends_on 'vapoursynth'

  def install
    system 'meson', 'build', *std_meson_args
    system 'ninja', '-C', 'build'
    (lib / 'vapoursynth').install 'build/libdescale.dylib'
  end
end
