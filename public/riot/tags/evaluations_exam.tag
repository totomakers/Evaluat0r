<evalutions_details>
    <div id="evaluations-details-content">
    </div>
    
    <script>
        loader.hide();
        var self = this;
        
        //On vérifie que la session n'est pas démarrer -
        this.on('mount', function(){
            opts.auth.getEvaluationsResume(opts.page.id);
        });
        
        opts.auth.on('account_evaluations_resume', function(json)
        {
            if(json.error == true)
            {
                riot.mount('#evaluations-details-content', 'evaluations_info', {'auth':auth, 'page': opts.page });
            }
            else
            {
            }
        });
    </script>    
        
    </script>
</evalutions_details>