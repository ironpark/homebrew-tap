# Written by the release workflow of github.com/ironpark/gvx-desktop; edits
# made here are overwritten by the next release.
cask "gvx-desktop" do
  version "0.3.0"
  sha256 "e01baf1884a44324f0293ab299934b36347d8cff725f1cb8e2f5c88c08e6d607"

  url "https://github.com/ironpark/gvx-desktop/releases/download/v#{version}/gvx-desktop-#{version}-macos-arm64.dmg"
  name "GVX Desktop"
  desc "Run and manage gvx sandboxes: Linux containers with no VM or daemon"
  homepage "https://github.com/ironpark/gvx-desktop"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "GVX Desktop.app"

  zap trash: "~/Library/Application Support/gvx-desktop"

  # The app is signed ad hoc, not with an Apple Developer ID: macOS would
  # refuse to open it while it carries the quarantine of a download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GVX Desktop.app"]
  end
end
