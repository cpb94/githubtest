$PBExportHeader$w_pasar_asiento.srw
$PBExportComments$€
forward
global type w_pasar_asiento from w_int_con_empresa
end type
type uo_ejercicio from u_ejercicio within w_pasar_asiento
end type
type dw_1 from datawindow within w_pasar_asiento
end type
type uo_origen from u_em_campo_2 within w_pasar_asiento
end type
type st_3 from statictext within w_pasar_asiento
end type
type st_asiento from statictext within w_pasar_asiento
end type
type em_asiento from u_em_campo within w_pasar_asiento
end type
type cb_1 from u_boton within w_pasar_asiento
end type
type uo_mes from u_em_campo_2 within w_pasar_asiento
end type
type st_4 from statictext within w_pasar_asiento
end type
type dw_apuntes from datawindow within w_pasar_asiento
end type
type cb_2 from commandbutton within w_pasar_asiento
end type
type st_2 from statictext within w_pasar_asiento
end type
type st_5 from statictext within w_pasar_asiento
end type
type em_nuevo_asiento from u_em_campo within w_pasar_asiento
end type
type st_1 from statictext within w_pasar_asiento
end type
type st_6 from statictext within w_pasar_asiento
end type
type st_7 from statictext within w_pasar_asiento
end type
type cb_3 from commandbutton within w_pasar_asiento
end type
type uo_nuevo_origen from u_em_campo_2 within w_pasar_asiento
end type
type em_nueva_fecha from u_em_campo within w_pasar_asiento
end type
type st_8 from statictext within w_pasar_asiento
end type
type pb_1 from upb_salir within w_pasar_asiento
end type
end forward

global type w_pasar_asiento from w_int_con_empresa
integer width = 2930
integer height = 2100
uo_ejercicio uo_ejercicio
dw_1 dw_1
uo_origen uo_origen
st_3 st_3
st_asiento st_asiento
em_asiento em_asiento
cb_1 cb_1
uo_mes uo_mes
st_4 st_4
dw_apuntes dw_apuntes
cb_2 cb_2
st_2 st_2
st_5 st_5
em_nuevo_asiento em_nuevo_asiento
st_1 st_1
st_6 st_6
st_7 st_7
cb_3 cb_3
uo_nuevo_origen uo_nuevo_origen
em_nueva_fecha em_nueva_fecha
st_8 st_8
pb_1 pb_1
end type
global w_pasar_asiento w_pasar_asiento

type variables
datetime inst_fechaapu
end variables

forward prototypes
public subroutine f_cambio_linea (integer reg)
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_desactiva_nuevos ()
public subroutine f_activa_nuevos ()
end prototypes

public subroutine f_cambio_linea (integer reg);if dw_1.RowCount() = 0 tHEN Return
iF IsNull(reg) Then Return
IF reg = 0 Then Return
Integer ln
ln = Integer(dw_1.Describe("DataWindow.LastRowOnPage"))
dw_1.SetItem(ln,"cta",dw_1.GetItemString(reg,"cuenta"))
dw_1.SetItem(ln,"con",dw_1.GetItemString(reg,"concepto"))
end subroutine

public subroutine f_desactiva ();uo_origen.em_campo.enabled = false
uo_mes.em_campo.enabled = false
em_asiento.enabled = false
st_asiento.enabled = false 
cb_1.enabled = false
end subroutine

public subroutine f_activa ();uo_origen.em_campo.enabled = true
uo_mes.em_campo.enabled = true
em_asiento.enabled = true
st_asiento.enabled = true
cb_1.enabled = true
end subroutine

public subroutine f_desactiva_nuevos ();uo_nuevo_origen.em_campo.enabled = false
uo_nuevo_origen.em_codigo.enabled = false
em_nueva_fecha.enabled = false

em_nuevo_asiento.enabled = false
cb_2.enabled = false
end subroutine

public subroutine f_activa_nuevos ();uo_nuevo_origen.em_campo.enabled = true
uo_nuevo_origen.em_codigo.enabled = true
em_nueva_fecha.enabled = true

em_nuevo_asiento.enabled = true
cb_2.enabled = true
end subroutine

event open;call super::open;dw_1.SetTransObject(SQLCA)

istr_parametros.s_titulo_ventana  = "Pasar asientos entre orígenes"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana
uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))


