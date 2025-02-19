Rails.application.routes.draw do
  # Gestion des pratiques et postures en tant que ressources imbriquées
  resources :practices do
    resources :postures # Pas besoin de spécifier les actions, toutes seront imbriquées
  end

  resources :postures, only: [:show, :edit, :update, :destroy] # Gestion individuelle des postures

  # Routes pour les pratiques temporaires en session (pour les utilisateurs non connectés)
  post "/sessions/add_practice", to: "sessions#add_practice", as: "add_temporary_practice"
  delete "/sessions/clear_practices", to: "sessions#clear_practices", as: "clear_temporary_practices"

  # Routes pour l'authentification avec Devise
  devise_for :users

  # Définition de la page d'accueil
  root to: "pages#home"

  # Route pour vérifier le statut de l'application
  get "up" => "rails/health#show", as: :rails_health_check
end
