class ImportPatientsJob < ApplicationJob
  queue_as :default

  def perform(file)
    Patient.import_file(file)
  end
end
