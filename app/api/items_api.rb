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

    post ':id/remember' do
      Item.find(params[:id]).remember
    end

    post ':id/forget' do
      Item.find(params[:id]).forget
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
