Vue.component('v-comments',{
	props: {
		comments: Array,
		news_id: String,
	},
	data: function () {
		return {
			mutableComments:this.comments,
			text:''
		}
	},
	template: `<div>
				<template v-for="comment in mutableComments">
					<div class="comment" :key="comment.id">
					{{comment.text}}
					<hr>
					Лайков:
					<v-likes
							       :entity_id="comment.id"
							       entity_type="comments"
							       :likes="comment.likes"
							       :liked="comment.liked"
					       ></v-likes>
					</div>
				</template>
				<div id="post_comment">
						<textarea v-model="text" cols="45" rows="3"></textarea><br>
						<button @click.prevent="addComment" class="btn btn-success">Добавить комментарий</button>
				</div>
					
					
			   </div>`,
	
	methods: {
		addComment(){
			const url = `/comments/create`;
			
			axios.post(url,`news_id=${this.news_id}&text=${this.text}`)
				.then( (response) =>{
					if(response.data.status !== 'success'){
						alert(response.data.error_message)
					}
					else{
						this.mutableComments.unshift(response.data.data);
						this.text = '';
					}
				})
				.catch((error) => {
					alert(error)
				});
		},
	},
	
});