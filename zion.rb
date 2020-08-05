class Zion < Formula
  desc "A statically-typed strict garbage-collected powerful but not too-powerful readable programming language with enough side-effects to make it fun."
  homepage "https://zionlang.org/"
  url "https://github.com/zionlang/zion/archive/v0.3.1.tar.gz"
  sha256 "39bde53fa17cf4ab854af0db0351f0181dec70e139b63105008a6db3fc150ef5"
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
    system "#{bin}/zion", "test"
    (testpath/"check.zion").write "fn fib(n) { return n < 2 ? 1 : (fib(n-1) + fib(n-2)) } fn main() { print(fib(10)) }"
    assert_match("89", shell_output("\"#{bin}/zion\" \"#{testpath/"check.zion"}\""))
  end
end
