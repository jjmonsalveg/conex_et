require 'test_helper'

class InteresadoCetsControllerTest < ActionController::TestCase
  setup do
    @interesado_cet = interesado_cets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interesado_cets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interesado_cets" do
    assert_difference('InteresadoCet.count') do
      post :create, interesado_cets: { apellido: @interesado_cet.apellido, email: @interesado_cet.email, nacionalidad: @interesado_cet.nacionalidad, nombre: @interesado_cet.nombre, numero_doc: @interesado_cet.numero_doc, telefono: @interesado_cet.telefono }
    end

    assert_redirected_to interesado_cet_path(assigns(:interesado_cets))
  end

  test "should show interesado_cets" do
    get :show, id: @interesado_cet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @interesado_cet
    assert_response :success
  end

  test "should update interesado_cets" do
    patch :update, id: @interesado_cet, interesado_cets: { apellido: @interesado_cet.apellido, email: @interesado_cet.email, nacionalidad: @interesado_cet.nacionalidad, nombre: @interesado_cet.nombre, numero_doc: @interesado_cet.numero_doc, telefono: @interesado_cet.telefono }
    assert_redirected_to interesado_cet_path(assigns(:interesado_cets))
  end

  test "should destroy interesado_cets" do
    assert_difference('InteresadoCet.count', -1) do
      delete :destroy, id: @interesado_cet
    end

    assert_redirected_to interesado_cets_path
  end
end
