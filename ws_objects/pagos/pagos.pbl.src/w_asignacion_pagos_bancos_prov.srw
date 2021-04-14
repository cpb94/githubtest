$PBExportHeader$w_asignacion_pagos_bancos_prov.srw
forward
global type w_asignacion_pagos_bancos_prov from w_int_con_empresa
end type
type pb_2 from upb_salir within w_asignacion_pagos_bancos_prov
end type
type cb_consulta from u_boton within w_asignacion_pagos_bancos_prov
end type
type dw_listado from datawindow within w_asignacion_pagos_bancos_prov
end type
type uo_tipodoc from u_em_campo_2 within w_asignacion_pagos_bancos_prov
end type
type st_2 from statictext within w_asignacion_pagos_bancos_prov
end type
type dw_1 from u_datawindow_consultas within w_asignacion_pagos_bancos_prov
end type
type dw_totales from datawindow within w_asignacion_pagos_bancos_prov
end type
type st_3 from statictext within w_asignacion_pagos_bancos_prov
end type
type uo_proveedor from u_em_campo_2 within w_asignacion_pagos_bancos_prov
end type
type st_1 from statictext within w_asignacion_pagos_bancos_prov
end type
type em_hasta from u_em_campo within w_asignacion_pagos_bancos_prov
end type
type em_fpago from u_em_campo within w_asignacion_pagos_bancos_prov
end type
type st_33 from statictext within w_asignacion_pagos_bancos_prov
end type
type cbx_mostrar_asignados from checkbox within w_asignacion_pagos_bancos_prov
end type
type uo_banco from u_em_campo_2 within w_asignacion_pagos_bancos_prov
end type
type st_banco from statictext within w_asignacion_pagos_bancos_prov
end type
type st_4 from statictext within w_asignacion_pagos_bancos_prov
end type
type gb_2 from groupbox within w_asignacion_pagos_bancos_prov
end type
end forward

global type w_asignacion_pagos_bancos_prov from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 2152
pb_2 pb_2
cb_consulta cb_consulta
dw_listado dw_listado
uo_tipodoc uo_tipodoc
st_2 st_2
dw_1 dw_1
dw_totales dw_totales
st_3 st_3
uo_proveedor uo_proveedor
st_1 st_1
em_hasta em_hasta
em_fpago em_fpago
st_33 st_33
cbx_mostrar_asignados cbx_mostrar_asignados
uo_banco uo_banco
st_banco st_banco
st_4 st_4
gb_2 gb_2
end type
global w_asignacion_pagos_bancos_prov w_asignacion_pagos_bancos_prov

type variables
String situacion= "0",cont="1"

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_totales ()
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.Setfilter("")
dw_data.filter()
//dw_data.reset()

datetime fechah,fechad
fechad = DateTime(Date(em_fpago.text))
fechah = DateTime(Date(em_hasta.text))

dw_data.SetTransObject(sqlca)
dw_data.Retrieve(codigo_empresa,uo_tipodoc.em_codigo.text,uo_proveedor.em_codigo.text,situacion,fechad,fechah)

if not(cbx_mostrar_asignados.checked) then
	dw_data.Setfilter("banco = ''")
	dw_data.filter()
	dw_data.sort()
	dw_data.groupcalc()
end if

registros = dw_data.RowCount()
f_totales()
end subroutine

public subroutine f_totales ();long ll_donde,ll_donde_inserto
dec  ld_total
string ls_banco,ls_busqueda,ls_evaluacion

dw_totales.reset()

ls_busqueda = "banco <> ''"

ll_donde = dw_1.find(ls_busqueda,1,dw_1.rowcount())

do
	if ll_donde > 0 then
		ls_banco = dw_1.object.banco[ll_donde]
		//ld_total = dw_1.object.total_asignado_banco[ll_donde]
		
		ld_total = dec(dw_1.Describe("evaluate ('sum(if ( banco = ~""+ls_banco+"~",importe,0) for all)',1)"))
		
		ll_donde_inserto = dw_totales.insertrow(0)
		dw_totales.object.empresa[ll_donde_inserto] = codigo_empresa
		dw_totales.object.banco[ll_donde_inserto]   = ls_banco
		dw_totales.object.total[ll_donde_inserto]   = ld_total
		
		ls_busqueda= ls_busqueda + " and banco <> '"+ls_banco+"'"
		
		ll_donde = dw_1.find(ls_busqueda,1,dw_1.rowcount())
	end if
loop while ll_donde > 0


dw_totales.sort()
dw_totales.groupcalc()
//dw_totales.Retrieve(codigo_empresa)
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
dw_totales.SetTransObject(sqlca)
This.title = " ASIGNACION PAGOS BANCO POR PROVEEDOR"

dw_1.Setfocus()

