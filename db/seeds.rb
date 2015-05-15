#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
administrador = Funcionario.create!(login:'intt_super_admin',
                                    password: '12345678',
                                    nombre: 'Jimi',
                                    apellido: 'Hendrix',
                                    nacionalidad: 'E',
                                    cedula: 10,
                                    direccion: 'Por estas calles',
                                    email: 'super_admin@intt.gob.ve')
puts '### ADMINISTRADOR CREADO ###'

Rol.create!([{nombre:'Analista ET', funcion_sistemas: FuncionSistema.where(nombre: 'manage', clase_controlador: [:InteresadoCet,:verificar_preinscripcion])},
             {nombre: 'Funcionario ET'},
             {nombre: 'Gerente Servicios Conexos'},
             {nombre:'Inspector ET'},
             {nombre: 'Verificador ET'}])

puts '### ROLES CREADOS ###'

Rol.create!(nombre: 'Administrador Conex-ET',
            funcionarios: Funcionario.where(id: administrador),
            funcion_sistemas: FuncionSistema.where(nombre: 'manage'))

puts '### ROL DE ADMINISTRADOR CREADO Y FUNCIONES ASIGNADAS ###'

puts '### SEEDEANDO TIPOS DE ESCUELA'
TipoEscuela.create!([{nombre: 'Clase A (Licencia de 2do, 3er y 4to grado)'},
                     {nombre: 'Clase B (Licencia de 2do, 3er, 4to y 5to grado)'},
                     {nombre: 'Clase C (Licencia de 4to, 5to y Título Profesional)'}])

#########################################################
############# SOLICITUDES Y REQUISITOS ##################
#########################################################
puts '## PRIMER NUMERO DE CONTROL DE SOLICITUDES ###'
NumeroControl.create!(nombre: 'solicitud', numero: 0)

puts '### SEEDEANDO TIPOS DE SOLICITUDES ###'
preinscripcion = TipoSolicitud.create!(nombre: 'preinscripcion',
                                       descripcion: 'Solicitud de Autorización de Adecuación')


puts '### SEEDEANDO WORKFLOW POR TIPO DE SOLICITUD##'
workflowPreinscripcion = WorkFlow.create!(nombre: 'WF_Preinscripcion',
                                          TipoSolicitud_id: preinscripcion.id)
puts 'workflow preinscripción ET creado'
# Creando Estados de Workflow Preincripcion

st_creada       = EstadosWorkFlow.create!(nombre:'creada'   ,
                                          Workflow_id: workflowPreinscripcion.id)
st_preparada    = EstadosWorkFlow.create!(nombre:'preparada',
                                          Workflow_id: workflowPreinscripcion.id)
st_completa     = EstadosWorkFlow.create!(nombre:'completa' ,
                                          Workflow_id: workflowPreinscripcion.id)
# st_modificada   = EstadosWorkFlow.create!(nombre:'modificada',
#                                           Workflow_id: workflowPreinscripcion.id)
st_para_estudio = EstadosWorkFlow.create!(nombre:'para_estudio',
                                          Workflow_id: workflowPreinscripcion.id)
st_diferida     = EstadosWorkFlow.create!(nombre:'diferida'    ,
                                          Workflow_id: workflowPreinscripcion.id)
st_caducada     = EstadosWorkFlow.create!(nombre:'caducada'    ,
                                          Workflow_id: workflowPreinscripcion.id)
st_en_espera_de_inpeccion = EstadosWorkFlow.create!(nombre:'en_espera_de_inpeccion',
                                                    Workflow_id: workflowPreinscripcion.id)
puts 'Estados de workflow preinscripción ET creado'

# creando eventos de Workflow Preincripcion

ev_preparar= EventosWorkFlow.create!(nombre:'preparar',Workflow_id: workflowPreinscripcion.id)
ev_imprimir_planilla= EventosWorkFlow.create!(nombre:'imprimir_planilla',Workflow_id: workflowPreinscripcion.id)
ev_modificar= EventosWorkFlow.create!(nombre:'modificar',Workflow_id: workflowPreinscripcion.id)
ev_hacer_inspeccion= EventosWorkFlow.create!(nombre:'hacer_inspeccion',Workflow_id: workflowPreinscripcion.id)
ev_diferir= EventosWorkFlow.create!(nombre:'diferir',Workflow_id: workflowPreinscripcion.id)
ev_hacer_estudio= EventosWorkFlow.create!(nombre:'hacer_estudio',Workflow_id: workflowPreinscripcion.id)
ev_caducar= EventosWorkFlow.create!(nombre:'caducar',Workflow_id: workflowPreinscripcion.id)

