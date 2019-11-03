class HomeController < ApplicationController
  require "base64"
  require "json"

  def index
    @projects = Project.where(active: true).order('position ASC')

    @des = "Hello, My name is Peter Koruga. I am a self taught developer actively looking to continue my software development career."
    @title = "Peter Koruga | Welcome!"


    #Tracking visitors
    if (params[:appid])#Used URL with an appliction code
      application = JobApplication.where(gen_code: params[:appid]).first

      unless application.resume.nil?
        @resume = application.resume
      end

      if cookies[:pka_id].nil?

        p_cook = "{\"appid\": \"#{application.id}\", \"c_date\": \"#{(Time.now.to_i).to_s}\"}"
        b_cook = Base64.encode64(p_cook)

        cookies[:pka_id] = {
          :value => b_cook,
          :expires => 6.months.from_now
        }
        Tracker.create(ip_address: request.remote_ip, job_application_id: application.id, cookie: b_cook, url_clicked: true)
      else
        Tracker.create(ip_address: request.remote_ip, job_application_id: application.id, cookie: cookies[:pka_id], url_clicked: true)
      end

    else #Used the URL without the application code
      
      unless cookies[:pka_id].nil?
        info = JSON.parse(Base64.decode64(cookies[:pka_id]))

        if JobApplication.exists?(info["appid"])

          application = JobApplication.find(info["appid"])
          
          unless application.resume.nil?
            @resume = application.resume
          end

          Tracker.create(ip_address: request.remote_ip, job_application_id: info["appid"].to_i, cookie: cookies[:pka_id])
        else
          cookies.delete :pka_id
        end

      end

    end
    #Tracking visitors

  end

  def resume
    respond_to  do |format|
      format.html
      format.pdf do
        render pdf: 'test',
          template: 'home/print.html.erb',
          layout: 'resume.html.erb',
          page_size: 'letter',
          show_as_html: params.key?('debug'),
          margin: {top: 15,
                  bottom: 7,
                  left: 10,
                  right: 10},
          outline: {outline: true,
                    outline_depth: 2}
        end
     end

     @projects = Project.where(active: true).order('position ASC')
     @des = "This is the resume that Im hoping will appropriately dispay my past projects, current abiities and willingness to learn in the future."
     @title = "Peter Koruga | Resume"

      if (params[:appid])#Used URL with an appliction code
        application = JobApplication.where(gen_code: params[:appid]).first

        unless application.resume.nil?
          @resume = application.resume
        end

      else
     
        unless cookies[:pka_id].nil?
          info = JSON.parse(Base64.decode64(cookies[:pka_id]))

          if JobApplication.exists?(info["appid"])
            application = JobApplication.find(info["appid"])
            unless application.resume.nil?
              @resume = application.resume
            end
          end

        end

    end
  end

  def detail
    @projects = Project.where(active: true).order('position ASC')
    if params[:pid]
      @project = Project.find(params[:pid])
    else
      @project = @projects.first
    end
    @des = "Here are a few of my, Peter Koruga's, projects that are visible to the outside world. Some of the tech includes: HTML, CSS, Javascript, React, Rails, iOS and Python."
    @title = "Peter Koruga | Projects"

    unless cookies[:pka_id].nil?
      info = JSON.parse(Base64.decode64(cookies[:pka_id]))

      if JobApplication.exists?(info["appid"])
        application = JobApplication.find(info["appid"])
        unless application.resume.nil?
          @resume = application.resume
        end
      end

    end
    
  end

  def contact
  end

  def donate

    Stripe.api_key = Rails.application.credentials.dig(:stripe, :live_sec_key)

    token = params[:stripeToken]
    first = params[:firstname]
    last = params[:lastname]
    company = params[:company]
    email = params[:email]
    dollars = params[:amount].to_f
    cents = (dollars * 100).ceil.to_i
    begin
      charge = Stripe::Charge.create({
          amount: cents,
          currency: 'usd',
          description: '4 the Kids Donation',
          source: token,
          metadata: {
            'firstname' => first,
            'lastname' => last,
            'company' => company,
            'email' => email
          }
      })
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]
    
      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Charge ID is: #{err[:charge]}"
      # The following fields are optional
      puts "Code is: #{err[:code]}" if err[:code]
      puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
      puts "Param is: #{err[:param]}" if err[:param]
      puts "Message is: #{err[:message]}" if err[:message]
      flash[:alert] = "Sorry, #{err[:message]}"
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
      flash[:alert] = "This is emberasing, something went wrong on my end. Please wait just a minute and try again."
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      flash[:alert] = "Something about that card information didnt match. Give it another try."
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      flash[:alert] = "My bad. Something went wrong on my end. You havent been charged. I've been notified. If you provided your email, Ill let you know when its fixed and if your still interested could try donating again."
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      flash[:alert] = "My bad. Something went wrong on my end. You havent been charged. I've been notified. If you provided your email, Ill let you know when its fixed and if your still interested could try donating again."
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      flash[:alert] = "My bad. Something went wrong on my end. You havent been charged. I've been notified. If you provided your email, Ill let you know when its fixed and if your still interested could try donating again."
    rescue => e
      # Something else happened, completely unrelated to Stripe
      flash[:alert] = "My bad. Something went wrong on my end. You havent been charged. I've been notified. If you provided your email, Ill let you know when its fixed and if your still interested could try donating again."
    else
      flash[:success] = " #{first} You Are Awesome! Thank you for your donation!"

      contrib = {to: email, amount: dollars, company: company, first: first, last: last}
      DonationMailer.with(contrib: contrib).send_wupty_email.deliver_later

    ensure
      redirect_to home_index_path()
    end

  end
end
