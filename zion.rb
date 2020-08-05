class Zion < Formula
  desc "A statically-typed strict garbage-collected powerful but not too-powerful readable programming language with enough side-effects to make it fun."
  homepage "https://zionlang.org/"
  url "https://github.com/zionlang/zion/archive/master.tar.gz"
  sha256 "a616e2f32c1d2d145c264cf48fa77610b2a587d1359d9e4e47b5d61028e1e927"
  license "MIT License"
  version "0.3.0"

  depends_on "cmake" => :build
  # depends_on "llvm@10"
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
