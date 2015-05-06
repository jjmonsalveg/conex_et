module ApplicationHelper

  #METODOS DE PARA CONFIGURAR GUI
  def full_title(page_title='')
    base_title= 'CONEX-ET'
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end

  #Teléfonos moviles para todas las vistas

  #lista de operadoras de moviles
  def generar_lista_operadoras_movil
    @lista_operadoras = {
        '0416' =>'416',
        '0426' =>'426',
        '0412' =>'412',
        '0414' =>'414',
        '0424' =>'424'
    }
  end

  #buscar movile en bd y prepararlo para separar operadora de número
  def cargar_movil( model = nil)
    unless model.nil?
      @operadora_movil_value = model.movil[0..2]
      model.movil= model.movil[3..9]
      return
    end

    return @operadora_movil_value = 416
  end

  #Tomar el movil desde la vista y prepararlo para guardar
  def set_movil_for_save(model)

    original_movil = params[model.class.to_s.underscore.to_sym][:movil]

    unless original_movil.blank?
      model.movil=
          params[:operadora_movil] + original_movil
    end

    original_movil
  end

  #Tomar el movil desde la vista y prepararlo para guardar
  def set_movil_for_update(model)

    original_movil = params[model.class.to_s.underscore.to_sym][:movil]

    unless original_movil.blank?
      params[model.class.to_s.underscore.to_sym][:movil]=
          params[:operadora_movil] + original_movil
    end

    original_movil
  end

  #Restaura el numero movil al original de la vista
  def restart_movil_view(original_movil,model)
    @operadora_movil_value = params[:operadora_movil]
    model.movil = original_movil
  end


  #MANEJO DE SESIONES
  def current_usuario
    funcionario_signed_in? ? current_funcionario : current_session_user
  end

  def usuario
    current_usuario.class.name.underscore.downcase
  end

  def if_signed_in?
    if signed_in?
      flash[:danger]='Ya has iniciado sesión'
      redirect_to root_url
      return
    end
  end

  #METODOS DE LOGICA Y COMPARACIÓN
  def concatenar_cadenas(cad1,cad2)
    if cad1.nil?
      if cad2.nil?
        return ''
      else
        return cad2
      end
    else
      if cad2.nil?
        return cad1
      else
        cad1 << ' '<< cad2
      end
    end
  end

  def menor_edad? (fecha_nacimiento)
    ( (Date.today - fecha_nacimiento).to_f/365.25).to_i < 18
  end

  def espacios_blancos_l_r(cad)
    cad.lstrip.rstrip
  end

  def igual_i_sin_blancos ( cad1, cad2)
    espacios_blancos_l_r(cad1).casecmp(espacios_blancos_l_r(cad2)) == 0
  end


  def pdf_preview(pdf)
    require 'RMagick'
    pdf = Magick::ImageList.new(pdf)
    thumb = pdf.scale(300, 300)
    thumb.write "doc.png"
  end
end
