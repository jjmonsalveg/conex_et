module ShowAtributosHelper

  def rif_show
    self.tipo_rif + '-' + self.rif.to_s + '-' + self.digito_rif.to_s rescue ''
  end

  def telefono_show
    '('+self.telefono[0..2]+')'+' '+self.telefono[3..5]+'-'+self.telefono[6..9] rescue ''
  end

  def movil_show
    '('+self.movil[0..2]+')'+' '+self.movil[3..5]+'-'+self.movil[6..9] rescue ''
  end

end