# frozen_string_literal: true

class Application < Roda
  plugin :environments
  plugin :slash_path_empty
  plugin :json, content_type: 'application/vnd.api+json'

  plugin :error_handler do |e|
    case e
    when Sequel::NoMatchingRow
      response.status = 404
      { 'meta' => I18n.t(:not_found, scope: 'api.errors') }
    when Sequel::UniqueConstraintViolation
      response.status = 422
      { 'meta' => I18n.t(:not_unique, scope: 'api.errors') }
    else
      response.status = 500
    end
  end

  plugin :not_found do
    {}
  end

  route do |r|
    r.on 'api' do
      r.on 'v1' do
        r.on 'user' do
          r.post 'registration' do
            params = Oj.load(r.body)

            contract = UserRegistrationContract.new.call(params)
            if contract.failure?
              response.status = 422
              return ErrorSerializer.from_contract(contract)
            end

            result = User::CreateService.call(*contract.to_h.values)
            if result.failure?
              response.status = 401
              return ErrorSerializer.from_messages(result.errors)
            end

            response.status = 201
            {}
          end

          r.post 'authentication' do
            params = Oj.load(r.body)

            contract = UserAuthenticationContract.new.call(params)
            if contract.failure?
              response.status = 422
              return ErrorSerializer.from_contract(contract)
            end

            result = UserSession::CreateService.call(*contract.to_h.values)
            if result.failure?
              response.status = 401
              return ErrorSerializer.from_messages(result.errors)
            end

            token = JwtEncoder.encode(uuid: result.session.uuid)
            meta = { token: token }

            response.status = 200
            { meta: meta }
          end

          r.post 'authorization' do
            auth_pattern = /\ABearer (?<token>.+)\z/.freeze
            data = env['HTTP_AUTHORIZATION'].match(auth_pattern)
            if data.blank?
              response.status = 403
              return {}
            end

            meta = JwtEncoder.decode(data[:token])
            result = Auth::FetchUserService.call(meta['uuid'])
            if result.failure?
              response.status = 403
              return {}
            end

            meta = { user_id: result.user.id }
            response.status = 200
            { meta: meta }
          rescue JWT::DecodeError
            response.status = 400
            {}
          end
        end
      end
    end
  end
end
