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

    #6.1 Editar el RIF en caso de que este vencido
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
    get 'guardar_documentos_circuito_manejo/:id', to:'circuitos_manejo#guardar_documentos_circuito',
        as: :guardar_documentos_circuito
    post 'guardar_circuito_manejo/:id', to:'circuitos_manejo#guardar_circuito',
         as: :guardar_circuito
    patch 'actualizar_circuito_manejo/:id', to:'circuitos_manejo#actualizar_circuito',
          as: :actualizar_circuito

    delete '/eliminar_circuito/:id',
           to: 'circuitos_manejo#eliminar_circuito',
           as: :eliminar_circuito


    #6.5 Seguro RCV
    resources :seguros, only: [:new, :create]
    patch '/seguros/', to: 'seguros#create'
    post '/rif/', to: 'seguros#rif_aseguradora', as: :rif_a

    #6.6 Planilla de Solicitud
    get 'solicitud/preparar/:id',to:'solicitud_adecuacion_acciones#preparar_solicitud', as: :preparar_solicitud_adecuacion
    get 'solicitud/modificar/:id',to:'solicitud_adecuacion_acciones#modificar_solicitud', as: :modificar_solicitud_adecuacion
    get 'solicitud/print', to: 'solicitud_final#print', as: :print_solicitud_adecuacion
    get 'solicitud/ver', to: 'solicitud_final#ver', as: :ver_solicitud_adecuacion

    #6.7 Trabajadores
    get 'listar_personal/:id',to: 'personals#index', as: :listar_personals ,constraints: {id: /\d+/}
    get 'find/:id', to:'personals#find',as: :encontrar_personal
    get 'instructor_documents/', to: 'personals#instructor_documents'
    get 'editar_trabajador/:id', to: 'personals#edit', as: :editar_personal
    get 'ver_trabajador/:id', to: 'personals#show', as: :ver_personal
    patch 'update/:id', to: 'personals#update', as: :actualizar_personal
    post 'found/:id', to: 'personals#found', as: :encontro_personal
    post 'save/:id', to: 'personals#save', as: :guardar_personal
    delete 'remove/:id', to: 'personals#remove', as: :eliminar_personal

  end
end

