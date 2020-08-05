class Zion < Formula
  desc "A statically-typed strict garbage-collected powerful but not too-powerful readable programming language with enough side-effects to make it fun."
  homepage "https://zionlang.org/"
  tarfile = `/tmp/v0.3.0.tar.gz`
  url "https://github.com/zionlang/zion/archive/master.tar.gz"
  sha256 "3203fe63dcbb5ec0ad6ef4dd1f9fd4cf3624a24f8821f85a5be7d60a00c2e487"
  license "MIT License"
  version "0.3.0"

  depends_on "cmake" => :build
  depends_on "llvm@10" => :build
  depends_on "pkg-config"
  depends_on "libsodium"
  depends_on "bdw-gc"

  patch :DATA

  def install

    mkdir "build" do
      system "cmake", "-G", "Unix Makefiles", "..", *std_cmake_args
      system "make"
    end

    system "./install.sh", "build", prefix

    pkgshare.install "runtime"
    pkgshare.install "lib"
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
