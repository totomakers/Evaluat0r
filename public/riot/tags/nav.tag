<app_nav>
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
           <div class="text-center">
               <img src="custom/picture/logo.png" alt="" class="logo-picture">
           </div>

        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
            <ul class="nav navbar-nav" show={user}>
                <li><a href="#">Accueil<i class="pull-right fa fa-blue fa-home fa-lg"></i></a></li>
                <li show={user.rank<=1 || user.rank==99}><a href="#result">Résultat<i class="pull-right fa fa-blue fa-bar-chart fa-lg"></i></a></li>
                <li show={user.rank==1 || user.rank==99}><a href="#sessions">Préparer une évaluation<i class="pull-right fa fa-blue fa-plus fa-lg"></i></span></a></li>
                <li show={user.rank==2 || user.rank==99}><a href="#themes">Thèmes<i class="pull-right fa fa-blue fa-cube fa-lg"></i></a></li>
                <li show={user.rank==2 || user.rank==99}><a href="#templates">Modèles<i class="pull-right fa fa-blue fa-cubes fa-lg"></i></a></li>
                <li show={user.rank==0 || user.rank==99}><a href="#eval">Evaluation<i class="pull-right fa fa-blue fa-pencil fa-lg"></i></a></li>
                <li><a href="#" onclick={auth.logout}>Déconnexion<i class="pull-right fa  fa-blue fa-sign-out fa-lg"></i></a></li>
            </ul>
        </div>
    </div>
    
    <script>
        var self = this;
        
        this.on('mount',function(){
            opts.profile();
        });
        
        //when profile is loaded
        opts.on('profile', function(json) {
            self.user = json.data;
            self.update();
        });
    </script>
</app_nav>

