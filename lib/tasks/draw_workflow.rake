namespace :workflow do
  desc "Generate a workflow graph for a model passed e.g. as NAME= WF_Preinscripcion FORMAT= png"
  task :draw => :environment do
    # require 'workflow/draw'
    # Workflow::Draw::workflow_diagram(ENV['MODEL'].constantize)
    require 'graphviz'
    workflow_solicitud =  WorkFlow.includes(:estados_work_flows,:eventos_work_flows).find_by(nombre: ENV['NAME'])
    if workflow_solicitud.nil?
      puts 'Workflow no existe'
    else

      g = GraphViz.new(:G,rankdir: 'LR')
      workflow_solicitud.estados_work_flows.each do |wf_state|
        nodeA = g.add_node(wf_state.nombre)

        wf_state.salidas.each do | salida|

          nodeB = g.add_node(salida.estado_destino.nombre)
          edge = g.add_edge(nodeA, nodeB)
          edge[:label] = salida.EventosWorkFlow.nombre
        end

      end
      g.output( ENV['FORMAT'].to_sym => "#{ENV['NAME']}.#{ENV['FORMAT']}" )
      puts 'work flow: '+ ENV['NAME'].to_s+' creado'
    end

  end
end