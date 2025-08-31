class Ddk < Formula
  desc "Apple Dictionary Development Kit (packaged for Homebrew)"
  homepage "https://developer.apple.com"
url "https://github.com/maahirvirsingh123-ctrl/homebrew-ddk/releases/download/v1.0.0/ddk-1.0.0.tar.gz"
sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license :cannot_represent

  def install
    libexec.install Dir["*"]

    if (libexec/"bin").directory?
      (libexec/"bin").children.each do |path|
        next unless path.file? && path.executable?
        bin.install_symlink path
      end
    end

    if (libexec/"build_dict.sh").exist?
      (bin/"ddk-build").write <<~EOS
        #!/bin/bash
        exec "#{libexec}/build_dict.sh" "$@"
      EOS
      (bin/"ddk-build").chmod 0755
    end
  end

  test do
    assert_predicate Pathname("#{HOMEBREW_PREFIX}/opt/#{name}/libexec"), :directory?
  end
end
