$PBExportHeader$w_con_recibos_cliente.srw
$PBExportComments$€
forward
global type w_con_recibos_cliente from w_int_con_empresa
end type
type mdi_1 from mdiclient within w_con_recibos_cliente
end type
type pb_2 from upb_salir within w_con_recibos_cliente
end type
type cb_1 from u_boton within w_con_recibos_cliente
end type
type dw_proceso from datawindow within w_con_recibos_cliente
end type
type cb_consulta from u_boton within w_con_recibos_cliente
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_cliente
end type
type dw_listado from datawindow within w_con_recibos_cliente
end type
type dw_proceso2 from datawindow within w_con_recibos_cliente
end type
type gb_2 from groupbox within w_con_recibos_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_recibos_cliente
end type
type cb_2 from u_boton within w_con_recibos_cliente
end type
type gb_cuenta from groupbox within w_con_recibos_cliente
end type
type st_1 from statictext within w_con_recibos_cliente
end type
type em_fechadesde from u_em_campo within w_con_recibos_cliente
end type
type em_fechahasta from u_em_campo within w_con_recibos_cliente
end type
type st_8 from statictext within w_con_recibos_cliente
end type
type st_9 from statictext within w_con_recibos_cliente
end type
type gb_1 from groupbox within w_con_recibos_cliente
end type
type uo_tipo from u_marca_lista within w_con_recibos_cliente
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_cliente
end type
type dw_1 from datawindow within w_con_recibos_cliente
end type
type cbx_original from checkbox within w_con_recibos_cliente
end type
end forward

global type w_con_recibos_cliente from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4462
integer height = 3344
string title = "Consulta de Movimientos"
boolean resizable = true
windowtype windowtype = mdidock!
long backcolor = 134217730
mdi_1 mdi_1
pb_2 pb_2
cb_1 cb_1
dw_proceso dw_proceso
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_proceso2 dw_proceso2
gb_2 gb_2
uo_cliente uo_cliente
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_8 st_8
st_9 st_9
gb_1 gb_1
uo_tipo uo_tipo
uo_tipo2 uo_tipo2
dw_1 dw_1
cbx_original cbx_original
end type
global w_con_recibos_cliente w_con_recibos_cliente

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();Integer numero,registros,x1,numero2,registros2,x2
String filtro,filtro1,filtro2,filtro21,fil,nexo

filtro = ""
filtro2 = ""
numero = uo_tipo.dw_marca.RowCount()
numero2 = uo_tipo2.dw_marca.RowCount()
IF numero =0 and numero2 =0 Then return ""


	FOR x1 = 1 To numero
   		IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
     			
      		IF Trim(filtro) = "" Then
         		filtro1 = " situacion = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      		Else
         		filtro1 = " Or situacion = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
     			End If
      		filtro = filtro  + filtro1
				filtro  = "(" + filtro + ")"
   		END IF
	NEXT



	FOR x2 = 1 To numero2
   	IF uo_tipo2.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	
      	IF Trim(filtro2) = "" Then
         	filtro21 = " tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro21 = " Or tipodoc = '" + uo_tipo2.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro2 = filtro2  + filtro21
			filtro2  = "(" + filtro2 + ")"
  		END IF
	NEXT


if trim(filtro)="" then
	if trim(filtro2)="" then
		nexo=""
	else
		nexo=""
	end if
else
	if trim(filtro2)="" then
		nexo=""
	else 
		nexo=" and "
	end if
end if
 
fil= filtro2 + nexo + filtro

return fil
end function

public subroutine f_cargar (datawindow dw_data);Integer registros
String cli1,cli2

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()

string f="",fi=""

if tipo_vista="Nacional" then 
	fi="(nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi="(nacional='N')"
	else
		fi="((nacional='N') or (nacional='S'))"
	end if
end if



f=f_filtro()
IF f="" then
	f=fi
else
	f=f_filtro() + "and" + fi
end if

dw_data.SetFilter(f)
dw_data.Filter()
iF Trim(uo_cliente.em_codigo.text) = "" Then
   cli1 = "."
   cli2 = "Z"
ELSE
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
END IF

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

dw_data.Retrieve(codigo_empresa,cli1,cli2,fecha1,fecha2)

registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

event ue_listar;dw_report = dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE EFECTOS POR CLIENTE"

dw_1.Setfocus()

//em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechadesde.text = String("01-01-01")
em_fechahasta.text = String(Today())

Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
registros=dw_proceso.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"codigo")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  if var_codigo = "3" then
		marca="N"
  else
		marca = "S"
  end if
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_tipo.st_titulo1.text="Situación"
uo_tipo.st_titulo2.text="Descripcion"


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
// DAVID 14-11-08: Agrupado debe estar desmarcado
//uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)

