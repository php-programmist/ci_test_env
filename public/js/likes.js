Vue.component('v-likes',{
	props: {
		entity_id: String,
		entity_type: String,
		likes: String,
		liked: String,
	},
	data: function () {
		return {
			mutableLikes:parseInt(this.likes),
			mutableLiked:parseInt(this.liked)
		}
	},
	template: `<span>
					{{mutableLikes}}
					<i v-show="mutableLiked" @click="unlike" class="fa fa-minus" aria-hidden="true"></i>
					<i v-show="!mutableLiked" @click="like"  class="fa fa-plus" aria-hidden="true"></i>
			   </span>`,
	
	methods: {
		like(){
			const url = `/likes/like`;
			
			axios.post(url,`entity_id=${this.entity_id}&entity_type=${this.entity_type}`)
				.then( (response) =>{
					if(response.data.status !== 'success'){
						alert(response.data.error_message)
					}
					else{
						this.mutableLikes = response.data.data.likes;
						this.mutableLiked = 1;
					}
				})
				.catch((error) => {
					alert(error)
				});
		},
		unlike(){
			const url = `/likes/unlike`;
			
			axios.post(url,`entity_id=${this.entity_id}&entity_type=${this.entity_type}`)
				.then( (response) =>{
					if(response.data.status !== 'success'){
						alert(response.data.error_message)
					}
					else{
						this.mutableLikes = response.data.data.likes;
						this.mutableLiked = 0;
					}
				})
				.catch((error) => {
					alert(error)
				});
		},
	},
	
});