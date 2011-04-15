namespace :erb do
  namespace :to do
    desc "Convert all .html.erb files to .html.haml"
    task :haml do
      files = `find . -iname *.html.erb`
      files.each_line do |file|
        file.strip!
        `bundle exec html2haml #{file} | cat > #{file.gsub(/\.erb$/, ".haml")}`
        `rm #{file}`
      end
    end
  end
end

namespace :html do
  namespace :to do
    desc "Convert all .html files to .html.haml"
    task :haml do
      files = `find . -iname *.html`
      files.each_line do |file|
        file.strip!
        `bundle exec html2haml #{file} | cat > #{file.gsub(/\.html$/, ".html.haml")}`
        `rm #{file}`
      end
    end
  end
end
