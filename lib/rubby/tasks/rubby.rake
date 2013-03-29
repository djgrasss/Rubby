require 'rubby'

namespace :rubby do
  rule '.rb' => ['.rbb'] do |t|
    puts "#{t.source} => #{t.name}"
    Rubby.transpile_file(t.source, t.name, ENV['TARGET_RUBY'] || Rubby::TargetVersion.new.to_s)
  end

  task :transpile => Dir.glob('**/*.rbb').map { |f| f.gsub(/\.rbb$/, '.rb') }
end
