<sessions_edit>
    <div class="row animated fadeIn">
        <div class="col-lg-6">
            <sessions_modify session={opts.session} page={opts.page}>
            </sessions_modify>
        </div>
        <div class="col-lg-6">
            <sessions_candidates>
            </sessions_candidates>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12 animated fadeIn" >
            <sessions_questions>
            </sessions_questions>
        </div>
    </div>
    <script>
        loader.hide();
    </script>
</sessions_edit>