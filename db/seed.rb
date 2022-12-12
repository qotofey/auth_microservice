def load_seed_file(seed)
  puts seed
  load seed
end

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each { |full_path| load_seed_file(full_path) }