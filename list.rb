require 'octokit'

repo = "onestlatech/onestlatech.github.io"

client = Octokit::Client.new(:access_token => ENV["GITHUB_TOKEN"], per_page: 100)
issues = client.list_issues(repo, :labels => 'signature')

issues.each do |issue|
    puts "* " + issue.body
    client.close_issue(repo, issue.number)
end
