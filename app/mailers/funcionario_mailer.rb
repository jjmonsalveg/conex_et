class FuncionarioMailer < ActionMailer::Base
  default from: "conex_et@intt.gob.ve"

  def send_password(funcionario, password)
    @funcionario = funcionario
    @password = password
    @host = 'http://localhost:3000'
    mail(to: funcionario.email, subject: 'Registro Funcionario Conex-ET')
  end
end
