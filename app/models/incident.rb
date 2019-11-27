class Incident < ApplicationRecord
  CATEGORIES = ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]

  belongs_to :flat
  has_one :user, through: :flat
  has_many :works

  validates :dispo, presence: true
  validates :category, presence: true, inclusion: { in: ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"] }

  DICTIONNAIRE = {
    P: {
      content: "plomberie",
      icone: "plomberie.jpg",
      P1: {
        content: "plomberie",
        icone: '',
        P11: {},
        P12: {},
        P13: { response: "PLOMBIER TOTO 300€"}
      },
      P2: {
        content: "plomberie",
        icone: "plomberie.jpg",
        P21: {},
        P22: {},
        P23: {}
      },
      P3: {
        content: "plomberie",
        icone: "plomberie.jpg",
        P31: {},
        P32: {},
        P33: {}
      }
    },
    E: { content: "plomberie", icone: "plomberie.jpg" },
    V: { content: "cuisine?", icone: "plomberie.jpg" },
    S: { content: "salle-de-bain", icone: "plomberie.jpg" }
  }
end
