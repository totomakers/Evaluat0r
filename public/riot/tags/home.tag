<home>
    <div class="animated fadeIn">
        <h1 show={user}>Bonjour, {user.lastname} {user.firstname}</h1>
    </div>
    <script>
        var self = this;
    
        //call api
        this.on('mount',function() {
            opts.profile();
        });
        
        //login ok
        opts.on('profile', function(json) {
            self.user = json.data;
            self.update();
        });  
    </script>
</home>

