class Contact < ApplicationRecord
  def author
    'ramonsantos'
  end

  def as_json(options = {})
    super(methods: :author, root: true)
  end
end
