class Funcionarios::RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]
  before_action :set_funcionario, only: [:show, :edit_rols_funcionario, :update_funcionario]
  @@password = ""

  def new_funcionario
    unless signed_in?
      redirect_to root_url and return
    end
    @funcionario ||= Funcionario.new
    authorize! :new, Funcionario
  end

  def create_funcionario
    if signed_in?
      @funcionario = Funcionario.new(funcionario_params)
      @@password = funcionario_params[:password]
      respond_to do |format|
        if @funcionario.save
          FuncionarioMailer.send_password(@funcionario, @@password).deliver
          format.html { redirect_to funcionarios_show_funcionario_path(@funcionario), notice: 'El funcionario se ha creado exitosamente.' }
          format.json { render :show, status: :created, location: @funcionario }
        else
          format.html { render :new_funcionario }
          format.json { render json: @funcionario.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url and return
    end
    authorize! :create, Funcionario
  end

  def show
    @pass = @@password
    @@password = ""
    authorize! :show, Funcionario
  end

  def edit_funcionario
    authorize! :update, Funcionario
  end

  def buscar_funcionarios
    if params[:query]==""
      @funcionarios = Funcionario.all.page(params[:page])
    else
      @funcionarios = Funcionario.funcionario_search(params[:query]).page(params[:page])
    end
    render partial: 'found_funcionarios'
    authorize! :update, Funcionario
  end

  def edit_rols_funcionario
    authorize! :update, Funcionario
  end

  def update_funcionario
    if signed_in?
      respond_to do |format|
        if @funcionario.update(funcionario_params)
          format.html { redirect_to funcionarios_show_funcionario_path(@funcionario), notice: 'Los datos del funcionario se han actualizado satisfactoriamente.' }
          format.json { render :show, status: :ok, location: @funcionario }
        else
          format.html { render :edit_rols_funcionario }
          format.json { render json: @funcionario.errors, status: :unprocessable_entity }
        end
      end
    end
    authorize! :update, Funcionario
  end

  # POST /resource
  #  def create
  #    super
  #  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def current_ability
      @current_ability ||= Ability.new(current_funcionario)
    end
    def resource_name
      :funcionario
    end
    def set_funcionario
      @funcionario = Funcionario.find_by(id: ActionController::Parameters.new(id: params[:id]).permit(:id)[:id])
    end

    def funcionario_params
      params.require(:funcionario).permit(:login, :password,  :email, rol_ids: [])
    end

    def rol_params
      params.require(:rol).permit(:rol_id)
    end

end
