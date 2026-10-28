class Post < ApplicationRecord
  belongs_to :user

  # Configuración de Paperclip (según tu guía)
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  # Validaciones del Punto 20.3 y Punto 2 de tu tarea
  validates :description, presence: { message: "no puede estar vacía" }
  validates :description, length: { minimum: 10, message: "debe tener al menos 10 caracteres" }

  has_many :likes, dependent: :destroy
end