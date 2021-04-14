$PBExportHeader$w_con_pagos_vencimiento_tipo_proveedor.srw
forward
global type w_con_pagos_vencimiento_tipo_proveedor from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_pagos_vencimiento_tipo_proveedor
end type
type cb_consulta from u_boton within w_con_pagos_vencimiento_tipo_proveedor
end type
type pb_imprimir_preli from picturebutton within w_con_pagos_vencimiento_tipo_proveedor
end type
type dw_listado from datawindow within w_con_pagos_vencimiento_tipo_proveedor
end type
type cb_2 from u_boton within w_con_pagos_vencimiento_tipo_proveedor
end type
type gb_2 from groupbox within w_con_pagos_vencimiento_tipo_proveedor
end type
type gb_1 from groupbox within w_con_pagos_vencimiento_tipo_proveedor
end type
type gb_cuenta from groupbox within w_con_pagos_vencimiento_tipo_proveedor
end type
type em_hasta from u_em_campo within w_con_pagos_vencimiento_tipo_proveedor
end type
type ddlb_1 from dropdownlistbox within w_con_pagos_vencimiento_tipo_proveedor
end type
type st_1 from statictext within w_con_pagos_vencimiento_tipo_proveedor
end type
type st_2 from statictext within w_con_pagos_vencimiento_tipo_proveedor
end type
type em_desde from u_em_campo within w_con_pagos_vencimiento_tipo_proveedor
end type
type cb_3 from u_boton within w_con_pagos_vencimiento_tipo_proveedor
end type
type uo_tipo_proveedor from u_marca_lista within w_con_pagos_vencimiento_tipo_proveedor
end type
type uo_tipo2 from u_marca_lista within w_con_pagos_vencimiento_tipo_proveedor
end type
type dw_1 from datawindow within w_con_pagos_vencimiento_tipo_proveedor
end type
end forward

global type w_con_pagos_vencimiento_tipo_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3689
integer height = 2140
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
cb_2 cb_2
gb_2 gb_2
gb_1 gb_1
gb_cuenta gb_cuenta
em_hasta em_hasta
ddlb_1 ddlb_1
st_1 st_1
st_2 st_2
em_desde em_desde
cb_3 cb_3
uo_tipo_proveedor uo_tipo_proveedor
uo_tipo2 uo_tipo2
dw_1 dw_1
end type
global w_con_pagos_vencimiento_tipo_proveedor w_con_pagos_vencimiento_tipo_proveedor

type variables
String situaciond = "0"
String situacionh = "0"
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
public subroutine f_nombre_meses (datawindow data)
public function string f_filtro_tipo_proveedor ()
end prototypes

public function string f_filtro ();Integer numero,x2
String filtro,filtro1

filtro = ""
numero = uo_tipo2.dw_marca.RowCount()
IF  numero =0 Then return ""
FOR x2 = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	IF Trim(filtro) = "" Then
         	filtro1 = " carpagos.tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro1 = " Or carpagos.tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
  		END IF
	NEXT

return filtro
end function

public subroutine f_cargar (datawindow dw_data);string   sel,filtro_documentos,tipo_proveedor,busqueda,moneda
string   filtro_tipo_proveedor
long     indice,total,donde
int      mes_inicio,anyo_inicio,mes,anyo,columna,dia,indice2
dec{2}   importe_dia,importe_columna
DateTime fdesde,fhasta,fvto
datastore pagos

uo_tipo_proveedor.visible = false
uo_tipo2.visible          = false

fdesde      = datetime(date(em_desde.text))
fhasta      = datetime(date(em_hasta.text))
mes_inicio  = month(date(em_desde.text))
anyo_inicio = year(date(em_desde.text))

dw_data.reset()
uo_tipo2.visible   = FALSE

dw_data.setredraw(false)
moneda = f_moneda_empresa(codigo_empresa)
dw_data.Retrieve(codigo_empresa,moneda,fdesde,fhasta,ddlb_1.text)
f_nombre_meses(dw_data)

filtro_documentos     = f_filtro()
filtro_tipo_proveedor = f_filtro_tipo_proveedor()

