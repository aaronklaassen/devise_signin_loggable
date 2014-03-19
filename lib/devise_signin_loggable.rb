module DeviseSigninLoggable
  class Configuration
    include Confiture::Configuration

    confiture_allowed_keys(:key, :secret)

    confiture_defaults(secret: 'SECRET_STUFF', key: 'EVEN_MOAR_SECRET')

  end
end
