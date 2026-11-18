# typed: false
# frozen_string_literal: true

# Written by the release workflow of github.com/ironpark/ggui; edits made
# here are overwritten by the next release.
class Ggui < Formula
  desc "Create, run, check and bundle ggui applications"
  homepage "https://github.com/ironpark/ggui"
  url "https://proxy.golang.org/github.com/ironpark/ggui/cmd/ggui/@v/v0.4.0.zip"
  version "0.4.0"
  sha256 "8b78a5452da7577b7e40cde3eeb18fbb0e8fb538c4a75def4227fe9082b811fa"
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
