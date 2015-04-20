Rails.application.routes.draw do
  
  root :to =>'static_pages#home'

  #1.DEVISE ROUTES
  #1.1 Session User
  devise_scope :session_user do
    get 'iniciar_sesion', to: 'devise/sessions#new'
    get 'registro', to: 'session_users/registrations#nuevo_registro'
    get 'cambio_contrasena_u',
        to: 'session_users/sessions#edit_password',
        as: 'cambio_contrasena_session_user'
    get 'recuperar_contrasena', to: 'session_users/passwords#new'
    patch 'actualizar_contrasena', to: 'session_users/sessions#update_password'
    post 'reestablecer_password',
         to:'session_users/passwords#permit_reset_password'
    delete 'cerrar_sesion', to: 'devise/sessions#destroy'
  end

  devise_for :session_users ,  :controllers =>
                                { :registrations => 'session_users/registrations',
                                  :sessions =>'session_users/sessions',
                                  :passwords => 'session_users/passwords'}
  #1.2. Funcionarios
  scope module: 'funcionarios' do
    post 'funcionarios/get_info',
         to: 'funcionarios#get_info'
    resources :funcionarios, only: [:create, :update]


    #1.2.1 Verificar Solicitudes de Preinscripcion

    # 1.2.1.1 busqueda de preinscripcion a verificar
    resources :verificar_preinscripcions, only: [:index, :new, :create]
    post 'verificar_preinscripcion/buscar_solicitud',
        to: 'verificar_preinscripcions#wf_buscar_solicitud'

    # 1.2.1.2 Wizard verificar Preincripcion
    get 'verificar_preinscripcion_escuela/informacion/:id',
        to: 'verificar_preinscripcions#wf_verificar_informacion_general',
        as: :verificar_informacion_general

    get 'verificar_preinscripcion_escuela/vehiculos/:id',
        to: 'verificar_preinscripcions#wf_verificar_vehiculos',
        as: :verificar_vehiculos

    get 'verificar_preinscripcion_escuela/planos_infraestructura/:id',
        to: 'verificar_preinscripcions#wf_verificar_planos',
        as: :verificar_planos

    get 'verificar_preinscripcion_escuela/planillas_manejo/:id',
        to: 'verificar_preinscripcions#wf_verificar_planillas_manejo',
        as: :verificar_planillas

    #1.2.1.3 Acciones sobre las Preeinscripciones
    get 'diferir_preinscripcion_escuela/:id',
        to: 'verificar_preinscripcions#wf_diferir_solicitud',
        as: :diferir_preinscripcion_escuela

    get 'inspeccionar_escuela/:id',
        to: 'verificar_preinscripcions#wf_realizar_inspeccion',
        as: :inspeccionar_preinscripcion_escuela

    get 'estudiar_preinscripcion_escuela/:id',
        to: 'verificar_preinscripcions#wf_realizar_estudio',
        as: :estudiar_preinscripcion_escuela

    get 'solicitud_procesada/:id',
        to: 'verificar_preinscripcions#wf_solitud_procesada',
        as: :verificada

    # post 'rechazar_preinscripcion_escuela/:id',
    #     to: 'verificar_preinscripcions#wf_rechazar_solicitud',
    #     as: :rechazar_preinscripcion_escuela

    # get 'aprobar_preinscripcion_escuela/:id',
    #     to: 'verificar_preinscripcions#wf_aprobar_solicitud',
    #     as: :aprobar_preinscripcion_escuela

  end

  # 1.2.1 Registro
  devise_scope :funcionario do

    get 'funcionarios/new',
        to: 'funcionarios/registrations#new_funcionario'
    get 'funcionarios/show/:id',
        to: 'funcionarios/registrations#show', as: 'funcionarios_show_funcionario'
    post 'funcionarios/create_funcionario',
         to: 'funcionarios/registrations#create_funcionario'
    get 'funcionarios/editf',
        to: 'funcionarios/registrations#edit_funcionario'
    post 'funcionarios/buscar_funcionarios',
         to: 'funcionarios/registrations#buscar_funcionarios'
    get 'funcionarios/editar/:id',
        to: 'funcionarios/registrations#edit_rols_funcionario', as: 'funcionarios_editar_funcionario'
    post 'funcionarios/update_funcionario/:id',
         to: 'funcionarios/registrations#update_funcionario', as: 'funcionarios/update_funcionario'
  end

  devise_for :funcionarios, controllers: { sessions: 'funcionarios/sessions',
                                           registrations: 'funcionarios/registrations'}

  #2. Roles
  resources :rols

  #3. Registro de Interesados
  scope module: 'interesado_cets' do
    resources :interesado_cets, only: [:new, :index, :create, :update, :show]
    post 'interesado_cets/find_interesado_ajax',
         to: 'interesado_cets#find_interesado_ajax'
    resources :tipo_escuelas
  end

  #4. Dynamic Selects
  namespace :dynamic_select do
    get ':estado_id/ciudades', to: 'ciudades#index', as: 'ciudades'
    get ':estado_id/municipios', to: 'municipios#index', as: 'municipios'
    get ':municipio_id/parroquias', to: 'parroquias#index', as: 'parroquias'
    post 'ciudad_municipio', to: 'ciudades#ciudad_municipio'
  end

  #5. Nested Resources Acceder a operadoras de un Representante legal
  resources :representante_legal do
    resources :escuela_transportes, controller: 'escuela_transportes/escuela_transportes'
  end

  resources :jquery_file_uploads, only: [:create, :destroy, :index] do
    member do
      delete 'destroy_no_paginado'
    end
  end

  #6. Preinscripcion de Escuela de Transporte
  namespace :escuela_transportes do

    #6.-1 Editar el RIF en caso de que este vencido
    resources :update_rif, only: [:edit, :update]

    #6.0 Documentos del Registro Inicial
    get 'cargar_documentos_registro/:id', to:'documentos_registros#new',as: :cargar_documentos_registro
    post 'documentos_registro/:id', to:'documentos_registros#create',as: :documentos_registro

    #6.1 Informacion General e Inicio
    resources :informacion_general, only: [:index, :create, :update, :edit]
    post 'informacion_general/new', to: 'informacion_general#new', as: 'informacion_general_new'
    get 'informacion_general/new', to: 'informacion_general#new_get', as: 'informacion_general_new_get'

   #6.2 Documentos de Vehiculos
   resources :vehiculos
   post 'vehiculos/buscar_vehiculo_pre', to: 'vehiculos#buscar_vehiculo_pre'

    #6.3 Documentos Planos de Infraestructura
    # resources :planos
    get  'cargar_planos_infraestructura/:id', to:'planos_infraestructura#new',
         as: :cargar_planos
    post 'guardar_planos_infraestructura/:id', to:'planos_infraestructura#create',
         as: :guardar_planos

    #6.4 Modelos de Planillas para practica de manejo
    get  'listar_circuitos_manejo/:id', to: 'circuitos_manejo#index_circuitos',
         as: :index_circuitos
    get  'ver_circuito_manejo/:id', to: 'circuitos_manejo#show',
         as: :ver_circuito
    get  'crear_circuito_manejo/:id', to:'circuitos_manejo#new',
         as: :crear_circuito
    get  'aditar_circuito_manejo/:id', to:'circuitos_manejo#editar_circuito',
         as: :editar_circuito
    post 'guardar_circuito_manejo/:id', to:'circuitos_manejo#guardar_circuito',
         as: :guardar_circuito
    patch 'actualizar_circuito_manejo/:id', to:'circuitos_manejo#actualizar_circuito',
          as: :actualizar_circuito

    delete '/eliminar_circuito/:id',
           to: 'circuitos_manejo#eliminar_circuito',
           as: :eliminar_circuito

    #6.5 Planilla de Solicitud
    resources :solicitud_final, only: [:new]
    get 'solicitud/print', to: 'solicitud_final#print', as: :print

    # Seguro RCV
    resources :seguros, only: [:new, :create]
    patch '/seguros/', to: 'seguros#create'
    post '/rif/', to: 'seguros#rif_aseguradora', as: :rif_a
  end
