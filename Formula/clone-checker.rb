class CloneChecker < Formula
    desc "APFS clone checker"
    homepage "https://github.com/dyorgio/apfs-clone-checker"
    url "https://github.com/dyorgio/apfs-clone-checker/archive/refs/tags/1.0.0.0.tar.gz"
    sha256 "5085ca15fa7c9b917777d8c721dc3aa2e106b4cddbc0c4ff264d840b8d7b030a"

    def install
        system "gcc", "-o", "clone-checker", "clone_checker.c"
        bin.install "clone-checker"
    end
end