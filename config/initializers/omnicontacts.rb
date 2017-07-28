require 'omnicontacts'

  Rails.application.middleware.use OmniContacts::Builder do
    importer :gmail, "997438033148-jvkhd6urb85c1ejsddargahqdm6sni9i.apps.googleusercontent.com", "Tg5uO2gVD_bnFCdKHWHEgcNU", {:redirect_path => "/oauth2callback"}
  end