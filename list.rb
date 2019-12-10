require 'octokit'

repo = "onestlatech/onestlatech.github.io"

client = Octokit::Client.new(:access_token => '<access_token>', per_page: 100)
issues = client.list_issues(repo, :labels => 'signature')

issues.each do |issue|
    puts "* " + issue.title + " - " + issue.body
end
