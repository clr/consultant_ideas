class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :login_required
  before_filter :set_defaults

  helper :all

  

  def set_defaults
    @default_per_page = 20
  end

  def prepare_restful_interpretation( class_name )
    resource_class = class_name.to_s.camelize.constantize 
    case params[:grammatical_number]
    when 'plural'
      self.action_name = self.request.request_method.to_s.pluralize
      @resources = resource_class.find( params[:ids].split( ',' ) ) if params[:ids]
    when 'singular'
      self.action_name = self.request.request_method.to_s.singularize
      if params[:id].to_i == 0
        @resource = resource_class.new
        @resource.workflow_id = Workflow.pending if @resource.respond_to? :workflow_id
      else
        @resource= resource_class.find( params[:id] ) if params[:id]
      end
    end
    [ @resource, @resources ]
  end

  def string_to_date(string)
    string =~ /\A(\d\d)-(\d\d)-(\d{4})\z/
    Time.local($3.to_i, $1.to_i, $2.to_i)
  end

  # For has_one association.
  def consider_attachment( resource, attachment_species, attachment_params = nil )
    attachment_params ||= params[ attachment_species ]
    if attachment_params
      if resource.send( attachment_species ).nil?
        if attachment_params[:uploaded_data] && attachment_params[:uploaded_data].length > 0
          attachment_class = attachment_species.to_s.classify.constantize
          resource.send( ( attachment_species.to_s + "=" ).to_sym, attachment_class.new( attachment_params ) )
        end
      else
        resource.send( attachment_species ).update_attributes( attachment_params )
      end
    end
  end

  # For has_many associations.
  def consider_attachments( resource, attachment_species, attachment_params = nil )
    attachment_params ||= ( params[ attachment_species ] || {} )
    associations = resource.send( attachment_species )
    # Consider existing records.
    unless associations.empty?
      associations.each do |association|
        # Update this record if it is found.
        if attachment_params.has_key?( association.id.to_s )
          association.update_attributes( attachment_params[ association.id.to_s ] )
        # Otherwise delete it.
        else
          association.destroy
        end
      end
    end
    # Create new records.
    attachment_params['0'].each do |attachment_param|
      if attachment_param[:uploaded_data] && attachment_param[:uploaded_data].length > 0
        attachment_class = attachment_species.to_s.singularize.classify.constantize
        associations << attachment_class.new( attachment_param )
      end
    end if attachment_params['0']
  end
  
  def prepare_attachment_association( resource, association_type )
    association = resource.send( association_type.to_sym ) 
    if !association.nil? && ( association.filename.nil? || association.content_type.nil? || association.size.nil? )
      association.destroy
    end
  end

  def delete_ricket( object )
    @object = object
    @object.destroy
    
    respond_to do |format|
      format.js { render :template => 'admin/rickets/delete' }
    end
  end
end
