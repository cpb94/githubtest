$PBExportHeader$w_con_historico_fecha_cliente.srw
$PBExportComments$€
forward
global type w_con_historico_fecha_cliente from w_int_con_empresa
end type
type gb_cuenta from groupbox within w_con_historico_fecha_cliente
end type
type gb_2 from groupbox within w_con_historico_fecha_cliente
end type
type pb_2 from upb_salir within w_con_historico_fecha_cliente
end type
type st_8 from statictext within w_con_historico_fecha_cliente
end type
type em_fechadesde from u_em_campo within w_con_historico_fecha_cliente
end type
type gb_1 from groupbox within w_con_historico_fecha_cliente
end type
type em_fechahasta from u_em_campo within w_con_historico_fecha_cliente
end type
type dw_listado from datawindow within w_con_historico_fecha_cliente
end type
type dw_proceso2 from datawindow within w_con_historico_fecha_cliente
end type
type pb_imprimir_preli from picturebutton within w_con_historico_fecha_cliente
end type
type cb_consulta from u_boton within w_con_historico_fecha_cliente
end type
type cb_2 from u_boton within w_con_historico_fecha_cliente
end type
type uo_1 from u_manejo_datawindow within w_con_historico_fecha_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_historico_fecha_cliente
end type
type st_1 from statictext within w_con_historico_fecha_cliente
end type
type em_fvto_desde from u_em_campo within w_con_historico_fecha_cliente
end type
type em_fvto_hasta from u_em_campo within w_con_historico_fecha_cliente
end type
type cbx_agrupados from checkbox within w_con_historico_fecha_cliente
end type
type gb_3 from groupbox within w_con_historico_fecha_cliente
end type
type uo_tipo2 from u_marca_lista within w_con_historico_fecha_cliente
end type
type dw_1 from datawindow within w_con_historico_fecha_cliente
end type
type em_fcobro_desde from u_em_campo within w_con_historico_fecha_cliente
end type
type em_fcobro_hasta from u_em_campo within w_con_historico_fecha_cliente
end type
type st_2 from statictext within w_con_historico_fecha_cliente
end type
type uo_agente from u_em_campo_2 within w_con_historico_fecha_cliente
end type
type uo_familia from u_em_campo_2 within w_con_historico_fecha_cliente
end type
type gb_4 from groupbox within w_con_historico_fecha_cliente
end type
type gb_5 from groupbox within w_con_historico_fecha_cliente
end type
type gb_9 from groupbox within w_con_historico_fecha_cliente
end type
end forward

global type w_con_historico_fecha_cliente from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5202
integer height = 3716
string title = "Consulta de Movimientos"
gb_cuenta gb_cuenta
gb_2 gb_2
pb_2 pb_2
st_8 st_8
em_fechadesde em_fechadesde
gb_1 gb_1
em_fechahasta em_fechahasta
dw_listado dw_listado
dw_proceso2 dw_proceso2
pb_imprimir_preli pb_imprimir_preli
cb_consulta cb_consulta
cb_2 cb_2
uo_1 uo_1
uo_cliente uo_cliente
st_1 st_1
em_fvto_desde em_fvto_desde
em_fvto_hasta em_fvto_hasta
cbx_agrupados cbx_agrupados
gb_3 gb_3
uo_tipo2 uo_tipo2
dw_1 dw_1
em_fcobro_desde em_fcobro_desde
em_fcobro_hasta em_fcobro_hasta
st_2 st_2
uo_agente uo_agente
uo_familia uo_familia
gb_4 gb_4
gb_5 gb_5
gb_9 gb_9
end type
global w_con_historico_fecha_cliente w_con_historico_fecha_cliente

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,registros,x1
String filtro,filtro1
filtro = ""
numero = uo_tipo2.dw_marca.RowCount()
IF numero =0  Then return ""

	FOR x1 = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(x1,"marca") = "S" THEN
      	
      	IF Trim(filtro) = "" Then
         	filtro1 = " ( tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x1,"codigo") + "'"
      	Else
         	filtro1 = " OR tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x1,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
			//filtro = "(" + filtro + ")"
  		END IF
	NEXT
	
if trim(filtro)<>"" then filtro = filtro+") "
return filtro
end function

public subroutine f_cargar (datawindow dw_data);String   cli1,cli2, original_txt
long i, registros, total_dias, plazo_medio_de_cobro
date ffra, fcobro
Datetime original
Dec anyo, orden, linea
Datetime fecha1,fecha2, fvto_desde, fvto_hasta, fcobro_desde, fcobro_hasta
string grupo, agente1

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo2.visible   = FALSE
string f="",fi=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()



fecha1 = Datetime(Date(String(em_fechadesde.Text)))
fecha2 = Datetime(Date(String(em_fechahasta.Text)))

fvto_desde = Datetime(Date(String(em_fvto_desde.Text)))
fvto_hasta = Datetime(Date(String(em_fvto_hasta.Text)))

