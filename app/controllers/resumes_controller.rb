class ResumesController < ApplicationController
  layout 'admin'
  before_action :confirm_logged_in, :only => [:create, :update, :delete, :destroy]

  def index
    @res = Resume.all()
    if @res.length == 0
      redirect_to new_resume_path()
    else
      redirect_to resume_path(@res[0].id)
    end
  end

  def show
    @user = User.find(session[:user_id]) if session[:user_id]
    @resume = Resume.find(1)
    @appCode = JobApplication.select(:gen_code).find(@resume.job_application_id).gen_code
    
    @projects = Project.where(active: true).order('position ASC')

    @techGroups = []
    teches = Tech.all
    t_count = teches.size
    if t_count % 2 != 0
      @techGroups << teches[0, (t_count/2+1)]
      @techGroups << teches[(t_count/2+1), (t_count/2)]
    else
      @techGroups << teches[0, (t_count/2)]
      @techGroups << teches[(t_count/2), (t_count/2)]
    end
    
    @certGroups = []
    certs = Certificate.all
    c_count = certs.size
    if c_count % 2 != 0
      @certGroups << certs[0, (c_count/2+1)]
      @certGroups << certs[(c_count/2+1), (c_count/2)]
    else
      @certGroups << certs[0, (c_count/2)]
      @certGroups << certs[(c_count/2), (c_count/2)]
    end

  end

  def new
    @res = Resume.new(job_application_id: params["appid"])
    @app = JobApplication.find(params["appid"])
    @count  = Resume.all().size
  end

  def create

    res = Resume.create!(resume_params)
    app = JobApplication.find(res.job_application_id)
    flash[:notice] = "Successfully created resume for #{app.position_applied} at #{app.company} ."
    redirect_to(job_application_path(app))
  end

  def edit
    @res = Resume.find(params[:id])
    @app = JobApplication.find(@res.job_application_id)
    @count  = Resume.all().size
  end

  def update
    res = Resume.find(params[:id])
    app = JobApplication.find(res.job_application_id)

    if res.update_attributes(resume_params)
      flash[:notice] = "Successfully edited resume for #{app.position_applied} at #{app.company} ."
      redirect_to(job_application_path(app))
    else
      render('show')
    end
  end

  def delete

  end

  def destroy

  end

  private

  def resume_params
    params.require(:resume).permit(:job_application_id, :title, :cert_desc, :tech_desc, :expir_desc, :job_application_id, project_ids: [], certificate_ids: [], tech_ids: [])
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'You didnt think that Id let you change things did you? I just left it open for you to see my VERY simple, mostly unnecessary admin system as another entry in my portfolio.'
      if params[:id]
        redirect_to project_path(params[:id])
      else
        redirect_to projects_path()
      end
    end
  end

end
