
# encoding: UTF-8
class SolicitudReport < Prawn::Document
  # Often-Used Constants

  @@interlineado            = 6
  @@margin                  = 20

  def initialize(escuela_transporte, solicitud, default_options={})
    super(default_options)
    @escuela_transporte = escuela_transporte
    @solicitud = solicitud
    @representante_legal = @escuela_transporte.representante_legal
    @usuario_sput = @representante_legal.usuario_sput
    # stroke_axis # pintar ejes
    header
    planilla
    font_size 8
    paginar
  end

  def header(project_title=nil, report_title=nil)
    # header
    bounding_box [bounds.left, bounds.top], :width => bounds.width do
      font "Helvetica"
      image "#{Rails.root}/app/assets/images/logo_ministerio.jpg", :at => [10,0],  scale: 0.25
      image "#{Rails.root}/app/assets/images/logo_planillas.png", :at => [450,0],  scale: 0.45
      text_box "República Bolivariana de Venezuela\nMinisterio del Poder Popular para Relaciones\nInteriores Justicia y Paz\nInstituto Nacional de Transporte Terrestre", :at => [110, -15], :align => :left, :size => 8
      text_box "Fecha de Emisión #{@solicitud.planilla_time.strftime("%d/%m/%Y")}", :at => [320, -15],  :size => 8
      text_box "PLANILLA ÚNICA DE TRAMITE", :at => [200, -80]
      move_down(80)
      text report_title, size: 12, style: :bold_italic, align: :center if report_title
    end
    move_down 20
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
      columns(0..3).size = 9
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
  def draw_table_two_columns(table_info, width_columns = [260, 260])
    table (table_info) do
      columns(0..1).border_width = 1
      columns(0..1).size = 9
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
      columns(0..1).size = 9
      self.column_widths = width_columns
    end
  end


  #Dibuja una tabla comun de 4 columnas =====================================
  def draw_table_four_columns(table_info, width_columns = [130, 130, 130, 130])
    table (table_info) do
      columns(0..3).border_width = 1
      columns(0..3).size = 8
      self.column_widths = width_columns
    end
  end
  #Dibuja una tabla comun de 5 columnas =====================================
  def draw_table_five_columns(table_info, width_columns = [100, 100, 100, 70, 130])
    table (table_info) do
      columns(0..4).border_width = 1
      columns(0..4).size = 9
      self.column_widths = width_columns
    end
  end

  #Dibuja una tabla comun de 6 columnas =====================================
  def draw_table_six_columns(table_info, width_columns = [100, 100, 100, 90, 90, 40])
    table (table_info) do
      columns(0..5).border_width = 1
      columns(0..5).size = 7
      self.column_widths = width_columns
    end
  end

  #Dibuja una tabla comun de 2 columnas =====================================
  def draw_pie_columns(table_info, width_columns = [260, 260])
    table (table_info) do
      columns(0).border_width = 1
      columns(0..1).size = 9
      rows(0..1).height = 150
      self.column_widths = width_columns
    end
  end

  def flota(list_flota, recursive = false)

    return if list_flota.empty?

    start_new_page if cursor <= 90

    indent(recursive ? 0 : @@margin) do
      table_info = [
          [{ content: "Flota (Vehículos)"}]
      ]
      width_columns = [520]
      draw_table_titulos_columns(table_info, width_columns)
      tabla_flota(list_flota)
    end
  end



  #Dibuja la tabla de los vehiculos para la solicitud de aumento de cupo
  def tabla_flota(list_flota)
    data = Array.new
    encabezado = make_table([ [{content: 'Placa', :width => 100, :size => 7},
                               {content: 'Modelo', :width => 100, :size => 7},
                               {content: 'Marca', :width => 100, :size => 7},
                               {content: 'Año', :width => 60, :size => 7},
                               {content: 'Serial de Carroceria', :width => 100, :size => 7}] ])
    table([
              [{content: "", :colspan => 7, :border_bottom_width => 0} ],
              [{content: "", :colspan => 1, :border_top_width => 0, :border_bottom_width => 0, :width => 30},
               {content: encabezado, :colspan => 5, :width => 460, background_color: 'd7d7d7'},
               {content: "", :colspan => 1,:border_top_width => 0, :border_bottom_width => 0,  :width => 30}]
          ])
    list_flota.each_with_index do |vehiculos,index|
      data = make_table([ [{content: vehiculos.placa,:width => 100, :size => 7 },
                           {content: vehiculos.modelo, :width => 100, :size => 7},
                           {content: vehiculos.marca, :width => 100, :size => 7},
                           {content: vehiculos.ano.to_s, :width => 60, :size => 7},
                           {content: vehiculos.s_carroceria,:width => 100, :size => 7 }] ])

      table([
                [{content: "", :colspan => 1, :border_top_width => 0, :border_bottom_width => 0,  :width => 30},
                 {content: data, :colspan => 5, :width => 460},
                 {content: "", :colspan => 1, :border_top_width => 0, :border_bottom_width => 0, :width => 30} ]

            ])
      if cursor <= 40
        table([
                  [{content: "", :colspan => 7, :border_top_width => 0, :width => 520}]
              ])
        start_new_page
        flota list_flota.slice(index+1,list_flota.length), true if index+1 <= list_flota.length
        return
      end
    end

    table([
              [{content: "", :colspan => 7, :border_top_width => 0, :width => 520}]
          ])

  end


  #Pie de la planilla para el solicitante  y el funcionario
  def pie_planilla

    sello = make_table([ [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: 'Sello:', :size => 6,  :border_bottom_width => 0 , :border_top_width => 1, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}] ,
                         [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                         [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}] ,
                         [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                         [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                         [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                         [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 1 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}]
                       ])

    huella = make_table([ [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: 'Huella Dactilar:', :size => 6,  :border_bottom_width => 0 , :border_top_width => 1, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}] ,
                          [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                          [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}] ,
                          [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                          [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                          [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}],
                          [{content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 120}, {content: '', :border_bottom_width => 1 , :border_top_width => 0, :width => 100}, {content: '', :border_bottom_width => 0 , :border_top_width => 0, :width => 40}]
                        ])
    table( [
               [{content:'Nombre:',  colspan: 1,:size => 6, :border_bottom_width => 0 , :border_top_width => 0, :width => 260}, {content:'Lugar:',  colspan: 1,:size => 6, :border_bottom_width => 0 , :border_top_width => 0, :width => 260}],
               [{content:'C.I:', :size => 6, :border_bottom_width => 0 , :border_top_width => 0,  colspan: 1, :width => 260 }, {content:'Fecha:',  colspan: 1,:size => 6, :border_bottom_width => 0 , :border_top_width => 0, :width => 260}],
               [{content:'Fecha:',  colspan: 1, :size => 6, :border_bottom_width => 0 , :border_top_width => 0, :width => 260}, {content:'Firma:',  colspan: 1, :size => 6, :border_bottom_width => 0 , :border_top_width => 0, :width => 260}],
               [ {content: sello,  colspan: 1, :border_top_width => 0,:border_bottom_width => 0, :width => 260}, {content: huella, colspan: 1, :border_bottom_width => 0 , :border_top_width => 0, :width => 260}],
               [ {content: '',  colspan: 1, :border_top_width => 0, :border_bottom_width => 1, :width => 260}, {content: '', colspan: 1, :border_bottom_width => 1 , :border_top_width => 0, :width => 260}]
           ])

  end

  #===========================================================
  #                                                          #
  #           Generar la Planilla de la solicitud            #
  #                                                          #
  #                                                          #
  #===========================================================

  def planilla
    move_down(@@interlineado)
    # parte 1
    indent(@@margin) do
      table_info = [
          [ {image: "#{Rails.root}/public/Barcodes/Code128B_#{@solicitud.numero_planilla}.png"},
            {content: "\nNúmero de Planilla: #{sprintf '%013d', @solicitud.numero_planilla }"}]
      ]
      width_columns = [260, 260]
      draw_table_two_columns(table_info, width_columns)
    end
    # parte 2
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
          [ {content:"Nombre y Apellido: #{@usuario_sput.nombre + ' ' + @usuario_sput.apellido}",  colspan: 2},
            {content:"Identificación: #{@usuario_sput.nacionalidad + ' ' + @usuario_sput.numero_doc}",
             colspan: 2}],
          [{content:"Teléfonos: #{telefono @usuario_sput.telefono_local}",  colspan: 2},{content:"Correo Electrónico: #{@usuario_sput.session_user.email} ",  colspan: 2}],
          [{ content:"Dirección: #{@representante_legal.direccion}",  colspan: 4}]
      ]
      width_columns = [130, 130, 130, 130]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_four_columns(table_info, width_columns)
    end
    # parte 3
    indent(@@margin) do
      table_info = [
          ['Datos de la Escuela de Transporte']
      ]
      width_columns = [520]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_titulos_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [ {content:"Nombre: #{@escuela_transporte.razonSocial}",  colspan: 2},
            {content:"Nombre Comercial: #{@escuela_transporte.razonSocial}",  colspan: 2}],
          [  {content:"Tipo de Escuela: #{@escuela_transporte.tipo_escuela.nombre}  ",  colspan: 2},
             {content:"Rif: #{@escuela_transporte.tipo_rif+@escuela_transporte.rif.to_s+ @escuela_transporte.digito_rif.to_s}  ",  colspan: 2}],
          [{content:"Teléfono: #{telefono @escuela_transporte.telefono} ",  colspan: 2},
           {content:"Teléfono Móvil: #{telefono @escuela_transporte.movil}",  colspan: 2}],
          [{content:"Email: #{@escuela_transporte.email} ",  colspan: 2},
           {content:"Dirección Web: #{@escuela_transporte.url}",  colspan: 2}],

      ]
      width_columns = [130, 130, 130, 130]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_four_columns(table_info, width_columns)
    end

    indent(@@margin) do
      table_info = [
          ['Dirección Fiscal']
      ]
      width_columns = [520]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_titulos_columns(table_info, width_columns)
    end

    indent(@@margin) do
      table_info = [
          [{content:"Estado: #{@escuela_transporte.ciudad.estado.nombre}",  colspan: 1,  :size => 6},
           {content:"Ciudad: #{@escuela_transporte.ciudad.nombre}  ",  colspan: 1,  :size => 6},
           {content:"Municipio: #{@escuela_transporte.parroquia.municipio.nombre}",  colspan: 1,  :size => 6},
           {content:"Parroquia: #{@escuela_transporte.parroquia.nombre}",  colspan: 1,  :size => 6}],
          [{content:"Sector/Urbanización: #{@escuela_transporte.direccion}",  colspan: 4}]

      ]
      width_columns = [130, 130, 130, 130]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_four_columns(table_info, width_columns)

    end
    # parte 4

    indent(@@margin) do
      table_info = [
          ['Trámites']
      ]
      width_columns = [520]
      draw_table_titulos_columns(table_info, width_columns)
    end
    indent(@@margin) do
      table_info = [
          [ {content: "Trámite: Autorización para la construcción y adecuación ",  colspan: 2, :size => 6},
            {content: "Número de Trámite: #{sprintf '%012d',@solicitud.id}",  colspan: 2, :size => 6}]
      ]
      width_columns = [130,130,130,130]
      draw_table_four_columns(table_info, width_columns)
    end

    # parte 5
    flota(@solicitud.vehiculo_pres)

    # parte 6
    start_new_page if cursor <= 200
    indent(@@margin) do
      table_info = [
          [ 'Funcionario Receptor', 'Solicitante']
      ]
      width_columns = [260, 260]

      # Aplica el formato de la tabla creada anteriormente
      draw_table_pie_columns(table_info, width_columns)
      pie_planilla
    end

  end

  private

  def telefono (telf)
    telf.insert(0,'0')
    telf.insert(4,'-')
    telf
  end
end
