class DiscussionsController < ApplicationController
	def create
		user = @current_user
		article_url = params[:article_url]

		response = Faraday.get "https://extractorapi.com/api/v1/extractor/?apikey=#{ENV["EXTRACTOR_KEY"]}&url=#{article_url}"
		json_response = JSON.parse(response.body)


		discussion = Discussion.create(name: json_response["title"].split(" ").join("_"), group: Group.find(params[:group_id]), article_url: params[:article_url])
		article = Article.create(title: json_response["title"], content: json_response["text"], discussion: discussion)
		# if article.valid?
		
		# binding.pry
		render json: DiscussionSerializer.new(discussion).to_serialized_json
	end

	def show
		# binding.pry
		if Group.find(params[:group_id]).users.include?(@current_user)
			discussion = Discussion.find(params[:id]) 
			render json: DiscussionSerializer.new(discussion).to_serialized_json			
		else
			render json: {error: "You must be a part of this group to view this discussion"}
		end

	end
end
