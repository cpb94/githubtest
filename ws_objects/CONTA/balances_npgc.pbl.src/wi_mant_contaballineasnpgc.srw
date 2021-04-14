$PBExportHeader$wi_mant_contaballineasnpgc.srw
forward
global type wi_mant_contaballineasnpgc from w_int_con_empresa
end type
type dw_1 from datawindow within wi_mant_contaballineasnpgc
end type
type cb_borrar from commandbutton within wi_mant_contaballineasnpgc
end type
type cb_insertar from commandbutton within wi_mant_contaballineasnpgc
end type
type cb_actualizar from commandbutton within wi_mant_contaballineasnpgc
end type
type cb_cancelar from commandbutton within wi_mant_contaballineasnpgc
end type
type dw_list from datawindow within wi_mant_contaballineasnpgc
end type
type ddlb_1 from dropdownlistbox within wi_mant_contaballineasnpgc
end type
type uo_grupo from u_em_campo_2 within wi_mant_contaballineasnpgc
end type
type st_1 from statictext within wi_mant_contaballineasnpgc
end type
type st_2 from statictext within wi_mant_contaballineasnpgc
end type
type uo_subgrupo from u_em_campo_2 within wi_mant_contaballineasnpgc
end type
type uo_balance from u_em_campo_2 within wi_mant_contaballineasnpgc
end type
type st_3 from statictext within wi_mant_contaballineasnpgc
end type
type cb_consultar from commandbutton within wi_mant_contaballineasnpgc
end type
type st_4 from statictext within wi_mant_contaballineasnpgc
end type
type cb_1 from picturebutton within wi_mant_contaballineasnpgc
end type
type st_5 from statictext within wi_mant_contaballineasnpgc
end type
type uo_partida from u_em_campo_2 within wi_mant_contaballineasnpgc
end type
end forward

global type wi_mant_contaballineasnpgc from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 3241
integer height = 2168
dw_1 dw_1
cb_borrar cb_borrar
cb_insertar cb_insertar
cb_actualizar cb_actualizar
cb_cancelar cb_cancelar
dw_list dw_list
ddlb_1 ddlb_1
uo_grupo uo_grupo
st_1 st_1
st_2 st_2
uo_subgrupo uo_subgrupo
uo_balance uo_balance
st_3 st_3
cb_consultar cb_consultar
st_4 st_4
cb_1 cb_1
st_5 st_5
uo_partida uo_partida
end type
global wi_mant_contaballineasnpgc wi_mant_contaballineasnpgc

type variables
boolean inst_consultado
end variables

forward prototypes
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_activa_botones ()
public subroutine f_desactiva_botones ()
public function boolean f_existe_grupo ()
public function boolean f_existe_subgrupo ()
end prototypes

public subroutine f_desactiva ();uo_balance.em_campo.enabled = false
ddlb_1.enabled = false
uo_grupo.em_campo.enabled = false
uo_subgrupo.em_campo.enabled = false
cb_consultar.enabled = false
end subroutine

public subroutine f_activa ();uo_balance.em_campo.enabled = true
ddlb_1.enabled = true
uo_grupo.em_campo.enabled = true
uo_subgrupo.em_campo.enabled = true
cb_consultar.enabled = true
end subroutine

public subroutine f_activa_botones ();cb_borrar.enabled = true
cb_insertar.enabled = true
cb_actualizar.enabled = true
end subroutine

public subroutine f_desactiva_botones ();cb_borrar.enabled = false
cb_insertar.enabled = false
cb_actualizar.enabled = false
end subroutine

public function boolean f_existe_grupo ();long cuantos
string bloque

bloque = left(ddlb_1.text,1)
select count(*) into :cuantos
from contabalgrupnpgc
where (contabalgrupnpgc.empresa 	= 	:codigo_empresa)					and
		(contabalgrupnpgc.codbal		= 	:uo_balance.em_codigo.text) 	and
		(contabalgrupnpgc.bloque		=	:bloque)								and
		(contabalgrupnpgc.grupo		=	:uo_grupo.em_codigo.text)	;
		
if isnull(cuantos) then cuantos = 0