sel = "select sum(carpagos.importe) importe_dia,carpagos.fvto,comproveedores.tipo_proveedor "+&
		"from carpagos,comproveedores "+&
		"where carpagos.empresa = '"+codigo_empresa+"' "+&
		"and carpagos.fvto between '"+string(fdesde,formato_fecha_cursores)+"' and '"+string(fhasta,formato_fecha_cursores)+"' "+&
		"and ("+filtro_documentos+") "+&
		"and ("+filtro_tipo_proveedor+") "+&
		"and carpagos.situacion between '"+situaciond+"' and '"+situacionh+"' "+&
		"and carpagos.empresa = comproveedores.empresa "+&
		"and carpagos.proveedor = comproveedores.codigo "+&
		"group by carpagos.fvto,comproveedores.tipo_proveedor"		

pagos = f_cargar_cursor(sel)		

total = pagos.rowcount()

for indice = 1 to total
	fvto           = pagos.object.carpagos_fvto[indice]
	tipo_proveedor = pagos.object.comproveedores_tipo_proveedor[indice]
	importe_dia    = pagos.object.importe_dia[indice]
	mes            = month(date(fvto))
	anyo		      = year(date(fvto))
	dia            = day(date(fvto))
	if anyo = anyo_inicio then
		columna = mes - mes_inicio + 1
	else
		columna = (12 - mes_inicio) + mes + 1
	end if
	busqueda = "dia = "+string(dia,"##")+" and tipo_proveedor = '"+tipo_proveedor+"'"
	donde = dw_data.find(busqueda,1,dw_data.rowcount())
	if donde = 0 then
		donde = dw_data.insertrow(0)
		dw_data.object.empresa[donde]        = codigo_empresa
		dw_data.object.dia[donde]            = dia
		dw_data.object.tipo_proveedor[donde] = tipo_proveedor
		for indice2 = 1 to 12
			dw_data.setitem(donde,"mes"+string(indice2,"##"),0)	
		next
	end if
	importe_columna = dw_data.getitemnumber(donde,"mes"+string(columna,"##"))
	importe_columna = importe_columna + importe_dia
	dw_data.setitem(donde,"mes"+string(columna,"##"),importe_columna)	
next

destroy pagos

dw_data.sort()
dw_data.groupcalc()
dw_data.setredraw(true)
end subroutine

public subroutine f_nombre_meses (datawindow data);int mes_inicio,anyo_inicio,indice,mes,anyo
string nombre_mes

mes_inicio  = month(date(em_desde.text))
anyo_inicio = year(date(em_desde.text))

for indice = 1 to 12
	mes  = mes_inicio + indice - 1
	anyo = anyo_inicio
	if mes > 12 then
		mes = mes - 12
		anyo = anyo + 1
	end if
	nombre_mes = f_nombre_mes_abr(mes)
	nombre_mes = nombre_mes + mid(string(anyo,"####"),3,2)
	data.Modify ("texto_mes"+string(indice,"##")+".text = '"+nombre_mes+"'")
next
end subroutine

public function string f_filtro_tipo_proveedor ();Integer numero,x2
String filtro,filtro1

filtro = ""
numero = uo_tipo_proveedor.dw_marca.RowCount()
IF  numero =0 Then return ""
FOR x2 = 1 To numero
   	IF uo_tipo_proveedor.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	IF Trim(filtro) = "" Then
         	filtro1 = " comproveedores.tipo_proveedor = '" + uo_tipo_proveedor.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro1 = " Or comproveedores.tipo_proveedor = '" + uo_tipo_proveedor.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
  		END IF
	NEXT

return filtro
end function

event open;call super::open;This.title = " CONSULTA EFECTOS POR VENCIMIENTOS AGRUPADOS POR TIPO DE PROVEEDOR"

String mascara
dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_desde.text = String(Today(),"dd-mm-yy")
em_desde.triggerevent("modificado")

Integer x2,registros2
String var_codigo2,var_texto2,marca2,maxdoc = '90'

DataStore dw_comodin

dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'" + " and tipodoc < '"+maxdoc+"'")
registros2=dw_comodin.RowCOunt()
If registros2<>0 THEN
	FOR x2= 1 To registros2
		var_codigo2  = dw_comodin.GetItemString(x2,"tipodoc")
		var_texto2   = dw_comodin.GetItemString(x2,"texto")
		marca2="S"
		uo_tipo2.dw_marca.InsertRow(x2)
		uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
		uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
		uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
	NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

