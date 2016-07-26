class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]


  # POST /subscriptions
  def create

    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.user.present? && @event.user.email == @new_subscription.user.email
      redirect_to @event, alert: I18n.t('controllers.subscription.host_cant_subscribe') and return nil
    end

    if @new_subscription.save
      redirect_to @event, notice: I18n.t('controllers.subscription.created')
    else
      render 'events/show', alert: I18n.t('controllers.subscription.error')
    end
  end


  # DELETE /subscriptions/1
  def destroy
    message = {notice: I18n.t('controllers.subscription.destroyed')}

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscription.error')}
    end

    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