f_mascara_columna(dw_1,"debe",f_mascara_decimales(2))
f_mascara_columna(dw_1,"haber",f_mascara_decimales(2))
f_mascara_columna(dw_1,"totald",f_mascara_decimales(2))
f_mascara_columna(dw_1,"totalh",f_mascara_decimales(2))
f_activar_campo(uo_origen.em_campo)

cb_2.enabled = false
f_desactiva_nuevos()
end event

on w_pasar_asiento.create
int iCurrent
call super::create
this.uo_ejercicio=create uo_ejercicio
this.dw_1=create dw_1
this.uo_origen=create uo_origen
this.st_3=create st_3
this.st_asiento=create st_asiento
this.em_asiento=create em_asiento
this.cb_1=create cb_1
this.uo_mes=create uo_mes
this.st_4=create st_4
this.dw_apuntes=create dw_apuntes
this.cb_2=create cb_2
this.st_2=create st_2
this.st_5=create st_5
this.em_nuevo_asiento=create em_nuevo_asiento
this.st_1=create st_1
this.st_6=create st_6
this.st_7=create st_7
this.cb_3=create cb_3
this.uo_nuevo_origen=create uo_nuevo_origen
this.em_nueva_fecha=create em_nueva_fecha
this.st_8=create st_8
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ejercicio
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.uo_origen
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_asiento
this.Control[iCurrent+6]=this.em_asiento
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.uo_mes
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.dw_apuntes
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_nuevo_asiento
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.cb_3
this.Control[iCurrent+19]=this.uo_nuevo_origen
this.Control[iCurrent+20]=this.em_nueva_fecha
this.Control[iCurrent+21]=this.st_8
this.Control[iCurrent+22]=this.pb_1
end on

on w_pasar_asiento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_ejercicio)
destroy(this.dw_1)
destroy(this.uo_origen)
destroy(this.st_3)
destroy(this.st_asiento)
destroy(this.em_asiento)
destroy(this.cb_1)
destroy(this.uo_mes)
destroy(this.st_4)
destroy(this.dw_apuntes)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.em_nuevo_asiento)
destroy(this.st_1)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_3)
destroy(this.uo_nuevo_origen)
destroy(this.em_nueva_fecha)
destroy(this.st_8)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_pasar_asiento
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_pasar_asiento
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_asiento)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_pasar_asiento
integer y = 8
end type

type uo_ejercicio from u_ejercicio within w_pasar_asiento
integer x = 2185
integer y = 144
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_1 from datawindow within w_pasar_asiento
integer x = 23
integer y = 472
integer width = 2825
integer height = 1380
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_con_contaapun1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemfocuschanged;Dec v_ejercicio
String cta

IF GetRow()<> 0 Then
		v_ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
		cta =  getItemString(getRow(),"cuenta")
End if

end event

event rowfocuschanged;f_cambio_linea(currentrow)
end event

type uo_origen from u_em_campo_2 within w_pasar_asiento
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 421
integer y = 212
integer width = 777
integer height = 80
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_origen.em_codigo.text)

IF Trim(uo_origen.em_campo.text)="" THEN 
 IF Trim(uo_origen.em_codigo.text)<>"" Then uo_origen.em_campo.SetFocus()
 uo_origen.em_campo.text=""
 uo_origen.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

on uo_origen.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_pasar_asiento
integer x = 425
integer y = 136
integer width = 777
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Origen "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_asiento from statictext within w_pasar_asiento
event clicked pbm_bnclicked
integer x = 1586
integer y = 136
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 12632256
string text = "Asiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_apuntes.SetTransObject(SQLCA)
IF dw_apuntes.retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Dec(uo_mes.em_codigo.text),uo_origen.em_codigo.text) <> 0 Then
	dw_apuntes.visible = TRUE
	st_8.text = ""
END IF
end event

type em_asiento from u_em_campo within w_pasar_asiento
event modificado pbm_custom02
integer x = 1586
integer y = 212
integer width = 270
integer height = 80
integer taborder = 30
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

type cb_1 from u_boton within w_pasar_asiento
integer x = 1865
integer y = 204
integer width = 279
integer height = 96
integer taborder = 40
string text = "&Consultar"
end type