if cuantos = 1 then
	return true
else
	return false
end if
		

end function

public function boolean f_existe_subgrupo ();long cuantos
string bloque
bloque = left(ddlb_1.text,1)
select count(*) into :cuantos
from contabalsubgrupnpgc
where (contabalsubgrupnpgc.empresa 	= 	:codigo_empresa)					and
		(contabalsubgrupnpgc.codbal		= 	:uo_balance.em_codigo.text) 	and
		(contabalsubgrupnpgc.bloque		=	:bloque)								and
		(contabalsubgrupnpgc.grupo		=	:uo_grupo.em_codigo.text)		and
		(contabalsubgrupnpgc.subgrupo	=	:uo_subgrupo.em_codigo.text);

if isnull(cuantos) then cuantos = 0

if cuantos = 1 then
	return true
else
	return false
end if
		

end function

on wi_mant_contaballineasnpgc.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.cb_actualizar=create cb_actualizar
this.cb_cancelar=create cb_cancelar
this.dw_list=create dw_list
this.ddlb_1=create ddlb_1
this.uo_grupo=create uo_grupo
this.st_1=create st_1
this.st_2=create st_2
this.uo_subgrupo=create uo_subgrupo
this.uo_balance=create uo_balance
this.st_3=create st_3
this.cb_consultar=create cb_consultar
this.st_4=create st_4
this.cb_1=create cb_1
this.st_5=create st_5
this.uo_partida=create uo_partida
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_borrar
this.Control[iCurrent+3]=this.cb_insertar
this.Control[iCurrent+4]=this.cb_actualizar
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.uo_grupo
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.uo_subgrupo
this.Control[iCurrent+12]=this.uo_balance
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.cb_consultar
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.uo_partida
end on

on wi_mant_contaballineasnpgc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.cb_actualizar)
destroy(this.cb_cancelar)
destroy(this.dw_list)
destroy(this.ddlb_1)
destroy(this.uo_grupo)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.uo_subgrupo)
destroy(this.uo_balance)
destroy(this.st_3)
destroy(this.cb_consultar)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.uo_partida)
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Lineas por Balance, Grupo y Subgrupo"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana

dw_1.settransObject(sqlca)
dw_list.settransObject(sqlca)
ddlb_1.selectitem("D",1)      

uo_balance.em_campo.setfocus()
f_desactiva_botones()

inst_consultado = false

str_paramemp em
int dec_moneda
em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)

f_mascara_columna(dw_1,"importe",f_mascara_decimales(dec_moneda))
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_contaballineasnpgc
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_contaballineasnpgc
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_contaballineasnpgc
integer width = 3058
end type

type dw_1 from datawindow within wi_mant_contaballineasnpgc
integer y = 676
integer width = 2775
integer height = 1204
boolean bringtotop = true
string dataobject = "dw_mant_contaballineasnpgc"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if f_existe_grupo() and f_existe_subgrupo() and inst_consultado then
	f_desactiva()
	f_activa_botones()
end if

end event

event editchanged;string nom
if dwo.name = "cuenta" then
	
	nom = f_nombre_contaplan(year(today()),codigo_empresa,data)
	
	dw_1.setitem(row,"titulo",nom)
end if
end event

type cb_borrar from commandbutton within wi_mant_contaballineasnpgc
integer x = 2816
integer y = 676
integer width = 361
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Linea"
end type

event clicked;long linea
linea=dw_1.getrow()
dw_1.deleterow(linea)
end event

type cb_insertar from commandbutton within wi_mant_contaballineasnpgc
integer x = 2816
integer y = 776
integer width = 361
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert. Linea"
end type

event clicked;long donde

donde=dw_1.insertrow(0)
dw_1.setitem(donde,"empresa",codigo_empresa)
dw_1.setitem(donde,"codbal",uo_balance.em_codigo.text)
dw_1.setitem(donde,"bloque",left(ddlb_1.text,1))
dw_1.setitem(donde,"grupo",uo_grupo.em_codigo.text)
dw_1.setitem(donde,"subgrupo",uo_subgrupo.em_codigo.text)
dw_1.setitem(donde,"partida", uo_partida.em_codigo.text)
dw_1.setcolumn("cuenta")
dw_1.setrow(donde)
dw_1.setfocus()
end event

