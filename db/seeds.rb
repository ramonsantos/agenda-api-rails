# Create Kinds

['Pessoal', 'Comercial'].each do |kind|
  Kind.create!(description: kind) if Kind.find_by(description: kind).blank?
end
