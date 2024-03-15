class Bestsource < Formula
  desc "A super great audio/video source and FFmpeg wrapper"
  homepage ""
  url "https://github.com/vapoursynth/bestsource.git"
  sha256 "9eb96e536b1daadfad0f6b6f48dcd93d36b7a27d77e91c16f3e1630f5b21372b"
  version "R1"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "jansson"
  depends_on "ffmpeg"
  depends_on "vapoursynth"

  def install
    mkdir "build" do
      system "meson", "setup", *std_meson_args, '..'
      system "meson", "compile"
      (lib/"vapoursynth").install "libbestsource.dylib"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test bestsource`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
