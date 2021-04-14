$PBExportHeader$w_inicio.srw
$PBExportComments$Ventana presentacion inicial.
forward
global type w_inicio from window
end type
type pb_teclado from picturebutton within w_inicio
end type
type st_6 from statictext within w_inicio
end type
type lb_1 from listbox within w_inicio
end type
type st_5 from statictext within w_inicio
end type
type st_4 from statictext within w_inicio
end type
type st_3 from statictext within w_inicio
end type
type p_2 from picture within w_inicio
end type
type sle_password from singlelineedit within w_inicio
end type
type sle_usuario from u_em_campo within w_inicio
end type
type st_texto from statictext within w_inicio
end type
type cb_2 from commandbutton within w_inicio
end type
type st_2 from statictext within w_inicio
end type
type st_1 from statictext within w_inicio
end type
type st_mensaje from statictext within w_inicio
end type
type r_1 from rectangle within w_inicio
end type
type cb_1 from commandbutton within w_inicio
end type
end forward

global type w_inicio from window
integer x = 690
integer y = 132
integer width = 1710
integer height = 884
boolean titlebar = true
string title = "Tendencias Cerámicas S.L.U."
boolean controlmenu = true
long backcolor = 20459244
string icon = "C:\bmp\tencer.ico"
pb_teclado pb_teclado
st_6 st_6
lb_1 lb_1
st_5 st_5
st_4 st_4
st_3 st_3
p_2 p_2
sle_password sle_password
sle_usuario sle_usuario
st_texto st_texto
cb_2 cb_2
st_2 st_2
st_1 st_1
st_mensaje st_mensaje
r_1 r_1
cb_1 cb_1
end type
global w_inicio w_inicio

type prototypes
function unsignedlong _lclose(unsignedlong fichero) library "kernel32.dll"
function integer f_fecha_archivo(integer archivo) library "Jobers.dll"
function unsignedlong _lopen(ref string nombre, uint att) library "kernel32.dll"	
end prototypes

type variables
String vuelta
end variables

event open;//COPIA DE BMPS

//RUN("ROBOCOPY \\AMAZONAS\BMP C:\BMP /MIR /Z",Minimized!)

string base_datos, servidor, sql_logid, sql_userid, sql_passwd, ruta_local_erp, ruta_remota_erp, servidor_archivos


//**************************************************************
//PARAMETROS FIJOS DE LA APLICACIÓN
base_datos = "TENCER"
servidor= "PASCAL"
servidor_archivos = "AMAZONAS"
ruta_remota_erp = "\\"+servidor_archivos+"\TENCER\"
ruta_local_erp = "C:\TENCER\"

//**************************************************************

//p_logo.Picturename=logotipo
//p_logo.Width=257
//p_logo.Height=225

this.Icon = 'c:\bmp\tencer.ico'
st_texto.text = texto_logotipo
vuelta = "N"

/*
if fileexists("c:\tencer_PB12\tencer2.ini") then
	fichero_ini="c:\tencer_PB12\tencer2.ini"
else
	messagebox("Error","No encuentro el fichero de configuracion")
	return;
end if

base_datos   		=  	ProfileString(fichero_ini,"database","DataBase","")
servidor 				= 	ProfileString(fichero_ini,"database","ServerName","")
sle_usuario.text 	=  ProfileString(fichero_ini,"database","usuario","")
*/

/*************************************************************************/
/* CONEXIÓN INICAL */
/*************************************************************************/
disconnect using SQLCA;

f_crear_transaccion (SQLCA, base_datos, servidor , true, "", "" )
//f_crear_transaccion (SQLCA, base_datos, servidor , false, "", "" )

connect using SQLCA;
if sqlca.sqlcode <> 0 then
	MessageBox ("No se puede conectar a la Base de Datos", sqlca.sqlerrtext)
	return
end if

/*************************************************************************/
/* FIN CONEXIÓN INICAL */
/*************************************************************************/
sleep(1)	

