class ItemsAPI < Grape::API
  version 'v1', using: :path
  format :json

  rescue_from ActiveRecord::RecordNotFound do
    rack_response({'message' => '404 Not found'}.to_json, 404)
  end

  resource :items do
    get do
      Item.all
    end

    get ':id' do
      Item.find(params[:id])
    end

    delete ':id' do
      Item.find(params[:id]).delete
    end

    put ':id/remember' do
      item = Item.find(params[:id])
      item.remember
      item
    end

    put ':id/forget' do
      item = Item.find(params[:id])
      item.forget
      item
    end

    desc "Create a Item."
    params do
      requires :question, type: String
      requires :answer, type: String
    end
    post do
      Item.create!({
        question: params[:question],
        answer: params[:answer]
      })
    end
  end
end