type cb_actualizar from commandbutton within wi_mant_contaballineasnpgc
integer x = 2816
integer y = 876
integer width = 361
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;string cuenta
long orden,i



dw_1.accepttext()

// control campo cuenta y orden
FOR i = 1 to dw_1.rowcount()
	cuenta 	= dw_1.getitemstring(i,"cuenta")	
	orden		= dw_1.getitemnumber(i,"orden")
	
	
	if cuenta = "" then
		messagebox("Error de datos","Debe rellenar el campo CUENTA")
		dw_1.setcolumn("cuenta")
		dw_1.setcolumn(i)
		dw_1.setfocus()
		return
	end if
	
	
	if isnull(orden) then
		messagebox("Error de datos","Debe rellenar el campo ORDEN")
		dw_1.setcolumn("orden")
		dw_1.setcolumn(i)
		dw_1.setfocus()
		return
		
	end if
	
	
	
next



dw_1.update()
commit;
dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text, uo_partida.em_codigo.text)
f_desactiva_botones()
f_activa()

end event

type cb_cancelar from commandbutton within wi_mant_contaballineasnpgc
integer x = 2816
integer y = 976
integer width = 361
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;if uo_balance.em_campo.enabled then
	close(parent)
else

	dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text, uo_partida.em_codigo.text)
	f_activa()
	f_desactiva_botones()
	
end if
end event

type dw_list from datawindow within wi_mant_contaballineasnpgc
boolean visible = false
integer x = 2487
integer width = 183
integer height = 120
boolean bringtotop = true
string dataobject = "report_contaballineasnpgc"
boolean livescroll = true
end type

type ddlb_1 from dropdownlistbox within wi_mant_contaballineasnpgc
integer x = 2085
integer y = 196
integer width = 329
integer height = 252
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Debe","Haber"}
end type

event modified;inst_consultado = false
dw_1.reset()
end event

type uo_grupo from u_em_campo_2 within wi_mant_contaballineasnpgc
integer x = 329
integer y = 300
integer width = 1504
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;string f1,f2
      		
ue_titulo     = "AYUDA SELECCION DE GRUPOS"
ue_datawindow = "dw_ayuda_contabalgrupnpgc"
f1 = " bloque = '"+left(ddlb_1.text,1)+"'"
f2 = " and codbal = '" + uo_balance.em_codigo.text + "'"
ue_filtro  = f1 + f2   
end event

event modificado;call super::modificado;string bal 
bal = uo_balance.em_codigo.text
uo_grupo.em_campo.text=f_nombre_contabalgrupnpgc(codigo_empresa,bal,left(ddlb_1.text,1),uo_grupo.em_codigo.text)

IF Trim(uo_grupo.em_campo.text)="" THEN 
 IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
 uo_grupo.em_campo.text=""
 uo_grupo.em_codigo.text=""
END IF
inst_consultado = false
dw_1.reset()
end event

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within wi_mant_contaballineasnpgc
integer x = 123
integer y = 308
integer width = 192
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Grupo :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within wi_mant_contaballineasnpgc
integer x = 37
integer y = 416
integer width = 283
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Subgrupo :"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_subgrupo from u_em_campo_2 within wi_mant_contaballineasnpgc
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 329
integer y = 404
integer width = 1504
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;string bal

bal = uo_balance.em_codigo.text

uo_subgrupo.em_campo.text=f_nombre_contabalsubgrupnpgc(codigo_empresa,bal,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text)
inst_consultado = false
dw_1.reset()

end event

event getfocus;call super::getfocus;string f1,f2,f3

ue_titulo     = "AYUDA SELECCION DE SUBGRUPOS"
ue_datawindow = "dw_ayuda_contabalsubgrupnpgc"

f1 = " codbal = '" + uo_balance.em_codigo.text + "'"

IF ddlb_1.text = "D" THEN
	f2 = " and bloque = 'D'"
ELSE
	f2 = " and bloque = 'H'"
