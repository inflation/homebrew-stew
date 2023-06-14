# frozen_string_literal: true

require 'language/node'

# Jellyfin is a Free Software Media System that puts you in control of managing
# and streaming your media
class Jellyfin < Formula
  desc 'Jellyfin is a Free Software Media System that puts you in control of managing
        and streaming your media'
  homepage 'https://github.com/jellyfin/jellyfin'
  url 'https://github.com/jellyfin/jellyfin/archive/refs/tags/v10.8.10.tar.gz'
  version '10.8.10'
  sha256 'a5412ae7a2470b90b51c77aee851aa1c95aaf4a51f1c830c254dc9a0cf9d0bd9'
  license 'GPL-2.0'

  depends_on 'ffmpeg'

  depends_on 'dotnet@6' => :build
  depends_on 'node' => :build

  resource 'jellyfin-web' do
    url 'https://github.com/jellyfin/jellyfin-web/archive/refs/tags/v10.8.10.tar.gz'
    sha256 '0ed8adc9d451d69cda26ec3a8d8a5baa6f1cb3788d3f4649c435dc19bdd20b8e'
  end

  def install_server
    system(*%w[dotnet publish Jellyfin.Server --configuration Release --self-contained
               --runtime osx-arm64 --output dist/jellyfin-server/
               -p:DebugSymbols=false;DebugType=none;UseAppHost=true])
    prefix.install 'dist/jellyfin-server/'
    bin.mkdir
    system 'ln', '-s', prefix / 'jellyfin-server/jellyfin', bin / 'jellyfin'
  end

  def install_client
    resource('jellyfin-web').stage do
      system 'npm', 'install', *Language::Node.local_npm_install_args
      system 'npm', 'run', 'build:production'
      (prefix / 'jellyfin-server').install 'dist' => 'jellyfin-web'
    end
  end

  def install
    install_server
    install_client
  end
end
