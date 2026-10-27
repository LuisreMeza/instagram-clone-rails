module ApplicationHelper
  # Retorna un Gravatar basado en el email del usuario
  def gravatar_for(user, options = { size: 80 })
    require 'digest' # Aseguramos que la librería MD5 esté disponible
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
end