puts 'Eventos de workflow preinscripción ET creado'

# creando transiciones de workflow Preinscripcion
#       st_creada  --  ev_preparar  -->st_preparada
TransicionesWorkFlow.create!(estado_fuente_id:st_creada.id,estado_destino_id:st_preparada.id,EventosWorkFlow_id:ev_preparar.id)

#       st_preparadas  --  ev_modificar  -->t_creada
TransicionesWorkFlow.create!(estado_fuente_id:st_preparada.id,estado_destino_id:st_creada.id,EventosWorkFlow_id:ev_modificar.id)


#       st_preparada  --  ev_imprimir_planilla  -->st_completa
TransicionesWorkFlow.create!(estado_fuente_id:st_preparada.id,estado_destino_id:st_completa.id,EventosWorkFlow_id:ev_imprimir_planilla.id)

#       st_completa  --  ev_imprimir_planilla  -->st_completa
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id:st_completa.id,EventosWorkFlow_id:ev_imprimir_planilla.id)

#       st_completa  --  ev_modificar -->st_creada
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id:st_creada.id,EventosWorkFlow_id:ev_modificar.id)

#       st_completa  --  ev_hacer_estudio -->st_para_estudio
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id: st_para_estudio.id,EventosWorkFlow_id: ev_hacer_estudio.id)

#       st_completa  --  ev_diferir  -->st_diferida
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id:st_diferida.id,EventosWorkFlow_id:ev_diferir.id)

#       st_completa  --  ev_hacer_inspeccion  -->st_en_espera_de_inpeccion
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id: st_en_espera_de_inpeccion.id,EventosWorkFlow_id: ev_hacer_inspeccion.id)

#      st_diferida --  ev_caducar  -->st_caducada
TransicionesWorkFlow.create!(estado_fuente_id:st_diferida.id,estado_destino_id:st_caducada.id,EventosWorkFlow_id:ev_caducar.id)
puts 'Transiciones de workflow preinscripción ET creado'

#cargando funcion sistemas asociadas con cambios de estados en Work flow
wf_diferir_solicitud   = FuncionSistema.find_by_nombre(:wf_diferir_solicitud)
wf_realizar_inspeccion = FuncionSistema.find_by_nombre(:wf_realizar_inspeccion)
wf_realizar_estudio    = FuncionSistema.find_by_nombre(:wf_realizar_estudio)

#creando asociaciones entre funcion sistemas y button (esta relacion es el connect de QT)
button_diferir_solicitud   = Button.create!(helper_path:'diferir_preinscripcion_escuela_path',
                                            style:'btn btn-danger',
                                            icon:'<i class="fa fa-archive"></i>',
                                            text:'Diferir Solicitud',
                                            funcion_sistema_id: wf_diferir_solicitud.id)

button_realizar_inspeccion = Button.create!(helper_path:'inspeccionar_preinscripcion_escuela_path',
                                            style:'btn btn-success',
                                            icon:'<i class="fa fa-eye"></i>',
                                            text:'Hacer Inspección',
                                            funcion_sistema_id:wf_realizar_inspeccion.id)

button_realizar_estudio    = Button.create!(helper_path:'estudiar_preinscripcion_escuela_path',
                                            style:'btn btn-success',
                                            icon:'<i class="fa fa-archive"></i>',
                                            text:'Hacer Estudio',
                                            funcion_sistema_id:wf_realizar_estudio.id)

puts 'Asociaciones entre funcion sistemas y button creadas'

#creando asociaciones entre Estados Work Flow y buttons
st_creada.buttons.push( button_diferir_solicitud,
                        button_realizar_estudio,
                        button_realizar_inspeccion)

puts 'Asociaciones entre Estados Work Flow preinscripción ET y buttons creadas'

