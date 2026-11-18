# typed: false
# frozen_string_literal: true

# Written by the release workflow of github.com/ironpark/ggui; edits made
# here are overwritten by the next release.
class Ggui < Formula
  desc "Create, run, check and bundle ggui applications"
  homepage "https://github.com/ironpark/ggui"
  url "https://proxy.golang.org/github.com/ironpark/ggui/cmd/ggui/@v/v0.3.1.zip"
  version "0.3.1"
  sha256 "4153a18d7af80b29e37af30f6074073abac9000c464f1c0b3b5c3d7cefb48cbc"
  license "Apache-2.0"

  depends_on "go"

  def install
    # The module zip holds the module below its path and version.
    cd "ironpark/ggui/cmd/ggui@v#{version}" do
      ENV["GOWORK"] = "off"
      # Built as the release binaries are; the command needs no cgo.
      ENV["CGO_ENABLED"] = "0"
      system "go", "build", *std_go_args(ldflags: "-s -w -X main.releaseVersion=v#{version}")
    end
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ggui version")
    system bin/"ggui", "help"
  end
end
