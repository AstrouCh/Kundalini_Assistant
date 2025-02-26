class SessionsController < ApplicationController
  after_action :save_temporary_practice, only: :create

  def add_practice
    session[:temporary_practices] ||= []  # Initialise un tableau vide si session[:temporary_practices] n'existe pas

    new_practice = {
      "name" => params[:name],
      "category" => "temporary"
    }

    session[:temporary_practices] << new_practice

    Rails.logger.debug "📌 Pratiques temporaires AVANT connexion : #{session[:temporary_practices].inspect}"

    redirect_to practices_path, notice: "Pratique temporaire ajoutée."
  end

  def clear_practices
    session[:temporary_practices] = []
    redirect_to practices_path, notice: "Toutes les pratiques temporaires ont été supprimées."
  end

private

def save_temporary_practice
  return unless session[:temporary_practices].present?

  session[:temporary_practices].each do |practice_data|
    current_user.practices.create(practice_data)
  end

  session.delete(:temporary_practices) # Supprime après migration

  flash[:notice] = "Vos pratiques temporaires ont été enregistrées sous votre compte."
end


end
