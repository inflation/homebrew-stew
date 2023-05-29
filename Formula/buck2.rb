class Buck2 < Formula
    desc "Successor to Buck, a multi-language build tool"
    homepage "https://buck2.build"
    url "https://github.com/facebook/buck2/releases/download/latest/buck2-aarch64-apple-darwin.zst"
    version "1b456f7"
    # sha256 "5085ca15fa7c9b917777d8c721dc3aa2e106b4cddbc0c4ff264d840b8d7b030a"

    def install
        mv "buck2-aarch64-apple-darwin", "buck2"
        bin.install "buck2"
    end
end
