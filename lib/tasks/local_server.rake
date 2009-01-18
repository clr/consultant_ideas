desc "Restart the local dev server."
task :restart do
  `touch #{RAILS_ROOT}/tmp/restart.txt`
end

