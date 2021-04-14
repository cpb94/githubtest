$PBExportHeader$wi_mant_contabalsubgruponpgc.srw
forward
global type wi_mant_contabalsubgruponpgc from w_int_con_empresa
end type
type dw_1 from datawindow within wi_mant_contabalsubgruponpgc
end type
type cb_borrar from commandbutton within wi_mant_contabalsubgruponpgc
end type
type cb_insertar from commandbutton within wi_mant_contabalsubgruponpgc
end type
type cb_actualizar from commandbutton within wi_mant_contabalsubgruponpgc
end type
type cb_cancelar from commandbutton within wi_mant_contabalsubgruponpgc
end type
type dw_list from datawindow within wi_mant_contabalsubgruponpgc
end type
type uo_balance from u_em_campo_2 within wi_mant_contabalsubgruponpgc
end type
type st_1 from statictext within wi_mant_contabalsubgruponpgc
end type
type cb_consultar from commandbutton within wi_mant_contabalsubgruponpgc
end type
type cb_1 from picturebutton within wi_mant_contabalsubgruponpgc
end type
type ddlb_1 from dropdownlistbox within wi_mant_contabalsubgruponpgc
end type
type uo_grupo from u_em_campo_2 within wi_mant_contabalsubgruponpgc
end type
type st_2 from statictext within wi_mant_contabalsubgruponpgc
end type
type st_3 from statictext within wi_mant_contabalsubgruponpgc
end type
end forward

global type wi_mant_contabalsubgruponpgc from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 2798
integer height = 1656
dw_1 dw_1
cb_borrar cb_borrar
cb_insertar cb_insertar
cb_actualizar cb_actualizar
cb_cancelar cb_cancelar
dw_list dw_list
uo_balance uo_balance
st_1 st_1
cb_consultar cb_consultar
cb_1 cb_1
ddlb_1 ddlb_1
uo_grupo uo_grupo
st_2 st_2
st_3 st_3
end type
global wi_mant_contabalsubgruponpgc wi_mant_contabalsubgruponpgc

forward prototypes
public subroutine f_activa_claves ()
public subroutine f_desactiva_claves ()
public subroutine f_activa_botones ()
public subroutine f_desactiva_botones ()
public subroutine f_borrar_espacios ()
end prototypes

public subroutine f_activa_claves ();uo_balance.em_campo.enabled = true
uo_grupo.em_campo.enabled = true
ddlb_1.enabled = true
cb_consultar.enabled = true
end subroutine

public subroutine f_desactiva_claves ();uo_balance.em_campo.enabled = false
uo_grupo.em_campo.enabled = false
ddlb_1.enabled = false
cb_consultar.enabled = false
end subroutine

public subroutine f_activa_botones ();cb_borrar.enabled = true
cb_insertar.enabled = true
cb_actualizar.enabled = true


end subroutine

public subroutine f_desactiva_botones ();cb_borrar.enabled = false
cb_insertar.enabled = false
cb_actualizar.enabled = false

end subroutine

public subroutine f_borrar_espacios ();
end subroutine

on wi_mant_contabalsubgruponpgc.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.cb_actualizar=create cb_actualizar
this.cb_cancelar=create cb_cancelar
this.dw_list=create dw_list
this.uo_balance=create uo_balance
this.st_1=create st_1
this.cb_consultar=create cb_consultar
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.uo_grupo=create uo_grupo
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_borrar
this.Control[iCurrent+3]=this.cb_insertar
this.Control[iCurrent+4]=this.cb_actualizar
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.uo_balance
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_consultar
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.ddlb_1
this.Control[iCurrent+12]=this.uo_grupo
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
end on

on wi_mant_contabalsubgruponpgc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.cb_actualizar)
destroy(this.cb_cancelar)
destroy(this.dw_list)
destroy(this.uo_balance)
destroy(this.st_1)
destroy(this.cb_consultar)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.uo_grupo)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Subgrupos por Grupo y Balance"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana

dw_1.settransObject(sqlca)
dw_list.settransObject(sqlca)

uo_balance.em_campo.setfocus()

f_activa_claves()
f_desactiva_botones()
cb_1.enabled = false


ddlb_1.text = "Debe"
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_contabalsubgruponpgc
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_contabalsubgruponpgc
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_contabalsubgruponpgc
end type

