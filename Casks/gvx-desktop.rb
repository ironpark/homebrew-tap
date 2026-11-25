# Written by the release workflow of github.com/ironpark/gvx-desktop; edits
# made here are overwritten by the next release.
cask "gvx-desktop" do
  version "0.11.0"
  sha256 "8330c9a0c34e79f6d679244aa037a79004223bbd6866fd186e34edfc62f90a56"

  url "https://github.com/ironpark/gvx-desktop/releases/download/v#{version}/gvx-desktop-#{version}-macos-arm64.dmg"
  name "GVX Desktop"
  desc "Run and manage gvx sandboxes: Linux containers with no VM or daemon"
  homepage "https://github.com/ironpark/gvx-desktop"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "GVX Desktop.app"

  # The app is signed ad hoc, not with an Apple Developer ID: macOS would
  # refuse to open it while it carries the quarantine of a download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GVX Desktop.app"]
  end

  # Quit the running app before an upgrade or uninstall replaces it, so the
  # old version does not keep running from the replaced bundle. The app stops
  # its sandboxes as it quits (or asks first, as its settings say), and
  # Homebrew opens the new version again after an upgrade.
  uninstall quit: "io.github.ironpark.gvx-desktop"

  zap trash: "~/Library/Application Support/gvx-desktop"
end