int i,actualizados,nuevos,borrados,total_servidor
string s,f,f1,f2,p1,p2,h1,h2, texto_error
datetime dt1,dt2,dt3, dt4, ult1, ult2
boolean correcto, actualiza, nuevo
string a
nuevos = 0
actualizados = 0
Timer(0)
correcto = TRUE
actualiza = FALSE
a = "TENCER"
p1 = ruta_remota_erp + "actualizar\"
p2 = ruta_local_erp + "actualizar\"
s  = "*.*"
//lb_1.DirList(p1+s, 0+1+2+4+32)
lb_1.DirList(p1, 0+1+2+4+32)
// COPIA TODO

for i=1 to lb_1.TotalItems()
	lb_1.SelectItem(i)
	f = lb_1.SelectedItem()
	f1 = p1+f
	f2 = p2+f
	f_hora_fichero(f1,dt1,dt2,dt3)
	h1 = string(dt3,"yyyymmddhhmmss")
	f_hora_fichero(f2,dt1,dt2,dt4)
	h2 = string(dt4,"yyyymmddhhmmss")
	if isnull(ult1) then
			ult1 = dt3
	else
		if ult1 < dt3 then
			ult1 = dt3
		end if
	end if
	if isnull(ult2) then
		ult2 = dt4
	else
		if ult2 < dt4 then
			ult2 = dt4
		end if
	end if
	if h1>h2 or not fileexists(f2) then
		//messagebox(f,h1+" - "+h2)
		actualiza = TRUE
		if fileexists(f2) then 
			nuevo = false
			correcto = filedelete(f2)
			if not correcto then 
				texto_error = "No se ha podido borrar el fichero antiguo = "+f2
				messagebox("Atención","Error de actualización.~nAvise al administrador del sistema.~n"+texto_error,StopSign!)
				exit
			end if
		else
			nuevo = true
		end if
		correcto = f_copia_fichero(f1,f2,TRUE)
		if not correcto then 
			texto_error = "No se ha podido efectuar el reemplazo de = "+F1+" sobre = "+F2
			messagebox("Atención","Error de actualización.~nAvise al administrador del sistema.~n"+texto_error,StopSign!)
			exit
		end if
		if nuevo then
			nuevos++
		else
			actualizados++
		end if
	end if
next


total_servidor = lb_1.TotalItems()
//Borrar lo que no existe en el servidor de la aplicacion

lb_1.DirList(p2, 0+1+2+4+32)//Local
for i=1 to lb_1.TotalItems()
	lb_1.SelectItem(i)
	f = lb_1.SelectedItem()
	f1 = p1+f//remoto
	f2 = p2+f//local
	if not fileexists(f1) then
		correcto = filedelete(f2)
		if not correcto then 
			texto_error = "No se ha podido borrar el fichero innecesario = "+f2
			messagebox("Atención","Error de actualización.~nAvise al administrador del sistema.~n"+texto_error,StopSign!)
			exit
		else
			borrados++
		end if
	end if
next


st_5.text = String(nuevos)+ " N " + String(actualizados)+" A "+String(borrados)+" B  ("+String(total_servidor)+")" 
st_6.text = servidor_archivos + " " + String(ult1,"dd/mm/yyyy hh:mm")+" a "+String(ult2,"dd/mm/yyyy hh:mm")

numero_ventanas_activas = 0

f_activar_campo(sle_usuario)
end event

on w_inicio.create
this.pb_teclado=create pb_teclado
this.st_6=create st_6
this.lb_1=create lb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.p_2=create p_2
this.sle_password=create sle_password
this.sle_usuario=create sle_usuario
this.st_texto=create st_texto
this.cb_2=create cb_2
this.st_2=create st_2
this.st_1=create st_1
this.st_mensaje=create st_mensaje
this.r_1=create r_1
this.cb_1=create cb_1
this.Control[]={this.pb_teclado,&
this.st_6,&
this.lb_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.p_2,&
this.sle_password,&
this.sle_usuario,&
this.st_texto,&
this.cb_2,&
this.st_2,&
this.st_1,&
this.st_mensaje,&
this.r_1,&
this.cb_1}
end on

