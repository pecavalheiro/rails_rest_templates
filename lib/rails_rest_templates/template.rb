app_name = "application"
app_title = app_name.classify

gem "rails_rest_templates", git: "http://github.com/ricardobaumann/rails_rest_templates"
gem "therubyracer"
gem "rspec"
 
run "bundle install"

run "rails generate rspec:install"

#environment 'config.action_mailer.default_url_options = {host: "http://yourwebsite.example.com"}', env: 'production'

environment "config.generators do |g|
      g.test_framework  :rspec, fixture: true, spec: true
      g.template_engine nil
      g.assets  false
      g.helper false
      g.stylesheets false
    end"

after_bundle do
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end

	lib "templates/rails/scaffold_controller/controller.rb", <<-CODE
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  
  include RestApiConcerns

  before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]
  
  # GET <%= route_url %>
  def index
    limit = params[:limit]||10
    offset = params[:offset]||0
    items = <%= plural_table_name %> = <%= class_name %>.limit(limit).offset(offset) 
    render json: items, status: :ok
  end
  
  # POST <%= route_url %>
  def create
    <%= singular_table_name %> = <%= orm_class.build(class_name, singular_table_name+"_params") %>
    if @<%= orm_instance.save %>
      render json: <%= singular_table_name %>, status: :created 
    else
      render json: <%= singular_table_name %>.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update(singular_table_name+"_params") %>
      render json: @<%= singular_table_name %>, status: ok
    else
      render json: @<%= singular_table_name %>.errors, status: unprocessable_entity
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end
    # Only allow a trusted parameter "white list" through.
    def <%= singular_table_name+"_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":"+name }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
CODE

