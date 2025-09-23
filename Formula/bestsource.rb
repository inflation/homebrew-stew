class Bestsource < Formula
  desc "A super great audio/video source and FFmpeg wrapper"
  homepage ""
  url "https://github.com/vapoursynth/bestsource.git", tag: "R13"
  version "R13"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "xxhash"
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