on w_inicio.destroy
destroy(this.pb_teclado)
destroy(this.st_6)
destroy(this.lb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.p_2)
destroy(this.sle_password)
destroy(this.sle_usuario)
destroy(this.st_texto)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_mensaje)
destroy(this.r_1)
destroy(this.cb_1)
end on

type pb_teclado from picturebutton within w_inicio
integer x = 1509
integer y = 644
integer width = 165
integer height = 144
integer taborder = 50
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\bmp\RF\Auto-Type.png"
string disabledname = "C:\bmp\RF\Auto-Type_dis.png"
end type

event clicked;//shellexecutea(Handle(This),"open","C:\Tencer_PB12\osk.exe",0,0,1)
//gf_ejecutar('C:\Windows\System32\osk.exe')
//gf_ejecutar('C:\Tencer_PB12\osk.exe')
//gf_ejecutar("C:\Windows\WinSxS\amd64_microsoft-windows-osk_31bf3856ad364e35_10.0.17134.376_none_8c47b691b018d9c4\osk.exe")
gf_ejecutar("C:\Windows\WinSxS\amd64_microsoft-windows-osk_31bf3856ad364e35_10.0.17763.1_none_9b82bd51b2181d7d\osk.exe")

if sle_usuario.text = '' then
	setfocus(sle_usuario)
else
	setfocus(sle_password)
end if
end event

type st_6 from statictext within w_inicio
integer x = 14
integer y = 720
integer width = 1490
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 20459244
boolean focusrectangle = false
end type

type lb_1 from listbox within w_inicio
boolean visible = false
integer x = 1157
integer y = 612
integer width = 338
integer height = 168
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_inicio
integer x = 1042
integer y = 628
integer width = 439
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 20459244
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_inicio
integer x = 23
integer y = 648
integer width = 878
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 20459244
string text = "www.tendenciasceramicas.com"
boolean focusrectangle = false
end type

type st_3 from statictext within w_inicio
integer x = 23
integer y = 604
integer width = 878
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 20459244
string text = "TENDENCIAS CERAMICAS S.L. *19"
boolean focusrectangle = false
end type

type p_2 from picture within w_inicio
integer x = 311
integer y = 56
integer width = 1079
integer height = 200
string picturename = "C:\bmp\tencer.jpg"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_inicio
integer x = 389
integer y = 500
integer width = 768
integer height = 84
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 16777215
boolean border = false
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
boolean hideselection = false
end type

type sle_usuario from u_em_campo within w_inicio
integer x = 389
integer y = 396
integer width = 768
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 0
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_texto from statictext within w_inicio
boolean visible = false
integer x = 443
integer y = 120
integer width = 635
integer height = 72
integer textsize = -36
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_inicio
integer x = 1179
integer y = 496
integer width = 352
integer height = 96
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "\bmp\MANO.CUR"
string text = "Cancelar"
boolean cancel = true
end type

on clicked;// Aborta la ejecucion de la aplicación
Halt
end on

type st_2 from statictext within w_inicio
integer x = 137
integer y = 500
integer width = 187
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 20459244
boolean enabled = false
string text = "Clave:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_inicio
integer x = 27
integer y = 392
integer width = 297
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 20459244
boolean enabled = false
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_mensaje from statictext within w_inicio
integer x = 507
integer y = 100
integer width = 695
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388736
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type r_1 from rectangle within w_inicio
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 16777215
integer width = 2112
integer height = 300
end type

type cb_1 from commandbutton within w_inicio
integer x = 1179
integer y = 388
integer width = 357
integer height = 96
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "\bmp\MANO.CUR"
string text = "Aceptar"
boolean default = true
end type

event clicked;string ls_usuario, ls_password, var_password,pantalla,parm, SQL_log_pass 
Window inicio
string fichero_servidor, fichero_local //, base_datos, ServerName
unsignedinteger att=0
unsignedlong fecha_servidor=0,fecha_local=0
long servidor,local	



nombre_usuario = sle_usuario.text
ls_password = sle_password.text


/*************************************************************************/
/* CONEXIÓN INCIAL */
/*************************************************************************/

