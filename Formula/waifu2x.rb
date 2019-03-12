class Waifu2x < Formula
  desc ""
  homepage ""
  head "https://github.com/inflation/waifu2x-converter-cpp.git"

  depends_on "llvm" => :build
  depends_on "cmake" => :build
  depends_on "opencv"

  def install
    system "cmake", ".", "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end
end
