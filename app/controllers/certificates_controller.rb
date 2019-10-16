class CertificatesController < ApplicationController

  before_action :confirm_logged_in, :only => [:create, :update, :destroy]
  layout 'admin'

  def index
    @certs = Certificate.all()
    if @certs.length == 0
      redirect_to new_certificate_path()
    else
      redirect_to certificate_path(@certs[0].id)
    end
  end

  def show
    @user = User.find(session[:user_id]) if session[:user_id]
    @allcerts = Certificate.all()
    @cert = Certificate.find(params[:id])
  end

  def new
    @cert = Certificate.new()
    @count  = Certificate.all().size
  end

  def create
    cert = Certificate.create!(certs_params)

    flash[:notice] = "Successfully created #{cert.title} certificate."
    redirect_to(certificate_path(cert))
  end

  def edit
    @cert = Certificate.find(params[:id])
  end

  def update
    @cert = Certificate.find(params[:id])
    if @cert.update_attributes(certs_params)
      flash[:notice] = "#{@cert.title} certificate has been updated."
      redirect_to(certificate_path(@cert))
    else
      render('show')
    end
  end

  def delete

  end

  def destroy
    
  end

  private

  def certs_params
    params.require(:certificate).permit(:title)
  end

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'You didnt think that Id let you change things did you? I just left it open for you to see my VERY simple, mostly unnecessary admin system as another entry in my portfolio.'
      if params[:id]
        redirect_to certificate_path(params[:id])
      else
        redirect_to certificates_path()
      end
    end
  end

end
