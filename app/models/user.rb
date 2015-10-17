class User
  include ActiveModel::Validations

  attr_accessor :name, :key

  validates :name,
            presence:     true,
            length:       { maximum: 255 }

  validates :key,
            presence:     true

  # Public: Constructor.
  #
  # key  - the String name.
  # key  - the Integer key.
  def initialize(name: nil, key: nil)
    @name = name
    @key  = key
  end

  # Public: Get the user name.
  #
  # Returns String name.
  def to_s
    name
  end

end
