class JsonWebToken
  HMAC_SECRET = "520325be79502764bf33a7fd77b88159eb56fd6e991c62e09b14fb6a24a2e6a2412e4586129807f95a1912fbdf8aa7e16ecec7613904eab24f43b251b438a155"
 
  class << self
    def encode payload
      payload[:exp] = 720.hours.from_now.to_i
      JWT.encode(payload, HMAC_SECRET, 'HS256')
    end
 
    def decode token
      body = JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })[0]
      HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise ExceptionHandler::ExpiredSignature, e.message
    end
  end
end