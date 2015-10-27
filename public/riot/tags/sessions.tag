<sessions>
    <div class="animated fadeIn" id="sessions-body">
        <div class="row">
            <div class="col-lg-12">
                <h1>Sessions <small> - 15 disponible(s)</small></h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12" id="alert-box"></div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="table">
                    <table id="sessions-data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom session</th>
                                <th>Début</th>
                                <th>Fin</th>
                                <th>Durée</th>
                                <th>Nb. questions</th>
                                <th>Nb. inscrits</th>
                                <th class="text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="sessions-add-name" placeholder="Nom"></input></td>
                                <td><input type="text" class="form-control" id="sessions-add-start" placeholder="01/01/2015"></input></td>
                                <td><input type="text" class="form-control" id="sessions-add-end" placeholder="01/02/2015"></input></td>
                                <td><input type="text" class="form-control" id="sessions-add-timer" placeholder="00h30"></input></td>
                                <td></td>
                                <td></td>
                                <td class="text-right"><button id="sessions-add-button" class="btn btn-success btn-lg" onclick={session_add}><i id="sessions-add-button-ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr>
                                <td>C# Session 2015-2016 PROMO CDI</td>
                                <td>24/12/2015</td>
                                <td>24/12/2015</td>
                                <td>04H00</td>
                                <td class="text-right">66</td>
                                <td class="text-right">28</td>
                                <td class="text-right">
                                    <a href="" onclick={session_edit}><i data-toggle="tooltip" data-placement="top" title="Editer" class="fa fa-plus fa-lg"></i></a>
                                    &nbsp;&nbsp;
                                    <a href="" onclick={session_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center" id="sessions-pagination-box">
                </div>
            </div>
        </div>
    </div>
</sessions>