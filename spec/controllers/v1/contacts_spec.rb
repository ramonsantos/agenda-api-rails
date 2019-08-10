# frozen_string_literal: true

require 'rails_helper'

describe V1::ContactsController, type: :controller do
  before do
    Kind.create!(description: 'Comercial')
  end

  context 'GET index' do
    it 'request index and return NOT ACCEPTABLE' do
      get(:index)
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'request index and return 200 OK' do
      request.accept = 'application/vnd.api+json'
      get(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'request show and return contact' do
      contact = Contact.create(
        name: 'Ramon Santos',
        email: 'ramonsantos.pe@gmail.com',
        birthdate: '28/04/1989',
        kind: Kind.first
      )
      request.accept = 'application/vnd.api+json'

      get(:show, params: { id: contact.id })

      response_body = JSON.parse(response.body)
      expect(response_body['data']['id']).to eq(contact.id.to_s)
      expect(response_body['data']['type']).to eq('contacts')
      expect(response_body['data']['attributes']['name']).to eq('Ramon Santos')
      expect(response_body['data']['attributes']['email']).to eq('ramonsantos.pe@gmail.com')
      expect(response_body['data']['attributes']['birthdate']).to eq('1989-04-28T00:00:00-03:00')
    end
  end

  context 'POST create' do
    let(:create_params) do
      {
        data: {
          type: 'contacts',
          attributes: {
            name: 'Ramon Santos',
            email: 'ramonsantos.pe@gmail.com',
            birthdate: '28/04/1989'
          },
          relationships: {
            kind: {
              data: {
                id: Kind.first.id,
                type: 'kinds'
              }
            }
          }
        }
      }
    end

    let(:create_params_without_kind) do
      {
        data: {
          type: 'contacts',
          attributes: {
            name: 'Ramon Santos',
            email: 'ramonsantos.pe@gmail.com',
            birthdate: '28/04/1989'
          }
        }
      }
    end

    it 'request create with success' do
      request.accept = 'application/vnd.api+json'
      request.content_type = 'application/vnd.api+json'

      post(:create, params: create_params)

      expect(Contact.count).to eq(1)
      expect(response.status).to eq(201)
      response_body = JSON.parse(response.body)
      expect(response_body['data']['type']).to eq('contacts')
      expect(response_body['data']['type']).not_to be_empty
    end

    it 'request create with unsupported media type' do
      request.accept = 'application/vnd.api+json'
      request.content_type = 'application/json'

      post(:create, params: create_params)

      expect(Contact.count).to eq(0)
      expect(response.status).to eq(415)
    end

    it 'request create with errors' do
      request.accept = 'application/vnd.api+json'
      request.content_type = 'application/vnd.api+json'

      post(:create, params: create_params_without_kind)

      expect(Contact.count).to eq(0)
      expect(response.status).to eq(422)
      response_body = JSON.parse(response.body)
      expect(response_body['errors'][0]['id']).to eq('kind')
      expect(response_body['errors'][0]['title']).to eq('não pode ficar em branco')
      expect(response_body['errors'][1]['id']).to eq('kind')
      expect(response_body['errors'][1]['title']).to eq('é obrigatório(a)')
    end
  end

  context 'PUT update' do
    let(:update_params) do
      {
        id: @contact.id,
        data: {
          type: 'contacts',
          attributes: {
            name: 'Ramon Nascimento'
          }
        }
      }
    end

    let(:update_params_with_erros) do
      {
        id: @contact.id,
        data: {
          type: 'contacts',
          attributes: {
            name: nil
          }
        }
      }
    end

    before do
      @contact = Contact.create(
        name: 'Ramon Santos',
        email: 'ramonsantos.pe@gmail.com',
        birthdate: '28/04/1989',
        kind: Kind.first
      )

      request.accept = 'application/vnd.api+json'
      request.content_type = 'application/vnd.api+json'
    end

    it 'request update with success' do
      put(:update, params: update_params)

      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data']['type']).to eq('contacts')
      expect(response_body['data']['attributes']['name']).to eq('Ramon Nascimento')
    end

    it 'request update with errors' do
      put(:update, params: update_params_with_erros)

      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['name'][0]).to eq('não pode ficar em branco')
    end
  end

  context 'GET delete' do
    before do
      @contact = Contact.create(
        name: 'Ramon Santos',
        email: 'ramonsantos.pe@gmail.com',
        birthdate: '28/04/1989',
        kind: Kind.first
      )
      request.accept = 'application/vnd.api+json'
      request.content_type = 'application/vnd.api+json'
    end

    it 'request delete and destroy contact' do
      delete(:destroy, params: { id: @contact.id })

      expect(response.status).to eq(204)
      expect(Contact.count).to eq(0)
    end
  end
end