#creando relaciones entre funcion sistemas y eventos workflow
wf_diferir_solicitud.eventos_work_flow  = ev_diferir
wf_realizar_estudio.eventos_work_flow    = ev_hacer_estudio
wf_realizar_inspeccion.eventos_work_flow = ev_hacer_inspeccion
puts 'Asociaciones entre funcion sistemas y eventos Work flow creadas'


puts '### CREANDO VISTAS ###'

vista_registro_escuela = Vista.create!(nombre: 'registro_inicial',
                                       descripcion:
                                           'Documentos requeridos al momento del registro de la escuela de transporte')

vista_informacion_general  = Vista.create!(nombre:'informacion_general',
                                           descripcion: 'Carga de Información General de la Escuela de Transporte',
                                           index: 0)

vista_planos_infraestructura    = Vista.create!(nombre: 'planos_infraestructura',
                                                descripcion: 'Planos de la Infraestructura',
                                                index: 1,  any_grupo_documentos_uno: true)

vista_rcv_flota = Vista.create!(nombre:'rcv_flota',
                                descripcion: 'Registro de Seguro RCV para Vehículos',
                                index: 2)

vista_vehiculo_ensenanza = Vista.create!(nombre:'vehiculo_pre',
                                         descripcion: 'Registro de Vehículos de Enseñanza',
                                         index: 3)

vista_arrendamiento = Vista.create!(nombre:'vehiculo_arrendamiento',
                                    descripcion: 'Datos de Arrendamiento',
                                    index: 3)

vista_registro_circuitos_manejo = Vista.create!(nombre: 'registro_circuitos_manejo',
                                                descripcion: 'Registro de Circuitos de Manejo',
                                                index: 4)

vista_registro_circuitos_manejo_abierto = Vista.create!(nombre: 'registro_circuitos_manejo_abierto',
                                                        descripcion: 'Registro de Circuitos de Manejo abierto',
                                                        index: 4)


vista_trabajadores = Vista.create!(nombre: 'trabajadores',
                                   descripcion: 'Registro de los Trabajadores',
                                   index: 5)

vista_trabajadores_instructores = Vista.create!(nombre: 'trabajadores_instructores',
                                                descripcion: 'Registro de los Trabajadores Instructores',
                                                index: 5)

puts '### ASOCIANDO VISTAS A TIPOS DE SOLICITUDES###'

preinscripcion.vistas<< vista_informacion_general<<vista_planos_infraestructura<<
    vista_rcv_flota<<vista_vehiculo_ensenanza<<vista_arrendamiento<<
    vista_registro_circuitos_manejo<<vista_trabajadores<<vista_trabajadores_instructores<<
    vista_registro_circuitos_manejo_abierto
puts '### DOCUMENTOS DE REQUISITOS ###'

# ######## DOCUMENTOS DE REGISTRO DE ESCUELA DE TRANSPORTE ###############
vista_registro_escuela.documento_requisitos<<
    DocumentoRequisito.create!([{nombre: 'rif_imagen',
                                 descripcion: 'RIF',
                                 cardinalidad_maxima: 1,
                                 obligatorio: true},
                                {nombre: 'acta_constitutiva',
                                 descripcion: 'Acta Constitutiva',
                                 paginado: true,
                                 cardinalidad_maxima: 1,
                                 obligatorio: true}
                               ])

####### DOCUMENTOS DE INFORMACION GENERAL ################


vista_informacion_general.documento_requisitos<<
    DocumentoRequisito.create!([{nombre: 'deposito_bancario',
                                 descripcion: 'Comprobante de depósito bancario por concepto de proceso de registro:',
                                 paginado: true,
                                 cardinalidad_maxima: 1},
                                {nombre: 'ultima_acta_asamblea',
                                 descripcion: 'Actas de Asamblea con las ultimas modificaciones, en caso de Existir:',
                                 paginado: true,
                                 cardinalidad_maxima: 1},
                                {nombre: 'carta_presidente_intt',
                                 descripcion: 'Carta de solicitud dirigida al presidente del INTT con atención a la gerencia de Servicios Conexos:',
                                 cardinalidad_maxima: 1},
                                {nombre: 'patente_industria_comercio',
                                 descripcion: 'Registro de la Patente de Industria y Comercio para uso educacional:',
                                 cardinalidad_maxima: 1},
                                {nombre: 'constancia_impuestos_municipales',
                                 descripcion: 'Constancia de pago de impuestos Municipales:',
                                 cardinalidad_maxima: 1},
                                {nombre:'impacto_ambiental_vial',
                                 descripcion: 'Estudio de impacto ambiental y víal',
                                 cardinalidad_maxima: 1},
                                {nombre: 'seguro_daño_terceros',
                                 descripcion:'Póliza de seguro a todo riesgo y daños a terceros:' ,
                                 cardinalidad_maxima: 1},
                                {nombre: 'organigrama_escuela',
                                 descripcion: 'Organigrama estructural de la escuela:',
                                 cardinalidad_maxima: 1}])

