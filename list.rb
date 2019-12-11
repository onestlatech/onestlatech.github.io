require 'octokit'

repo = "onestlatech/onestlatech.github.io"

content = File.read("content/_index.md", :encoding => "UTF-8")

client = Octokit::Client.new(:access_token => ENV["GITHUB_TOKEN"], per_page: 100)
issues = client.list_issues(repo, :labels => "signature")

newSignatues = ""
issues.each do |issue|
    puts "Closing " << issue.title << " - " << issue.body
    if issue.body == ""
        newSignatues << "* " << issue.title << "\n"
    else
        newSignatues << "* " << issue.body << "\n"
    end
    client.close_issue(repo, issue.number)
end

regex = /### Actrices et acteurs du numérique\n\n(.*)\n\n### Organisations/m
signatures = content.match(regex)[1]
signatures << "\n" << newSignatues

def sort_markdown(a)
    if a[0..2] == "* ["
        return a[3..].downcase
    end

    a[2..].downcase
end

signatures = signatures.split("\n").uniq.sort_by!{ |a| sort_markdown(a) }.join("\n") << "\n"

content.sub!(regex, "### Actrices et acteurs du numérique\n\n" << signatures << "\n### Organisations")
File.open("content/_index.md", "w") {|file| file.puts content}
