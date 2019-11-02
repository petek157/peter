class JobApplicationsController < ApplicationController
  
  before_action :confirm_logged_in
  layout 'admin'
  def index
    @apps = JobApplication.all()
    if @apps.length == 0
      redirect_to new_job_application_path()
    else
      redirect_to job_application_path(@apps[0].id)
    end
  end

  def show
    @user = User.find(session[:user_id]) if session[:user_id]
    @allapps = JobApplication.all()
    @app = JobApplication.find(params[:id])

    unless @app.resume.nil?
      @resume = @app.resume
    end
    allT = Tracker.where(url_clicked: false)

    ts_ips = []
    allT.each do |t|
      unless ts_ips.include?(t.ip_address)
        ts_ips << t.ip_address
      end
    end
    puts(ts_ips)
    @tsObs = []

    ts_ips.each do |tip|
      tobj = {ip: tip, cnt: 0}
      allT.each do |t2|
        if t2.ip_address == tobj[:ip]
          tobj[:cnt] += 1
        end
      end
      @tsObs << tobj
    end
  end

  def new
    key = ((Time.now.to_i)*2).to_s

    @app = JobApplication.new(gen_code: key)
    @count  = JobApplication.all().size

  end

  def create
    app = JobApplication.create!(apps_params)

    flash[:notice] = "Successfully created an application for #{app.position_applied} at #{app.company}."
    redirect_to(job_application_path(app))

  end

  def edit
    @app = JobApplication.find(params[:id])
  end

  def update
    @app = JobApplication.find(params[:id])
    if @app.update_attributes(apps_params)
      flash[:notice] = "#{@app.position_applied} at #{@app.company} application has been updated."
      redirect_to(job_application_path(@app))
    else
      render('show')
    end
  end

  def delete

  end

  def destroy

  end

  private

  def apps_params
    params.require(:job_application).permit(:company, :position_applied, :gen_code, :application_notes, :response, :comp_jobid)
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'A guy has to have his secrets!'
      redirect_to root_path()
    end
  end

end
