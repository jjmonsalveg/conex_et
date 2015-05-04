class EscuelaTransportes::PersonalsController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion ,only:[:index, :find,:found,:save,:edit, :update]
  before_action :cargar_representante
  before_action :cargar_rif
  helper_method :nombre_solicitud
  helper_method :reload_documents?

  def index
    init_solicitud(nombre_solicitud,@escuela_transporte)
    centinel =  @solicitud.personals.empty? ? true : false

    @solicitud.personals.each do  |personal|
      if not personal.documentos_registro_completos?
        centinel =true
        break
      end
    end

    if centinel
      @solicitud.update_index_mask(5,false)
    else
      @solicitud.update_index_mask(5)
    end
  end

  def edit
    init_solicitud(nombre_solicitud,@escuela_transporte)
    @personal = @solicitud.personals.find_by(id: params[:personal_id])
  end

  def find
    init_solicitud(nombre_solicitud,@escuela_transporte)
  end

  def instructor_documents
    render partial: 'escuela_transportes/personals/instructor_documents_partial'
  end

  def found
    #buscamos en saime si este ciudadano existe
    @error = nil
    if Personal.find_by(cedula: params[:trabajador][:cedula]).present?
      flash[:danger]=
          'Trabajador Pertenece a otra Escuela de Transporte'
      @error =true
    else
      ciudadano = Tciudadano.find_cedula(params[:trabajador][:cedula])
      if ciudadano.nil?
        flash[:danger]= 'Cédula no encontrada'
        @error = true
      else
        nacionalidad = params[:trabajador][:nacionalidad]

        begin
          fecha =  (params[:trabajador]["fecha_nacimiento(3i)"]).to_s+
              "/" + (params[:trabajador]["fecha_nacimiento(2i)"]).to_s +
              "/" + (params[:trabajador]["fecha_nacimiento(1i)"]).to_s
          fecha = fecha.to_date
        rescue
          flash[:danger]=
              'Fecha introducida en formato inválido'
          @error =true
        end

        if( nacionalidad == ciudadano.dnacionalidad and
            fecha == ciudadano.ffecha_nac.to_date)

          if menor_edad?(fecha)
            flash[:danger]=
                'El ciudadano debe ser mayor de edad '
            @error = true
          else
            @personal= Personal.new(nombre: concatenar_cadenas(ciudadano.dnombre_1, ciudadano.dnombre_2),
                                    apellido: concatenar_cadenas(ciudadano.dapellido_1,ciudadano.dapellido_2),
                                    cedula: ciudadano.ccedula, nacionalidad: ciudadano.dnacionalidad)
          end

        else
          flash[:danger]= 'Combinación de campos no Existente, verifique sus datos '
          @error = true
        end
      end
    end

  end

  def save
    ciudadano = Tciudadano.find_cedula(params[:personal][:cedula])

    if ciudadano.nil?
      flash[:danger]= 'Cédula no encontrada'
    else
      nacionalidad = params[:personal][:nacionalidad]

      if nacionalidad == ciudadano.dnacionalidad

        if menor_edad?(ciudadano.ffecha_nac.to_date)
          flash[:danger]=
              'El ciudadano debe ser mayor de edad '
        else
          init_solicitud(nombre_solicitud,@escuela_transporte)

          params[:personal][:nombre]       = concatenar_cadenas(ciudadano.dnombre_1, ciudadano.dnombre_2)
          params[:personal][:apellido]     = concatenar_cadenas(ciudadano.dapellido_1,ciudadano.dapellido_2)
          params[:personal][:cedula]       = ciudadano.ccedula
          params[:personal][:nacionalidad] = ciudadano.dnacionalidad

          @personal = @solicitud.personals.build(params_new_personal)

          if @personal.save
            flash[:success]= 'Trabajador Guardado Satisfactoriamente'
            @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(5)
            render js: "window.location = '#{escuela_transportes_listar_personals_path(id: @escuela_transporte.id)}'"
            return
          end
        end

      else
        flash[:danger]= 'Combinación de campos no Existente, verifique sus datos '
      end
    end
  end

  def update
    init_solicitud(nombre_solicitud,@escuela_transporte)
    @personal = @solicitud.personals.find_by(id: params[:personal_id])

    if @personal.update(params_edit_personal)
      if !@personal.instructor?
        @personal.documentos_vista(:trabajadores_instructores).each do  |documento|
          documento.destroy
        end
      end
      flash[:success]= 'Trabajador Guardado Satisfactoriamente'
      @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(5)
      redirect_to escuela_transportes_listar_personals_path(id: @escuela_transporte.id)
    else
      render 'escuela_transportes/personals/edit'
    end
  end

  def remove
    personal= Personal.includes(:solicitud).find_by(id: params[:id])
    if personal.present?
      escuela = @representante_legal.escuela_transportes.joins(:solicituds).where(solicituds:{id: personal.solicitud.id}).last
      if  escuela.nil?
        flash[:danger] = 'Este Trabajador no existe para ninguna de sus Escuelas'
        redirect_to root_path
      else
        personal.destroy
        solicitud = Solicitud.includes(:personals).find_by(id: personal.solicitud.id)
        flash[:success] = 'Trabajador Eliminado con exito'

        if solicitud.personals.empty?
          solicitud.update_index_mask(5,false)
        end

        redirect_to escuela_transportes_listar_personals_path(id: escuela.id)
      end
    else
      flash[:danger] = 'Este Trabajador no existe'
      redirect_to root_path
    end
  end


  def nombre_solicitud
    :preinscripcion
  end

  private

  def cargar_rif
    #TODO Arreglar el RIF de representante legal, o este rif
    @rif = @representante_legal.rif[0]
    @rif +='-'
    @rif += @representante_legal.rif[1..@representante_legal.rif.length-2]
    @rif +='-'
    @rif +=@representante_legal.rif[@representante_legal.rif.length-1]
  end

  def cargar_representante
    @representante_legal =  current_session_user.representante_legal
  end

  def params_new_personal
    params.require(:personal).permit(:nombre,:apellido,:cedula,:nacionalidad,:tipo_personal,
                                     documentos_attributes:
                                         [:id, :documentos_requisitos_por_vista_id,:doc])
  end

  def params_edit_personal
    params.require(:personal).permit(:tipo_personal, documentos_attributes: [:id, :documentos_requisitos_por_vista_id,
                                                                             :doc ])
  end

end