fcobro_desde = Datetime(Date(String(em_fcobro_desde.Text)))
fcobro_hasta = Datetime(Date(String(em_fcobro_hasta.Text)))

if uo_familia.em_codigo.text <> '' then
	grupo = uo_familia.em_codigo.text
else
	grupo = '%'
end if

if uo_agente.em_codigo.text <> '' then
	agente1 = uo_agente.em_codigo.text
else
	agente1 = '%'
end if


fi = '1 = 1'

if tipo_vista="Nacional" then 
	fi = fi + " AND nacional='S' "
else
	if tipo_vista="Exportacion" then 
		fi = fi + " AND nacional='N' "
	else
		fi = fi + " AND ( nacional='N' OR nacional='S' ) "
	end if
end if

if cbx_agrupados.checked then
	fi = fi + "  AND situacion <> '3' "
end if

f=f_filtro()
IF f="" then
	f=fi
else
	f= f + " AND " + fi
end if

IF trim(uo_cliente.em_codigo.text)<>""  then
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
ELSE
	cli1 = "."
	cli2 = "Z"
END IF

dw_data.SetFilter(f)
dw_data.Filter()

dw_data.Retrieve(codigo_empresa,fecha1,fecha2,cli1,cli2, fvto_desde, fvto_hasta, fcobro_desde, fcobro_hasta, grupo, agente1)

registros = dw_data.RowCount()
If registros = 0 Then Return

if dw_1.rowcount() > 0 then
	total_dias = 0
	for i= 1 to dw_1.rowcount()
		ffra = date(dw_1.object.ffra[i])
		fcobro = date(dw_1.object.fcobro[i])
		total_dias = total_dias + DaysAfter (ffra, fcobro)		
		/*
		//Calculo Fecha vencimiento original
		anyo = dw_1.GetItemNumber(i,"anyo")
 		orden = dw_1.GetItemNumber(i,"orden")
  		linea = dw_1.GetItemNumber(i,"linea")
		setnull(original)
		original_txt = ""
		SELECT fvto_original INTO :original FROM carhistorico WHERE anyo = :anyo AND orden = :orden AND linea = :linea;
		original_txt = String(original, 'dd-mm-yyyy')
		if not isnull(original_txt) and original_txt <> "" and original_txt <> "01-01-1900" then
			dw_1.object.t_original.text = original_txt
		end if
		*/
	next
	
	dw_1.object.t_pmc.text = string(round(total_dias / dw_1.rowcount(), 0))	
	
end if



end subroutine

event ue_listar;dw_report= dw_1
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA HISTORICO ENTRE FECHAS POR CLIENTE"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

em_fvto_desde.text = "01-01-2001" 
em_fvto_hasta.text = String(RelativeDate(Today(), 365) )

em_fcobro_desde.text = String(MDY(01,01,Year(Today())))
em_fcobro_hasta.text = String(Today())



Integer x2,registros2 
String var_codigo2,var_texto2,marca2

dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"tipodoc")
  var_texto2   = dw_proceso2.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(em_fechadesde)


end event

on w_con_historico_fecha_cliente.create
int iCurrent
call super::create
this.gb_cuenta=create gb_cuenta
this.gb_2=create gb_2
this.pb_2=create pb_2
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.dw_proceso2=create dw_proceso2
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_consulta=create cb_consulta
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.em_fvto_desde=create em_fvto_desde
this.em_fvto_hasta=create em_fvto_hasta
this.cbx_agrupados=create cbx_agrupados
this.gb_3=create gb_3
this.uo_tipo2=create uo_tipo2
this.dw_1=create dw_1
this.em_fcobro_desde=create em_fcobro_desde
this.em_fcobro_hasta=create em_fcobro_hasta
this.st_2=create st_2
this.uo_agente=create uo_agente
this.uo_familia=create uo_familia
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_9=create gb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_cuenta
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.dw_proceso2
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.cb_consulta
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.uo_1
this.Control[iCurrent+14]=this.uo_cliente
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.em_fvto_desde
this.Control[iCurrent+17]=this.em_fvto_hasta
this.Control[iCurrent+18]=this.cbx_agrupados
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.uo_tipo2
this.Control[iCurrent+21]=this.dw_1
this.Control[iCurrent+22]=this.em_fcobro_desde
this.Control[iCurrent+23]=this.em_fcobro_hasta
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.uo_agente
this.Control[iCurrent+26]=this.uo_familia
this.Control[iCurrent+27]=this.gb_4
this.Control[iCurrent+28]=this.gb_5
this.Control[iCurrent+29]=this.gb_9
end on

on w_con_historico_fecha_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_cuenta)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.dw_proceso2)
destroy(this.pb_imprimir_preli)
destroy(this.cb_consulta)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.em_fvto_desde)
destroy(this.em_fvto_hasta)
destroy(this.cbx_agrupados)
destroy(this.gb_3)
destroy(this.uo_tipo2)
destroy(this.dw_1)
destroy(this.em_fcobro_desde)
destroy(this.em_fcobro_hasta)
destroy(this.st_2)
destroy(this.uo_agente)
destroy(this.uo_familia)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_9)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_historico_fecha_cliente
integer x = 905
integer y = 552
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_historico_fecha_cliente
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_historico_fecha_cliente
integer y = 20
integer width = 5157
end type

