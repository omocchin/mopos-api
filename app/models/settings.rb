class Settings < SettingsCabinet::Base
  using SettingsCabinet::DSL

  source Rails.root.join("config", "settings.yml")
  namespace Rails.env
end