# == Route Map
#
#                                            Prefix Verb   URI Pattern                                                                         Controller#Action
#               escuela_transportes_personals_index GET    /escuela_transportes/personals/index(.:format)                                      escuela_transportes/personals#index
#                escuela_transportes_personals_edit GET    /escuela_transportes/personals/edit(.:format)                                       escuela_transportes/personals#edit
#                escuela_transportes_personals_find GET    /escuela_transportes/personals/find(.:format)                                       escuela_transportes/personals#find
#               escuela_transportes_personals_found GET    /escuela_transportes/personals/found(.:format)                                      escuela_transportes/personals#found
#                escuela_transportes_personals_save GET    /escuela_transportes/personals/save(.:format)                                       escuela_transportes/personals#save
#              escuela_transportes_personals_update GET    /escuela_transportes/personals/update(.:format)                                     escuela_transportes/personals#update
#              escuela_transportes_personals_remove GET    /escuela_transportes/personals/remove(.:format)                                     escuela_transportes/personals#remove
#                                              root GET    /                                                                                   static_pages#home
#                                    iniciar_sesion GET    /iniciar_sesion(.:format)                                                           devise/sessions#new
#                                          registro GET    /registro(.:format)                                                                 session_users/registrations#nuevo_registro
#                    cambio_contrasena_session_user GET    /cambio_contrasena_u(.:format)                                                      session_users/sessions#edit_password
#                              recuperar_contrasena GET    /recuperar_contrasena(.:format)                                                     session_users/passwords#new
#                             actualizar_contrasena PATCH  /actualizar_contrasena(.:format)                                                    session_users/sessions#update_password
#                             reestablecer_password POST   /reestablecer_password(.:format)                                                    session_users/passwords#permit_reset_password
#                                     cerrar_sesion DELETE /cerrar_sesion(.:format)                                                            devise/sessions#destroy
#                             session_user_password POST   /session_users/password(.:format)                                                   session_users/passwords#create
#                         new_session_user_password GET    /session_users/password/new(.:format)                                               session_users/passwords#new
#                        edit_session_user_password GET    /session_users/password/edit(.:format)                                              session_users/passwords#edit
#                                                   PATCH  /session_users/password(.:format)                                                   session_users/passwords#update
#                                                   PUT    /session_users/password(.:format)                                                   session_users/passwords#update
#                  cancel_session_user_registration GET    /session_users/cancel(.:format)                                                     session_users/registrations#cancel
#                         session_user_registration POST   /session_users(.:format)                                                            session_users/registrations#create
#                     new_session_user_registration GET    /session_users/sign_up(.:format)                                                    session_users/registrations#new
#                    edit_session_user_registration GET    /session_users/edit(.:format)                                                       session_users/registrations#edit
#                                                   PATCH  /session_users(.:format)                                                            session_users/registrations#update
#                                                   PUT    /session_users(.:format)                                                            session_users/registrations#update
#                                                   DELETE /session_users(.:format)                                                            session_users/registrations#destroy
#                         session_user_confirmation POST   /session_users/confirmation(.:format)                                               devise/confirmations#create
#                     new_session_user_confirmation GET    /session_users/confirmation/new(.:format)                                           devise/confirmations#new
#                                                   GET    /session_users/confirmation(.:format)                                               devise/confirmations#show
#                          new_session_user_session GET    /session_users/sign_in(.:format)                                                    session_users/sessions#new
#                              session_user_session POST   /session_users/sign_in(.:format)                                                    session_users/sessions#create
#                      destroy_session_user_session DELETE /session_users/sign_out(.:format)                                                   session_users/sessions#destroy
#                             funcionarios_get_info POST   /funcionarios/get_info(.:format)                                                    funcionarios/funcionarios#get_info
#                                      funcionarios POST   /funcionarios(.:format)                                                             funcionarios/funcionarios#create
#                                       funcionario PATCH  /funcionarios/:id(.:format)                                                         funcionarios/funcionarios#update
#                                                   PUT    /funcionarios/:id(.:format)                                                         funcionarios/funcionarios#update
#                         verificar_preinscripcions GET    /verificar_preinscripcions(.:format)                                                funcionarios/verificar_preinscripcions#index
#                                                   POST   /verificar_preinscripcions(.:format)                                                funcionarios/verificar_preinscripcions#create
#                      new_verificar_preinscripcion GET    /verificar_preinscripcions/new(.:format)                                            funcionarios/verificar_preinscripcions#new
#         verificar_preinscripcion_buscar_solicitud POST   /verificar_preinscripcion/buscar_solicitud(.:format)                                funcionarios/verificar_preinscripcions#wf_buscar_solicitud
#                     verificar_informacion_general GET    /verificar_preinscripcion_escuela/informacion/:id(.:format)                         funcionarios/verificar_preinscripcions#wf_verificar_informacion_general
#                               verificar_vehiculos GET    /verificar_preinscripcion_escuela/vehiculos/:id(.:format)                           funcionarios/verificar_preinscripcions#wf_verificar_vehiculos
#                                  verificar_planos GET    /verificar_preinscripcion_escuela/planos_infraestructura/:id(.:format)              funcionarios/verificar_preinscripcions#wf_verificar_planos
#                               verificar_planillas GET    /verificar_preinscripcion_escuela/planillas_manejo/:id(.:format)                    funcionarios/verificar_preinscripcions#wf_verificar_planillas_manejo
#                    diferir_preinscripcion_escuela GET    /diferir_preinscripcion_escuela/:id(.:format)                                       funcionarios/verificar_preinscripcions#wf_diferir_solicitud
#               inspeccionar_preinscripcion_escuela GET    /inspeccionar_escuela/:id(.:format)                                                 funcionarios/verificar_preinscripcions#wf_realizar_inspeccion
#                   estudiar_preinscripcion_escuela GET    /estudiar_preinscripcion_escuela/:id(.:format)                                      funcionarios/verificar_preinscripcions#wf_realizar_estudio
#                                        verificada GET    /solicitud_procesada/:id(.:format)                                                  funcionarios/verificar_preinscripcions#wf_solitud_procesada
#                                  funcionarios_new GET    /funcionarios/new(.:format)                                                         funcionarios/registrations#new_funcionario
#                     funcionarios_show_funcionario GET    /funcionarios/show/:id(.:format)                                                    funcionarios/registrations#show
#                   funcionarios_create_funcionario POST   /funcionarios/create_funcionario(.:format)                                          funcionarios/registrations#create_funcionario
#                                funcionarios_editf GET    /funcionarios/editf(.:format)                                                       funcionarios/registrations#edit_funcionario
#                  funcionarios_buscar_funcionarios POST   /funcionarios/buscar_funcionarios(.:format)                                         funcionarios/registrations#buscar_funcionarios
#                   funcionarios_editar_funcionario GET    /funcionarios/editar/:id(.:format)                                                  funcionarios/registrations#edit_rols_funcionario
#                   funcionarios_update_funcionario POST   /funcionarios/update_funcionario/:id(.:format)                                      funcionarios/registrations#update_funcionario
#                              funcionario_password POST   /funcionarios/password(.:format)                                                    devise/passwords#create
#                          new_funcionario_password GET    /funcionarios/password/new(.:format)                                                devise/passwords#new
#                         edit_funcionario_password GET    /funcionarios/password/edit(.:format)                                               devise/passwords#edit
#                                                   PATCH  /funcionarios/password(.:format)                                                    devise/passwords#update
#                                                   PUT    /funcionarios/password(.:format)                                                    devise/passwords#update
#                   cancel_funcionario_registration GET    /funcionarios/cancel(.:format)                                                      funcionarios/registrations#cancel
#                          funcionario_registration POST   /funcionarios(.:format)                                                             funcionarios/registrations#create
#                      new_funcionario_registration GET    /funcionarios/sign_up(.:format)                                                     funcionarios/registrations#new
#                     edit_funcionario_registration GET    /funcionarios/edit(.:format)                                                        funcionarios/registrations#edit
#                                                   PATCH  /funcionarios(.:format)                                                             funcionarios/registrations#update
#                                                   PUT    /funcionarios(.:format)                                                             funcionarios/registrations#update
#                                                   DELETE /funcionarios(.:format)                                                             funcionarios/registrations#destroy
#                           new_funcionario_session GET    /funcionarios/sign_in(.:format)                                                     funcionarios/sessions#new
#                               funcionario_session POST   /funcionarios/sign_in(.:format)                                                     funcionarios/sessions#create
#                       destroy_funcionario_session DELETE /funcionarios/sign_out(.:format)                                                    funcionarios/sessions#destroy
#                                              rols GET    /rols(.:format)                                                                     rols#index
#                                                   POST   /rols(.:format)                                                                     rols#create
#                                           new_rol GET    /rols/new(.:format)                                                                 rols#new
#                                          edit_rol GET    /rols/:id/edit(.:format)                                                            rols#edit
#                                               rol GET    /rols/:id(.:format)                                                                 rols#show
#                                                   PATCH  /rols/:id(.:format)                                                                 rols#update
#                                                   PUT    /rols/:id(.:format)                                                                 rols#update
#                                                   DELETE /rols/:id(.:format)                                                                 rols#destroy
#                                   interesado_cets GET    /interesado_cets(.:format)                                                          interesado_cets/interesado_cets#index
#                                                   POST   /interesado_cets(.:format)                                                          interesado_cets/interesado_cets#create
#                                new_interesado_cet GET    /interesado_cets/new(.:format)                                                      interesado_cets/interesado_cets#new
#                                    interesado_cet GET    /interesado_cets/:id(.:format)                                                      interesado_cets/interesado_cets#show
#                                                   PATCH  /interesado_cets/:id(.:format)                                                      interesado_cets/interesado_cets#update
#                                                   PUT    /interesado_cets/:id(.:format)                                                      interesado_cets/interesado_cets#update
#              interesado_cets_find_interesado_ajax POST   /interesado_cets/find_interesado_ajax(.:format)                                     interesado_cets/interesado_cets#find_interesado_ajax
#                                     tipo_escuelas GET    /tipo_escuelas(.:format)                                                            interesado_cets/tipo_escuelas#index
#                                                   POST   /tipo_escuelas(.:format)                                                            interesado_cets/tipo_escuelas#create
#                                  new_tipo_escuela GET    /tipo_escuelas/new(.:format)                                                        interesado_cets/tipo_escuelas#new
#                                 edit_tipo_escuela GET    /tipo_escuelas/:id/edit(.:format)                                                   interesado_cets/tipo_escuelas#edit
#                                      tipo_escuela GET    /tipo_escuelas/:id(.:format)                                                        interesado_cets/tipo_escuelas#show
#                                                   PATCH  /tipo_escuelas/:id(.:format)                                                        interesado_cets/tipo_escuelas#update
#                                                   PUT    /tipo_escuelas/:id(.:format)                                                        interesado_cets/tipo_escuelas#update
#                                                   DELETE /tipo_escuelas/:id(.:format)                                                        interesado_cets/tipo_escuelas#destroy
#                           dynamic_select_ciudades GET    /dynamic_select/:estado_id/ciudades(.:format)                                       dynamic_select/ciudades#index
#                         dynamic_select_municipios GET    /dynamic_select/:estado_id/municipios(.:format)                                     dynamic_select/municipios#index
#                         dynamic_select_parroquias GET    /dynamic_select/:municipio_id/parroquias(.:format)                                  dynamic_select/parroquias#index
#                   dynamic_select_ciudad_municipio POST   /dynamic_select/ciudad_municipio(.:format)                                          dynamic_select/ciudades#ciudad_municipio
#           representante_legal_escuela_transportes GET    /representante_legal/:representante_legal_id/escuela_transportes(.:format)          escuela_transportes/escuela_transportes#index
#                                                   POST   /representante_legal/:representante_legal_id/escuela_transportes(.:format)          escuela_transportes/escuela_transportes#create
#        new_representante_legal_escuela_transporte GET    /representante_legal/:representante_legal_id/escuela_transportes/new(.:format)      escuela_transportes/escuela_transportes#new
#       edit_representante_legal_escuela_transporte GET    /representante_legal/:representante_legal_id/escuela_transportes/:id/edit(.:format) escuela_transportes/escuela_transportes#edit
#            representante_legal_escuela_transporte GET    /representante_legal/:representante_legal_id/escuela_transportes/:id(.:format)      escuela_transportes/escuela_transportes#show
#                                                   PATCH  /representante_legal/:representante_legal_id/escuela_transportes/:id(.:format)      escuela_transportes/escuela_transportes#update
#                                                   PUT    /representante_legal/:representante_legal_id/escuela_transportes/:id(.:format)      escuela_transportes/escuela_transportes#update
#                                                   DELETE /representante_legal/:representante_legal_id/escuela_transportes/:id(.:format)      escuela_transportes/escuela_transportes#destroy
#                         representante_legal_index GET    /representante_legal(.:format)                                                      representante_legal#index
#                                                   POST   /representante_legal(.:format)                                                      representante_legal#create
#                           new_representante_legal GET    /representante_legal/new(.:format)                                                  representante_legal#new
#                          edit_representante_legal GET    /representante_legal/:id/edit(.:format)                                             representante_legal#edit
#                               representante_legal GET    /representante_legal/:id(.:format)                                                  representante_legal#show
#                                                   PATCH  /representante_legal/:id(.:format)                                                  representante_legal#update
#                                                   PUT    /representante_legal/:id(.:format)                                                  representante_legal#update
#                                                   DELETE /representante_legal/:id(.:format)                                                  representante_legal#destroy
#            destroy_no_paginado_jquery_file_upload DELETE /jquery_file_uploads/:id/destroy_no_paginado(.:format)                              jquery_file_uploads#destroy_no_paginado
#                               jquery_file_uploads GET    /jquery_file_uploads(.:format)                                                      jquery_file_uploads#index
#                                                   POST   /jquery_file_uploads(.:format)                                                      jquery_file_uploads#create
#                                jquery_file_upload DELETE /jquery_file_uploads/:id(.:format)                                                  jquery_file_uploads#destroy
#               edit_escuela_transportes_update_rif GET    /escuela_transportes/update_rif/:id/edit(.:format)                                  escuela_transportes/update_rif#edit
#                    escuela_transportes_update_rif PATCH  /escuela_transportes/update_rif/:id(.:format)                                       escuela_transportes/update_rif#update
#                                                   PUT    /escuela_transportes/update_rif/:id(.:format)                                       escuela_transportes/update_rif#update
#    escuela_transportes_cargar_documentos_registro GET    /escuela_transportes/cargar_documentos_registro/:id(.:format)                       escuela_transportes/documentos_registros#new
#           escuela_transportes_documentos_registro POST   /escuela_transportes/documentos_registro/:id(.:format)                              escuela_transportes/documentos_registros#create
#     escuela_transportes_informacion_general_index GET    /escuela_transportes/informacion_general(.:format)                                  escuela_transportes/informacion_general#index
#                                                   POST   /escuela_transportes/informacion_general(.:format)                                  escuela_transportes/informacion_general#create
#      edit_escuela_transportes_informacion_general GET    /escuela_transportes/informacion_general/:id/edit(.:format)                         escuela_transportes/informacion_general#edit
#           escuela_transportes_informacion_general PATCH  /escuela_transportes/informacion_general/:id(.:format)                              escuela_transportes/informacion_general#update
#                                                   PUT    /escuela_transportes/informacion_general/:id(.:format)                              escuela_transportes/informacion_general#update
#       escuela_transportes_informacion_general_new POST   /escuela_transportes/informacion_general/new(.:format)                              escuela_transportes/informacion_general#new
#   escuela_transportes_informacion_general_new_get GET    /escuela_transportes/informacion_general/new(.:format)                              escuela_transportes/informacion_general#new_get
#                     escuela_transportes_vehiculos GET    /escuela_transportes/vehiculos(.:format)                                            escuela_transportes/vehiculos#index
#                                                   POST   /escuela_transportes/vehiculos(.:format)                                            escuela_transportes/vehiculos#create
#                  new_escuela_transportes_vehiculo GET    /escuela_transportes/vehiculos/new(.:format)                                        escuela_transportes/vehiculos#new
#                 edit_escuela_transportes_vehiculo GET    /escuela_transportes/vehiculos/:id/edit(.:format)                                   escuela_transportes/vehiculos#edit
#                      escuela_transportes_vehiculo GET    /escuela_transportes/vehiculos/:id(.:format)                                        escuela_transportes/vehiculos#show
#                                                   PATCH  /escuela_transportes/vehiculos/:id(.:format)                                        escuela_transportes/vehiculos#update
#                                                   PUT    /escuela_transportes/vehiculos/:id(.:format)                                        escuela_transportes/vehiculos#update
#                                                   DELETE /escuela_transportes/vehiculos/:id(.:format)                                        escuela_transportes/vehiculos#destroy
# escuela_transportes_vehiculos_buscar_vehiculo_pre POST   /escuela_transportes/vehiculos/buscar_vehiculo_pre(.:format)                        escuela_transportes/vehiculos#buscar_vehiculo_pre
#                 escuela_transportes_cargar_planos GET    /escuela_transportes/cargar_planos_infraestructura/:id(.:format)                    escuela_transportes/planos_infraestructura#new
#                escuela_transportes_guardar_planos POST   /escuela_transportes/guardar_planos_infraestructura/:id(.:format)                   escuela_transportes/planos_infraestructura#create
#               escuela_transportes_index_circuitos GET    /escuela_transportes/listar_circuitos_manejo/:id(.:format)                          escuela_transportes/circuitos_manejo#index_circuitos
#                  escuela_transportes_ver_circuito GET    /escuela_transportes/ver_circuito_manejo/:id(.:format)                              escuela_transportes/circuitos_manejo#show
#                escuela_transportes_crear_circuito GET    /escuela_transportes/crear_circuito_manejo/:id(.:format)                            escuela_transportes/circuitos_manejo#new
#               escuela_transportes_editar_circuito GET    /escuela_transportes/aditar_circuito_manejo/:id(.:format)                           escuela_transportes/circuitos_manejo#editar_circuito
#   escuela_transportes_guardar_documentos_circuito GET    /escuela_transportes/guardar_documentos_circuito_manejo/:id(.:format)               escuela_transportes/circuitos_manejo#guardar_documentos_circuito
#              escuela_transportes_guardar_circuito POST   /escuela_transportes/guardar_circuito_manejo/:id(.:format)                          escuela_transportes/circuitos_manejo#guardar_circuito
#           escuela_transportes_actualizar_circuito PATCH  /escuela_transportes/actualizar_circuito_manejo/:id(.:format)                       escuela_transportes/circuitos_manejo#actualizar_circuito
#             escuela_transportes_eliminar_circuito DELETE /escuela_transportes/eliminar_circuito/:id(.:format)                                escuela_transportes/circuitos_manejo#eliminar_circuito
#                       escuela_transportes_seguros POST   /escuela_transportes/seguros(.:format)                                              escuela_transportes/seguros#create
#                    new_escuela_transportes_seguro GET    /escuela_transportes/seguros/new(.:format)                                          escuela_transportes/seguros#new
#                                                   PATCH  /escuela_transportes/seguros(.:format)                                              escuela_transportes/seguros#create
#                         escuela_transportes_rif_a POST   /escuela_transportes/rif(.:format)                                                  escuela_transportes/seguros#rif_aseguradora
#           new_escuela_transportes_solicitud_final GET    /escuela_transportes/solicitud_final/new(.:format)                                  escuela_transportes/solicitud_final#new
#                         escuela_transportes_print GET    /escuela_transportes/solicitud/print(.:format)                                      escuela_transportes/solicitud_final#print
#
