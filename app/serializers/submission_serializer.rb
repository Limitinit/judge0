class SubmissionSerializer < ActiveModel::Serializer
  attributes((Submission.column_names + ["status", "language"] - ["id"]).collect(&:to_sym))

  def source_code
    object_decoder(:source_code)
  end

  def input
    object_decoder(:input)
  end

  def expected_output
    object_decoder(:expected_output)
  end

  def stdout
    object_decoder(:stdout)
  end

  def stderr
    object_decoder(:stderr)
  end

  def compile_output
    object_decoder(:compile_output)
  end
  
  def status
    { id: object.status_id, description: object.status.name }
  end

  def language
    ActiveModelSerializers::SerializableResource.new(object.language, { serializer: LanguageSerializer })
  end

  private

  def object_decoder(method)
    instance_options[:base64_encoded] ? object[method] : object.send(method)
  end
end
