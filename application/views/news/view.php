<?php $this->load->helper('html'); ?>
<!-- Page Content -->
<div class="container" id="app">
    
    <div class="row">
        
        <!-- Blog Entries Column -->
        <div class="col-md-8">
	
	        <article class="card mb-4">
                <?php echo img($article['img'],false,['class'=> 'card-img-top','alt'=>$article['header']]) ?>
		
		        <div class="card-body">
			        <header>
				        <h2 class="card-title">
                            <?php echo $article['header'] ?>
				        </h2>
			        </header>
			        <p class="card-text">
                        <?php echo $article['text'] ?>
			
			        </p>
		
		        </div>
		
		        <footer class="card-footer text-muted">
			       <div class="row">
				       <div class="col-4">Просмотров: <?php echo $article['views'] ?></div>
				       <div class="col-4">Лайков:
					       <v-likes
							       entity_id="<?php echo $article['id'] ?>"
							       entity_type="news"
							       likes="<?php echo $article['likes'] ?>"
							       liked="<?php echo $article['liked'] ?>"
					       ></v-likes>
				       </div>
				       <div class="col-4">Комментариев: <?php echo count($comments) ?></div>
			       </div>
			       
		        </footer>
	
	        </article>
         
	        <!-- START COMMENTS -->
	        <div id="comments">
		       
		<v-comments :comments='<?php echo json_encode($comments) ?>' news_id="<?php echo $article['id'] ?>">
		</v-comments>
		     
	        </div>
	        <!-- END COMMENTS -->
	        
        
        </div>
        
        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">
            <!-- Categories Widget -->
            <div class="card my-4">
                <h5 class="card-header">Популярные:</h5>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <ul class="list-unstyled mb-0">
                                <?php foreach ($popular as $item) : ?>
	                                <li>
		                                <a href="<?php echo base_url('/news/view/'.$item['id']) ?>"><?php echo $item['header'] ?></a>
	                                </li>
                                <?php endforeach; ?>
                                
                            </ul>
                        </div>
                       
                    </div>
                </div>
            </div>
            
        
        </div>
    
    </div>
    <!-- /.row -->

</div>
<!-- /.container -->
