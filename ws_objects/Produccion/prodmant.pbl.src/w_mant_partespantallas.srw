$PBExportHeader$w_mant_partespantallas.srw
forward
global type w_mant_partespantallas from window
end type
type st_2 from statictext within w_mant_partespantallas
end type
type sle_turno from singlelineedit within w_mant_partespantallas
end type
type dw_1 from u_datawindow within w_mant_partespantallas
end type
type pb_4 from picturebutton within w_mant_partespantallas
end type
type pb_3 from picturebutton within w_mant_partespantallas
end type
type pb_grabar from picturebutton within w_mant_partespantallas
end type
type pb_1 from picturebutton within w_mant_partespantallas
end type
type st_1 from statictext within w_mant_partespantallas
end type
type em_fecha from editmask within w_mant_partespantallas
end type
end forward

global type w_mant_partespantallas from window
integer width = 2583
integer height = 2980
boolean titlebar = true
string title = "Introducción de Partes de Pantallas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
sle_turno sle_turno
dw_1 dw_1
pb_4 pb_4
pb_3 pb_3
pb_grabar pb_grabar
pb_1 pb_1
st_1 st_1
em_fecha em_fecha
end type
global w_mant_partespantallas w_mant_partespantallas

type variables
Int id_ventana_activa
end variables

on w_mant_partespantallas.create
this.st_2=create st_2
this.sle_turno=create sle_turno
this.dw_1=create dw_1
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_grabar=create pb_grabar
this.pb_1=create pb_1
this.st_1=create st_1
this.em_fecha=create em_fecha
this.Control[]={this.st_2,&
this.sle_turno,&
this.dw_1,&
this.pb_4,&
this.pb_3,&
this.pb_grabar,&
this.pb_1,&
this.st_1,&
this.em_fecha}
end on

on w_mant_partespantallas.destroy
destroy(this.st_2)
destroy(this.sle_turno)
destroy(this.dw_1)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_grabar)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_fecha)
end on

event open;//em_fecha.text = string(today(), "dd-mm-yy")
dw_1.Settransobject(SQLCA)
end event

event close;string codigo

if dw_1.DeletedCount() + dw_1.ModifiedCount() > 0 then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		pb_grabar.triggerevent (clicked!)
	end if
end if

f_menu_cerrar_ventana(this,id_ventana_activa)

w_mant_partespantallas = ventanas_activas[id_ventana_activa].ventana


//if dw_1.rowcount() > 0 and dw_1.object.#1[dw_1.getrow()] <> '' and not isnull(dw_1.object.#1[dw_1.getrow()]) then
//	codigo = dw_1.object.#1[dw_1.getrow()]
//	CloseWithReturn (this, codigo)
//end if

end event

event activate;//Ventanas en el menú principal
id_ventana_activa = f_menu_insertar_ventana(this)
end event

type st_2 from statictext within w_mant_partespantallas
integer x = 549
integer y = 36
integer width = 210
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Turno:"
boolean focusrectangle = false
end type

type sle_turno from singlelineedit within w_mant_partespantallas
integer x = 777
integer y = 32
integer width = 123
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event losefocus;if sle_turno.text <> '' and not isnull(sle_turno.text) then
//	messagebox("","")
	dw_1.retrieve(codigo_empresa, datetime (date(em_fecha.text)), sle_turno.text)
end if

end event

type dw_1 from u_datawindow within w_mant_partespantallas
integer x = 32
integer y = 156
integer width = 2464
integer height = 2656
integer taborder = 30
string dataobject = "dw_mant_partespantallas"
end type

event key;call super::key;string campo, consulta
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "tipo_marco"
			
			busqueda.titulo_ventana = "Búsqueda de Tipo de Marco"
			busqueda.consulta = "SELECT CODIGO AS CÓDIGO, DESCRIPCION as DESCRIPCIÓN, ancho as ANCHO, LARGO AS LARGO FROM prodtipomarcopantalla WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Ancho"
			busqueda.titulos[4] = "Largo"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipo_marco[this.GetRow()] = resultado.valores[1]		
			end if
			
//			
//			consulta = "SELECT CODIGO AS CÓDIGO, DESCRIPCION as DESCRIPCIÓN, ancho as ANCHO, LARGO AS LARGO FROM prodtipomarcopantalla WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
//			OpenWithParm(wt_busquedas, consulta)
//			dw_1.object.tipo_marco[dw_1.GetRow()] = Message.StringParm		// Devuelve el valor que encuentra ...
			
			
	END CHOOSE
end if	
end event

type pb_4 from picturebutton within w_mant_partespantallas
integer x = 2167
integer y = 32
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Insert!"
end type

event clicked;long fila

fila = dw_1.insertrow(0)
dw_1.scrolltorow(fila)
dw_1.setfocus()
dw_1.setcolumn("tipo_marco")

dw_1.object.empresa[fila] = codigo_empresa
dw_1.object.fecha[fila] = datetime(date(em_fecha.text))
dw_1.object.operario[fila] = '1'
dw_1.object.turno[fila] = sle_turno.text
dw_1.object.buenas[fila] = 0
dw_1.object.malas[fila] = 0

end event

type pb_3 from picturebutton within w_mant_partespantallas
integer x = 2386
integer y = 32
integer width = 110
integer height = 96
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Exit!"
end type

event clicked;
close(parent)
end event

type pb_grabar from picturebutton within w_mant_partespantallas
integer x = 2057
integer y = 32
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Save!"
end type

event clicked;dw_1.accepttext()
if dw_1.update() = 1 then
	commit using SQLCA;
else
	rollback using SQLCA;
end if
end event

type pb_1 from picturebutton within w_mant_partespantallas
integer x = 2277
integer y = 32
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Clear!"
end type

event clicked;
dw_1.accepttext()
if dw_1.deleterow(0) = 1 then
	commit using SQLCA;
else
	rollback using SQLCA;
end if
end event

type st_1 from statictext within w_mant_partespantallas
integer x = 37
integer y = 36
integer width = 210
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha:"
boolean focusrectangle = false
end type

type em_fecha from editmask within w_mant_partespantallas
integer x = 251
integer y = 32
integer width = 274
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;
if sle_turno.text <> '' and not isnull(sle_turno.text) then
	dw_1.retrieve(codigo_empresa, datetime (date(this.text)), sle_turno.text)
end if


end event