####### DOCUMENTOS DE INFRAESTRUCTURA (PLANOS) ######

vista_planos_infraestructura.documento_requisitos<<
    DocumentoRequisito.create!([{nombre:'deposito_bancario_infraestructura',
                                 descripcion:
                                     'Comprobante Deposito Bancario por pago de la Certificación de la  Infraestructura:',
                                 cardinalidad_maxima:1,
                                 paginado:true,
                                 obligatorio: true
                                },
                                {nombre:'permiso_municipal_construccion',
                                 descripcion:
                                     'Permiso Municipal de construcción:',
                                 cardinalidad_maxima:1,
                                 obligatorio: true
                                },
                                {nombre:'permiso_ingenieria_municipal',
                                 descripcion:
                                     'Permiso de Ingeniería Municipal(Variables Urbanas):',
                                 cardinalidad_maxima:1,
                                 obligatorio: true
                                },
                                {nombre:'propiedad_arrendamiento_inmueble',
                                 descripcion:
                                     'Documento de propiedad del inmueble o contrato de arrendamiento que faculte su uso:',
                                 cardinalidad_maxima:1,
                                 obligatorio: true
                                }
                               ])

grupoAlmenosUnoInfraestructura =
    GrupoDocumentosUno.create!(mensaje:
                                   'Debe ingresar almenos un documento de Planos (marcados con asterisco verde) ',
                               icon_color:'verde')

doc_planos_planta =
    DocumentoRequisito.create!(nombre:'Planta',
                               descripcion: 'Planta',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)

doc_planta_corte_lateral_izquierdo=
    DocumentoRequisito.create!(nombre:'Planta_corte_lateral_izquierdo',
                               descripcion: 'Planta corte lateral izquierdo',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)

doc_planta_corte_lateral_derecho =
    DocumentoRequisito.create!(nombre:'Planta_corte_lateral_derecho',
                               descripcion: 'Planta corte lateral derecho',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)
doc_fachada=
    DocumentoRequisito.create!(nombre:'fachada',
                               descripcion: 'Fachada',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)

doc_techo =
    DocumentoRequisito.create!( nombre:'techo',
                                descripcion: 'Techo',
                                cardinalidad_maxima:1,
                                obligatorio: false,
                                almenos_uno: true)
doc_aguas_negras =
    DocumentoRequisito.create!(nombre:'aguas_negras',
                               descripcion: 'Aguas Negras',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)
doc_aguas_blancas =
    DocumentoRequisito.create!(nombre:'aguas_blancas',
                               descripcion: 'Aguas Blancas',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)
doc_electricidad =
    DocumentoRequisito.create!( nombre:'electricidad',
                                descripcion: 'Electricidad',
                                cardinalidad_maxima:1,
                                obligatorio: false,
                                almenos_uno: true)

DocumentosRequisitosPorVista.create!([
                                         {
                                             vista: vista_planos_infraestructura,
                                             documento_requisito:  doc_planos_planta,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura

                                         },
                                         {   vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_planta_corte_lateral_izquierdo
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_planta_corte_lateral_derecho
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_fachada
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_techo
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_aguas_negras

                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_aguas_blancas
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_electricidad
                                         }
                                     ])
# #####################################################
# ####### DATOS DEL SEGURO RCV   ######################
# #####################################################
vista_rcv_flota.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'rcv_digital',
                                    descripcion:
                                        'Póliza RCV digital:',
                                    cardinalidad_maxima:1
                                   }
                               ])
