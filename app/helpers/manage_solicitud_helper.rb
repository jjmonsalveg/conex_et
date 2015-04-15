module ManageSolicitudHelper
# ########################################################
# ########## PARAMETROS PARA GUARDAR DOCUMENTOS ##########
# ########################################################
#   def escuela_transporte_doc_params
#     params.require(:escuela_transporte).permit(solicituds_attributes: [ :id,
#                                                                         documentos_attributes:
#                                                                             [:id, :documento_requisito_id,
#                                                                              :doc
#                                                                             ]
#                                                ]
#     )
#   end
  #######################################################################################
  ########## METODO PARA INICIALIZAR LOS DOCUMENTOS Y MOSTRARLOS EN LAS VISTAS ##########
  ########## SEGUN EL NOMBRE DE LA SOLICITUD Y EL GRUPO DE REQUISITOS ###################
  ########## FUNCIONA PARA CUALQUIER MODELO ASOCIADO A SOLICITUD ########################
  #######################################################################################
  def init_solicitud(nombre_solicitud, modelo)

    solicitud = modelo.solicituds.joins(:tipo_solicitud).find_by(tipo_solicituds: {nombre: nombre_solicitud})

    if solicitud.blank?
      tipo_solicitud = TipoSolicitud.find_by(nombre: nombre_solicitud)
      solicitud = modelo.id.blank? ? modelo.solicituds.build(tipo_solicitud: tipo_solicitud) : modelo.solicituds.create!(tipo_solicitud: tipo_solicitud)
    end
    @solicitud = solicitud
  end

  def load_solicitud(model)
    init_solicitud(nombre_solicitud, model)
    load_documentos(nombre_vista,@solicitud)
  end

#
#
#   def loop_build_documentos(documento_requisitos, solicitud)
#     documento_requisitos.each do |documento_requisito|
#       solicitud.documentos.build(documento_requisito: documento_requisito)
#     end
#   end

  # def cargar_documentos(documento_requisitos, solicitud)
  #   @documentos = Array.new
  #   solicitud.documentos.to_a.each do |d|
  #     documento_requisitos.each do |documento|
  #       if d.documento_requisito_id == documento[:id]
  #         @documentos<<d
  #         break
  #       end
  #     end
  #   end
  # end
  #
  # def cargar_documentos_verificacion(solicitud, tramite)
  #   documento_requisitos =
  #       DocumentoRequisito.find_by_solicitud_grupo_requisitos(nombre_solicitud,
  #                                                             tramite)
  #   cargar_documentos(documento_requisitos,solicitud)
  # end
end