SELECT usuarios.v_basedatos, usuarios.v_servername, usuarios.v_password, usuarios.v_empresa, usuarios.v_grupo, usuarios.v_idioma
INTO   :global_base_datos, :global_servidor, :var_password, :codigo_empresa, :gs_usuarios_v_grupo, :codigo_idioma
FROM   usuarios
WHERE  usuarios.v_usuario = :nombre_usuario 
USING SQLCA;

IF SQLCA.SQLCode<>0 THEN
	 MessageBox("El usuario No Existe","Usuario erroneo",Exclamation!, OK!,1)
	 f_activar_campo(sle_usuario)
	 Return
END IF

SQL_log_pass = ''

if nombre_usuario = 'PCOPIA' then ib_nueva_gestion_de_reservas = true

//trans_cursor  = CREATE transaction	

//f_crear_transaccion (trans_cursor, "", "" , true, "", "" )
f_crear_transaccion (trans_cursor, "", "" , false, "", "" )


connect using trans_cursor;
if trans_cursor.sqlcode <> 0 then
	f_mensaje ("No Puedo conectar para grabar la incidencia", trans_cursor.sqlerrtext +  "CODE" + trans_cursor.sqlerrtext)
end if

disconnect using SQLCA;

f_crear_transaccion (SQLCA, "", "" , false, "", "" )
//f_crear_transaccion (SQLCA, "", "" , true, "", "" )

connect using SQLCA;

IF sqlca.sqlcode = 100 Then
	 f_mensaje("f_grabar_Incidencia","Error seleccion variable conexion")
END IF


/*************************************************************************/
/* FIN CONEXIÓN INCIAL */
/*************************************************************************/


ls_usuario = sle_usuario.text;

pantalla = Trim(f_pantalla_utigrupo(gs_usuarios_v_grupo))
	 
IF ISNull(var_password)  THEN  var_password=""
IF ISNull(ls_password)   THEN  ls_password=""         
IF var_password <> ls_password THEN
	MessageBox("Acceso denegado","Clave erronea",Exclamation!, OK!,1)
	f_activar_campo(sle_usuario)
	Return
END IF

SetPointer(hourglass!)
st_mensaje.Text = "Iniciando la Aplicación..."

st_mensaje.Text = ""

fecha_conexion = DateTime(Today(),Now())

INSERT INTO uticonexiones ( usuario, fecha,servidor,base_datos,version )  
VALUES ( :nombre_usuario, :fecha_conexion,:sqlca.ServerName,:sqlca.Database,:version) ;
COMMIT;

ejercicio_activo   =   f_ejercicio_activo(codigo_empresa)
control_mensajes   = f_control_mensajes_uti_parametros(codigo_empresa)
 
DELETE FROM UTI_BLOQUEO
WHERE USUARIO = :nombre_usuario using sqlca;

IF sqlca.sqlcode = -1 Then
	MESSAGEBOX("ERROR","Error al borrar bloqueos del usuario")
	rollback;
else
	commit;
END IF

SELECT moneda_emp,moneda_emp_2
INTO   :moneda_empresa_primaria,:moneda_empresa_secundaria
FROM   paramemp
WHERE  empresa = :codigo_empresa;

IF SQLCA.SQLCode<>0 THEN
 	MessageBox("La moneda de la Empresa "+codigo_empresa+" no existe","Moneda erronea",Exclamation!, OK!,1)
 	f_activar_campo(sle_usuario)
 	Return
END IF

//Creamos una transaccion Serializable para casos de máximo control del bloqueo.

f_crear_transaccion(trans_TS,"" ,"" ,false, "TS","")	

CONNECT USING trans_TS;

//Nueva gestion de menus
//guo_menu_usuarios = create uo_menu_usuarios

guo_menu_utigrupos = create uo_menu_utigrupos
string ls_list 
ls_list = getlibrarylist ()
SetLibraryList("C:\Tencer\lbmenus.pbl," + ls_list )
//Nueva gestion de menus

if upper(nombre_usuario) = 'PCOPIA' then ib_nueva_gestion_de_reservas = true

RUN("ROBOCOPY \\AMAZONAS\BMP C:\BMP /MIR /Z",Minimized!)

Open(inicio,pantalla)

Close(Parent)




end event

