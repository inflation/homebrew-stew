# frozen_string_literal: true

# :nodoc:
class VapoursynthFmtconv < Formula
  desc 'Vapoursynth Plugin for fmtconv'
  homepage 'https://gitlab.com/EleonoreMizo/fmtconv/'
  url 'https://gitlab.com/EleonoreMizo/fmtconv/-/archive/r30/fmtconv-r30.tar.bz2'
  version 'r30'

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
