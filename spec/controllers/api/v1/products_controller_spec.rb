require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do 
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, params: { id: @product.id }
    end

    it "returns product information" do
      product_response = json_response
      expect(product_response[:title]).to eq(@product.title)
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :product }
      get :index
    end

    it "returns all products" do
      products_response = json_response
      expect(products_response.count).to eq(4)
    end
  end

  describe "POST #create" do
    context "when successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @product_attributes = FactoryGirl.attributes_for :product 
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, product: @product_attributes } 
      end

      it "renders product as json" do
        product_response = json_response
        expect(product_response[:title]).to eq(@product_attributes[:title])
      end

      it { should respond_with 201 }
    end

    context "when not successful" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_product_attributes = { title: "Smart Tv", price: "Twelve dollars" } 
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, product: @invalid_product_attributes } 
      end

      it "renders json error response" do
        product_response = json_response
        product_response.has_key?(:errors)
      end

      it "provides reason why attribute not created" do
        product_response = json_response
        expect(product_response[:errors].first).to include "is not a number" 
      end

      it { should respond_with 422 }
    end
  end
  
  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product, user: @user
      api_authorization_header @user.auth_token
    end

    context "when successfully updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @product.id, product:{ title: "An Expensive tv" }}
      end

      it "renders user json" do
        product_response = json_response
        expect(product_response[:title]).to eq "An Expensive tv"
      end

      it { should respond_with 200 }
    end

    context "when not updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @product.id,
               product: { price: "two hundred" } }
      end

      it "renders json errors" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, params: { user_id: @user.id, id: @product.id }
    end

    it { should respond_with 204 }
  end
end
