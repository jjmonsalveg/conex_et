namespace 'funcion_sistemas' do
  desc "Loading all models and their related controller methods inpermissions table."
  task(:funcion_sistemas => :environment) do
    arr = []
    #load all the controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        #check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*_?[a-z]*?$/
         Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
           if x =~ /_controller/
             arr << "#{entry.titleize.gsub(' ','')}::#{x.camelize.gsub('.rb', '')}".constantize
           end
         end
      end
    end
    arr.each do |controller|
      #only that controller which represents a model
      if controller.respond_to?(:funcion_sistema) && controller != "ApplicationController"
        #create a universal permission for that model. eg "manage User" will allow all actions on User model.
        write_permission(controller.funcion_sistema, "manage", 'manage') #add permission to do CRUD for every model.
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+[?|!]?)$/ #add_user, add_user_info, Add_user, add_User+
            nombre, cancan_action = eval_cancan_action(method)
            unless (nombre.blank? && cancan_action.blank?) || controller.funcion_sistema.nil?
              write_permission(controller.funcion_sistema, cancan_action, nombre)
            end
          end
        end
      end
    end
  end

  task(:barcode_folder => :environment) do
    require 'fileutils'
    dirname = File.dirname(Rails.root.join('public')) + '/public/Barcodes/'
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
      puts 'Barcodes Folder Created'
    end
  end
end

#this method returns the cancan action for the action passed.
def eval_cancan_action(accion)
  case accion.to_s
    when "index"
      nombre = 'list'
      cancan_action = "index" #let the cancan action be the actual method name
      action_desc = I18n.t :list
    when "new", "create"
      nombre = 'create and update'
      cancan_action = "create"
      action_desc = I18n.t :create
    when "show"
      nombre = 'view'
      cancan_action = "view"
      action_desc = I18n.t :view
    when "edit", "update"
      nombre = 'create and update'
      cancan_action = "update"
      action_desc = I18n.t :update
    when "delete", "destroy"
      nombre = 'delete'
      cancan_action = "destroy"
      action_desc = I18n.t :destroy
    else
      #Convencion de nombre de metodos publicos del sistema
      # wf = Web Function
      if accion =~ /^wf_/i
        nombre = accion.to_s
        cancan_action = accion.to_s
        action_desc = "Other: " < cancan_action
      end
  end
  return nombre, cancan_action
end

#check if the permission is present else add a new one.
def write_permission(modelo, cancan_action, nombre)
  permission = FuncionSistema.where(clase_controlador: modelo, accion: cancan_action).first
  if permission.nil?
    permission = FuncionSistema.new
    permission.nombre = nombre
    permission.clase_controlador = modelo
    permission.accion = cancan_action
    permission.save
    if permission.errors.any?
      puts permission.errors.inspect
    end
  else
    permission.nombre = nombre
    permission.save
  end

end