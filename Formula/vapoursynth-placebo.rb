# frozen_string_literal: true

# :nodoc:
class VapoursynthPlacebo < Formula
  desc 'Vapoursynth plugin for libplacebo'
  homepage 'https://github.com/Lypheo/vs-placebo'
  url 'https://github.com/Lypheo/vs-placebo.git'
  version '1.4.4'
  sha256 '9fb3c36331bbc115c8889ccc0cd0e1ace367ffa5bc7512cb1ea6c79cb7cfa75e'

  depends_on 'meson' => :build
  depends_on 'ninja' => :build

  depends_on 'libplacebo'
  depends_on 'vapoursynth'

  def install
    # ENV['PKG_CONFIG_PATH'] += ':/opt/VulkanSDK/1.3.216.0/macOS/lib/pkgconfig'
    mkdir "build" do
      system 'meson', 'setup', *std_meson_args, '..'
      system 'meson', 'compile'
      (lib / "vapoursynth").install 'libvs_placebo.dylib'
    end
  end
end
