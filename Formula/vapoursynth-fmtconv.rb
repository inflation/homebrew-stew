# frozen_string_literal: true

# Vapoursynth Plugin for fmtconv
class VapoursynthFmtconv < Formula
  desc 'Vapoursynth Plugin for fmtconv'
  homepage 'https://github.com/EleonoreMizo/fmtconv'
  url 'https://github.com/EleonoreMizo/fmtconv/archive/refs/tags/r29.tar.gz'
  version 'r29'
  sha256 'cf087eef8d40f88bb33c1e94e7123448d6f5fc3c1dadd862e0d836569dbd922a'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build

  def install
    vslib = lib / 'vapoursynth'

    Dir.chdir('build/unix')
    system './autogen.sh'
    system './configure', *std_configure_args, "--libdir=#{vslib}"
    system 'make', 'install'
  end
end
