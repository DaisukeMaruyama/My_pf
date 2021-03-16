Rails.configuration.stripe = {
  :publishable_key => "pk_test_51IVVvFE5MxamtZbv4lDBgQAUXVEqEsADSzGnRbRIiy5pLyBOvAnFtqaT5imACYTvPWQtXzbaxrS24zF3WKz1aIDh003LOa2HSR",
  :secret_key      => "sk_test_51IVVvFE5MxamtZbvVVAQBPuEl5md88r1qsgOKFfhPTBTW1uIVhW7bRnW5xnGg2rpVWNQBXTrIXyZKfk8CO9aSoha00gugWaOgf"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]