class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    render json: Tenant.all
  end

  def show
    tenant = find_tenant
    render json: tenant
  end

  def create
    render json: Tenant.create!(tenant_params), status: :created
  end

  def update
    tenant = find_tenant
    tenant.update(tenant_params)
    render json: tenant
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end

  def find_tenant
    Tenant.find(params[:id])
  end

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
  end
end
