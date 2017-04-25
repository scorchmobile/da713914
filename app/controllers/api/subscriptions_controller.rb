class Api::SubscriptionsController < ApplicationController
  before_action :set_api_subscription, only: [:show, :edit, :update, :destroy]

  # GET /api/subscriptions
  # GET /api/subscriptions.json
  def index
    @api_subscriptions = Api::Subscription.all
  end

  # GET /api/subscriptions/1
  # GET /api/subscriptions/1.json
  def show
  end

  # GET /api/subscriptions/new
  def new
    @api_subscription = Api::Subscription.new
  end

  # GET /api/subscriptions/1/edit
  def edit
  end

  # POST /api/subscriptions
  # POST /api/subscriptions.json
  def create
    # params[:id] is the knowmadics id

    @api_subscription = Api::Subscription.new(api_subscription_params)

    respond_to do |format|
      if @api_subscription.save
        format.html { redirect_to @api_subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @api_subscription }
      else
        format.html { render :new }
        format.json { render json: @api_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/subscriptions/1
  # PATCH/PUT /api/subscriptions/1.json
  def update
    respond_to do |format|
      if @api_subscription.update(api_subscription_params)
        format.html { redirect_to @api_subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_subscription }
      else
        format.html { render :edit }
        format.json { render json: @api_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/subscriptions/1
  # DELETE /api/subscriptions/1.json
  def destroy
    @api_subscription.destroy
    respond_to do |format|
      format.html { redirect_to api_subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_subscription
      @api_subscription = Api::Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_subscription_params
      params.fetch(:api_subscription, {})
    end
end
