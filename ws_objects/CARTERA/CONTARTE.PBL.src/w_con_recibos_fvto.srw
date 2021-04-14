$PBExportHeader$w_con_recibos_fvto.srw
$PBExportComments$€
forward
global type w_con_recibos_fvto from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_fvto
end type
type dw_proceso from datawindow within w_con_recibos_fvto
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_fvto
end type
type dw_listado from datawindow within w_con_recibos_fvto
end type
type dw_proceso2 from datawindow within w_con_recibos_fvto
end type
type cb_1 from u_boton within w_con_recibos_fvto
end type
type cb_2 from u_boton within w_con_recibos_fvto
end type
type cb_consulta from u_boton within w_con_recibos_fvto
end type
type gb_1 from groupbox within w_con_recibos_fvto
end type
type uo_cliente from u_em_campo_2 within w_con_recibos_fvto
end type
type st_1 from statictext within w_con_recibos_fvto
end type
type gb_cli from groupbox within w_con_recibos_fvto
end type
type cbx_1 from checkbox within w_con_recibos_fvto
end type
type dw_1 from datawindow within w_con_recibos_fvto
end type
type uo_tipo from u_marca_lista within w_con_recibos_fvto
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_fvto
end type
type sle_dias from singlelineedit within w_con_recibos_fvto
end type
type gb_2 from groupbox within w_con_recibos_fvto
end type
end forward

global type w_con_recibos_fvto from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3250
integer height = 2624
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_proceso dw_proceso
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_proceso2 dw_proceso2
cb_1 cb_1
cb_2 cb_2
cb_consulta cb_consulta
gb_1 gb_1
uo_cliente uo_cliente
st_1 st_1
gb_cli gb_cli
cbx_1 cbx_1
dw_1 dw_1
uo_tipo uo_tipo
uo_tipo2 uo_tipo2
sle_dias sle_dias
gb_2 gb_2
end type
global w_con_recibos_fvto w_con_recibos_fvto

type variables
String ante_articulo,retrasos
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

	dw_listado.object.t_situacion.text = "Situación: "
	FOR x1 = 1 To numero
   		IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
				dw_listado.object.t_situacion.text = dw_listado.object.t_situacion.text +" : "+ uo_tipo.dw_marca.GetItemString(x1,"texto")
     			
      		IF Trim(filtro) = "" Then
         		filtro1 = " situacion = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      		Else
         		filtro1 = " Or situacion = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
     			End If
      		filtro = filtro  + filtro1
				filtro  = "(" + filtro + ")"
   		END IF
	NEXT



	dw_listado.object.t_tipodoc.text = "Tipo Doc: "
	FOR x2 = 1 To numero2
   	IF uo_tipo2.dw_marca.GetItemString(x2,"marca") = "S" THEN
			dw_listado.object.t_tipodoc.text = dw_listado.object.t_tipodoc.text +" : "+ uo_tipo2.dw_marca.GetItemString(x2,"texto")

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
dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
string filt="",is_filtro=""
string f="",fi=""
string clien

clien=uo_cliente.em_codigo.text
if clien<>"" then 
	filt=" (cliente = '"+ clien + "')"
else
	filt=""
end if

is_filtro=f_filtro()

if is_filtro="" then 
	is_filtro=filt
else
	if filt="" then 
		is_filtro=is_filtro
	else
		is_filtro=is_filtro + " and " + filt
	end if
end if


if tipo_vista="Nacional" then 
	fi=" (nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi=" (nacional='N')"
	else
		fi=" ((nacional='N') or (nacional='S'))"
	end if
end if

f=is_filtro
IF f="" then
	f=fi
else
	f=is_filtro + "and" + fi
end if
dw_data.SetFilter(f)
dw_data.Filter()

dw_data.Retrieve(codigo_empresa)

registros = dw_data.RowCount()
If registros = 0 Then Return


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE EFECTOS POR TRAMOS DE VENCIMIENTO"

dw_1.Setfocus()
Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)

registros=dw_proceso.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"codigo")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  marca="S"
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
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

sle_dias.text = '0'
f_activar_campo(uo_cliente.em_campo)
end event

on w_con_recibos_fvto.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_proceso=create dw_proceso
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_proceso2=create dw_proceso2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_consulta=create cb_consulta
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.gb_cli=create gb_cli
this.cbx_1=create cbx_1
this.dw_1=create dw_1
this.uo_tipo=create uo_tipo
this.uo_tipo2=create uo_tipo2
this.sle_dias=create sle_dias
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.dw_proceso2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_consulta
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.uo_cliente
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.gb_cli
this.Control[iCurrent+13]=this.cbx_1
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.uo_tipo
this.Control[iCurrent+16]=this.uo_tipo2
this.Control[iCurrent+17]=this.sle_dias
this.Control[iCurrent+18]=this.gb_2
end on

