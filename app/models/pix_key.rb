require 'qrcode_pix_ruby'

class PixKey < ApplicationRecord
  belongs_to :user

  enum key_type: {
    cpf: 0,
    email: 1,
    phone: 2,
    random: 3
  }

  # before_validation :add_country_code
  validates :key, presence: true, uniqueness: true
  validates :key_type, presence: true
  validates :registered_at, presence: true
  validate :validate_key_format

  def pix_statico
    pix = QrcodePixRuby::Payload.new(
      pix_key:        key,
      description:    description,
      merchant_name:  merchant_name,
      merchant_city:  merchant_city.upcase,
      transaction_id: transaction_id,
      # amount:         0.00,
      currency:       '986',
      country_code:   'BR',
      postal_code:    postal_code,
      repeatable:     true
    )
  end

  def pix_dinamico
    pix = QrcodePixRuby::Payload.new(
      url:            "http://localhost:3000/pix_keys/#{self.id}.json",
      merchant_name:  merchant_name,
      merchant_city:  merchant_city.upcase,
      amount:         amount,
      transaction_id: transaction_id,
      repeatable:     false
    )
  end

  def pix_copia_e_cola
    pix_statico.payload
    # pix_dinamico.payload
  end

  def pix_qrcode
    pix_statico.base64
    # pix_dinamico.base64
    # base64_chatgpt
  end

  def base64_chatgpt
    ::RQRCode::QRCode.new(pix.payload).as_png(
      bit_depth: 1,
      size: 270,
      border_modules: 3,   # Aumenta o espaço da borda
      color_mode: 0,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      error_correction_level: :h,  # Correção de erro alta (mais robusto)
      resize_exactly_to: false,
      resize_gte_to: false
    ).to_data_url
  end
  

  private

  def validate_key_format
    case key_type
    when "cpf" 
      validate_cpf
    when "email"
      validate_email
    when "phone"
      validate_phone
    when "random"
      validate_random
    else
      errors.add(:key_type, "tipo de chave inválido")
    end
  end

  def validate_cpf
    unless key.match?(/\A\d{11}\z/) && cpf_valid?(key)
      errors.add(:key, "não é um CPF válido")
    end
  end

  def validate_email
    unless key.match?(/\A[^@\s]+@[^@\s]+\z/)
      errors.add(:key, "não é um email válido")
    end
  end

  def validate_phone
    unless key.match?(/\A\+?\d{1,3}(\s?\d{1,4}){2,4}\z/)
      errors.add(:key, "não é um telefone válido")
    end
  end

  def validate_random
    unless key.match?(/\A[a-zA-Z0-9]{32}\z/)
      errors.add(:key, "não é uma chave aleatória válida")
    end
  end

  def cpf_valid?(cpf)
    cpf = cpf.gsub(/\D/, '')

    return false if cpf.length != 11 || cpf.match?(/^(.)\1{10}$/)

    digits = cpf.chars.map(&:to_i)
    verifiers = (9..10).map do |i|
      sum = digits[0...i].each_with_index.sum { |digit, index| digit * (i + 1 - index) }
      mod = sum % 11
      mod < 2 ? 0 : 11 - mod
    end

    verifiers == digits[-2..]
  end
end
