class Halide < Formula
  desc ""
  homepage ""
  head "https://github.com/halide/Halide.git"

  depends_on "cmake" => :build
  depends_on "llvm" => :build

  def install
    mkdir "build" do
      args = %W[
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=#{prefix}
      ]
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test Halide`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