dw_comodin = f_cargar_cursor("Select codigo,descripcion from comtipo_proveedor where empresa = '"+codigo_empresa+"'")
registros2 = dw_comodin.RowCOunt()
If registros2 > 0 THEN
	FOR x2= 1 To registros2
		var_codigo2  = dw_comodin.GetItemString(x2,"codigo")
		var_texto2   = dw_comodin.GetItemString(x2,"descripcion")
		marca2       = "S"
		uo_tipo_proveedor.dw_marca.InsertRow(x2)
		uo_tipo_proveedor.dw_marca.setitem(x2,"marca",marca2)
		uo_tipo_proveedor.dw_marca.setitem(x2,"codigo",var_codigo2)
		uo_tipo_proveedor.dw_marca.setitem(x2,"texto",var_texto2)
	NEXT
END IF
uo_tipo_proveedor.st_titulo1.text="Codigo"
uo_tipo_proveedor.st_titulo2.text="Tipo Proveedor"

destroy dw_comodin

f_activar_campo(em_desde)


end event

on w_con_pagos_vencimiento_tipo_proveedor.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_cuenta=create gb_cuenta
this.em_hasta=create em_hasta
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_2=create st_2
this.em_desde=create em_desde
this.cb_3=create cb_3
this.uo_tipo_proveedor=create uo_tipo_proveedor
this.uo_tipo2=create uo_tipo2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_cuenta
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.em_desde
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.uo_tipo_proveedor
this.Control[iCurrent+16]=this.uo_tipo2
this.Control[iCurrent+17]=this.dw_1
end on

on w_con_pagos_vencimiento_tipo_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_cuenta)
destroy(this.em_hasta)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_desde)
destroy(this.cb_3)
destroy(this.uo_tipo_proveedor)
destroy(this.uo_tipo2)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pagos_vencimiento_tipo_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pagos_vencimiento_tipo_proveedor
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pagos_vencimiento_tipo_proveedor
integer x = 59
integer width = 2642
end type

type pb_2 from upb_salir within w_con_pagos_vencimiento_tipo_proveedor
integer x = 3515
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_pagos_vencimiento_tipo_proveedor
integer x = 2222
integer y = 140
integer width = 311
integer height = 92
integer taborder = 80
string text = "&Consulta"
end type

event clicked;call super::clicked;
CHOOSE CASE ddlb_1.text
	CASE "Pendientes"
		situaciond = '0'
		situacionh = '0'
	CASE "Emitidos"
		situaciond = '1'
		situacionh = '1'
	CASE "Pagados"
		situaciond = '2'
		situacionh = '2'
	CASE "Pendientes/Emitidos"
		situaciond = '0'
		situacionh = '1'
	CASE "Todos"
		situaciond = '0'
		situacionh = '2'
END CHOOSE

DateTime	fdesde,fhasta

IF em_desde.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
ELSE
	IF em_hasta.text = "00-00-00" THEN
		MessageBox("ERROR","Debe introducir fecha",Exclamation!)
		f_activar_campo(em_hasta)
	ELSE
		fdesde = Datetime(Date(em_desde))
		fhasta = Datetime(Date(em_hasta))
		IF fdesde > fhasta THEN
			MessageBox("ERROR","La fecha Desde mayor que Hasta",Exclamation!)
			f_activar_campo(em_desde)
		END IF
		f_cargar(dw_1)
		f_activar_campo(em_desde)
	END IF
END IF

end event

type pb_imprimir_preli from picturebutton within w_con_pagos_vencimiento_tipo_proveedor
integer x = 3515
integer y = 144
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;
CHOOSE CASE ddlb_1.text
	CASE "Pendientes"
		situaciond = '0'
		situacionh = '0'
	CASE "Emitidos"
		situaciond = '1'
		situacionh = '1'
	CASE "Pagados"
		situaciond = '2'
		situacionh = '2'
	CASE "Pendientes/Emitidos"
		situaciond = '0'
		situacionh = '1'
	CASE "Todos"
		situaciond = '0'
		situacionh = '2'
END CHOOSE

DateTime	fdesde,fhasta

IF em_desde.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
ELSE
	IF em_hasta.text = "00-00-00" THEN
		MessageBox("ERROR","Debe introducir fecha",Exclamation!)
		f_activar_campo(em_hasta)
	ELSE
		fdesde = Datetime(Date(em_desde))
		fhasta = Datetime(Date(em_hasta))
		IF fdesde > fhasta THEN
			MessageBox("ERROR","La fecha Desde mayor que Hasta",Exclamation!)
			f_activar_campo(em_desde)
		END IF
		f_cargar(dw_listado)
		f_imprimir_datawindow(dw_listado)
		f_activar_campo(em_desde)
	END IF