type dw_1 from datawindow within wi_mant_contabalsubgruponpgc
integer x = 69
integer y = 400
integer width = 2258
integer height = 1004
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_mant_contabalsubgrupnpgc"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;f_desactiva_claves()
f_activa_botones()
f_borrar_espacios()

end event

type cb_borrar from commandbutton within wi_mant_contabalsubgruponpgc
integer x = 2368
integer y = 404
integer width = 366
integer height = 108
integer taborder = 50
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

type cb_insertar from commandbutton within wi_mant_contabalsubgruponpgc
integer x = 2368
integer y = 512
integer width = 366
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert. Linea"
end type

event clicked;long linea,donde
string emp,bloq,grup,tit,bal

//if dw_1.rowcount() > 0 then


	bal = trim(uo_balance.em_codigo.text)
	
	linea=dw_1.getrow()
	
	
	emp=codigo_empresa
	if ddlb_1.text = "Debe" then
		bloq = "D"
	else
		bloq = "H"
	end if
	grup= uo_grupo.em_codigo.text
//	titulo=trim(dw_1.getitemstring(linea,"contabalgrupnpgc_titulo"))
	
	donde=dw_1.insertrow(linea)
	
	dw_1.setitem(donde,"contabalsubgrupnpgc_empresa",emp)
	dw_1.setitem(donde,"contabalsubgrupnpgc_codbal",bal)
	dw_1.setitem(donde,"contabalsubgrupnpgc_bloque",bloq)
	dw_1.setitem(donde,"contabalsubgrupnpgc_grupo",grup)
	
//	dw_1.setitem(donde,"contabalgrupnpgc_empresa",emp)
//	dw_1.setitem(donde,"contabalgrupnpgc_bloque",bloq)
//	dw_1.setitem(donde,"contabalgrupnpgc_grupo",grup)
//	dw_1.setitem(donde,"contabalgrupnpgc_titulo",tit)
	
	
	
	
	dw_1.setfocus()
	dw_1.setrow(donde)
	dw_1.setcolumn("contabalsubgrupnpgc_subgrupo")
	
//end if
end event

type cb_actualizar from commandbutton within wi_mant_contabalsubgruponpgc
integer x = 2368
integer y = 620
integer width = 366
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;long i,orden
string subgrupo

dw_1.accepttext()
// control campo subgrupo
FOR i = 1 to dw_1.rowcount()
	orden = dw_1.getitemnumber(i,"contabalsubgrupnpgc_orden")	
	
	subgrupo = trim(dw_1.getitemstring(i,"contabalsubgrupnpgc_subgrupo")	)
	if subgrupo = "" then
		messagebox("Error de datos","Debe rellenar el campo SUBGRUPO")
		dw_1.setcolumn("contabalsubgrup_subgrupo")
		dw_1.setcolumn(i)
		dw_1.setfocus()
		return
	end if
	if isnull(orden) then
		messagebox("Error de datos","Debe rellenar el campo ORDEN")
		dw_1.setcolumn("contabalsubgrupnpgc_orden")
		dw_1.setcolumn(i)
		dw_1.setfocus()
		return
	end if

next


dw_1.accepttext()
dw_1.update()
commit;

string bloque 
if ddlb_1.text = "Debe" then
	bloque = "D"
else
	bloque = "H"
end if

dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text,bloque,uo_grupo.em_codigo.text)
f_activa_claves()
f_desactiva_botones()
end event

type cb_cancelar from commandbutton within wi_mant_contabalsubgruponpgc
integer x = 2368
integer y = 728
integer width = 366
integer height = 108
integer taborder = 80
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
	string bloque 
	if ddlb_1.text = "Debe" then
		bloque = "D"
	else
		bloque = "H"
	end if
	
	dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text,bloque,uo_grupo.em_codigo.text)
	f_activa_claves()
	f_desactiva_botones()
end if
end event

type dw_list from datawindow within wi_mant_contabalsubgruponpgc
boolean visible = false
integer x = 2235
integer y = 8
integer width = 133
integer height = 104
integer taborder = 100
boolean bringtotop = true
string dataobject = "report_contabalsubgruponpgc"
boolean livescroll = true
end type

type uo_balance from u_em_campo_2 within wi_mant_contabalsubgruponpgc
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 375
integer y = 168
integer width = 1641
integer taborder = 10
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;

