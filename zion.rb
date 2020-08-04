class Zion < Formula
  desc "A statically-typed strict garbage-collected powerful but not too-powerful readable programming language with enough side-effects to make it fun."
  homepage "https://zionlang.org/"
  url "file:///Users/wbbradley/src/homebrew-zion"  # /file:https://github.com/zionlang/zion/archive/v0.3.tar.gz"
  # sha256 "9b95c6a23e755366083e5693f0de07a1a61b3a5f5a0fdff8c7c15905c96eb5c9"
  license "MIT License"
  version "0.3.0"

  depends_on "cmake" => :build
  depends_on "llvm@10" => :build
  depends_on "pkg-config"
  depends_on "libsodium"
  depends_on "bdw-gc"

  def install

    mkdir "build" do
      system "cmake", "-G", "Unix Makefiles", "..", *std_cmake_args
      system "make"
    end

    # system "cmake", ".", 
    # llvm_dir = "#{prefix}/opt/llvm"
    # system \
    #   "LDFLAGS=\"-L#{llvm_dir}/lib\" " \
    #   "CPPFLAGS=\"-L#{llvm_dir}/include\" " \
    #   "PATH=\"#{llvm_dir}/bin:$PATH\" " \
    #   "make " \
    #   "BUILD_DIR=build " \
    #   "prefix=\"#{prefix}\" " \
    #   "man1dir=\"#{man}/man1\" "
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test zion`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/zion", "test"
  end
end
