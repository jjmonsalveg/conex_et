module SessionUsersHelper
  def autorized_user
      unless current_session_user.representante_legal.autorizado?
        store_location
        flash[:danger]= 'Debes cambiar tu clave para activar tu cuenta'
        redirect_to cambio_contrasena_session_user_path
        return
      end
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_autorized_url] || default)
    session.delete(:forwarding_autorized_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_autorized_url] = request.url if request.get?
  end

  def devise_error_messages_modified!

    messages = resource.errors.map { |name,msg| content_tag(:li,
                                                            msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end