type gb_cuenta from groupbox within w_con_historico_fecha_cliente
integer x = 2098
integer y = 320
integer width = 1417
integer height = 188
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Cliente"
end type

type gb_2 from groupbox within w_con_historico_fecha_cliente
integer x = 2985
integer y = 104
integer width = 366
integer height = 216
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_historico_fecha_cliente
integer x = 4997
integer y = 168
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_8 from statictext within w_con_historico_fecha_cliente
integer x = 379
integer y = 176
integer width = 55
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_historico_fecha_cliente
integer x = 50
integer y = 184
integer width = 311
integer taborder = 10
boolean bringtotop = true
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type gb_1 from groupbox within w_con_historico_fecha_cliente
integer x = 14
integer y = 120
integer width = 800
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Factura"
end type

type em_fechahasta from u_em_campo within w_con_historico_fecha_cliente
integer x = 475
integer y = 184
integer width = 311
integer taborder = 20
boolean bringtotop = true
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_listado from datawindow within w_con_historico_fecha_cliente
boolean visible = false
integer y = 4
integer width = 41
integer height = 40
string dataobject = "report_carhistorico_fechas_cliente"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_con_historico_fecha_cliente
boolean visible = false
integer x = 114
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_historico_fecha_cliente
integer x = 4782
integer y = 168
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;f_cargar(dw_listado)
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type cb_consulta from u_boton within w_con_historico_fecha_cliente
integer x = 3963
integer y = 168
integer width = 329
integer height = 96
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
dw_1.visible   = TRUE

end event

type cb_2 from u_boton within w_con_historico_fecha_cliente
event clicked pbm_bnclicked
integer x = 3611
integer y = 168
integer width = 329
integer height = 96
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
dw_1.visible = FALSE
end event

type uo_1 from u_manejo_datawindow within w_con_historico_fecha_cliente
integer x = 4306
integer y = 124
integer width = 599
integer height = 160
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_historico_fecha_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2117
integer y = 392
integer width = 1362
integer taborder = 90
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Cliente"
ue_datawindow ="dw_ayuda_clientes"

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_con_historico_fecha_cliente
integer x = 1257
integer y = 188
integer width = 55
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fvto_desde from u_em_campo within w_con_historico_fecha_cliente
integer x = 919
integer y = 192
integer width = 315
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fvto_hasta from u_em_campo within w_con_historico_fecha_cliente
integer x = 1344
integer y = 192
integer width = 315
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type cbx_agrupados from checkbox within w_con_historico_fecha_cliente
integer x = 3671
integer y = 384
integer width = 1431
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar efectos en situación ~"AGRUPADOS~" en otros."
boolean checked = true
end type

type gb_3 from groupbox within w_con_historico_fecha_cliente
integer x = 882
integer y = 120
integer width = 800
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Vencimiento"
end type

type uo_tipo2 from u_marca_lista within w_con_historico_fecha_cliente
boolean visible = false
integer x = 1330
integer y = 1272
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_historico_fecha_cliente
boolean visible = false
integer y = 528
integer width = 5157
integer height = 2992
string dataobject = "dw_con_carhistorico_fecha_cliente2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=4
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  lstr_param.s_argumentos[4]=String(This.GetItemNumber(Row,"linea"))
  OpenWithParm(wi_mant_carhistorico,lstr_param) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado_historico,lstr_param)


End If
end event

type em_fcobro_desde from u_em_campo within w_con_historico_fecha_cliente
integer x = 1787
integer y = 192
integer width = 315
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fcobro_hasta from u_em_campo within w_con_historico_fecha_cliente
integer x = 2217
integer y = 192
integer width = 315
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_con_historico_fecha_cliente
integer x = 2130
integer y = 188
integer width = 55
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_agente from u_em_campo_2 within w_con_historico_fecha_cliente
event destroy ( )
integer x = 782
integer y = 392
integer width = 1275
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 
dw_1.Reset()

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Agentes"
ue_datawindow ="dw_ayuda_venagentes"


end event

type uo_familia from u_em_campo_2 within w_con_historico_fecha_cliente
event destroy ( )
integer x = 32
integer y = 388
integer width = 663
integer taborder = 70
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_4 from groupbox within w_con_historico_fecha_cliente
integer x = 1751
integer y = 120
integer width = 800
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Cobro"
end type

type gb_5 from groupbox within w_con_historico_fecha_cliente
integer x = 745
integer y = 328
integer width = 1335
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
string text = "Agente"
end type

type gb_9 from groupbox within w_con_historico_fecha_cliente
integer y = 328
integer width = 722
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Familia"
end type

