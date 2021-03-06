import chunk from 'lodash/chunk';
import cloneDeep from "lodash/cloneDeep"
import _ from 'lodash';

export default function topicsReducer(state = {
	topics: [],
	parentTopic: "",
	b: ""
}, action) {
	switch (action.type) {
		case "ADD_TOPICS":
			// debugger
			console.log("adding topics")
			return {
				...state,
				topics: action.topics
			}

		case "SELECT_TOPIC":
			console.log("setting parent topic")
			return {
				...state,
				parentTopic: action.topic		
			}

		case "UPDATE_TOPIC":
			console.log("updating parent topic")
			console.log(state.parentTopic)
			// console.log(action)
			
			let updatedTopics = state.topics
			let desTopicIndex = updatedTopics.findIndex(topic => topic.name === action.destinationTopic.root.name)
			let desRootTopic = updatedTopics[desTopicIndex]
			console.log(action.destinationTopic)

			// action.destinationTopic.facts.push(action.fact)
			// let updatedDesTopic = action.destinationTopic
			let updatedParentTopic
			function getIndexPath(rootTopic, topic) {
				let schema = rootTopic
				let path = topic.path.map(topic => topic.name).slice(1)
				let indexPathArr = []
				for (let i = 0; i < path.length; i++) {
					let subIndex = schema.children.findIndex(topic => topic.name === path[i])
					schema = schema.children[subIndex]
					indexPathArr.push("children", subIndex)
				}
				updatedParentTopic = schema
				indexPathArr.push("facts")
				return indexPathArr
			}

			console.log(updatedParentTopic)

			let desIndexPathArr = getIndexPath(desRootTopic, action.destinationTopic)
			let desIndexPath = desIndexPathArr.join(".")
			_.get(desRootTopic, desIndexPath).push(action.fact)
			updatedTopics[desTopicIndex] = desRootTopic
			console.log(desRootTopic)
			// debugger


			let parTopicIndex = updatedTopics.findIndex(topic => topic.name === state.parentTopic.root.name)
			let parRootTopic = updatedTopics[parTopicIndex]
			
			let parIndexPathArr = getIndexPath(parRootTopic, state.parentTopic)
			let parIndexPath = parIndexPathArr.join(".")
			// _.get(parRootTopic, parIndexPath).filter(fact => fact.id !== action.fact.id)
			_.set(parRootTopic, parIndexPath, state.parentTopic.facts.filter(fact => fact.id !== action.fact.id))
			updatedTopics[parTopicIndex] = parRootTopic
			
			console.log(_.get(parRootTopic, _.initial(parIndexPath.split(".")).join(".")))
			// debugger

			console.log(updatedParentTopic)

			return {
				...state,
				topics: updatedTopics,
				parentTopic: {
					...state.parentTopic,
					updatedParentTopic
				} 
			}

		case "ADD_FACT":
			let boi = _.cloneDeep(state.topics)

			let newTopic = ""
			return {
				...state,
				topics: boi.map((topic, index) => {
					if (index === 0) {						
						topic.facts.push(action.fact)
						newTopic = topic	
					}
					return topic
				}),
				parentTopic: newTopic
		}

		default:
			return state;
	}
}