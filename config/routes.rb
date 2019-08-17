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

  # Privilege
  get 'privileges/department/:department/rank/:rank', :to => 'privileges#get_privileges'
  post 'privileges', :to => 'privileges#post_privileges'
  put 'privileges/department/:department/rank/:rank', :to => 'privileges#put_privileges'
  delete 'privileges/department/:department/rank/:rank', :to => 'privileges#delete_privileges'

  # User
  get 'users', :to => 'users#list_users'
  get 'users/:id', :to => 'users#get_user'
  post 'users', :to => 'users#post_user'
  put 'users/:id', :to => 'users#put_user'
  delete 'users/:id', :to => 'users#delete_user'

  # User Profile
  get 'profiles/:id', :to => 'profiles#get_profile'
  post 'profiles', :to => 'profiles#post_profile'
  put 'profiles/:id', :to => 'profiles#put_profile'
  delete 'profiles/:id', :to => 'profiles#delete_profile'
  
end
