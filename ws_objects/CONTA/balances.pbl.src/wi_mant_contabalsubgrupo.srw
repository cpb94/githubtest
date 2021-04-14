$PBExportHeader$wi_mant_contabalsubgrupo.srw
forward
global type wi_mant_contabalsubgrupo from w_int_con_empresa
end type
type dw_1 from datawindow within wi_mant_contabalsubgrupo
end type
type cb_borrar from commandbutton within wi_mant_contabalsubgrupo
end type
type cb_insertar from commandbutton within wi_mant_contabalsubgrupo
end type
type cb_actualizar from commandbutton within wi_mant_contabalsubgrupo
end type
type cb_cancelar from commandbutton within wi_mant_contabalsubgrupo
end type
type dw_list from datawindow within wi_mant_contabalsubgrupo
end type
type uo_balance from u_em_campo_2 within wi_mant_contabalsubgrupo
end type
type st_1 from statictext within wi_mant_contabalsubgrupo
end type
type cb_consultar from commandbutton within wi_mant_contabalsubgrupo
end type
type cb_1 from picturebutton within wi_mant_contabalsubgrupo
end type
end forward

global type wi_mant_contabalsubgrupo from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 2926
integer height = 1648
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
end type
global wi_mant_contabalsubgrupo wi_mant_contabalsubgrupo

forward prototypes
public subroutine f_activa_claves ()
public subroutine f_desactiva_claves ()
public subroutine f_activa_botones ()
public subroutine f_desactiva_botones ()
end prototypes

public subroutine f_activa_claves ();uo_balance.em_campo.enabled = true
cb_consultar.enabled = true
end subroutine

public subroutine f_desactiva_claves ();uo_balance.em_campo.enabled = false
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

on wi_mant_contabalsubgrupo.create
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
end on

on wi_mant_contabalsubgrupo.destroy
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
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_contabalsubgrupo
integer taborder = 70
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_contabalsubgrupo
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_contabalsubgrupo
end type

type dw_1 from datawindow within wi_mant_contabalsubgrupo
integer x = 27
integer y = 284
integer width = 2277
integer height = 1120
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_mant_contabalsubgrup"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;f_desactiva_claves()
f_activa_botones()
end event

type cb_borrar from commandbutton within wi_mant_contabalsubgrupo
integer x = 2400
integer y = 388
integer width = 366
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Linea"
end type

event clicked;long linea
linea=dw_1.getrow()
dw_1.deleterow(linea)
end event

type cb_insertar from commandbutton within wi_mant_contabalsubgrupo
integer x = 2400
integer y = 496
integer width = 366
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert. Linea"
end type

event clicked;long linea,donde
string emp,bloq,grup,tit,bal

if dw_1.rowcount() > 0 then


	bal = trim(uo_balance.em_codigo.text)
	
	linea=dw_1.getrow()
	
	
	emp=dw_1.getitemstring(linea,"contabalgrup_empresa")
	bloq=dw_1.getitemstring(linea,"contabalgrup_bloque")
	grup=dw_1.getitemstring(linea,"contabalgrup_grupo")
	titulo=dw_1.getitemstring(linea,"contabalgrup_titulo")
	
	donde=dw_1.insertrow(linea)
	
	dw_1.setitem(donde,"contabalsubgrup_empresa",emp)
	dw_1.setitem(donde,"contabalsubgrup_codbal",bal)
	dw_1.setitem(donde,"contabalsubgrup_bloque",bloq)
	dw_1.setitem(donde,"contabalsubgrup_grupo",grup)
	
	dw_1.setitem(donde,"contabalgrup_empresa",emp)
	dw_1.setitem(donde,"contabalgrup_bloque",bloq)
	dw_1.setitem(donde,"contabalgrup_grupo",grup)
	dw_1.setitem(donde,"contabalgrup_titulo",tit)
	dw_1.setitem(donde,"contabalsubgrup_subgrupo","")
	
	dw_1.groupcalc()
	
	dw_1.setfocus()
	dw_1.setrow(donde)
	dw_1.setcolumn("contabalsubgrup_subgrupo")
	
