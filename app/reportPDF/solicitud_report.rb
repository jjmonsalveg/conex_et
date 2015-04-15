
# encoding: UTF-8
class SolicitudReport < Prawn::Document
  # Often-Used Constants

  @@interlineado            = 6
  @@margin                  = 10

  def initialize(escuela_transporte, solicitud, default_options={})
    super(default_options)
    @escuela_transporte = escuela_transporte
    @solicitud = solicitud
    header
    organizacion_transporte
    font_size 8
    start_new_page
    header_two
    relacion_flota
    paginar
  end

  def header(project_title=nil, report_title=nil)
    # header
    bounding_box [bounds.left, bounds.top], :width => bounds.width do
      font "Helvetica"
      image "#{Rails.root}/app/assets/images/logo_ministerio.jpg", :at => [10,0],  scale: 0.25
      image "#{Rails.root}/app/assets/images/logo_planillas.png", :at => [450,0],  scale: 0.45
      text_box "República Bolivariana de Venezuela\nMinisterio del Poder Popular para Relaciones\nInteriores Justicia y Paz\nInstituto Nacional de Transporte Terrestre", :at => [115, -25], :align => :left, :size => 9
      text_box "Fecha de Emisión\n#{@solicitud.planilla_time.strftime("%d/%m/%Y")}", :at => [380, -25], :align => :left, :size => 9
      text_box "PLANILLA ÚNICA DE TRAMITE", :at => [200, -90]
      move_down(110)
      text report_title, size: 12, style: :bold_italic, align: :center if report_title
    end
    move_down 10
  end

  def header_two
    bounding_box [bounds.left, bounds.top], :width => bounds.width do
      font "Helvetica"
      image "#{Rails.root}/app/assets/images/logo_ministerio.jpg", :at => [10,0],  scale: 0.25
      image "#{Rails.root}/app/assets/images/logo_planillas.png", :at => [450,0],  scale: 0.45
      text_box "República Bolivariana de Venezuela\nMinisterio del Poder Popular para Relaciones\nInteriores Justicia y Paz\nInstituto Nacional de Transporte Terrestre", :at => [115, -25], :align => :left, :size => 9
      text_box "Fecha de Emisión\n#{@solicitud.planilla_time.strftime("%d/%m/%Y")}", :at => [380, -25], :align => :left, :size => 9
      text_box "Relación de Flota Vehicular", :at => [200, -90], :size => 12, :style => :bold
      move_down(110)
    end
    move_down 10
  end

  def paginar
    page_count.times do |i|
      bounding_box([bounds.left, bounds.bottom], :width => bounds.width, :height => 30) {
        go_to_page i+1
        text "#{i+1}/#{page_count}", :align => :center
      }
    end
  end

  #Dibuja una tabla de 1 columna para titulos del encabezado =====================================
  def draw_table_titulos_columns(table_info, width_columns = [520])
    table (table_info) do
      rows(0).background_color = 'd7d7d7'
      rows(0).border_width = 1
      columns(0..3).font_style = :bold
      columns(0).border_width = 1
      columns(0..3).size = 10
      self.column_widths = width_columns
    end
  end
  #Dibuja una tabla de 1 columna para titulos del encabezado =====================================
  def draw_table_second_title_columns(table_info, width_columns = [260, 260])
    table (table_info) do
      rows(0).background_color = 'F0F0F0'
      rows(0).border_width = 1
      columns(0).border_width = 1
      columns(0..1).font_style = :bold
      columns(0..1).size = 9
      self.column_widths = width_columns
    end
  end
  #Dibuja una tabla de 2 columnas para código de barras y numero de planilla ========================
  def draw_table_barcode_columns(table_info, width_columns =  [260, 260])
    table (table_info) do
      rows(0).border_width = 1
      columns(0).border_width = 1
      columns(0..1).size = 10
      self.column_widths = width_columns
    end
  end

  #Dibuja una tabla de 1 columna para titulos para el final de la planilla ========================
  def draw_table_pie_columns(table_info, width_columns =  [260, 260])
    table (table_info) do
      rows(0).background_color = 'F5F5F6'
      rows(0).border_width = 1
      columns(0..1).font_style = :bold
      columns(0).border_width = 1
      columns(0..1).size = 8
      self.column_widths = width_columns
    end
  end
  #Dibuja una tabla de 5 columnas para los Vehículos
  def draw_table_five_columns(table_info, width_columns =  [100, 100, 100, 100, 120])
    table (table_info) do
      rows(0).background_color = 'F5F5F6'
      rows(0).border_width = 1
      columns(0..4).font_style = :bold
      columns(0).border_width = 1
      columns(0..4).size = 8
      self.column_widths = width_columns
    end
  end


  #Dibuja una tabla comun de 4 columnas =====================================
  def draw_table_four_columns(table_info, width_columns = [130, 130, 130, 130])
    table (table_info) do
      columns(0..3).border_width = 1
      columns(0..3).size = 9
      self.column_widths = width_columns
    end
  end

  #Dibuja una tabla comun de 4 columnas =====================================
  def draw_pie_columns(table_info, width_columns = [260, 260])
    table (table_info) do
      columns(0).border_width = 1
      columns(0..1).size = 9
      rows(0..1).height = 150
      self.column_widths = width_columns
    end
  end

  # Tabla de la Planilla de solicitud  ====================
  def organizacion_transporte
    move_down(@@interlineado)
    indent(@@margin) do
      table_info = [
          [ {image: "#{Rails.root}/public/Barcodes/Code128B_#{@solicitud.numero_planilla}.png"}, {content: "\nNúmero de Planilla: #{sprintf '%013d', @solicitud.numero_planilla}"}]
      ]
      width_columns = [260, 260]
      draw_table_barcode_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          ['Datos del Solicitante']
      ]
      width_columns = [520]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_titulos_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [ {content:"Nombre y Apellido:  #{@escuela_transporte.representante_legal.usuario_sput.nombre + ' ' + @escuela_transporte.representante_legal.usuario_sput.apellido}",  colspan: 2},  {content:"Identificación:  #{@escuela_transporte.representante_legal.usuario_sput.nacionalidad+'-'+@escuela_transporte.representante_legal.usuario_sput.numero_doc}",  colspan: 2}],
          [{content:"Teléfonos:  #{ @escuela_transporte.representante_legal.usuario_sput.telefono_local.nil? ? '' : '('+@escuela_transporte.representante_legal.usuario_sput.telefono_local[0..2]+')'+' '+@escuela_transporte.representante_legal.usuario_sput.telefono_local[3..5]+'-'+@escuela_transporte.representante_legal.usuario_sput.telefono_local[6..9]+' , '} #{@escuela_transporte.representante_legal.usuario_sput.movil_show}",  colspan: 2},{content:"Correo Electrónico:  #{@escuela_transporte.representante_legal.session_user.email}",  colspan: 2}],
          [{ content:'Dirección: -',  colspan: 4}]
      ]
      width_columns = [130, 130, 130, 130]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_four_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          ['Trámites']
      ]
      width_columns = [520]
      draw_table_titulos_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [ {content: "Trámite"}, {content: "Número de Trámite"}]
      ]
      width_columns = [260, 260]
      draw_table_second_title_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [ {content: "#{@solicitud.tipo_solicitud.descripcion}",  colspan: 2},  {content: "#{sprintf '%012d', @solicitud.id}",  colspan: 2}]
      ]
      width_columns = [130, 130, 130, 130]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_four_columns(table_info, width_columns)
    end
    # parte 1
    indent(@@margin) do
      table_info = [
          ['Datos de la Operadora']
      ]
      width_columns = [520]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_titulos_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [ {content:"Nombre: #{@escuela_transporte.razonSocial}",  colspan: 2},  {content:"Rif:  #{@escuela_transporte.rif_show}",  colspan: 2}],
          [{content:"Teléfono:  #{@escuela_transporte.telefono_show}",  colspan: 2},{content:"Teléfono Móvil: #{@escuela_transporte.movil_show}",  colspan: 2}],
          [{ content:"Dirección Fiscal: #{@escuela_transporte.direccion}",  colspan: 4}],
      ]
      width_columns = [130, 130, 130, 130]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_four_columns(table_info, width_columns)
    end
    # parte 6
    indent(@@margin) do
      table_info = [
          ['Solicitante', 'Funcionario Receptor']
      ]
      width_columns = [260, 260]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_pie_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [{image: "#{Rails.root}/app/assets/images/solicitante_aux.jpg", scale: 0.50}, {image: "#{Rails.root}/app/assets/images/funcionario_receptor_aux.jpg", scale: 0.50}]
      ]
      width_columns = [260, 260]

      draw_pie_columns(table_info, width_columns)
    end
  end

  def relacion_flota
    move_down(@@interlineado)
    indent(@@margin) do
      table_info = [
          [ {image: "#{Rails.root}/public/Barcodes/Code128B_#{@solicitud.numero_planilla}.png"}, {content: "\nNúmero de Planilla: #{sprintf '%013d', @solicitud.numero_planilla}"}]
      ]
      width_columns = [260, 260]
      draw_table_barcode_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          ['Vehículos']
      ]
      width_columns = [520]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_titulos_columns(table_info, width_columns)
    end
    @escuela_transporte.vehiculo_pres.each do |vehiculo|
      indent(@@margin) do
        table_info = [
            [ {content:"Placa: #{vehiculo.placa}"},  {content:"Modelo: #{vehiculo.modelo}"}, {content:"Marca: #{vehiculo.marca }"},{content:"Año: #{vehiculo.ano}"},{content:"S. de Carroceria: #{vehiculo.s_carroceria}"}]
        ]
        width_columns = [100, 100, 100, 100, 120]

        # Aplica el formato de la tabla creada anteriormente
        draw_table_five_columns(table_info, width_columns)
      end
    end
  end
end
