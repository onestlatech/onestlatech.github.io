require 'octokit'

repo = "onestlatech/onestlatech.github.io"

content = File.read("content/_index.md", :encoding => "UTF-8")

client = Octokit::Client.new(:access_token => ENV["GITHUB_TOKEN"], per_page: 100)
issues = client.list_issues(repo, :labels => "signature")

newSignatures = ""
issues.each do |issue|
    puts "Closing " << issue.title << " - " << issue.body
    if issue.body == ""
        newSignatures << "* " << issue.title << "\n"
    else
        newSignatures << "* " << issue.body << "\n"
    end
    client.close_issue(repo, issue.number)
end

regex = /### Actrices et acteurs du numérique\n\n(.*)\n\n### Organisations/m
signatures = content.match(regex)[1]
signatures << "\n" << newSignatures

def sort_markdown(a)
    if a.length < 3
        return a
    end

    if a[0..2] == "* ["
        return a[3..].downcase
    end

    a[2..].downcase
end

signatures = signatures.split("\n").reject(&:empty?).uniq.sort_by!{ |a| sort_markdown(a) }.join("\n") << "\n"

content.sub!(regex, "### Actrices et acteurs du numérique\n\n" << signatures << "\n### Organisations")
File.open("content/_index.md", "w") {|file| file.puts content}
