# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
  helper_method :resource, :resource_name, :devise_mapping
  def home
  end

  def resource_name
    :session_user
  end

  def resource
    @resource ||= SessionUser.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:session_user]
  end
  protected
    def self.funcion_sistema
      return "StaticPage"
    end
end

