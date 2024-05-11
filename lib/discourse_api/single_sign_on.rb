# frozen_string_literal: true
require "base64"
require "rack"
require "openssl"

module DiscourseApi
  class SingleSignOn
    class ParseError < RuntimeError
    end
    class MissingConfigError < RuntimeError
    end

    ACCESSORS = %i[
      add_groups
      admin
      avatar_force_update
      avatar_url
      bio
      card_background_url
      confirmed_2fa
      email
      external_id
      groups
      locale
      locale_force_update
      moderator
      name
      no_2fa_methods
      nonce
      profile_background_url
      remove_groups
      require_2fa
      require_activation
      return_sso_url
      suppress_welcome_message
      title
      username
    ]

    FIXNUMS = []

    BOOLS = %i[
      admin
      avatar_force_update
      confirmed_2fa
      locale_force_update
      moderator
      no_2fa_methods
      require_2fa
      require_activation
      suppress_welcome_message
    ]
    ARRAYS = [:groups]
    #NONCE_EXPIRY_TIME = 10.minutes # minutes is a rails method and is causing an error. Is this needed in the api?

    attr_accessor(*ACCESSORS)
    attr_writer :custom_fields, :sso_secret, :sso_url

    def self.sso_secret
      raise MissingConfigError, "sso_secret not implemented on class, be sure to set it on instance"
    end

    def self.sso_url
      raise MissingConfigError, "sso_url not implemented on class, be sure to set it on instance"
    end

    def self.parse_hash(payload)
      sso = new

      sso.sso_secret = payload.delete(:sso_secret)
      sso.sso_url = payload.delete(:sso_url)

      ACCESSORS.each do |k|
        val = payload[k]

        val = val.to_i if FIXNUMS.include? k
        val = %w[true false].include?(val) ? val == "true" : nil if BOOLS.include? k
        val = val.split(",") if ARRAYS.include?(k) && !val.nil?
        sso.send("#{k}=", val)
      end

      # Set custom_fields
      sso.custom_fields = payload[:custom_fields]

      # Add custom_fields (old format)
      payload.each do |k, v|
        if field = k[/^custom\.(.+)$/, 1]
          # Maintain adding of .custom bug
          sso.custom_fields["custom.#{field}"] = v
        end
      end

      sso
    end

    def self.parse(payload, sso_secret = nil)
      sso = new
      sso.sso_secret = sso_secret if sso_secret

      parsed = Rack::Utils.parse_query(payload)
      if parsed["sso"].nil? || sso.sign(parsed["sso"]) != parsed["sig"]
        diags =
          "\n\nsso: #{parsed["sso"].inspect}\n\nsig: #{parsed["sig"].inspect}\n\nexpected sig: #{sso.sign(parsed.fetch("sso", ""))}"
        if parsed["sso"].nil? || parsed["sso"] =~ %r{[^a-zA-Z0-9=\r\n/+]}m
          raise ParseError,
                "The SSO field should be Base64 encoded, using only A-Z, a-z, 0-9, +, /, and = characters. Your input contains characters we don't understand as Base64, see http://en.wikipedia.org/wiki/Base64 #{diags}"
        else
          raise ParseError, "Bad signature for payload #{diags}"
        end
      end

      decoded = Base64.decode64(parsed["sso"])
      decoded_hash = Rack::Utils.parse_query(decoded)

      ACCESSORS.each do |k|
        val = decoded_hash[k.to_s]
        val = val.to_i if FIXNUMS.include? k
        val = %w[true false].include?(val) ? val == "true" : nil if BOOLS.include? k
        val = val.split(",") if ARRAYS.include?(k) && !val.nil?
        sso.send("#{k}=", val)
      end

      decoded_hash.each do |k, v|
        if field = k[/^custom\.(.+)$/, 1]
          sso.custom_fields[field] = v
        end
      end

      sso
    end

    def diagnostics
      DiscourseApi::SingleSignOn::ACCESSORS.map { |a| "#{a}: #{send(a)}" }.join("\n")
    end

    def sso_secret
      @sso_secret || self.class.sso_secret
    end

    def sso_url
      @sso_url || self.class.sso_url
    end

    def custom_fields
      @custom_fields ||= {}
    end

    def sign(payload)
      OpenSSL::HMAC.hexdigest("sha256", sso_secret, payload)
    end

    def to_url(base_url = nil)
      base = "#{base_url || sso_url}"
      "#{base}#{base.include?("?") ? "&" : "?"}#{payload}"
    end

    def payload
      payload = Base64.strict_encode64(unsigned_payload)
      "sso=#{CGI.escape(payload)}&sig=#{sign(payload)}"
    end

    def unsigned_payload
      payload = {}

      ACCESSORS.each do |k|
        next if (val = send k) == nil
        payload[k] = val
      end

      @custom_fields.each { |k, v| payload["custom.#{k}"] = v.to_s } if @custom_fields

      Rack::Utils.build_query(payload)
    end
  end
end