end if
end event

type cb_actualizar from commandbutton within wi_mant_contabalsubgrupo
integer x = 2400
integer y = 604
integer width = 366
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;long i,orden
string subgrupo


// control campo subgrupo
FOR i = 1 to dw_1.rowcount()
	orden = dw_1.getitemnumber(i,"contabalsubgrup_orden")	
	if (orden <> 9999) or (isnull(orden)) then
		subgrupo = dw_1.getitemstring(i,"contabalsubgrup_subgrupo")	
		if subgrupo = "" then
			messagebox("Error de datos","Debe rellenar el campo SUBGRUPO")
			dw_1.setcolumn("contabalsubgrup_subgrupo")
			dw_1.setcolumn(i)
			dw_1.setfocus()
			return
		end if
		if isnull(orden) then
			messagebox("Error de datos","Debe rellenar el campo ORDEN")
			dw_1.setcolumn("contabalsubgrup_orden")
			dw_1.setcolumn(i)
			dw_1.setfocus()
			return
		end if
	end if
next


dw_1.accepttext()
dw_1.update()
commit;
dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text)
f_activa_claves()
f_desactiva_botones()
end event

type cb_cancelar from commandbutton within wi_mant_contabalsubgrupo
integer x = 2400
integer y = 712
integer width = 366
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;if uo_balance.em_campo.enabled then
	close(parent)
else
	
	dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text)
	f_activa_claves()
	f_desactiva_botones()
end if
end event

type dw_list from datawindow within wi_mant_contabalsubgrupo
boolean visible = false
integer x = 2281
integer y = 868
integer width = 494
integer height = 360
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_contabalsubgrupo"
boolean livescroll = true
end type

type uo_balance from u_em_campo_2 within wi_mant_contabalsubgrupo
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 434
integer y = 168
integer width = 1463
integer height = 88
integer taborder = 10
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabal(codigo_empresa,uo_balance.em_codigo.text)
IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""
END IF

cb_consultar.triggerevent("clicked")
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabal"
ue_filtro     = ""

end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within wi_mant_contabalsubgrupo
integer x = 123
integer y = 172
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Balance :"
boolean focusrectangle = false
end type

type cb_consultar from commandbutton within wi_mant_contabalsubgrupo
integer x = 1929
integer y = 168
integer width = 343
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;long cuantas,i,cuantos
string bal
bal = uo_balance.em_codigo.text
cuantas=dw_1.retrieve(codigo_empresa,bal)

if cuantas <= 0 then 
	uo_balance.em_campo.setfocus()
	cb_1.enabled = false 
	return
else
	cb_1.enabled = true
end if


for i=1 to cuantas
	string grupo,bloque
	bloque=dw_1.getitemstring(i,"contabalgrup_bloque")
	grupo=dw_1.getitemstring(i,"contabalgrup_grupo")
	
	
	select count(*) into :cuantos
	from contabalsubgrup
	where empresa=:codigo_empresa
	and codbal = :bal
	and bloque=:bloque
	and grupo=:grupo;
	
	if cuantos=0 then
		insert into contabalsubgrup
		(empresa,codbal,bloque,grupo,subgrupo,orden)
		VALUES ( :codigo_empresa,:bal,:bloque,:grupo,"",9999);
	end if
next
dw_1.retrieve(codigo_empresa,uo_balance.em_codigo.text)
      
end event

type cb_1 from picturebutton within wi_mant_contabalsubgrupo
event clicked pbm_bnclicked
integer x = 2469
integer y = 168
integer width = 183
integer height = 160
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;dw_list.retrieve(codigo_empresa,uo_balance.em_codigo.text)
f_imprimir_datawindow(dw_list)
end event