# #####################################################
# ####### DOCUMENTOS DE VEHICULOS #####################
# #####################################################
vista_vehiculo_ensenanza.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'certificado_homologacion',
                                    descripcion:
                                        'Certificado de Homologación:',
                                    cardinalidad_maxima:1,
                                    obligatorio: false
                                   },
                                   {nombre:'certificado_registro_del_vehiculo',
                                    descripcion:
                                        'Certificado de Registro del Vehículo:',
                                    cardinalidad_maxima:1
                                   },
                                   {nombre:'certificado_revision_tecnica',
                                    descripcion: 'Certificado Revisión Técnica:',
                                    cardinalidad_maxima:1,
                                    obligatorio: true
                                   },
                                   {nombre:'Comprobante_de_pago_por_certificacion',
                                    descripcion: 'Comprobante de pago por certificación:',
                                    cardinalidad_maxima:1,
                                    obligatorio: true
                                   }
                               ])

# #####################################################
# ####### DOCUMENTOS DE ARRENDAMIENTO      ############
# #####################################################
vista_arrendamiento.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'arrendamiento_notariado',
                                    descripcion:
                                        'Contrato de arrendamiento notariado:',
                                    cardinalidad_maxima:1
                                   }
                               ])
# #####################################################
# ####### DOCUMENTOS CIRCUITOS DE MANEJO ##############
# #####################################################
vista_registro_circuitos_manejo.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'pago_certificacion',
                                    descripcion:
                                        'Comprobante de pago por la Certificación:',
                                    cardinalidad_maxima:1,
                                    paginado:true
                                   },
                                   {nombre:'planos_escala',
                                    descripcion:
                                        'planos_escala 1:1000:',
                                    cardinalidad_maxima:20,
                                    paginado:true
                                   }
                               ])
vista_registro_circuitos_manejo_abierto.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'permiso_circulacion',
                                    descripcion: 'Permiso circulación en vías públicas:',
                                    cardinalidad_maxima:1,
                                    obligatorio: true
                                   }
                               ])
# #####################################################
# ####### DOCUMENTOS REGISTRO DE TRABAJADORES##########
# #####################################################
vista_trabajadores.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'cedula',
                                    descripcion:
                                        'Cédula de identidad:',
                                    cardinalidad_maxima:1}
                               ])
vista_trabajadores_instructores.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'Licencia_instructor',
                                    descripcion:
                                        'Licencia de instructor:',
                                    cardinalidad_maxima:1,
                                   },
                                   {nombre:'certificado_medico_salud_integral',
                                    descripcion:
                                        'Certificado médico de salud integral:',
                                    cardinalidad_maxima:1,
                                   },
                                   {nombre:'Certificado_psicologico_conducir',
                                    descripcion: 'Certificado psicológico para conducir:',
                                    cardinalidad_maxima:1
                                   }
                               ])
puts '### PRODUCTION SEED END ###'
################################################
##### SEEDS PARA EL ENTORNO DE DESARROLLO ######
################################################

unless Rails.env.production?
  puts '### INICIO DE SEEDS PARA DESARROLLO Y TEST###'

  #usuarios 'externos' para probar en entornos de desarrollo y test
  userbiosoft = SessionUser.create!(email: 'biosoft@correo.com',
                                    email_confirmation: 'biosoft@correo.com',
                                    password:              '12345678',
                                    password_confirmation: '12345678',
                                    confirmed_at: Date.today,
                                    usuario_sput_id: 1
  )

  RepresentanteLegal.create!(
      estado_representante: 2,
      rif: 'V1911',
      usuario_sput_id:1,
      session_user_id: userbiosoft.id,
      direccion:'Mérida',
      remote_doc_rif_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu',
      remote_doc_cedula_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu'

  )

  userbiosoft2 = SessionUser.create!(email: 'biosoft2@correo.com',
                                     email_confirmation: 'biosoft2@correo.com',
                                     password:              '12345678',
                                     password_confirmation: '12345678',
                                     confirmed_at: Date.today,
                                     usuario_sput_id: 2
  )

  RepresentanteLegal.create!(
      estado_representante: 2,
      rif: 'V1922',
      usuario_sput_id:2,
      session_user_id: userbiosoft2.id,
      direccion:'Mérida',
      remote_doc_rif_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu',
      remote_doc_cedula_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu'
  )
  puts '### USUARIOS EXTERNOS DE PRUEBA CREADOS (TEST Y DEVELOPMENT) ###'


end