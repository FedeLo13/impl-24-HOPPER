require 'minitest/autorun'
require_relative 'aspectos.rb'

class TestUser < Minitest::Test
  def setup
    @user = User.new("Juanito32", "contraseña123")
  end

  def test_login_account_successful
    assert_output("¡Bienvenido Juanito32!\n[AUDIT] El usuario 'Juanito32' ha iniciado sesión correctamente\n") do
      @user.login_account("Juanito32", "contraseña123")
    end  
  end

  def test_login_account_failed
    assert_output("Nombre de usuario o contraseña incorrectos.\n[AUDIT] Intento de inicio de sesión fallido para el usuario 'Juanito32'\n") do
      @user.login_account("Juanito32", "incorrect_password")
    end
  end

  def test_update_account
    assert_output("La contraseña se ha modificado\n[AUDIT] El usuario 'Juanito32' ha actualizado su contraseña de cuenta a 'nueva_contraseña'\n") do
      @user.update_account("nueva_contraseña")
    end
    assert_equal "nueva_contraseña", @user.password
  end
end
