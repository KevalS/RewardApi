require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  fixtures :tier
  context "Create Customers with Client" do
    let!(:client) { create(:client) }

    let!(:another_client) { create(:client) }
    let!(:same_customer_under_another_client) { create(:customer, client: another_client, name: "customer_name", email: "customer@client.com", dob: Date.today) }

    before do 
      login_as(client)
    end

    let!(:params) do
      {
        customer: {
          name: "customer_name",
          email: "customer@client.com",
          dob: Date.today
        }
      }
    end

    it "should return sucess response" do
      post :create, :params=> params

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response["name"]).to eq("customer_name")
      expect(json_response["email"]).to eq("customer@client.com")
    end
  end

  describe "Errors" do
    context "Create Customers with Client" do
      let!(:client) { create(:client) }
      let!(:existing_customer) { create(:customer, client: client) }

      before do
        login_as(client)
      end

      let!(:params) do
        {
          customer: {
            name: "customer_name",
            email: "customer@client.com",
            dob: Date.today
          }
        }
      end
      it "should return error response when name is not passed in params" do
        params[:customer].delete(:name)
        post :create, :params=> params
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["error"]["message"]).to eq(["Name can't be blank"])
      end

      it "should return error response when dob is not passed in params" do
        params[:customer].delete(:dob)
        post :create, :params=> params
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["error"]["message"]).to eq(["Dob can't be blank"])
      end

      it "should return error response when email is not passed in params" do
        params[:customer].delete(:email)
        post :create, :params=> params
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["error"]["message"]).to eq(["Email can't be blank", "Email is invalid"])
      end

      it "should return error response when invalid email is passed in params" do
        params[:customer] = params[:customer].merge(email: "invalid_email")
        post :create, :params=> params
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["error"]["message"]).to eq(["Email is invalid"])
      end

      it "should return error response when email is already exists under this client" do
        params[:customer] = params[:customer].merge(email: existing_customer.email)
        post :create, :params=> params
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["error"]["message"]).to eq(["Email has already been taken"])
      end
    end
  end
end