event clicked;call super::clicked;long regi
regi = dw_1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,Dec(uo_mes.em_codigo.text),uo_origen.em_codigo.text,Dec(em_asiento.text))
if regi > 0 then
	dw_1.setfocus()
	f_desactiva()
	f_activa_nuevos()
	uo_nuevo_origen.em_codigo.text = dw_1.getitemstring(1,"origen")
	uo_nuevo_origen.em_campo.text = f_nombre_contaorigen(codigo_empresa,dw_1.getitemstring(1,"origen"))
	em_nueva_fecha.text = string(date(dw_1.getitemdatetime(1,"fapunte")))
	inst_fechaapu = dw_1.getitemdatetime(1,"fapunte")
	uo_nuevo_origen.em_campo.setfocus()
	cb_2.enabled = true
	cb_3.enabled = true
	st_8.text = ""

else
	uo_nuevo_origen.em_campo.text = ""
	uo_nuevo_origen.em_codigo.text = ""
	uo_mes.em_campo.text = ""
	uo_mes.em_codigo.text = ""
	
	st_8.text = ""
	
end if
end event

type uo_mes from u_em_campo_2 within w_pasar_asiento
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1198
integer y = 212
integer width = 384
integer height = 80
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_mes.em_campo.text=f_nombre_mes(Dec(uo_mes.em_codigo.text))

IF Trim(uo_mes.em_campo.text)="" THEN 
 IF Trim(uo_mes.em_codigo.text)<>"" Then uo_mes.em_campo.SetFocus()
 uo_mes.em_campo.text=""
 uo_mes.em_codigo.text=""
END IF


end event

on uo_mes.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_pasar_asiento
integer x = 1202
integer y = 136
integer width = 384
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Mes"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_apuntes from datawindow within w_pasar_asiento
event clicked pbm_dwnlbuttonclk
boolean visible = false
integer x = 1093
integer y = 212
integer width = 763
integer height = 788
string dataobject = "dw_con_contaapun3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0     Then return
IF IsNull(row) Then return
em_asiento.text = String(GetItemNumber(row,"asiento"))
uo_mes.em_codigo.text = String(Month(Date(GetItemDateTime(row,"fapunte"))))
uo_mes.em_campo.text  = f_nombre_mes(Dec(uo_mes.em_codigo.text))
This.Reset()
This.visible = FALSE
cb_1.TriggerEvent("clicked")

end event

type cb_2 from commandbutton within w_pasar_asiento
integer x = 1870
integer y = 352
integer width = 279
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;str_contaapun apu
string origen,nuevo_origen
int mes,nuevo_mes,apuntes,i,bien,apunte
dec ejercicio,asiento,nuevo_asiento
datetime nueva_fecha

bien = 0



if not isdate(em_nueva_fecha.text) then
	messagebox("Atención","Nueva fecha NO válida")
	return
end if



ejercicio=	Dec(uo_ejercicio.em_ejercicio.text)
mes 		=	integer(uo_mes.em_codigo.text)
origen 	=	uo_origen.em_codigo.text
asiento	=	dec(em_asiento.text) 


nuevo_origen = uo_nuevo_origen.em_codigo.text
nueva_fecha = datetime(date(em_nueva_fecha.text))
nuevo_mes= 	month(date(nueva_fecha))	



// El año de la nueva fecha ha de coincidir con el ejercicio
if integer(ejercicio) <> year(date(nueva_fecha)) then
	messagebox("Atención","El año de la nueva fecha ha de coincidir con el ejercicio actual")
	return		
end if


// Si sólo cambia la fecha dentro del mes es el mismo asiento
if nuevo_mes = mes and nuevo_origen = origen then
	
	update	contaapun
	set 	contaapun.fapunte		=	:nueva_fecha
	where (contaapun.ejercicio =	:ejercicio)			and
			(contaapun.empresa	=	:codigo_empresa)	and
			(contaapun.mes			=	:mes)					and
			(contaapun.origen		=	:origen)				and
			(contaapun.asiento	=	:asiento);

	st_8.text = em_asiento.text
	
	

