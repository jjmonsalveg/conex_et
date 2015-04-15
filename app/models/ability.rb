#encoding: utf-8
class Ability
  include CanCan::Ability

  def initialize(funcionario)
    unless funcionario.nil?
      funcionario.rols.each do |rol|
        rol.funcion_sistemas.each do |funcion_sistema|
          if funcion_sistema.clase_controlador == "all"
            can funcion_sistema.accion.to_sym, funcion_sistema.clase_controlador.to_sym
          elsif (funcion_sistema.clase_controlador.constantize rescue nil).nil?
            can funcion_sistema.accion.to_sym, funcion_sistema.clase_controlador.to_sym rescue nil
          else
            can funcion_sistema.accion.to_sym, funcion_sistema.clase_controlador.constantize rescue nil
          end
        end
      end
    end
  end

end