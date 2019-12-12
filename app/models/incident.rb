class Incident < ApplicationRecord
  CATEGORIES = ["plomberie", "électricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"]

  attr_accessor :answer
  has_many_attached :photos
  belongs_to :flat
  has_one :user, through: :flat
  has_many :works

  validates :category, presence: true, inclusion: { in: ["plomberie", "electricité", "serrurerie", "chauffage", "vitrerie", "petits travaux", "jardinage", "peinture", "sols", "électroménager"] }

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
    return nil if question.nil?
    answers = current_answer[:next_question_answers]&.map{ |key| [TREE[key][:label], key] }
    return {
      question: question,
      answers: answers
    }
  end

  def self.final_result(tree_key)
    TREE[tree_key]
  end

  def self.resume(tree_key)
    splitted_key = tree_key.to_s.split("_")
    splitted_key.map.with_index do |el, index|
      splitted_key[0..index].join("_").to_sym
    end
  end

  def self.category(tree_key)
    TREE[tree_key][:label].downcase
  end

  TREE = {
    # categories
    v: {
      label: "Vitrerie",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:v_1, :v_2, :v_3],
      final_answer: nil
    },
    e: {
      label: "Electricité",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:e_1, :e_2, :e_3, :e_4, :e_5, :e_6],
      final_answer: nil
    },
    p: {
      label: "Plomberie",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:p_1, :p_2, :p_3, :p_4, :p_6, :p_7],
      final_answer: nil
    },
    s: {
      label: "Serrurerie",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:e_1, :_2],
      final_answer: nil
    },
    c: {
      label: "Chauffage",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:e_1, :_2],
      final_answer: nil
    },
    t: {
      label: "Autres",
      next_question: "Votre problème concerne ?",
      next_question_answers: [:e_1, :_2],
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
      label: "Salle de bain (douche, baignoire)",
      next_question: "Quelle est la nature de votre problème ?",
      next_question_answers: [:p_2_1, :p_2_2],
      final_answer: nil
    },
    p_3: {
      label: "Tuyauterie et canalisation (hors wc, douche, évier, machines)",
      next_question: "Vous avez une fuite au niveau :",
      next_question_answers: [:p_3_1, :p_3_2, :p_3_3],
      final_answer: nil
    },
    p_4: {
      label: "Cuisine",
      next_question: "Quelle est la nature de votre problème ?",
      next_question_answers: [:p_4_1, :p_3_2],
      final_answer: nil
    },
    p_6: {
      label: "Chaudière, chauffe-eau et ballon d'eau chaude",
      next_question: "Quel est votre besoin ?",
      next_question_answers: [:p_6_1, :p_6_2],
      final_answer: nil
    },
    p_7: {
      label: "Tuyau de la machine à laver ou du lave-vaisselle",
      final_answer: {
        result: "Réparation d'une fuite du tuyau de la machine à laver / lave-vaisselle",
        tarif: "Entre 130 € et 150 € TTC",
        responsable: "Locataire"
      }
    },

    # plomberie - WC
    p_1_1: {
      label: "Fuite",
      next_question: "D'où coule l'eau ?",
      next_question_answers: [:p_1_1_1, :p_1_1_2, :p_1_1_3, :p_1_1_4],
      final_answer: nil
    },
    p_1_2: {
      label: "Engorgement",
      next_question: "Avez-vous un saniboyeur ?",
      next_question_answers: [:p_1_2_1, :p_1_2_2],
      final_answer: nil
    },

    # wc - fuite
    p_1_1_1: {
      label: "Près du robinet d’arrêt",
      final_answer: {
        result: "Réparation d'une fuite du robinet d'arrêt du WC",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire",
        # resume: [:p, :p_1, :p_1_1, :p_1_1_1]
      }
    },
    p_1_1_2: {
      label: "Près de la pipe de sortie",
      next_question: "Avez-vous un saniboyeur ?",
      next_question_answers: [:p_1_1_2_1, :p_1_1_2_2],
      final_answer: nil
    },
    p_1_1_2_1: {
      label: "Oui",
      final_answer: {
        result: "Réparation d'une fuite de la pipe de sortie du WC avec sanibroyeur",
        tarif: "Entre 120 € et 200 € TTC",
        responsable: "Propriétaire",
        # resume: [:p, :p_1, :p_1_1, :p_1_1_2, :p_1_1_2_1]
      }
    },
    p_1_1_2_2: {
      label: "Non",
      final_answer: {
        result: "Réparation d'une fuite de la pipe de sortie du WC sans sanibroyeur",
        tarif: "Entre 120 € et 200 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_1_1_3: {
      label: "Socle",
      final_answer: {
        result: "Réparation d'une fuite du robinet d'arrêt du WC",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    p_1_1_4: {
      label: "Entre la cuvette et le réservoir",
      final_answer: {
        result: "Réparation d'une fuite du robinet d'arrêt du WC",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },

    # wc - engorgement
    p_1_2_1: {
      label: "Oui",
      final_answer: {
        result: "Débouchage de WC avec sanibroyeur",
        tarif: "Entre 150 € et 250 € TTC",
        responsable: "Locataire"
      }
    },
    p_1_2_2: {
      label: "Non",
      final_answer: {
        result: "Débouchage de WC sans sanibroyeur",
        tarif: "Entre 100 € et 180 € TTC",
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
      label: "Engorgement de douche ou de baignoire",
      final_answer: {
        result: "Débouchage de douche ou de baignoire",
        tarif: "Entre 100€ et 200€ TTC",
        responsable: "Locataire"
      }
    },

    #plomberie - tuyauterie
    p_3_1: {
      label: "D'un tuyau d'évacuation (tuyau PVC)",
      final_answer: {
        result: "Réparation d'une fuite du tuyau d'évacuation",
        tarif: "Entre 150€ et 200€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_3_2: {
      label: "De la vanne d'entrée (la vanne qui coupe l'eau dans l'appartement)",
      final_answer: {
        result: "Réparation d'une fuite de la vanne principale de l'appartement ou avant la vanne",
        tarif: "Entre 150€ et 300€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_3_3: {
      label: "D'un autre tuyau",
      final_answer: {
        result: "Réparation d'une fuite du tuyau après la vanne principale de l'appartement",
        tarif: "Entre 120€ et 200€ TTC",
        responsable: "Propriétaire"
      }
    },

    # plomberie - cuisine
    p_4_1: {
      label: "Fuite/robinetterie",
      next_question: "Votre lavabo possède-t-il un sanispeed ?",
      next_question_answers: [:p_4_1_1, :p_4_1_2, :p_4_1_3, :p_4_1_4],
      final_answer: nil
    },
    p_4_2: {
      label: "Engorgement (lavabo/ évier bouché)",
      next_question: "Votre lavabo possède-t-il un sanispeed ?",
      next_question_answers: [:p_4_2_1, :p_4_2_2],
      final_answer: nil
    },

    #plomberie - chaudiere
    p_6_1: {
      label: "Reparation d'une panne de chauffage",
      next_question: "Votre appareil à chauffer est-il :",
      next_question_answers: [:p_6_1_1, :p_6_1_2],
      final_answer: nil
    },
    p_6_2: {
      label: "Reparation d'une fuite de ballon d'eau chaude",
      final_answer: {
        result: "Réparation d'une fuite du ballon d'eau chaude",
        tarif: "Entre 150€ et 300€ TTC",
        responsable: "Propriétaire"
      }
    },
    # sdb - fuite
    p_2_1_1: {
      label: "Du robinet",final_answer: {
        result: "Fourniture et pose d'un robinet",
        tarif: "Entre 150€ et 350€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_2_1_2: {
      label: "Du tuyau d'évacuation (sous la douche)",
      final_answer: {
        result: "Réparation d'une fuite du tuyau d'évacuation de la douche",
        tarif: "Entre 100€ et 200€ TTC",
        responsable: "Propriétaire"
      }
    },
    # cuisine - evier/lavabo
    p_4_1_1: {
      label: "Directement du robinet",
      final_answer: {
        result: "Fourniture et pose d'un robinet",
        tarif: "Entre 150€ et 300€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_4_1_2: {
      label: "Autour du robinet",
      final_answer: {
        result: "Fourniture et pose d'un robinet",
        tarif: "Entre 150€ et 300€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_4_1_3: {
      label: "Au niveau du flexible",
      final_answer: {
        result: "Changement des flexibles (robinet de lavabo / évier)",
        tarif: "Entre 100€ et 150€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_4_1_4: {
      label: "Au niveau du siphon",
      next_question: "Quel type de siphon possédez-vous ??",
      next_question_answers: [:p_4_1_4_1, :p_4_1_4_2],
      final_answer: nil
    },
    p_4_1_4_1: {
      label: "Siphon en plastique (PVC)",
      final_answer: {
        result: "Changement du siphon (lavabo / évier) en PVC",
        tarif: "Entre 80€ et 150€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_4_1_4_2: {
      label: "Siphon en laiton (métallique)",
      final_answer: {
        result: "Changement du siphon (lavabo / évier) en laiton",
        tarif: "Entre 100€ et 160€ TTC",
        responsable: "Propriétaire"
      }
    },
    p_4_2_1: {
      label: "Oui",
      final_answer: {
        result: "Débouchage d'un lavabo / évier avec sanispeed",
        tarif: "Entre 150€ et 250€ TTC",
        responsable: "Locataire"
      }
    },
    p_4_2_2: {
      label: "Non",
      final_answer: {
        result: "Débouchage d'un lavabo / évier sans sanispeed",
        tarif: "Entre 100€ et 180€ TTC",
        responsable: "Locataire"
      }
    },
    # chaudiere - central/individuel
    p_6_1_1: {
      label: "Central avec le robinet à boisseau",
      final_answer: {
        result: "Réparation du chauffage collectif (avec le robinet à boisseau)",
        tarif: "Entre 150€ et 250€ TTC",
        responsable: "Syndic"
      }
    },
    p_6_1_2: {
      label: "Individuel",
      final_answer: {
        result: "Réparation d'une chaudière à gaz ou électrique en fonction de la marque",
        tarif: "Entre 180€ et 260€ TTC",
        responsable: "Propriétaire"
      }
    },

    ################ VITRERIE #############################
    v_1: {
      label: "Vitre cassée",
      next_question: "Quel type de vitrage a été cassé ?",
      next_question_answers: [:v_1_1, :v_1_2, :v_1_3, :v_1_4],
      final_answer: nil
    },
    v_2: {
      label: "Fenêtre à remplacer",
      next_question: "Quel type de fenêtre préférez-vous ?",
      next_question_answers: [:v_2_1, :v_2_2, :v_2_3, :v_2_4],
      final_answer: nil
    },
    v_3: {
      label: "Autre",
      next_question: "Quel est votre besoin ?",
      next_question_answers: [:v_3_1, :v_3_2, :v_3_3, :v_3_4, :v_3_5],
      final_answer: nil
    },
    # vitrerie - Vitre cassee => Avec final answer
    v_1_1: {
      label: "Simple vitrage",
      final_answer: {
        result: "Changement de vitre cassée Simple Vitrage",
        tarif: "Entre 150 € et 300 € TTC",
        responsable: "Locataire"
      }
    },
    v_1_2: {
      label: "Double vitrage",
      final_answer: {
        result: "Changement de vitre cassée Double Vitrage",
        tarif: "Entre 150 € et 500 € TTC",
        responsable: "Locataire"
      }
    },
    v_1_3: {
      label: "Survitrage",
      final_answer: {
        result: "Changement de vitre cassée Survitrage",
        tarif: "Entre 150 € et 400 € TTC",
        responsable: "Locataire"
      }
    },
    v_1_4: {
      label: "Autre",
      final_answer: {
        result: "Changement de vitre cassée type inconnu",
        tarif: "Entre 200 € et 500 € TTC",
        responsable: "Locataire"
      }
    },

    # vitrerie - Fenetre a remplacer => Avec final answer
    v_2_1: {
      label: "En bois",
      final_answer: {
        result: "Fourniture et pose d'une fenêtre en bois",
        tarif: "Entre 650 € et 1000 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_2_2: {
      label: "En PVC",
      final_answer: {
        result: "Fourniture et pose d'une fenêtre en PVC",
        tarif: "Entre 500 € et 800 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_2_3: {
      label: "En aluminum",
      final_answer: {
        result: "Fourniture et pose d'une fenêtre en aluminium",
        tarif: "Entre 800 € et 1300 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_2_4: {
      label: "Autre",
      final_answer: {
        result: "Fourniture et pose d'une fenêtre autres matériaux",
        tarif: "Entre 500 € et 1400 € TTC",
        responsable: "Propriétaire"
      }
    },

    # vitrerie - Autre besoin => Avec final answer
    v_3_1: {
      label: "Des joins à remplacer",
      final_answer: {
        result: "Changement de joints de vitre",
        tarif: "Entre 150 € et 300 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_3_2: {
      label: "Un trou à percer pour la climatisation",
      final_answer: {
        result: "Perçage d'un trou dans une vitre",
        tarif: "Entre 100 € et 250 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_3_3: {
      label: "Problème d'un fenêtre de toit (velux)",
      final_answer: {
        result: "Problème lié à une fenêtre de toit",
        tarif: "Entre 200 € et 500 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_3_4: {
      label: "Poignée (crémone) à remplacer",
      final_answer: {
        result: "Remplacement d'une crémone de fenêtre",
        tarif: "Entre 150 € et 250 € TTC",
        responsable: "Propriétaire"
      }
    },
    v_3_5: {
      label: "Autre",
      final_answer: {
        result: "Problème de vitrerie inconnu",
        tarif: "Entre 150 € et 500 € TTC",
        responsable: "Propriétaire ou Locataire"
      }
    },

    ################ ELECTRICITE #############################
    e_1: {
      label: "Prise électrique",
      next_question: "De quel type de prise s'agit-il ?",
      next_question_answers: [:e_1_1, :e_1_2, :e_1_3, :e_1_4],
      final_answer: nil
    },
    e_2: {
      label: "Lumière",
      next_question: "Combien de pièces sont concernées par la panne ?",
      next_question_answers: [:e_2_1, :e_2_2],
      final_answer: nil
    },
    e_3: {
      label: "Radiateur, convecteur, sèche serviette",
      next_question: "Vous avez besoin de :",
      next_question_answers: [:e_3_1, :e_3_2, :e_3_3],
      final_answer: nil
    },
    e_4: {
      label: "Chaudière, chauffe eau ou ballon d'eau chaude",
      next_question: "Votre problème est lié :",
      next_question_answers: [:e_4_1, :e_4_2, :e_4_3],
      final_answer: nil
    },
    e_5: {
      label: "Tout l'appartement/la maison",
      final_answer: {
        result: "Problème d'électricité dans tout l'appartement",
        tarif: "Entre 100 € et 250 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_6: {
      label: "Autre",
      final_answer: {
        result: "Problème d'électricité inconnu",
        tarif: "Entre 100 € et 300 € TTC",
        responsable: "Propriétaire ou Locataire"
      }
    },

    # electricite - Prise électrique => Avec final answer
    e_1_1: {
      label: "Une ou plusieurs prises electrique",
      final_answer: {
        result: "Réparation d'une panne d'une ou de plusieurs prises",
        tarif: "Entre 150 € et 250 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_1_2: {
      label: "Prise coaxiale (télévision)",
      final_answer: {
        result: "Réparation d'une panne de prise coaxiale",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_1_3: {
      label: "Prise RJ45 (internet)",
      final_answer: {
        result: "Réparation d'une panne de prise RJ45",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_1_4: {
      label: "Autre",
      final_answer: {
        result: "Problème d'électricité inconnu",
        tarif: "Entre 100 € et 300 € TTC",
        responsable: "Propriétaire ou Locataire"
      }
    },

    # electricite - Lumiere
    e_2_1: {
      label: "Tout l'appartement/la maison",
      final_answer: {
        result: "Réparation d'une panne d'éclairage dans tout l'appartement",
        tarif: "Entre 100 € et 250 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_2_2: {
      label: "Une pièce",
      next_question: "Quel type d’interrupteur possédez-vous ?",
      next_question_answers: [:e_1_2_1, :e_1_2_2, :e_1_2_3, :e_1_2_4],
      final_answer: nil
    },
    # electricite - Lumiere/Une pièce => Avec final answer
    e_1_2_1: {
      label: "Classique",
      final_answer: {
        result: "Remplacement d'un interrupteur classique",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_1_2_2: {
      label: "Va et vient",
      final_answer: {
        result: "Remplacement d'un interrupteur 'va-et-vient'",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_1_2_3: {
      label: "Poussoir",
      final_answer: {
        result: "Remplacement d'un interrupteur poussoir",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_1_2_4: {
      label: "Variateur",
      final_answer: {
        result: "Remplacement d'un interrupteur variateur",
        tarif: "Entre 120 € et 180 € TTC",
        responsable: "Propriétaire"
      }
    },

    # electricite -Radiateur, convecteur, seche serviette => Avec final answer
    e_3_1: {
      label: "Réparation d'un radiateur/convecteur/sèche serviette",
      final_answer: {
        result: "Réparation d'une panne de radiateurs / sèche-serviette électrique",
        tarif: "Entre 180 € et 240 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_3_2: {
      label: "Remplacement d'un radiateur/convecteur/sèche serviette",
      final_answer: {
        result: "Fourniture et pose d'un radiateur électrique ou d'un sèche-serviettes",
        tarif: "Entre 400 € et 550 € TTC",
        responsable: "Propriétaire"
      }
    },
    e_3_3: {
      label: "Installation d'un radiateur/convecteur/sèche serviette",
      final_answer: {
        result: "Pose d'un convecteur/radiateur électrique ou d'un sèche-serviettes",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire"
      }
    },

    # electricite - Chauffage/chaudiere/ballond'eau chaude
    e_4_1: {
      label: "Au chauffage",
      next_question: "Votre problème concerne-t-il :",
      next_question_answers: [:e_4_1_1, :e_4_1_2],
      final_answer: nil
    },
    e_4_2: {
      label: "A l'eau chaude",
      next_question: "Quel appareil utilisez-vous pour chauffer l'eau ?",
      next_question_answers: [:e_4_2_1, :e_4_2_2, :e_4_2_3],
      final_answer: nil
    },
    e_4_3: {
      label: "Au chauffage et à l'eau chaude",
      next_question: "Votre appareil à chauffer est-il :",
      next_question_answers: [:e_4_1_2_1, :e_4_1_2_2],
      final_answer: nil
    },
    # electricite - Chauffage/Radiateur electrique ou chaudiere
    e_4_1_1: {
      label: "Radiateur éléctrique",
      next_question: "Vous avez besoin de :",
      next_question_answers: [:e_3_1, :e_3_2, :e_3_3], # renvoi au reponse chauffage
      final_answer: nil
    },
    e_4_1_2: {
      label: "Chaudière",
      next_question: "Votre appareil à chauffer est-il :",
      next_question_answers: [:e_4_1_2_1, :e_4_1_2_2],
      final_answer: nil
    },

    # electricite - Chauffage/Chaudiere
    e_4_1_2_1: {
      label: "Centrale",
      final_answer: {
        result: "Réparation du chauffage collectif",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2: {
      label: "Individuel",
      next_question: "Vous vous chauffez :",
      next_question_answers: [:e_4_1_2_2_1, :e_4_1_2_2_2, :e_4_1_2_2_3],
      final_answer: nil
    },

    # electricite - Chauffage/chaudiere/indivuduelle
    e_4_1_2_2_1: {
      label: "Au gaz",
      next_question: "Quelle est la marque de votre chaudière ?",
      next_question_answers: [:e_4_1_2_2_1_1, :e_4_1_2_2_1_2, :e_4_1_2_2_1_3, :e_4_1_2_2_1_4, :e_4_1_2_2_1_5, :e_4_1_2_2_1_6],
      final_answer: nil
    },
    e_4_1_2_2_2: {
      label: "A l'éléctricité",
      next_question: "Quelle est la marque de votre chaudière ?",
      next_question_answers: [:e_4_1_2_2_2_1, :e_4_1_2_2_2_3, :e_4_1_2_2_2_6],
      final_answer: nil
    },
    e_4_1_2_2_3: {
      label: "Autre (par exemple au fioul)",
      final_answer: {
        result: "Réparation de chaudière autre qu'au gaz et qu'à l'électricité",
        tarif: "Entre 200 € et 300 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },

    # electricite - Marque de chaudiere :
    e_4_1_2_2_1_1: {
      label: "ELM Leblanc",
      final_answer: {
        result: "Réparation d'une chaudière au gaz de marque ELM le Blanc",
        tarif: "Entre 149 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_2_1: {
      label: "ELM Leblanc",
      final_answer: {
        result: "Réparation d'une chaudière électrique de marque ELM le Blanc",
        tarif: "Entre 180 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_1_2: {
      label: "Frisquet",
      final_answer: {
        result: "Réparation d'une chaudière au gaz de marque Frisquet",
        tarif: "Entre 149 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_1_3: {
      label: "Saunier Duval",
      final_answer: {
        result: "Réparation d'une chaudière au gaz de marque Saunier Duval",
        tarif: "Entre 149 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_2_3: {
      label: "Saunier Duval",
      final_answer: {
        result: "Réparation d'une chaudière électrique de marque Saunier Duval",
        tarif: "Entre 180 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_1_4: {
      label: "Chaffoteaux",
      final_answer: {
        result: "Réparation d'une chaudière au gaz de marque Chaffoteaux",
        tarif: "Entre 169 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_1_5: {
      label: "De Dietrich",
      final_answer: {
        result: "Réparation d'une chaudière au gaz de marque De Dietrich",
        tarif: "Entre 149 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_1_6: {
      label: "Autre",
      final_answer: {
        result: "Réparation d'une chaudière au gaz marque inconnue",
        tarif: "Entre 149 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_1_2_2_2_6: {
      label: "Autre",
      final_answer: {
        result: "Réparation d'une chaudière électrique de marque inconnue",
        tarif: "Entre 180 € et 260 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },

    # electricite - Chauffage/Eau chaude
    e_4_2_1: {
      label: "Chaudière",
      next_question: "Vous avez besoin de :",
      next_question_answers: [:e_4_2_1_1, :e_4_2_1_2],
      final_answer: nil
    },
    e_4_2_2: {
      label: "Ballon d'eau chaude",
      next_question: "Quelle est la marque de votre de ballon d'eau chaude ?",
      next_question_answers: [:e_4_2_2_1, :e_4_2_2_2, :e_4_2_2_3, :e_4_2_2_4, :e_4_2_2_5, :e_4_2_2_6],
      final_answer: nil
    },
    e_4_2_3: {
      label: "Autre",
      final_answer: {
        result: "Réparation d'un appareil de chauffage inconnu",
        tarif: "Entre 180 € et 350 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    # electricite - Chauffage/Ballon d'eau chaude
    e_4_2_1_1: {
      label: "Centrale",
      final_answer: {
        result: "Réparation du chauffage collectif",
        tarif: "Entre 100 € et 150 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_2_1_2: {
      label: "Individuel",
      next_question: "Vous vous chauffez :",
      next_question_answers: [:e_4_1_2_2_1, :e_4_1_2_2_2, :e_4_1_2_2_3],
      final_answer: nil
    },
    # electricite - Marque de Ballon d'eau chaudde :
    e_4_2_2_1: {
      label: "Sauter",
      final_answer: {
        result: "Réparation d'un ballon d'eau chaude électrique de marque Sauter",
        tarif: "Entre 180 € et 300 € TTCC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_2_2_2: {
      label: "Fleck",
      final_answer: {
        result: "Réparation d'un ballon d'eau chaude électrique de marque Fleck",
        tarif: "Entre 180 € et 300 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_2_2_3: {
      label: "Thermor",
      final_answer: {
        result: "Réparation d'un ballon d'eau chaude électrique de marque Thermor",
        tarif: "Entre 180 € et 300 € TTCC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_2_2_4: {
      label: "Chaffoteaux",
      final_answer: {
        result: "Réparation d'un ballon d'eau chaude électrique de marque Chaffoteaux",
        tarif: "Entre 180 € et 300 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_2_2_5: {
      label: "De Dietrich",
      final_answer: {
        result: "Réparation d'un ballon d'eau chaude électrique de marque De Dietrich",
        tarif: "Entre 180 € et 300 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
    e_4_2_2_6: {
      label: "Autre",
      final_answer: {
        result: "Réparation d'un ballon d'eau chaude électrique de marque inconnue",
        tarif: "Entre 180 € et 300 € TTC",
        responsable: "Propriétaire ou Syndic"
      }
    },
  }
end
