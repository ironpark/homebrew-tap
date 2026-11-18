# typed: false
# frozen_string_literal: true

# Written by the release workflow of github.com/ironpark/ggui; edits made
# here are overwritten by the next release.
class Ggui < Formula
  desc "Create, run, check and bundle ggui applications"
  homepage "https://github.com/ironpark/ggui"
  url "https://proxy.golang.org/github.com/ironpark/ggui/cmd/ggui/@v/v0.6.0.zip"
  version "0.6.0"
  sha256 "4675a1408a144c4cea762d1b9dd2f778ff5ffc8bcdb8a5863a23d2e481c9e504"
  license "Apache-2.0"

  depends_on "go"

  def install
    # The module zip holds the module below its path and version.
    cd "ironpark/ggui/cmd/ggui@v#{version}" do
      ENV["GOWORK"] = "off"
      # Built as the release binaries are: on macOS without cgo, since
      # ggui signs there with Apple's tools; on Linux with cgo and
      # Homebrew's compiler, which links zapp's rcodesign library, so
      # that ggui signs and notarizes macOS apps there too.
      ENV["CGO_ENABLED"] = OS.mac? ? "0" : "1"
      system "go", "build", *std_go_args(ldflags: "-s -w -X main.releaseVersion=v#{version}")
    end
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ggui version")
    system bin/"ggui", "help"
  end
end
