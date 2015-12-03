module RestApiConcerns extend ActiveSupport::Concern
	included do
		before_filter :set_format
		protect_from_forgery with: :exception
	  	skip_before_action :verify_authenticity_token
	  	before_filter :set_format, :cors_preflight_check
	  	after_filter :cors_set_access_control_headers
	end

	def set_format
		request.format = 'json'
	end

	def cors_set_access_control_headers
	    headers['Content-Type'] = 'application/json'
	    headers['Accept'] = 'application/json'
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
	    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
	    headers['Access-Control-Max-Age'] = "1728000"
	end
	 
	def cors_preflight_check
        headers['Content-Type'] = 'application/json'
        headers['Accept'] = 'application/json'
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = '*'
        headers['Access-Control-Max-Age'] = '1728000'
	end


end