class PixKeysController < ApplicationController
  before_action :set_pix_key, only: [:show, :edit, :update, :destroy]

  # GET /pix_keys
  def index
    @pix_keys = PixKey.all
  end

  # GET /pix_keys/1
  def show
    respond_to do |format|
      format.html
      format.json { render :show,
        transaction_id: @pix_key.transaction_id,
        amount: @pix_key.amount,
        merchant_name: @pix_key.merchant_name,
        merchant_city: @pix_key.merchant_city,
        key: @pix_key.key, # Aqui você retorna a chave Pix do recebedor
        location: @pix_key
      }
    end
  end

  # GET /pix_keys/new
  def new
    @pix_key = PixKey.new
  end

  # GET /pix_keys/1/edit
  def edit
  end

  # POST /pix_keys
  def create
    @pix_key = PixKey.new(pix_key_params)
    @pix_key.amount = 0.00
    @pix_key.transaction_id = "0000"
    @pix_key.user_id = "1"

    # debugger

    if @pix_key.save
      redirect_to @pix_key, notice: 'Chave Pix criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pix_keys/1
  def update
    if @pix_key.update(pix_key_params)
      redirect_to @pix_key, notice: 'Chave Pix atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pix_keys/1
  def destroy
    @pix_key.destroy
    redirect_to pix_keys_url, notice: 'Chave Pix removida com sucesso.'
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_pix_key
      @pix_key = PixKey.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def pix_key_params
      params.require(:pix_key).permit(
        :user_id,
        :key,
        :key_type,
        :registered_at,
        :merchant_name,
        :merchant_city,
        :description,
        :postal_code,
        :amount,
        :transaction_id,
        :repeatable
      )
    end
end
