class FactsController < ApplicationController
	def create
		# binding.pry
		user = @current_user

		if params[:origin_topic_name] && params[:destination_topic_name]
			# binding.pry
			fact = Fact.find(params[:fact_id])
			origin_topic = user.topics.find_by(name: params[:origin_topic_name])
			destination_topic = user.topics.find_by(name: params[:destination_topic_name])

			origin_topic.facts.delete(fact)
			destination_topic.facts << fact
			# binding.pry

			render json: TopicSerializer.new(user.topics).to_serialized_json_tree
			# render json: TopicSerializer.new(origin_topic.subtree).to_serialized_json_tree
			# render json: FactSerializer.new(fact).to_serialized_json
		else
			fact = Fact.new(content: params[:selected_text], url: params[:selection_url])
			if fact.valid?
				# binding.pry
				fact.save
				user.topics.find_by(name: "New Facts").facts << fact 
				render json: FactSerializer.new(fact).to_serialized_json
			else				
				render json: {error: "could not save fact"}
			end			
		end
	end
end