END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(uo_cliente.em_campo)


end event

on w_con_recibos_cliente.create
int iCurrent
call super::create
this.mdi_1=create mdi_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.dw_proceso=create dw_proceso
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_proceso2=create dw_proceso2
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_8=create st_8
this.st_9=create st_9
this.gb_1=create gb_1
this.uo_tipo=create uo_tipo
this.uo_tipo2=create uo_tipo2
this.dw_1=create dw_1
this.cbx_original=create cbx_original
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.dw_proceso2
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.gb_cuenta
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.em_fechadesde
this.Control[iCurrent+15]=this.em_fechahasta
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.st_9
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.uo_tipo
this.Control[iCurrent+20]=this.uo_tipo2
this.Control[iCurrent+21]=this.dw_1
this.Control[iCurrent+22]=this.cbx_original
end on

on w_con_recibos_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.dw_proceso)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_proceso2)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.uo_tipo)
destroy(this.uo_tipo2)
destroy(this.dw_1)
destroy(this.cbx_original)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_cliente
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_cliente
integer y = 20
integer width = 4009
integer height = 80
end type

type mdi_1 from mdiclient within w_con_recibos_cliente
long BackColor=268435456
end type

type pb_2 from upb_salir within w_con_recibos_cliente
integer x = 4238
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type cb_1 from u_boton within w_con_recibos_cliente
integer x = 2784
integer y = 164
integer width = 398
integer height = 96
integer taborder = 50
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type dw_proceso from datawindow within w_con_recibos_cliente
boolean visible = false
integer x = 430
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_con_recibos_cliente
integer x = 3205
integer y = 164
integer width = 384
integer height = 96
integer taborder = 60
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_cliente.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_recibos_cliente
integer x = 4087
integer y = 28
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "Print!"
end type

event clicked;if cbx_original.checked = true then
	dw_listado.dataobject = "report_carefectos_situacion_cuenta2"
else
	dw_listado.dataobject = "report_carefectos_situacion_cuenta"
end if

f_cargar(dw_listado)
dw_listado.visible = FALSE

Parent.TriggerEvent("ue_listar")

f_activar_campo(uo_cliente.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_cliente
boolean visible = false
integer x = 2514
integer y = 28
integer width = 201
integer height = 220
string dataobject = "report_carefectos_situacion_cuenta"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_con_recibos_cliente
boolean visible = false
integer x = 110
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_recibos_cliente
integer x = 2363
integer y = 120
integer width = 1239
integer height = 164
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_cliente from u_em_campo_2 within w_con_recibos_cliente
event destroy ( )
integer x = 27
integer y = 192
integer width = 1225
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"

end event

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

dw_1.Reset()
//dw_1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)	
end event

type cb_2 from u_boton within w_con_recibos_cliente
event clicked pbm_bnclicked
integer x = 2395
integer y = 164
integer width = 379
integer height = 96
integer taborder = 40
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type gb_cuenta from groupbox within w_con_recibos_cliente
integer y = 96
integer width = 1294
integer height = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_con_recibos_cliente
integer x = 27
integer y = 140
integer width = 1225
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "C  l  i  e  n  t  e"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_recibos_cliente
integer x = 1440
integer y = 168
integer width = 361
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fechahasta from u_em_campo within w_con_recibos_cliente
integer x = 1943
integer y = 168
integer width = 361
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "MS Sans Serif"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type st_8 from statictext within w_con_recibos_cliente
integer x = 1815
integer y = 180
integer width = 114
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "al"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_con_recibos_cliente
integer x = 1317
integer y = 180
integer width = 110
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Del"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_recibos_cliente
integer x = 1298
integer y = 104
integer width = 1029
integer height = 172
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Fecha Factura"
end type

type uo_tipo from u_marca_lista within w_con_recibos_cliente
boolean visible = false
integer x = 1577
integer y = 272
integer width = 1623
integer height = 672
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type uo_tipo2 from u_marca_lista within w_con_recibos_cliente
boolean visible = false
integer x = 1312
integer y = 272
integer width = 1454
integer height = 664
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_recibos_cliente
boolean visible = false
integer y = 308
integer width = 4357
integer height = 2792
string dataobject = "dw_con_carefectos_cuentas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carefectos,lstr_param) 
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

   OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

type cbx_original from checkbox within w_con_recibos_cliente
integer x = 3648
integer y = 144
integer width = 704
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Imprimir F.Vto.Original"
end type

