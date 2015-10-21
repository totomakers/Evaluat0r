<home>
    <div class="animated fadeIn">
        <h1 show={user}>Bonjour, {user.lastname} {user.firstname}</h1>
    </div>
    <script>
        loader.show();
        var self = this;
    
        //call api
        this.on('mount',function() {
            opts.profile();
        });
        
        //profile ok 
        opts.on('profile', function(json) {
            self.user = json.data;
            self.update();
            loader.hide();
        });  
    </script>
</home>

