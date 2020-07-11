class CardsController < ApplicationController
  require 'payjp'

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
  end

  def create #payjpとCardのデータベース作成
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to action: :new
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(current_user.id)
      else
        redirect_to action: :create
      end
    end
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
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
      redirect_to action: :new
    end
  end

  def destroy #PayjpとCardデータベースを削除
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: :new
  end
end
