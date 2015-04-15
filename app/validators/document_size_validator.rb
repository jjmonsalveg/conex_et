class DocumentSizeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.size.to_f/(1000*1000) > 2.to_f
      record.errors.add(attribute,
          "Los documentos no pueden tener un tamaño mayor a 2 MB
            (#{attribute.to_s.humanize.titleize.gsub(/\ADoc/,'Documento Digital')})")
    end
  end
end