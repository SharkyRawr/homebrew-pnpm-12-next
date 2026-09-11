class PnpmAT12 < Formula
  desc "Fast, disk space efficient package manager"
  homepage "https://pnpm.io/"
  url "https://registry.npmjs.org/pnpm/-/pnpm-12.4.1.tgz"
  sha256 "6276298e9af576b7a7f5e9044bfafbe2678209250cd10b1705ea5d3aa64d4882"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/pnpm/next-12"
    strategy :json do |json|
      json["version"]
    end
  end

  keg_only :versioned_formula

  depends_on "node" => [:build, :test]

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false), "--min-release-age=0"
    bin.install_symlink libexec.glob("bin/*")

    generate_completions_from_executable(bin/"pnpm", "completion")
  end

  def caveats
    <<~EOS
      pnpm requires a Node installation to function. You can install one with:
        brew install node
    EOS
  end

  test do
    system bin/"pnpm", "init"
    assert_path_exists testpath/"package.json", "package.json must exist"
  end
end
