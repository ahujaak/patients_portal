class PatientsController < ApplicationController
  before_action :find_patient, only: [:show, :destroy, :edit, :update]
  
  def index
    @patients = Patient.all
    @patients = @patients.where(['email like ?', params[:email] + '%']) if params[:email]
    @patients = @patients.order("email #{params[:sort_by] || 'asc'}").page params[:page]
  end

  def new
    @patient = Patient.new
  end

  def show
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to patients_path, notice: "Patient details are saved successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to patients_path, notice: "Patient details are updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    if @patient.destroy
      flash[:notice] = 'Patient details are deleted successfully.'
    else
      flash[:alert] = @patient.errors.full_messages.to_sentence
    end
    redirect_to patients_path
  end

  def import
    file = params[:file]
    file_extension = file.original_filename.split('.').pop.downcase

    if ['json', 'xml', 'csv'].exclude?(file_extension)
      flash[:alert] = 'Invalid file format!'
      return
    end

    ImportPatientsJob.perform_now(file)
    redirect_to :patients, notice: 'Import started in background process.'
  end

  def export
    file_data = Patient.export_file_data(params[:file_format])
    send_data(file_data, filename: "patient-export-#{Time.now}.#{params[:file_format]}")
  end

  private

  def patient_params
    params.require(:patient).permit(
      :email, :first_name, :last_name, :phone, medical_reports: []
    )
  end

  def find_patient
    @patient = Patient.find_by(id: params[:id])
  end
end
