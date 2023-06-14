# frozen_string_literal: true

# A Modern Linker
class Sold < Formula
  desc 'A Modern Linker'
  homepage 'https://github.com/bluewhalesystems/sold'
  license 'AGPL-3.0-only'
  head 'https://github.com/bluewhalesystems/sold.git', branch: 'main'

  depends_on 'cmake' => :build
  depends_on 'tbb'
  depends_on 'zstd'
  uses_from_macos 'zlib'

  depends_on 'llvm' => :build if DevelopmentTools.clang_build_version <= 1200

  fails_with :clang do
    build 1200
    cause 'Requires C++20'
  end

  fails_with :gcc do
    version '7'
    cause 'Requires C++20'
  end

  def conf
    # Ensure we're using Homebrew-provided versions of these dependencies.
    %w[mimalloc tbb zlib zstd].map { |dir| (buildpath / 'third-party' / dir).rmtree }
    %w[
      -D MOLD_LTO=ON
      -D MOLD_USE_MIMALLOC=ON
      -D MOLD_USE_SYSTEM_MIMALLOC=ON
      -D MOLD_USE_SYSTEM_TBB=ON
      -D CMAKE_SKIP_INSTALL_RULES=OFF
    ]
  end

  def install
    args = conf

    system 'cmake', '-S', '.', '-B', 'build', *args, *std_cmake_args
    system 'cmake', '--build', 'build'
    system 'cmake', '--install', 'build'

    pkgshare.install 'test'
  end
end
