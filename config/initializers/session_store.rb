Rails.application.config.session_store :redis_store,
  servers: "redis://localhost:6379/0/session",
  key: "_rd_cart_session",
  expire_after: 90.minutes