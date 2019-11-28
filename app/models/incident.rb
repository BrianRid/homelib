class Incident < ApplicationRecord
  CATEGORIES = ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]

  attr_accessor :answer

  belongs_to :flat
  has_one :user, through: :flat
  has_many :works

  validates :dispo, presence: true
  validates :category, presence: true, inclusion: { in: ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"] }

  # DICTIONNAIRE = {
  # P: { content: "plomberie", question: "Votre problème concerne ?", reponses: [:P1, :P2] }
  # P1: { reponse: "WC", question: "Quelle est la nature de votre problème ?", reponses: [:P11, :P12] }
  #   P11: { reponse: "Fuite", question: "D’où coule l’eau ?", responses: [:P111, :P112, :P113, :P114] }
  #     P111: { reponse: "Près du robinet d’arrêt" }
  #       P1111: { reponse: "Réparation d'une fuite du robinet d'arrêt du WC", tarif: "Entre 100 et 150 € TTC", responsable: "Propriétaire" }
  #     P112: { reponse: "Près de la pipe de sortie", question: "Avez vous un saniboyeur ?" }
  #       P1121: { reponse: "Oui" }
  #         P11211: { reponse: "Réparation d'une fuite de la pipe de sortie du WC avec sanibroyeur", tarif: "Entre 120 € et 200 € TTC", responsable: "Propriétaire" }
  #       P1122: { reponse: "Non" }
  #         P11221: { reponse: "Réparation d'une fuite de la pipe de sortie du WC sans sanibroyeur", tarif: "Entre 120 € et 200 € TTC", responsable: "Propriétaire" }
  #     P113: { reponse: "Socle" }
  #       P1131:{ reponse: "Scellement WC", tarif: "Entre 100 € et 200 € TTC", responsable: "Propriétaire" }
  #     P114: { reponse: "Entre la cuvette et le réservoir"}
  #       P1141: { reponse: "Réparation d'une fuite entre la cuvette et le réservoir du WC", tarif: "Entre 100 € et 200 € TTC", responsable: "Propriétaire" }

  #   P12: { reponse: "Engorgement", question: "Avez vous un saniboyeur ?" }
  #     P121: { reponse: "Oui" }
  #       P1211: { reponse: "Débouchage de WC avec sanibroyeur", tarif: "Entre 150 € et 250 € TTC", responsable: "Locataire" }
  #     P122: { reponse: "Non"}
  #       P1221: { reponse: "Débouchage de WC sans sanibroyeur", tarif: "Entre 100 € et 180 € TTC", responsable: "Locataire" }

  # # P2: { reponse: "salle de bain", question: "Quelle est la nature de votre problème ?" }
    # P21: { reponse: "Fuite", question: "D’où coule l’eau ?" }
    #   P211: { reponse: "Du robinet"}
    #     P2111: { reponse: "Fourniture et pose d'un robinet", tarif: "Entre 150 € et 350 € TTC", responsable: "Propriétaire" }
    #   P212: { reponse: "Du tuyau d'évacuation (sous la douche)"}
    #   P2121: { reponse: "Réparation d'une fuite du tuyau d'évacuation de la douche", tarif: "Entre 100 € et 200 € TTC", responsable: "Propriétaire" }
    # P22: { reponse: "Engorgement" }
    #   P221: { reponse: "Débouchage de douche", tarif: "Entre 100 € et 200 € TTC", responsable: "Locataire" }



  # }

  TREE = {
    # categories
    p: {
      label: "Plomberie",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:p_1, :p_2],
      final_answer: nil
    },
    v: {
      label: "Vitrerie",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:v_1, :v_2],
      final_answer: nil
    },

    # Plomberie
    p_1: {
      label: "WC",
      next_question: "Quelle est la nature de votre problème ?",
      next_question_answers: [:p_1_1, :p_1_2],
      final_answer: nil
    },
    p_2: {
      label: "Salle de bain (douche, baignoir)",
      next_question: "Quelle est la nature de votre problème ?",
      next_question_answers: [:p_2_1, :p_2_2],
      final_answer: nil
    },
    P3: {
      label: "Tuyauterie et canalisation (hors wc, douche, evier, machines)"
      next_question: "Vous avez une fuite au niveau:",
      next_question_answers: [:p_3_1, :p_3_2, :p_3_3],
      final_answer: nil
    },

    P4: {
      label: "Cuisine",
      next_question: "Vous avez une fuite au niveau:",
      next_question_answers: [:p_3_1, :p_3_2, :p_3_3],
      final_answer: nil
    },

    P5: { reponse: "Colonne générale d'immeuble" },
    P6: { reponse: "Chaudière, chauffe-eau et ballon d'eau chaude" },
    p7: { reponse: "Autres" },


    # plomberie - WC
    p_1_1: {
      label: "Fuite",
      next_question: "D'ou coule l'eau",
      next_question_answers: [:p_1_1_1, :p_1_1_2, :p_1_1_3, :p_1_1_4],
      final_answer: nil
    },
    p_1_2: {
      label: "Engorgement",
      next_question: "Avez vous un saniboyeur ?",
      next_question_answers: [:p_1_2_1, :p_1_2_2],
      final_answer: nil
    },

    # wc - fuite
    p_1_1_1: {
      label: "Près du robinet d’arrêt",
      final_answer: {
        result: "Réparation d'une fuite du robinet d'arrêt du WC",
        tarif: "Entre 100 et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_1_1_2: {
      label: "Près de la pipe de sortie",
      next_question: "Avez vous un saniboyeur ?",
      next_question_answers: [:p_1_1_2_1, :p_1_1_2_2],
      final_answer: nil
    },
    p_1_1_2_1: {
      label: "Oui",
      final_answer: {
        result: "Réparation d'une fuite de la pipe de sortie du WC avec sanibroyeur",
        tarif: "Entre 120 et 200 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_1_1_2_2: {
      label: "Non",
      final_answer: {
        result: "Réparation d'une fuite de la pipe de sortie du WC sans sanibroyeur",
        tarif: "Entre 120 et 200 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_1_1_3: {
      label: "Socle",
      final_answer: {
        result: "Réparation d'une fuite du robinet d'arrêt du WC",
        tarif: "Entre 100 et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_1_1_4: {
      label: "Entre la cuvette et le réservoir",
      final_answer: {
        result: "Réparation d'une fuite du robinet d'arrêt du WC",
        tarif: "Entre 100 et 150 € TTC",
        responsable: "Propriétaire"
      }
    },

    # wc - engorgement
    p_1_2_1: {
      label: "Oui",
      final_answer: {
        result: "Débouchage de WC avec sanibroyeur",
        tarif: "Entre 150 et 250 € TTC",
        responsable: "Locataire"
      }
    },
    p_1_2_2: {
      label: "Non",
      final_answer: {
        result: "Débouchage de WC sans sanibroyeur",
        tarif: "Entre 100 et 180 € TTC",
        responsable: "Locataire"
      }
    },

    # plomberie - sdb
    p_2_1: {
      label: "Fuite",
      next_question: "D’où coule l’eau ?",
      next_question_answers: [:p_2_1_1, :p_2_1_2],
      final_answer: nil
    },
    p_2_2: {
      label: "Engorgement de douche ou baignoire",
      final_answer: {
        result: "Débouchage de douche ou de baignoire",
        tarif: "Entre 100 et 200 € TTC",
        responsable: "Locataire"
      }
    },

    #plomberie - tuyauterie
    p_3_1: {
      label: "D'un tuyau d'évacuation (tuyau PVC)",
      final_answer: {
        result: "Réparation d'une fuite du tuyau d'évacuation",
        tarif: "Entre 150 et 200 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_3_2: {
      label: "De la vanne d'entrée (la vanne qui coupe l'eau dans l'appartement)",
      final_answer: {
        result: "Réparation d'une fuite de la vanne principale de l'appartement ou avant la vanne",
        tarif: "Entre 150 et 300 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_3_3: {
      label: "D'un autre tuyau",
      final_answer: {
        result: "Réparation d'une fuite du tuyau après la vanne principale de l'appartement",
        tarif: "Entre 120 et 200 € TTC",
        responsable: "Propriétaire"
      }
    },

    # plomberie - cuisine
    p_4_1: {
      label: "Fuite/robinetterie",
      final_answer: {
        result: "Fourniture et pose d'un robinet",
        tarif: "Entre 150 € et 350 € TTC",
        responsable: "Propriétaire"
      }
    },

    # cuisine - evier/lavabo
    p_4_1: {
      label: "Autour du robinet",
      next_question: "D’où coule l’eau ?",
      next_question_answers: [:p_4_1_1, :p_4_1_2, :p4_1_3, p:4_1_4],
      final_answer: nil
    },

    p_4_2: {
      label: "Engorgement de douche ou baignoire",
      final_answer: {
        result: "Débouchage de douche ou de baignoire",
        tarif: "Entre 100 et 200 € TTC",
        responsable: "Locataire"
      }
    },

    # sdb - fuite
    p_2_1_1: {
      label: "Du robinet",
      final_answer: {
        result: "Fourniture et pose d'un robinet",
        tarif: "Entre 150 € et 350 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_2_1_2: {
      label: "Du tuyau d'évacuation (sous la douche)",
      final_answer: {
        result: "Réparation d'une fuite du tuyau d'évacuation de la douche",
        tarif: "Entre 100 € et 200 € TTC",
        responsable: "Propriétaire"
      }
  }






  def self.first_decision
    question = "Voulez-vous déclarer un incident ?"
    answers = TREE.select{ |k,v| k.to_s.size == 1 }.map{ |k,v| [v[:label], k] }
    return {
      question: question,
      answers: answers
    }
  end

  def self.next_decision(tree_key)
    current_answer = TREE[tree_key]
    question = current_answer[:next_question]
    answers = current_answer[:next_question_answers].map{ |key| [TREE[key][:label], key] }
    return {
      question: question,
      answers: answers
    }
  end








end
