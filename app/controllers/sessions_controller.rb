class SessionsController < ApplicationController
  def add_practice
    session[:temporary_practices] ||= []  # Initialise un tableau vide si session[:temporary_practices] n'existe pas

    new_practice = {
      "name" => params[:name],
      "category" => "temporary"
    }

    session[:temporary_practices] << new_practice

    redirect_to practices_path, notice: "Pratique temporaire ajoutée."
  end

  def clear_practices
    session[:temporary_practices] = []
    redirect_to practices_path, notice: "Toutes les pratiques temporaires ont été supprimées."
  end
end