else
	
	nuevo_asiento	=	f_ultimo_asiento(ejercicio,codigo_empresa,nuevo_mes,nuevo_origen)
	apunte = 0
	
	select count(*) into :apuntes
	from contaapun
	where (contaapun.ejercicio =	:ejercicio)			and
			(contaapun.empresa	=	:codigo_empresa)	and
			(contaapun.mes			=	:mes)					and
			(contaapun.origen		=	:origen)				and
			(contaapun.asiento	=	:asiento);
	
	if isnull(apuntes) then apuntes = 0
	if apuntes = 0 then 
		messagebox("Atención","No hay apuntes en el asiento seleccionado")
		return		
	end if
	
	
	long apuntes_iva
	SELECT count(*) into :apuntes_iva
	from contaapun
	where (contaapun.ejercicio =	:ejercicio)			and
			(contaapun.empresa	=	:codigo_empresa)	and
			(contaapun.mes			=	:mes)					and
			(contaapun.origen		=	:origen)				and
			(contaapun.asiento	=	:asiento)			and
			(contaapun.tipoapu is not null) 				and
			(contaapun.tipoapu <> "");
	
	int op
	if apuntes_iva > 0 then
		op = messagebox("Atención","Existen apuntes de IVA en el asiento. ¿ Desea continuar ?",question!,yesno!,2)
		if op = 2 then return
	end if
	
	
	
	update	contaapun
	set 	contaapun.fapunte		=	:nueva_fecha,
			contaapun.origen		=	:nuevo_origen,
			contaapun.mes			=  :nuevo_mes,
			contaapun.asiento		=  :nuevo_asiento,
			contaapun.fregistro	=	:nueva_fecha
	where (contaapun.ejercicio =	:ejercicio)			and
			(contaapun.empresa	=	:codigo_empresa)	and
			(contaapun.mes			=	:mes)					and
			(contaapun.origen		=	:origen)				and
			(contaapun.asiento	=	:asiento);
	
	

	
	if sqlca.sqlcode <> 0 then 
		messagebox("Atención","Error al actualizar asiento ")
		bien = 1
	end if
	
	
end if


if bien = 0 then
	commit;
	if apunte > 0 then
		st_8.text = string(integer(nuevo_asiento))		
	end if
	f_activa()
	
	
else
	rollback;
	st_8.text = ""
	messagebox("Atención","No se ha traspasado el asiento")
	f_desactiva_nuevos()
	f_activa()
	uo_nuevo_origen.em_campo.text = ""
	uo_nuevo_origen.em_codigo.text = ""

	em_nueva_fecha.text = ""
	em_nuevo_asiento.text = ""


	em_asiento.setfocus()
	dw_1.reset()
	
	
	
end if


cb_2.enabled = false
cb_3.enabled = false
end event

type st_2 from statictext within w_pasar_asiento
integer x = 1207
integer y = 292
integer width = 379
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_pasar_asiento
integer x = 1591
integer y = 292
integer width = 265
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long backcolor = 12632256
string text = "Asiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_nuevo_asiento from u_em_campo within w_pasar_asiento
integer x = 82
integer y = 124
integer width = 265
integer height = 80
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "Ä"
end type

type st_1 from statictext within w_pasar_asiento
integer x = 421
integer y = 288
integer width = 782
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Origen "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_pasar_asiento
integer x = 137
integer y = 220
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "DESDE :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_pasar_asiento
integer x = 146
integer y = 372
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "HASTA :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_pasar_asiento
integer x = 2153
integer y = 352
integer width = 279
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;f_activa()

f_desactiva_nuevos()

uo_nuevo_origen.em_campo.text = ""
uo_nuevo_origen.em_codigo.text = ""

em_nueva_fecha.text = ""
em_nuevo_asiento.text = ""

st_8.text = ""
em_asiento.setfocus()
dw_1.reset()
end event

type uo_nuevo_origen from u_em_campo_2 within w_pasar_asiento
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 421
integer y = 364
integer width = 777
integer height = 80
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_nuevo_origen.em_campo.text=f_nombre_contaorigen(codigo_empresa,uo_nuevo_origen.em_codigo.text)

IF Trim(uo_nuevo_origen.em_campo.text)="" THEN 
 IF Trim(uo_nuevo_origen.em_codigo.text)<>"" Then uo_nuevo_origen.em_campo.SetFocus()
 uo_nuevo_origen.em_campo.text=""
 uo_nuevo_origen.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE ORIGENES"
		ue_datawindow = "dw_ayuda_contaorigen"
		ue_filtro     = ""

end event

on uo_nuevo_origen.destroy
call u_em_campo_2::destroy
end on

type em_nueva_fecha from u_em_campo within w_pasar_asiento
integer x = 1202
integer y = 364
integer width = 384
integer height = 80
integer taborder = 60
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = ""
end type

type st_8 from statictext within w_pasar_asiento
integer x = 1591
integer y = 364
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_pasar_asiento
integer x = 2702
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

