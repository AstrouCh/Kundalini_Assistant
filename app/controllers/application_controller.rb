class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    Rails.logger.debug "✅ Pratiques temporaires APRÈS connexion : #{session[:temporary_practices].inspect}"
    Rails.logger.debug "✅ Posture temporaire APRÈS connexion : #{session[:temporary_posture].inspect}"

    # 1️⃣ Gérer les pratiques temporaires (créées sans être connecté)
    if session[:temporary_practices].present?
      session[:temporary_practices].each do |practice_data|
        postures = practice_data.delete("postures") || [] # Séparer les postures des autres données
        practice = resource.practices.create(practice_data.merge(category: 'personal')) # Créer la pratique
        postures.each { |posture| practice.postures.create(posture) } # Ajouter les postures
      end
      session.delete(:temporary_practices)
    end

    # 2️⃣ Gérer la posture temporaire ajoutée à une pratique suggérée
    if session[:temporary_posture].present?
      practice = Practice.find(session[:temporary_posture][:practice_id])
      posture_params = session[:temporary_posture][:posture]

      # Si la pratique est suggérée, en créer une copie pour l'utilisateur
      if practice.category != 'personal'
        new_practice = practice.dup
        new_practice.user = current_user
        new_practice.category = 'personal'
        new_practice.save

        # Ajouter la posture à la nouvelle pratique
        new_practice.postures.create(posture_params)

        session.delete(:temporary_posture) # Nettoyer la session après enregistrement

        return redirect_to practice_postures_path(new_practice) # Rediriger vers la nouvelle pratique
      end
    end

    super # Comportement normal de Devise si pas de pratique/temporaire à gérer
  end
end
