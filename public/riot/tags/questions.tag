<questions>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12">
                <h1>Themes C#<small> - Description</small></h1>
                <hr>
            </div>
        </div>
        <form>
            <div class="row">
                <div class="col-lg-6">
            
                    <div class="form-group">
                        <label for="question">Question</label>
                        <textarea class="form-control" id="question" name="question" rows="3"></textarea>
                    </div>
                    <div class="table">
                    <table id="question_data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Réponse</th>
                                <th>Bonne réponse</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="questions_answers_add_wording" placeholder="Libellé"></input></td>
                                <td class="text-center"><input type="checkbox" class="checkbox-primary" id="questions_answers_add_good"></input></td>
                                <td class="text-right"><button id="themes_add_button" class="btn btn-success btn-lg" onclick={themes_add}><i id="themes_add_button_ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                    <button type="submit" class="btn btn-success">Ajouter</button>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        var self = this;
        loader.show();
        loader.hide();
    </script>
</questions>