em_fpago.text = String(mdy(1,1,year(today())),"dd-mm-yy")
em_hasta.text = String(mdy(12,31,year(today())),"dd-mm-yy")


f_activar_campo(uo_proveedor.em_campo)


end event

on w_asignacion_pagos_bancos_prov.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.dw_listado=create dw_listado
this.uo_tipodoc=create uo_tipodoc
this.st_2=create st_2
this.dw_1=create dw_1
this.dw_totales=create dw_totales
this.st_3=create st_3
this.uo_proveedor=create uo_proveedor
this.st_1=create st_1
this.em_hasta=create em_hasta
this.em_fpago=create em_fpago
this.st_33=create st_33
this.cbx_mostrar_asignados=create cbx_mostrar_asignados
this.uo_banco=create uo_banco
this.st_banco=create st_banco
this.st_4=create st_4
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_tipodoc
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_totales
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.uo_proveedor
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.em_hasta
this.Control[iCurrent+12]=this.em_fpago
this.Control[iCurrent+13]=this.st_33
this.Control[iCurrent+14]=this.cbx_mostrar_asignados
this.Control[iCurrent+15]=this.uo_banco
this.Control[iCurrent+16]=this.st_banco
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.gb_2
end on

on w_asignacion_pagos_bancos_prov.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.dw_listado)
destroy(this.uo_tipodoc)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.dw_totales)
destroy(this.st_3)
destroy(this.uo_proveedor)
destroy(this.st_1)
destroy(this.em_hasta)
destroy(this.em_fpago)
destroy(this.st_33)
destroy(this.cbx_mostrar_asignados)
destroy(this.uo_banco)
destroy(this.st_banco)
destroy(this.st_4)
destroy(this.gb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_asignacion_pagos_bancos_prov
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_asignacion_pagos_bancos_prov
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_asignacion_pagos_bancos_prov
integer width = 2642
end type

type pb_2 from upb_salir within w_asignacion_pagos_bancos_prov
integer x = 2729
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_asignacion_pagos_bancos_prov
integer x = 2318
integer y = 192
integer width = 544
integer height = 88
integer taborder = 0
string text = "&Consulta"
end type

event clicked;call super::clicked;
f_cargar(dw_1)


// Por defecto la fpago es la fvto
datetime fvto,fpago
int i,reg

reg =dw_1.rowcount()

if  reg > 0 then
		
	for i = 1 to reg 
	
		fvto = dw_1.getitemdatetime(i,"fvto")
		fpago = dw_1.getitemdatetime(i,"fpago")
		if isnull(fpago) or not isdate(string(date(fpago))) then
			dw_1.setitem(i,"fpago",fvto)
		end if
		
	next
end if



f_activar_campo(uo_proveedor.em_campo)

end event

type dw_listado from datawindow within w_asignacion_pagos_bancos_prov
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_asignacion_pagos_bancos"
boolean livescroll = true
end type

type uo_tipodoc from u_em_campo_2 within w_asignacion_pagos_bancos_prov
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1838
integer y = 196
integer width = 471
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_tipodoc.em_campo.text=f_nombre_cartipodoc(codigo_empresa,uo_tipodoc.em_codigo.text)
If Trim(uo_tipodoc.em_campo.text)="" then
	uo_tipodoc.em_campo.text=""
	uo_tipodoc.em_codigo.text=""
	Return
end if 

//f_cargar(dw_1)


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de tipos de documento"
ue_datawindow ="dw_ayuda_cartipodoc"

end event

on uo_tipodoc.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_asignacion_pagos_bancos_prov
integer x = 1838
integer y = 128
integer width = 471
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Tipo de Dmto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_asignacion_pagos_bancos_prov
integer x = 9
integer y = 296
integer width = 2862
integer height = 1252
integer taborder = 50
string dataobject = "dw_asignacion_pagos_bancos_prov"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;String tip,banco,tipo
DateTime fe
	tip   = uo_tipodoc.em_codigo.text
	fe    =  dw_1.GetItemDatetime(GetRow(),"fvto")
IF  key = KeyTab! Then  
	AcceptText()

	banco = dw_1.GetItemString(GetRow(),"banco")
	tipo  = dw_1.GetItemString(GetRow(),"tipodoc_pago")
	IF IsNull(banco) Then banco = ""
	IF IsNull(tipo ) Then tipo = ""
	IF banco <> "" and tipo = "" Then dw_1.SetItem(GetRow(),"tipodoc_pago",tip)
	IF banco <> "" Then dw_1.SetItem(GetRow(),"fpago",fe)
END IF

IF  key  <> KeyEnter! Then
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
   CASE "tipodoc_pago"
 		bus_datawindow = "dw_ayuda_cartipodoc"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DMTOS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
ELSE
  dw_1.AcceptText()
  IF Trim(dw_1.GetItemString(GetRow(),"banco")) <> "" Then dw_1.SetItem(GetRow(),"asignar_banco","S")
  banco = dw_1.GetItemString(GetRow(),"banco")
  Tipo  = dw_1.GetItemString(GetRow(),"tipodoc_pago")
  iF IsNull(banco) Then banco = ""
  iF IsNull(tipo ) Then tipo = ""
  IF banco <> "" and tipo = "" Then dw_1.SetItem(GetRow(),"tipodoc_pago",tip)
  If banco ="" and tipo<>"" then dw_1.SetItem(GetRow(),"tipodoc_pago","")
  IF banco <> "" Then dw_1.SetItem(GetRow(),"fpago",fe)
  dw_1.Update()
  COMMIT;
  f_totales()
END IF



end event

event rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipodoc_pago"
 		bus_datawindow = "dw_ayuda_cartipodoc"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DMTOS"		

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event doubleclicked;call super::doubleclicked;Dec var_anyo,var,var_orden
String  con
iF row = 0 Then return


	//Proceso para congelar los pagos		
	var_anyo  = GetItemNumber(row,"anyo")
	var_orden = GetItemNumber(row,"orden")
	con       = GetItemString(row,"asignar_banco")
	iF con = "N" Then
		con = "S"
	ELSE
		con = "N"
	END IF
	Update carpagos
	Set    carpagos.asignar_banco = :con,
			 carpagos.banco         = null
	Where  carpagos.empresa = :codigo_empresa
	And    carpagos.anyo    = :var_anyo
	And    carpagos.orden   = :var_orden;
	COMMIT;
	SetItem(row,"asignar_banco",con)
	SetItem(row,"banco","")


f_totales()

end event

event clicked;call super::clicked;IF f_objeto_datawindow(dw_1) = "grabar" Then  
	dw_1.AcceptText()
	dw_1.Update()
	COMMIT;
	f_totales()
END IF

IF f_objeto_datawindow(dw_1) = "eti_ban" Then
	IF cont = "1" Then
		dw_1.SetFilter("asignar_banco= 'S'")
		dw_1.Filter()
		cont= "2"
	ELSE
		cb_consulta.TriggerEvent(clicked!)
		cont = "1"
	END IF
	RETURN
END IF

if f_objeto_datawindow(dw_1) = "banco" Then
	if uo_banco.em_codigo.text <> "" then
		this.setrow(row)
		this.object.banco[row] = uo_banco.em_codigo.text
		this.event key(KeyEnter!,0)
	end if
end if
end event

type dw_totales from datawindow within w_asignacion_pagos_bancos_prov
integer x = 9
integer y = 1676
integer width = 2862
integer height = 256
boolean bringtotop = true
string dataobject = "dw_asignacion_pagos_bancos2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_asignacion_pagos_bancos_prov
integer x = 681
integer y = 128
integer width = 1157
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Proveedor"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_asignacion_pagos_bancos_prov
event destroy ( )
integer x = 686
integer y = 196
integer width = 1152
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;string ls_codpago,ls_tipodoc

uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
else
	ls_codpago = f_codpago_comprov(codigo_empresa,this.em_codigo.text)
	ls_tipodoc = f_tipodoc_carforpag(codigo_empresa,ls_codpago)
	
	uo_tipodoc.em_codigo.text = ls_tipodoc
	uo_tipodoc.event modificado(0,0)
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"
end event

type st_1 from statictext within w_asignacion_pagos_bancos_prov
integer x = 347
integer y = 128
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Vto. Hasta"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within w_asignacion_pagos_bancos_prov
integer x = 347
integer y = 196
integer width = 334
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type em_fpago from u_em_campo within w_asignacion_pagos_bancos_prov
integer x = 9
integer y = 196
integer width = 338
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

type st_33 from statictext within w_asignacion_pagos_bancos_prov
integer x = 9
integer y = 128
integer width = 338
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Vto. Desde"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_mostrar_asignados from checkbox within w_asignacion_pagos_bancos_prov
integer x = 2313
integer y = 132
integer width = 562
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar Asignados"
borderstyle borderstyle = styleraised!
end type

type uo_banco from u_em_campo_2 within w_asignacion_pagos_bancos_prov
event destroy ( )
integer x = 462
integer y = 1568
integer width = 859
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_banco.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""

end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de bancos"
ue_datawindow ="dw_ayuda_carbancos"

end event

type st_banco from statictext within w_asignacion_pagos_bancos_prov
integer x = 37
integer y = 1580
integer width = 416
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco a asignar:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_asignacion_pagos_bancos_prov
integer x = 1330
integer y = 1588
integer width = 1527
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Click sobre la casilla del banco asigna el banco seleccionado"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_asignacion_pagos_bancos_prov
integer x = 9
integer y = 1528
integer width = 2862
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