end

# == Route Map
#
#                            Prefix Verb   URI Pattern                                       Controller#Action
#     operadora_escuela_transportes GET    /operadora_escuela_transportes(.:format)          operadora_escuela_transportes#index
#                                   POST   /operadora_escuela_transportes(.:format)          operadora_escuela_transportes#create
#  new_operadora_escuela_transporte GET    /operadora_escuela_transportes/new(.:format)      operadora_escuela_transportes#new
# edit_operadora_escuela_transporte GET    /operadora_escuela_transportes/:id/edit(.:format) operadora_escuela_transportes#edit
#      operadora_escuela_transporte GET    /operadora_escuela_transportes/:id(.:format)      operadora_escuela_transportes#show
#                                   PATCH  /operadora_escuela_transportes/:id(.:format)      operadora_escuela_transportes#update
#                                   PUT    /operadora_escuela_transportes/:id(.:format)      operadora_escuela_transportes#update
#                                   DELETE /operadora_escuela_transportes/:id(.:format)      operadora_escuela_transportes#destroy
#                              root GET    /                                                 static_pages#home
#                        registrado GET    /registrado(.:format)                             static_pages#later_register
#                    iniciar_sesion GET    /iniciar_sesion(.:format)                         devise/sessions#new
#                          registro GET    /registro(.:format)                               session_users/registrations#nuevo_registro
#    cambio_contrasena_session_user GET    /cambio_contrasena_u(.:format)                    session_users/sessions#edit_password
#              recuperar_contrasena GET    /recuperar_contrasena(.:format)                   session_users/passwords#new
#             actualizar_contrasena PATCH  /actualizar_contrasena(.:format)                  session_users/sessions#update_password
#             reestablecer_password POST   /reestablecer_password(.:format)                  session_users/passwords#permit_reset_password
#                     cerrar_sesion DELETE /cerrar_sesion(.:format)                          devise/sessions#destroy
#             session_user_password POST   /session_users/password(.:format)                 session_users/passwords#create
#         new_session_user_password GET    /session_users/password/new(.:format)             session_users/passwords#new
#        edit_session_user_password GET    /session_users/password/edit(.:format)            session_users/passwords#edit
#                                   PATCH  /session_users/password(.:format)                 session_users/passwords#update
#                                   PUT    /session_users/password(.:format)                 session_users/passwords#update
#  cancel_session_user_registration GET    /session_users/cancel(.:format)                   session_users/registrations#cancel
#         session_user_registration POST   /session_users(.:format)                          session_users/registrations#create
#     new_session_user_registration GET    /session_users/sign_up(.:format)                  session_users/registrations#new
#    edit_session_user_registration GET    /session_users/edit(.:format)                     session_users/registrations#edit
#                                   PATCH  /session_users(.:format)                          session_users/registrations#update
#                                   PUT    /session_users(.:format)                          session_users/registrations#update
#                                   DELETE /session_users(.:format)                          session_users/registrations#destroy
#         session_user_confirmation POST   /session_users/confirmation(.:format)             devise/confirmations#create
#     new_session_user_confirmation GET    /session_users/confirmation/new(.:format)         devise/confirmations#new
#                                   GET    /session_users/confirmation(.:format)             devise/confirmations#show
#          new_session_user_session GET    /session_users/sign_in(.:format)                  session_users/sessions#new
#              session_user_session POST   /session_users/sign_in(.:format)                  session_users/sessions#create
#      destroy_session_user_session DELETE /session_users/sign_out(.:format)                 session_users/sessions#destroy
#              funcionario_password POST   /funcionarios/password(.:format)                  devise/passwords#create
#          new_funcionario_password GET    /funcionarios/password/new(.:format)              devise/passwords#new
#         edit_funcionario_password GET    /funcionarios/password/edit(.:format)             devise/passwords#edit
#                                   PATCH  /funcionarios/password(.:format)                  devise/passwords#update
#                                   PUT    /funcionarios/password(.:format)                  devise/passwords#update
#   cancel_funcionario_registration GET    /funcionarios/cancel(.:format)                    funcionarios/registrations#cancel
#          funcionario_registration POST   /funcionarios(.:format)                           funcionarios/registrations#create
#      new_funcionario_registration GET    /funcionarios/sign_up(.:format)                   funcionarios/registrations#new
#     edit_funcionario_registration GET    /funcionarios/edit(.:format)                      funcionarios/registrations#edit
#                                   PATCH  /funcionarios(.:format)                           funcionarios/registrations#update
#                                   PUT    /funcionarios(.:format)                           funcionarios/registrations#update
#                                   DELETE /funcionarios(.:format)                           funcionarios/registrations#destroy
#           new_funcionario_session GET    /funcionarios/sign_in(.:format)                   funcionarios/sessions#new
#               funcionario_session POST   /funcionarios/sign_in(.:format)                   funcionarios/sessions#create
#       destroy_funcionario_session DELETE /funcionarios/sign_out(.:format)                  funcionarios/sessions#destroy
#      funcionarios_new_funcionario GET    /funcionarios/new_funcionario(.:format)           funcionarios/registrations#new_funcionario
#   funcionarios_create_funcionario POST   /funcionarios/create_funcionario(.:format)        funcionarios/registrations#create_funcionario
#     funcionarios_show_funcionario GET    /funcionarios/show/:id(.:format)                  funcionarios/registrations#show_funcionario
#     funcionarios_edit_funcionario GET    /funcionarios/edit_funcionario(.:format)          funcionarios/registrations#edit_funcionario
#  funcionarios_buscar_funcionarios POST   /funcionarios/buscar_funcionarios(.:format)       funcionarios/registrations#buscar_funcionarios
#   funcionarios_editar_funcionario GET    /funcionarios/editar/:id(.:format)                funcionarios/registrations#edit_rols_funcionario
#   funcionarios_update_funcionario POST   /funcionarios/update_funcionario/:id(.:format)    funcionarios/registrations#update_funcionario
#                              rols GET    /rols(.:format)                                   rols#index
#                                   POST   /rols(.:format)                                   rols#create
#                           new_rol GET    /rols/new(.:format)                               rols#new
#                          edit_rol GET    /rols/:id/edit(.:format)                          rols#edit
#                               rol GET    /rols/:id(.:format)                               rols#show
#                                   PATCH  /rols/:id(.:format)                               rols#update
#                                   PUT    /rols/:id(.:format)                               rols#update
#                                   DELETE /rols/:id(.:format)                               rols#destroy
#                  funcion_sistemas GET    /funcion_sistemas(.:format)                       funcion_sistemas#index
#                                   POST   /funcion_sistemas(.:format)                       funcion_sistemas#create
#               new_funcion_sistema GET    /funcion_sistemas/new(.:format)                   funcion_sistemas#new
#              edit_funcion_sistema GET    /funcion_sistemas/:id/edit(.:format)              funcion_sistemas#edit
#                   funcion_sistema GET    /funcion_sistemas/:id(.:format)                   funcion_sistemas#show
#                                   PATCH  /funcion_sistemas/:id(.:format)                   funcion_sistemas#update
#                                   PUT    /funcion_sistemas/:id(.:format)                   funcion_sistemas#update
#                                   DELETE /funcion_sistemas/:id(.:format)                   funcion_sistemas#destroy
#
