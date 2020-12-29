class Patient < ApplicationRecord
  has_many_attached :medical_reports

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP
  }, if: -> { email.present? }

  def name
    "#{first_name} #{last_name}"
  end

  def self.import_file file
    # get file extension
    file_extension = file.original_filename.split('.').pop.downcase
    file_data = File.read(file)

    case file_extension
    when 'json'
      rows = JSON.parse(file_data)
    when 'xml'
      rows = Hash.from_xml(file_data)['patients']['patient']
    when 'csv'
      # parse CSV and get the items in an array.
      rows = []
      CSV.foreach(file, headers: true) do |row|
        rows << row.to_h
      end
    end
    # create bulk records
    Patient.import(rows)
  end

  def self.export_file_data(file_format='csv')
    data = case file_format.downcase
    when 'csv'
      to_csv
    when 'json'
      all.to_json
    when 'xml'
      all.map{|a| a.attributes}.to_xml(root: 'patients')
    end
    data
  end

  # convert patients data to csv
  def self.to_csv
    attributes = Patient.attribute_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |patient|
        csv << attributes.map{ |attr| patient.send(attr) }
      end
    end
  end
end
