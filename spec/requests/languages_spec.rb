require 'swagger_helper'

RSpec.describe 'languages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:jwt_token) { JsonWebToken.encode(user_id: user.id) }
  
  path '/languages' do
    get('list languages') do
      parameter name: :token, :in => :header, :type => :string
      response(200, 'successful') do
        let!(:token) { jwt_token }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/current_language' do

    get('current_language language') do
      parameter name: :token, :in => :header, :type => :string

      response(200, 'successful') do
        let!(:token) { jwt_token }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/update_current_language' do

    put('update_current_language language') do
      parameter name: :token, :in => :header, :type => :string

      response(200, 'successful') do
        let!(:token) { jwt_token }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
