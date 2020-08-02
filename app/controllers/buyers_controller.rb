class BuyersController < ApplicationController
  require 'payjp'#Payjpの読み込み
  before_action :set_card, :set_product

  def new
    @address = Address.find_by(user_id: current_user.id)
    @buyer_first_name = current_user.first_name
    @buyer_last_name = current_user.last_name

    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      #カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      @card_brand = @default_card_information.brand
      case @card_brand
      when "Visa"
        @card_src = 'https://www-mercari-jp.akamaized.net/assets/img/card/visa.svg?238737266'
      when "MasterCard"
        @card_src = 'https://www-mercari-jp.akamaized.net/assets/img/card/master-card.svg?238737266'
      when "JCB"
        @card_src = 'https://www-mercari-jp.akamaized.net/assets/img/card/jcb.svg?238737266'
      when "American Express"
        @card_src = 'https://www-mercari-jp.akamaized.net/assets/img/card/american_express.svg?238737266'
      when "Diners Club"
        @card_src = 'https://www-mercari-jp.akamaized.net/assets/img/card/dinersclub.svg?238737266'
      when "Discover"
        @card_src = 'https://www-mercari-jp.akamaized.net/assets/img/card/discover.svg?238737266'
      end
    else
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path, notice: '商品を購入するには、クレジットカードの登録が必要です'
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      :amount => @product.price, #支払金額を引っ張ってくる
      :customer => @card.customer_id,  #顧客ID
      :currency => 'jpy',              #日本円
    )
    @product.update(buyer_id: current_user.id)
    @parents = Category.where(ancestry: nil)
  end

  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