on w_con_recibos_fvto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_proceso)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_proceso2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_consulta)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.gb_cli)
destroy(this.cbx_1)
destroy(this.dw_1)
destroy(this.uo_tipo)
destroy(this.uo_tipo2)
destroy(this.sle_dias)
destroy(this.gb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_fvto
integer x = 850
integer y = 764
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_fvto
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_fvto
integer x = 27
integer y = 20
integer width = 2871
integer height = 88
end type

type pb_2 from upb_salir within w_con_recibos_fvto
integer x = 3045
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_proceso from datawindow within w_con_recibos_fvto
boolean visible = false
integer x = 1714
integer y = 52
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type pb_imprimir_preli from picturebutton within w_con_recibos_fvto
integer x = 3045
integer y = 176
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

event clicked;if tipo_vista="Exportacion" then
	if cbx_1.checked then
		dw_listado.DataObject = "report_carefectos_fvto_exp"
	else
		dw_listado.DataObject = "report_carefectos_fvto_exp_res"
	end if	
else
	if cbx_1.checked then
		dw_listado.DataObject = "report_carefectos_situacion_fvto"
	else
		dw_listado.DataObject = "report_carefectos_situacion_fvto_res"
		if sle_dias.text = '' or isnull (sle_dias.text) then sle_dias.text = '0'

		dw_listado.object.menos_30.Expression = "if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ) )<30,importe,0)"
		dw_listado.object.entre_30_60.Expression = " if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))>=30 and daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))<60,importe,0)"
		dw_listado.object.entre_60_90.Expression = " if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))>=60 and daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))<90,importe,0)"
		dw_listado.object.mas_90.Expression = "if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ) )>90,importe,0)"

	end if
end if

f_cargar(dw_listado)

Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type dw_listado from datawindow within w_con_recibos_fvto
boolean visible = false
integer x = 1189
integer y = 84
integer width = 183
integer height = 188
string dataobject = "report_carefectos_situacion_fvto_res"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_con_recibos_fvto
boolean visible = false
integer x = 1353
integer y = 52
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type cb_1 from u_boton within w_con_recibos_fvto
integer x = 1595
integer y = 200
integer width = 302
integer height = 72
integer taborder = 30
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = FALSE
dw_1.visible = FALSE


end event

type cb_2 from u_boton within w_con_recibos_fvto
event clicked pbm_bnclicked
integer x = 1289
integer y = 200
integer width = 302
integer height = 72
integer taborder = 20
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type cb_consulta from u_boton within w_con_recibos_fvto
integer x = 1902
integer y = 200
integer width = 302
integer height = 72
integer taborder = 40
string text = "&Consulta"
end type

event clicked;if tipo_vista="Exportacion" then
	if cbx_1.checked then
		dw_1.DataObject = "dw_con_carefectos_fvto_exp"
	else
		dw_1.DataObject = "dw_con_carefectos_fvto_exp_res"
	end if
else
	if cbx_1.checked then
		dw_1.DataObject = "dw_con_carefectos_situacion_fvto"
	else
		dw_1.DataObject = "dw_con_carefectos_sit_fvto_res"

		if sle_dias.text = '' or isnull (sle_dias.text) then sle_dias.text = '0'
		
		dw_1.object.menos_30.Expression = "if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ) )<30,importe,0)"
		dw_1.object.entre_30_60.Expression = " if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))>=30 and daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))<60,importe,0)"
		dw_1.object.entre_60_90.Expression = " if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))>=60 and daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ))<90,importe,0)"
		dw_1.object.mas_90.Expression = "if (daysafter(today(),( relativedate ( date(fvto) , "+string(integer(sle_dias.text))+" ) ) )>90,importe,0)"
	end if
end if

f_cargar(dw_1)

dw_1.visible   = TRUE

end event

type gb_1 from groupbox within w_con_recibos_fvto
integer x = 1275
integer y = 164
integer width = 942
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_cliente from u_em_campo_2 within w_con_recibos_fvto
integer x = 32
integer y = 184
integer width = 1207
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



end event

type st_1 from statictext within w_con_recibos_fvto
integer x = 32
integer y = 136
integer width = 1207
integer height = 60
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

type gb_cli from groupbox within w_con_recibos_fvto
integer x = 18
integer y = 104
integer width = 1239
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cbx_1 from checkbox within w_con_recibos_fvto
integer x = 2249
integer y = 200
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Detalle"
end type

type dw_1 from datawindow within w_con_recibos_fvto
boolean visible = false
integer x = 9
integer y = 292
integer width = 3159
integer height = 2096
string dataobject = "dw_con_carefectos_sit_fvto_res"
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

type uo_tipo from u_marca_lista within w_con_recibos_fvto
boolean visible = false
integer x = 832
integer y = 296
integer width = 1454
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type uo_tipo2 from u_marca_lista within w_con_recibos_fvto
boolean visible = false
integer x = 151
integer y = 292
integer height = 672
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type sle_dias from singlelineedit within w_con_recibos_fvto
integer x = 2601
integer y = 200
integer width = 251
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_con_recibos_fvto
integer x = 2587
integer y = 148
integer width = 283
integer height = 152
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "+ Días"
end type

