Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Department

  get 'departments', :to => 'departments#list_department'
  get 'departments/:id', :to => 'departments#get_department'
  post 'departments', :to => 'departments#post_department'
  
end
