# Template for Casks/tozap-remote.rb when releases are ad-hoc signed and NOT notarized
# (ZAP_RELEASE_MODE=adhoc). to.zap's scripts/release.sh fills in the version and the SHA-256 of
# the published release archive; never edit those values by hand. The caveats explain Apple's own approval step; this cask
# never removes the quarantine attribute or bypasses Gatekeeper.
cask "tozap-remote" do
  version "1.0.0"
  sha256 "15f6a7d7357f1c834e960a3cb52a9e25aea11f175944f4a2f3ef8f52ddc339e2"

  url "https://github.com/skiliz/tozap/releases/download/v#{version}/tozap-#{version}.zip"
  name "to.zap"
  desc "Menu bar remote for Fire TV devices"
  homepage "https://github.com/skiliz/tozap"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "to.zap.app"

  # Only with `brew uninstall --zap`: removes the pairing and preferences. Ordinary upgrades keep them.
  zap trash: [
    "~/Library/Application Support/to.zap",
    "~/Library/Preferences/local.tozap.app.plist",
  ]

  caveats <<~EOS
    to.zap is free, open-source software. It is not signed with an Apple Developer ID
    or notarized by Apple, so macOS blocks it the first time it opens and again
    after each upgrade. To allow it:
      1. Open to.zap from Applications and click Done in the warning
         (on macOS 14 Sonoma: click Cancel, or Control-click the app and choose Open).
      2. Within about an hour, open System Settings > Privacy & Security,
         click "Open Anyway" under Security and enter your login password.
      3. Click Open to confirm.
    After an upgrade macOS may also ask again for Microphone, Speech Recognition
    and Local Network access.
  EOS
end
