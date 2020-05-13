class NavbarComponent < ApplicationComponent
  private

  def sheets
    {
      "Bounties": {image: "tophat/gitcoin-symbol.svg", alt: "Gitcoin symbol", url: "https://gitcoin.co", color: "29086a", top: 4, left: 5},
      "Grants": {image: "tophat/grants-symbol.svg", alt: "Grants symbol", url: "https://gitcoin.co/grants", color: "00a55e", top: 8, left: 6},
      "Quests": {image: "tophat/quests-symbol.svg", alt: "Quests symbol", url: "https://gitcoin.co/quests", color: "ffffff", top: 4, left: 5},
      "Kudos": {image: "tophat/kudos-symbol.svg", alt: "Kudos symbol", url: "https://gitcoin.co/kudos", color: "3e00ff", top: 4, left: 5},
      "Hackathons": {image: "tophat/gitcoin-symbol.svg", alt: "Gitcoin Hackathon symbold", url: "https://gitcoin.co/hackathons", color: "55508e", top: 4, left: 5},
      "BYS": {image: "tophat/back-your-stack-logo.svg", alt: "Back Your Stack symbol", url: "https://backyourstack.com/?utm_source=codefund", color: "ffffff", top: 7, left: 7, height: "auto"}
    }
  end

  def unopened_emails
    @unopened_emails ||= current_user.unopened_emails
  end

  def unopened_emails_count
    unopened_emails&.count || 0
  end
end
