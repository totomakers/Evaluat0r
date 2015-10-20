<login>
    <div class="center-block">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1>Connexion</h1>
            </div>
        </div>
        <div class="row animated fadeIn">
            <div class="col-lg-4 col-lg-offset-4">
                <div class="panel panel-default">
                  <div class="panel-body">
                    <div class="text-center">
                        <img src="custom/picture/user.png" alt="" class="login-picture img-circle">
                    </div>
                    <hr>
                    <div class="alert alert-danger animated fadeIn" show={error}>{ message }</div>
                    <div class="alert alert-success animated fadeIn" show={error == false}>{ message }</div>
                    <form onsubmit={ login }>
                        <div class="form-group">
                            <label for="email">Adresse mail</label>
                            <input name="email" type="text" class="form-control" id="email" placeholder="mail@fai.com" required focus>
                        </div>
                        <div class="form-group">
                            <label for="password">Mot de passe</label>
                            <input name="password" type="password" class="form-control" id="password" placeholder="" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Connexion</button>
                        </div>
                    </form>
                  </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
    
        //call api
        login(e) {
            credentials = {'username' : this.email.value, 'password' : this.password.value};
            opts.login(credentials);
        }
        
        //login ok
        opts.on('login', function(json) {
            self.message = json.message;
            self.error = json.error;  
           
            if(self.error == false) document.location.href = '/app'; //redirect when login ok
            else self.update();
        });  
      
    </script>
</login>

