module AuthRateLimitable
  extend ActiveSupport::Concern

  class_methods do
    def auth_rate_limit(name:, to:, within:, only:, redirect_to:)
      before_action(only:) do
        next unless auth_rate_limited?(name:, to:, within:)

        handle_auth_rate_limit(public_send(redirect_to))
      end
    end
  end

  private

  def auth_rate_limited?(name:, to:, within:)
    cache_key = auth_rate_limit_cache_key(name)
    cached_window = Rails.cache.read(cache_key)
    current_window = build_rate_limit_window(cached_window, within)

    current_window[:count] += 1

    Rails.cache.write(
      cache_key,
      current_window,
      expires_in: current_window[:expires_at] - Time.current
    )

    current_window[:count] > to
  end

  def auth_rate_limit_cache_key(name)
    [ "auth-rate-limit", controller_path, name, request.remote_ip ].join(":")
  end

  def build_rate_limit_window(cached_window, within)
    return fresh_rate_limit_window(within) if cached_window.blank?
    return fresh_rate_limit_window(within) if cached_window[:expires_at] <= Time.current

    cached_window
  end

  def fresh_rate_limit_window(within)
    {
      count: 0,
      expires_at: within.from_now
    }
  end
end