END IF
f3 = " and grupo = '"+uo_grupo.em_codigo.text+"'"

ue_filtro = f1 + f2 + f3     

end event

on uo_subgrupo.destroy
call u_em_campo_2::destroy
end on

type uo_balance from u_em_campo_2 within wi_mant_contaballineasnpgc
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 329
integer y = 200
integer width = 1504
integer height = 88
integer taborder = 10
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabalnpgc(codigo_empresa,uo_balance.em_codigo.text)
cb_1.enabled = true
IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""
 cb_1.enabled = false
END IF

inst_consultado = false
dw_1.reset()

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabalnpgc"
ue_filtro     = ""

end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within wi_mant_contaballineasnpgc
integer x = 87
integer y = 208
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Balance :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_consultar from commandbutton within wi_mant_contaballineasnpgc
integer x = 2030
integer y = 356
integer width = 334
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;if uo_balance.em_campo.text = "" then
	messagebox("Error de Datos","Debe rellenar el campo BALANCE",exclamation!)
	uo_balance.em_campo.setfocus()
	return
end if

if uo_grupo.em_campo.text = "" then
	messagebox("Error de Datos","Debe rellenar el campo GRUPO",exclamation!)
	uo_grupo.em_campo.setfocus()
	return
end if

if uo_subgrupo.em_campo.text = "" then
	messagebox("Error de Datos","Debe rellenar el campo SUBGRUPO",exclamation!)
	uo_subgrupo.em_campo.setfocus()
	return
end if

// Existe grupo en el balance
if not f_existe_grupo() then
	messagebox("Error de datos","No existe el grupo "+ uo_grupo.em_campo.text +&
					" en el balance "+ uo_balance.em_campo.text,exclamation!)
	uo_grupo.em_campo.setfocus()
	dw_1.reset()
	return
end if

// Existe subgrupo en el grupo
if not f_existe_subgrupo() then
	messagebox("Error de datos","No existe el subgrupo "+ uo_subgrupo.em_campo.text +&
					" en el grupo "+ uo_grupo.em_campo.text,exclamation!)
	uo_subgrupo.em_campo.setfocus()
	dw_1.reset()
	return
end if

inst_consultado = true
dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text, uo_partida.em_codigo.text)



end event

type st_4 from statictext within wi_mant_contaballineasnpgc
integer x = 1902
integer y = 208
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Bloque :"
boolean focusrectangle = false
end type

type cb_1 from picturebutton within wi_mant_contaballineasnpgc
event clicked pbm_bnclicked
integer x = 2377
integer y = 356
integer width = 110
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;if uo_balance.em_campo.text = "" then
	messagebox("Error de datos","Ha de introducir el balance",exclamation!)
	uo_balance.em_campo.setfocus()
	return
end if

dw_list.retrieve(codigo_empresa,uo_balance.em_codigo.text)

f_imprimir_datawindow(dw_list)
end event

type st_5 from statictext within wi_mant_contaballineasnpgc
integer x = 37
integer y = 524
integer width = 283
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Partida:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_partida from u_em_campo_2 within wi_mant_contaballineasnpgc
integer x = 329
integer y = 512
integer width = 1504
integer height = 88
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;string bal

bal = uo_balance.em_codigo.text

uo_partida.em_campo.text=f_nombre_contabalpartidanpgc(codigo_empresa,bal,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text, uo_partida.em_codigo.text)
inst_consultado = false
dw_1.reset()

end event

event getfocus;call super::getfocus;string f1,f2,f3,f4

ue_titulo     = "AYUDA SELECCION DE PARTIDAS"
ue_datawindow = "dw_ayuda_contabalpartidanpgc"

f1 = " codbal = '" + uo_balance.em_codigo.text + "'"
f2 = " and bloque = '"+left(ddlb_1.text,1)+"'"
f3 = " and grupo = '"+uo_grupo.em_codigo.text+"'"
f4 = " and subgrupo = '"+uo_subgrupo.em_codigo.text+"'"
ue_filtro = f1 + f2 + f3 + f4
end event

on uo_partida.destroy
call u_em_campo_2::destroy
end on