uo_balance.em_campo.text=f_nombre_contabalnpgc(codigo_empresa,uo_balance.em_codigo.text)
dw_1.reset()
uo_grupo.em_campo.text = ""
IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""
END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabalnpgc"
ue_filtro     = ""

end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within wi_mant_contabalsubgruponpgc
integer x = 78
integer y = 172
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Balance :"
boolean focusrectangle = false
end type

type cb_consultar from commandbutton within wi_mant_contabalsubgruponpgc
integer x = 2030
integer y = 264
integer width = 334
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;long cuantas,i,cuantos, donde
string bal
bal = uo_balance.em_codigo.text
//cuantas=dw_1.retrieve(codigo_empresa,bal)

//if cuantas <= 0 then 
//	uo_balance.em_campo.setfocus()
//	cb_1.enabled = false 
//	return
//else
//	cb_1.enabled = true
//end if
//
//
//for i=1 to cuantas
//	string grupo,bloque
//	bloque=trim(dw_1.getitemstring(i,"contabalgrup_bloque"))
//	grupo=trim(dw_1.getitemstring(i,"contabalgrup_grupo"))
//	
//	
//	select count(*) into :cuantos
//	from contabalsubgrup
//	where empresa=:codigo_empresa
//	and codbal = :bal
//	and bloque=:bloque
//	and grupo=:grupo;
//	
//	if cuantos=0 then
//		insert into contabalsubgrup
//		(empresa,codbal,bloque,grupo,subgrupo,orden)
//		VALUES ( :codigo_empresa,:bal,:bloque,:grupo," ",9999);
//	end if
//next


string bloque

if ddlb_1.text = "Debe" then
	bloque = "D"
else
	bloque = "H"	
end if

dw_1.retrieve(codigo_empresa,bal,bloque,uo_grupo.em_codigo.text)
 if dw_1.rowcount() <=0 then
	f_activa_botones()
	donde  = dw_1.insertrow(0)
	dw_1.setitem(donde,"contabalsubgrupnpgc_empresa",codigo_empresa)
	dw_1.setitem(donde,"contabalsubgrupnpgc_codbal",bal)
	dw_1.setitem(donde,"contabalsubgrupnpgc_bloque",bloque)
	dw_1.setitem(donde,"contabalsubgrupnpgc_grupo",uo_grupo.em_codigo.text)
	

end if     
end event

type cb_1 from picturebutton within wi_mant_contabalsubgruponpgc
event clicked pbm_bnclicked
integer x = 2368
integer y = 260
integer width = 110
integer height = 96
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "PRINT!"
end type

event clicked;//dw_list.retrieve(codigo_empresa,uo_balance.em_codigo.text)
//f_imprimir_datawindow(dw_list)
end event

type ddlb_1 from dropdownlistbox within wi_mant_contabalsubgruponpgc
integer x = 370
integer y = 264
integer width = 485
integer height = 296
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
borderstyle borderstyle = stylelowered!
end type

type uo_grupo from u_em_campo_2 within wi_mant_contabalsubgruponpgc
event destroy ( )
integer x = 1157
integer y = 264
integer width = 859
integer height = 80
integer taborder = 30
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;string f1,f2

ue_datawindow  = "dw_ayuda_contabalgrupnpgc"
ue_titulo      = "AYUDA SELECCION DE GRUPOS"
f1			      = " bloque = '"+left(ddlb_1.text,1)+"'"
f2					= " and codbal = '"+trim(uo_balance.em_codigo.text)+"'"
ue_filtro		= f1 + f2
if ddlb_1.text="" then ddlb_1.setfocus()
end event

event modificado;string bloque
if ddlb_1.text = "Debe" then
	bloque = "D"
else
	bloque = "H"
end if

uo_grupo.em_campo.text=f_nombre_contabalgrupnpgc(codigo_empresa,uo_balance.em_codigo.text,bloque,uo_grupo.em_codigo.text)
cb_1.enabled = true
IF Trim(uo_grupo.em_campo.text)="" THEN 
 IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
 uo_grupo.em_campo.text=""
 uo_grupo.em_codigo.text=""
 cb_1.enabled = false
END IF

cb_consultar.triggerevent("clicked")





end event

type st_2 from statictext within wi_mant_contabalsubgruponpgc
integer x = 914
integer y = 268
integer width = 233
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Grupo :"
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_contabalsubgruponpgc
integer x = 110
integer y = 272
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Bloque :"
boolean focusrectangle = false
end type

