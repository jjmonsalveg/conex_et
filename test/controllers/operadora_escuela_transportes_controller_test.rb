require 'test_helper'

class OperadoraEscuelaTransportesControllerTest < ActionController::TestCase
  setup do
    @escuela_transporte = operadora_escuela_transportes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:escuela_transportes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operadora_escuela_transporte" do
    assert_difference('OperadoraEscuelaTransporte.count') do
      post :create, escuela_transporte: { avenida: @escuela_transporte.avenida, calle: @escuela_transporte.calle, codigoET: @escuela_transporte.codigoET, edificio_cc: @escuela_transporte.edificio_cc, email: @escuela_transporte.email, local: @escuela_transporte.local, movil: @escuela_transporte.movil, piso: @escuela_transporte.piso, razonSocial: @escuela_transporte.razonSocial, rif: @escuela_transporte.rif, telefono: @escuela_transporte.telefono, urbanizacion: @escuela_transporte.urbanizacion, url: @escuela_transporte.url }
    end

    assert_redirected_to operadora_escuela_transporte_path(assigns(:escuela_transporte))
  end

  test "should show operadora_escuela_transporte" do
    get :show, id: @escuela_transporte
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @escuela_transporte
    assert_response :success
  end

  test "should update operadora_escuela_transporte" do
    patch :update, id: @escuela_transporte, escuela_transporte: { avenida: @escuela_transporte.avenida, calle: @escuela_transporte.calle, codigoET: @escuela_transporte.codigoET, edificio_cc: @escuela_transporte.edificio_cc, email: @escuela_transporte.email, local: @escuela_transporte.local, movil: @escuela_transporte.movil, piso: @escuela_transporte.piso, razonSocial: @escuela_transporte.razonSocial, rif: @escuela_transporte.rif, telefono: @escuela_transporte.telefono, urbanizacion: @escuela_transporte.urbanizacion, url: @escuela_transporte.url }
    assert_redirected_to operadora_escuela_transporte_path(assigns(:escuela_transporte))
  end

  test "should destroy operadora_escuela_transporte" do
    assert_difference('OperadoraEscuelaTransporte.count', -1) do
      delete :destroy, id: @escuela_transporte
    end

    assert_redirected_to operadora_escuela_transportes_path
  end
end
