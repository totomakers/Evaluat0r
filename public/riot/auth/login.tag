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
                            <input type="text" class="form-control" id="email" placeholder="mail@fai.com" required focus>
                        </div>
                        <div class="form-group">
                            <label for="password">Mot de passe</label>
                            <input type="password" class="form-control" id="password" placeholder="" required>
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
    
        login(e) {
            //call api
            credentials = {'username' : $("#email").val(), 'password' : $("#password").val()};
            $.ajax({type: "POST", url:'/api/accounts/login', data: credentials, success: self.successLogin}).fail(self.failLogin);
        }
        
        //login ok
        successLogin(data) {
            self.message = data.message;
            self.error = data.error;  
           
            if(self.error == false) document.location.href = '/app'; //redirect when login ok
            else self.update();
        }
        
        //login fail - api unvailable
        failLogin(data) {
             self.error = true;
             self.message = self.unvailable_server;
        }
    </script>
</login>

