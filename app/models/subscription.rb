class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :event, presence: true

  #Проверки выполняются если юзер не задан:
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'

  #Делаем scope валидацию
  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user, uniqueness: {scope: :user_email}, unless: 'user.present?'

  before_validation :check_users_emails


  def check_users_emails
    unless user.present?
      u = User.find_by(email: user_email)
      if u.present?
        errors.add(:email, "эта почта принадлежит одному из зарегистрированных пользователей")
        return false
      end
    end
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

end
