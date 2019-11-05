class User < Hanami::Entity
  def gender
    sex ? 'women' : 'man'
  end
end
