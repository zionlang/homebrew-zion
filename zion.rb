class Zion < Formula
  desc "A statically-typed strict garbage-collected powerful but not too-powerful readable programming language with enough side-effects to make it fun."
  homepage "https://zionlang.org/"
  url "https://github.com/zionlang/zion/archive/master.tar.gz"
  sha256 "a95fe05ac42a5e24232eaf72448e28ddb45d5a99fda80e77170e0278ef4da83e"
  license "MIT License"
  version "0.3.1"

  depends_on "bdw-gc"
  depends_on "cmake" => :build
  depends_on "graphviz"
  depends_on "libsodium"
  depends_on "llvm@10"
  depends_on "pkg-config"

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
    (testpath/"check.zion").write "fn fib(n) { return n < 2 ? 1 : (fib(n-1) + fib(n-2)) } fn main() { print(fib(10)) }"
    assert_match("89", shell_output("#{bin}/zion \"#{testpath/"check.zion"}\""))
  end
end
