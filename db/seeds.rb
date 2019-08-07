# frozen_string_literal: true

%w[Pessoal Comercial Residencial].each do |kind|
  Kind.create!(description: kind) if Kind.find_by(description: kind).blank?
end