END IF

end event

type dw_listado from datawindow within w_con_pagos_vencimiento_tipo_proveedor
boolean visible = false
integer x = 2098
integer y = 76
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_vto_tipo_proveedor"
boolean livescroll = true
end type

type cb_2 from u_boton within w_con_pagos_vencimiento_tipo_proveedor
event clicked pbm_bnclicked
integer x = 1600
integer y = 140
integer width = 311
integer height = 92
integer taborder = 60
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;uo_tipo2.visible = not(uo_tipo2.visible)

uo_tipo_proveedor.visible = false

end event

type gb_2 from groupbox within w_con_pagos_vencimiento_tipo_proveedor
integer x = 1582
integer y = 96
integer width = 974
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_pagos_vencimiento_tipo_proveedor
integer x = 1042
integer y = 96
integer width = 539
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "SITUACIÓN"
end type

type gb_cuenta from groupbox within w_con_pagos_vencimiento_tipo_proveedor
integer x = 14
integer y = 96
integer width = 1029
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "VENCIMENTO"
end type

type em_hasta from u_em_campo within w_con_pagos_vencimiento_tipo_proveedor
integer x = 727
integer y = 144
integer width = 293
integer taborder = 40
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;ddlb_1.text = 'Pendientes'
end event

event modified;call super::modified;DateTime	fdesde,fhasta

IF em_desde.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
END IF

IF em_hasta.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_hasta)
END IF

fdesde = Datetime(Date(em_desde))
fhasta = Datetime(Date(em_hasta))
IF fdesde > fhasta THEN
	MessageBox("ERROR","La fecha Desde mayor que Hasta",Exclamation!)
	f_activar_campo(em_desde)
END IF
end event

type ddlb_1 from dropdownlistbox within w_con_pagos_vencimiento_tipo_proveedor
integer x = 1061
integer y = 144
integer width = 503
integer height = 456
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pendientes"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Pendientes","Emitidos","Pagados","Pendientes/Emitidos","Todos"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_con_pagos_vencimiento_tipo_proveedor
integer x = 23
integer y = 156
integer width = 229
integer height = 76
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
string text = "Desde :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_pagos_vencimiento_tipo_proveedor
integer x = 544
integer y = 156
integer width = 178
integer height = 76
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
string text = "Hasta :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde from u_em_campo within w_con_pagos_vencimiento_tipo_proveedor
event losefocus pbm_enkillfocus
integer x = 247
integer y = 144
integer width = 293
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ä"
end type

event losefocus;call super::losefocus;
IF this.text = "00-00-00" THEN
	MessageBox("ERROR","Debe introducir fecha",Exclamation!)
	f_activar_campo(em_desde)
END IF
end event

event modificado;call super::modificado;date f_desde,f_hasta
int  dia,mes,anyo

if this.text <> "00-00-00" then	
	f_desde = date(this.text)
	dia     = day(f_desde)
	mes 	  = month(f_desde)
	anyo 	  = year(f_desde)
	f_hasta = mdy(mes -1,dia,anyo + 1)
	em_hasta.text = string(f_hasta,"dd/mm/yy")
end if
end event

type cb_3 from u_boton within w_con_pagos_vencimiento_tipo_proveedor
integer x = 1911
integer y = 140
integer width = 311
integer height = 92
integer taborder = 70
boolean bringtotop = true
string text = "Tipo Prov"
end type

event clicked;uo_tipo_proveedor.visible = not(uo_tipo_proveedor.visible)

uo_tipo2.visible = false

end event

type uo_tipo_proveedor from u_marca_lista within w_con_pagos_vencimiento_tipo_proveedor
boolean visible = false
integer x = 768
integer y = 256
integer width = 1454
integer height = 652
integer taborder = 60
boolean border = false
end type

on uo_tipo_proveedor.destroy
call u_marca_lista::destroy
end on

type uo_tipo2 from u_marca_lista within w_con_pagos_vencimiento_tipo_proveedor
boolean visible = false
integer x = 457
integer y = 256
integer width = 1454
integer height = 652
boolean bringtotop = true
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_pagos_vencimiento_tipo_proveedor
integer y = 260
integer width = 3630
integer height = 1672
string dataobject = "dw_con_pagos_vencimiento_tipo_proveedor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//str_parametros lstr_param
//IF Row <> 0 Then
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
//  OpenWithParm(wi_mant_carpagos,lstr_param) 
//End If
end event

