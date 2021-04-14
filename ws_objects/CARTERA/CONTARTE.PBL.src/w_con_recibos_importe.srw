$PBExportHeader$w_con_recibos_importe.srw
$PBExportComments$€
forward
global type w_con_recibos_importe from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_importe
end type
type cb_1 from u_boton within w_con_recibos_importe
end type
type uo_tipo from u_marca_lista within w_con_recibos_importe
end type
type dw_proceso from datawindow within w_con_recibos_importe
end type
type cb_consulta from u_boton within w_con_recibos_importe
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_importe
end type
type st_8 from statictext within w_con_recibos_importe
end type
type em_importedesde from u_em_campo within w_con_recibos_importe
end type
type st_9 from statictext within w_con_recibos_importe
end type
type gb_3 from groupbox within w_con_recibos_importe
end type
type gb_1 from groupbox within w_con_recibos_importe
end type
type em_importehasta from u_em_campo within w_con_recibos_importe
end type
type dw_listado from datawindow within w_con_recibos_importe
end type
type cb_2 from u_boton within w_con_recibos_importe
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_importe
end type
type dw_1 from datawindow within w_con_recibos_importe
end type
type dw_proceso2 from datawindow within w_con_recibos_importe
end type
type gb_2 from groupbox within w_con_recibos_importe
end type
type uo_moneda from u_em_campo_2 within w_con_recibos_importe
end type
end forward

global type w_con_recibos_importe from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2949
integer height = 2224
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
dw_proceso dw_proceso
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
st_8 st_8
em_importedesde em_importedesde
st_9 st_9
gb_3 gb_3
gb_1 gb_1
em_importehasta em_importehasta
dw_listado dw_listado
cb_2 cb_2
uo_tipo2 uo_tipo2
dw_1 dw_1
dw_proceso2 dw_proceso2
gb_2 gb_2
uo_moneda uo_moneda
end type
global w_con_recibos_importe w_con_recibos_importe

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
string  moneda
dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
dec importe_desde,importe_hasta

uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()


importe_desde = dec(em_importedesde.Text)
importe_hasta = dec(em_importehasta.Text)

string f="",fi=""

if tipo_vista="Nacional" then 
	fi=" (nacional='S')"
else
	if tipo_vista="Exportacion" then 
		fi=" (nacional='N')"
	else
		fi=" ((nacional='N') or (nacional='S'))"
	end if
end if


f = f_filtro()
IF f="" then
	f=fi
else
	f=f_filtro() + "and" + fi
end if
dw_data.SetFilter(f)
dw_data.Filter()
if trim(uo_moneda.em_codigo.text) = "" then
	moneda = "%"
else
	moneda = trim(uo_moneda.em_codigo.text)
end if
dw_data.Retrieve(codigo_empresa,importe_desde,importe_hasta,moneda)

registros = dw_data.RowCount()

If registros > 0 Then 
	dw_data.visible   = TRUE
end if
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA EFECTOS POR FECHA FACTURA"

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

f_activar_campo(uo_moneda.em_campo)


end event

on w_con_recibos_importe.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_8=create st_8
this.em_importedesde=create em_importedesde
this.st_9=create st_9
this.gb_3=create gb_3
this.gb_1=create gb_1
this.em_importehasta=create em_importehasta
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.uo_tipo2=create uo_tipo2
this.dw_1=create dw_1
this.dw_proceso2=create dw_proceso2
this.gb_2=create gb_2
this.uo_moneda=create uo_moneda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.em_importedesde
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.em_importehasta
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.uo_tipo2
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.dw_proceso2
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.uo_moneda
end on

on w_con_recibos_importe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.st_8)
destroy(this.em_importedesde)
destroy(this.st_9)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.em_importehasta)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.uo_tipo2)
destroy(this.dw_1)
destroy(this.dw_proceso2)
destroy(this.gb_2)
destroy(this.uo_moneda)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_importe
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_importe
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_importe
integer x = 27
integer y = 24
integer width = 2642
end type

type pb_2 from upb_salir within w_con_recibos_importe
integer x = 2757
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type cb_1 from u_boton within w_con_recibos_importe
integer x = 1920
integer y = 204
integer width = 334
integer height = 76
integer taborder = 70
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_con_recibos_importe
boolean visible = false
integer x = 1166
integer y = 320
integer width = 1349
integer height = 656
integer taborder = 100
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_con_recibos_importe
boolean visible = false
integer x = 242
integer y = 8
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_con_recibos_importe
integer x = 2258
integer y = 204
integer width = 325
integer height = 76
integer taborder = 80
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

end event

type pb_imprimir_preli from picturebutton within w_con_recibos_importe
integer x = 2757
integer y = 196
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

event clicked;f_cargar(dw_listado)
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type st_8 from statictext within w_con_recibos_importe
integer x = 1024
integer y = 200
integer width = 178
integer height = 72
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
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_importedesde from u_em_campo within w_con_recibos_importe
integer x = 667
integer y = 184
integer width = 352
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

type st_9 from statictext within w_con_recibos_importe
integer x = 489
integer y = 200
integer width = 178
integer height = 72
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
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_recibos_importe
integer x = 5
integer y = 120
integer width = 475
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Moneda"
end type

type gb_1 from groupbox within w_con_recibos_importe
integer x = 480
integer y = 120
integer width = 1088
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Importe efecto"
end type

type em_importehasta from u_em_campo within w_con_recibos_importe
integer x = 1189
integer y = 184
integer width = 352
integer height = 80
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.00"
end type

type dw_listado from datawindow within w_con_recibos_importe
boolean visible = false
integer width = 41
integer height = 40
string dataobject = "report_carefectos_situacion_importe"
boolean livescroll = true
end type

type cb_2 from u_boton within w_con_recibos_importe
event clicked pbm_bnclicked
integer x = 1582
integer y = 204
integer width = 334
integer height = 76
integer taborder = 60
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type uo_tipo2 from u_marca_lista within w_con_recibos_importe
boolean visible = false
integer x = 411
integer y = 320
integer width = 1349
integer height = 656
integer taborder = 90
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_recibos_importe
boolean visible = false
integer x = 9
integer y = 316
integer width = 2857
integer height = 1652
integer taborder = 110
string dataobject = "dw_con_carefectos_situacion_importe"
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

type dw_proceso2 from datawindow within w_con_recibos_importe
boolean visible = false
integer x = 1147
integer y = 8
integer width = 448
integer height = 116
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_recibos_importe
integer x = 1568
integer y = 168
integer width = 1029
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_moneda from u_em_campo_2 within w_con_recibos_importe
event destroy ( )
integer x = 32
integer y = 184
integer width = 421
integer height = 80
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_moneda.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_moneda.em_campo.text = f_nombre_moneda_abr(uo_moneda.em_codigo.text)

If Trim(uo_moneda.em_campo.text)= "" then
	em_importedesde.setmask(DecimalMask!,"###,###,###,##0.00")
	em_importehasta.setmask(DecimalMask!,"###,###,###,##0.00")	
	uo_moneda.em_campo.text  = ""
	uo_moneda.em_codigo.text = ""
	Return
else
	em_importedesde.setmask(DecimalMask!,f_mascara_moneda(uo_moneda.em_codigo.text))
	em_importehasta.setmask(DecimalMask!,f_mascara_moneda(uo_moneda.em_codigo.text))
end if 


end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Monedas"
ue_datawindow = "dw_ayuda_divisas"
valor_empresa = False
end event

