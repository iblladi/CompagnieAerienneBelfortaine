CREATE OR REPLACE PACKAGE BODY UI_UTLISATEUR AS

procedure client(volaller varchar2 DEFAULT NULL,volretour varchar2 DEFAULT NULL) AS
title varchar2(30) := 'Client Vol';
nomclass varchar2(50);
BEGIN

ui_cookie.sendtwo(volaller,volretour);
nomclass:=ui_cookie.getit('search').vals(1);
ui_menu_footer.entete(title);
htp.print('<div class="container">');
htp.print('<div class="row">');
htp.print('<div class="col-md-6">');
htp.print('<button onclick="login()" class="btn btn-primary">Client</button>');
htp.print('<button onclick="register()" class="btn btn-primary">Nouveau client</button>');
htp.print('<div class="jumbotron">');
htp.print('<form method="post" action="UI_UTLISATEUR.passager" id="formlogin">');
htp.print('<div class="form-group">');
htp.print('<label>Email :</label>');
htp.print('<input name="admeluser" type="email" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label>Password :</label>');
htp.print('<input type="password" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="text-right">');
htp.print('<button type="submit" class="btn btn-primary"> Login</button>');
htp.print('</div>');
htp.print('</form>');
htp.print('<form method="post" action="PA_UTILISATEUR.AddUSER" id="formregister" style="display: none">');
ui_form_utilisateur.formulaire_utlisateur;
htp.print('<div class="text-right">');
htp.print('<button type="submit" class="btn btn-primary"> Valider</button>');
htp.print('</div>');
htp.print('</form>');
htp.print('</div>');
htp.print('</div>');
ui_details_vol.detailvol(volaller,volretour,nomclass);
htp.print('</div>');
htp.print('</div>');
ui_menu_footer.footer;
END client;

procedure passager(admeluser varchar2) AS
title varchar2(30) :=  'Passager vol';
c_user sqlcur;
cur_user utilisateur%rowtype;
nomclass varchar2(50);
codevolreela varchar2(50);
codevolreelr varchar2(50);
BEGIN
ui_cookie.send('clientemail',admeluser);
nomclass:=ui_cookie.getit('search').vals(1);
codevolreela:=ui_cookie.getit('volaller').vals(1);
codevolreelr:=ui_cookie.getit('volretour').vals(1);
ui_menu_footer.entete(title);

htp.print('<div class="container">');
htp.print('<div class="row">');
htp.print('<div class="col-md-6">');
htp.print('<button onclick="login()" class="btn btn-primary">Je suis passager</button>');
htp.print('<button onclick="register()" class="btn btn-primary">Je ne suis pas passager</button>');
htp.print('<div class="jumbotron">');
htp.print('<p>'||admeluser||'</p>');
c_user := PA_UTILISATEUR.checkExistanceOfUser(admeluser);
fetch c_user into cur_user;
htp.print('<form method="post" action="PA_UTILISATEUR.updateUser" id="formlogin">');
while(c_user%found) loop
ui_form_utilisateur.formulaire_utlisateur(cur_user.nom_user,cur_user.pre_user,cur_user.num_categ,TO_CHAR(cur_user.dnaiss_user,'YYYY-MM-DD'),cur_user.nrue_user,cur_user.cp_user,cur_user.ville_user,cur_user.pays_user,cur_user.tel_user,cur_user.admel_user);
htp.print('<div class="form-group">');
htp.print('<label>* Nationalité:</label>');
htp.print('<input name="natiopasg" type="text" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label>* Numéro Passeport:</label>');
htp.print('<input name="numpasspasg" type="text" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="text-right">');
htp.print('<button type="submit" class="btn btn-primary"> Réserver</button>');
htp.print('</div>');
fetch c_user into cur_user;
end loop;
htp.print('</form>');
htp.print('<form method="post" action="PA_UTILISATEUR.addpassager" id="formregister" style="display: none">');
ui_form_utilisateur.formulaire_utlisateur();
htp.print('<div class="form-group">');
htp.print('<label>* Natinalité:</label>');
htp.print('<input name="natiopasg" type="text" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="form-group">');
htp.print('<label>* Numéro Passeport:</label>');
htp.print('<input name="numpasspasg" type="text" class="form-control" required>');
htp.print('</div>');
htp.print('<div class="text-right">');
htp.print('<button type="submit" class="btn btn-primary"> Réserver</button>');
htp.print('</div>');
htp.print('</form>');
htp.print('</div>');
htp.print('</div>');
ui_details_vol.detailvol(codevolreela,codevolreelr,nomclass);
htp.print('</div>');
htp.print('</div>');
ui_menu_footer.footer;
END passager;

procedure redirect_passager(admeluser varchar2) as
begin
owa_util.redirect_url('ui_utlisateur.passager?admeluser='||admeluser);
end redirect_passager;

END UI_UTLISATEUR;
/
