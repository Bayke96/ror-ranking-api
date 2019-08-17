Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Department
  get 'departments', :to => 'departments#list_departments'
  get 'departments/:id', :to => 'departments#get_department'
  post 'departments', :to => 'departments#post_department'
  put 'departments/:id', :to => 'departments#put_department'
  delete 'departments/:id', :to => 'departments#delete_department'

  # Rank
  get 'ranks', :to => 'ranks#list_ranks'
  get 'ranks/:id', :to => 'ranks#get_rank'
  post 'ranks', :to => 'ranks#post_rank'
  put 'ranks/:id', :to => 'ranks#put_rank'
  delete 'ranks/:id', :to => 'ranks#delete_rank'
  
end
