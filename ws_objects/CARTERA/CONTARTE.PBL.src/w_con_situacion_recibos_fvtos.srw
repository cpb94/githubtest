$PBExportHeader$w_con_situacion_recibos_fvtos.srw
$PBExportComments$€
forward
global type w_con_situacion_recibos_fvtos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_situacion_recibos_fvtos
end type
type cb_1 from u_boton within w_con_situacion_recibos_fvtos
end type
type uo_tipo from u_marca_lista within w_con_situacion_recibos_fvtos
end type
type dw_proceso from datawindow within w_con_situacion_recibos_fvtos
end type
type cb_consulta from u_boton within w_con_situacion_recibos_fvtos
end type
type pb_imprimir_preli from picturebutton within w_con_situacion_recibos_fvtos
end type
type st_8 from statictext within w_con_situacion_recibos_fvtos
end type
type em_fechadesde from u_em_campo within w_con_situacion_recibos_fvtos
end type
type st_9 from statictext within w_con_situacion_recibos_fvtos
end type
type gb_3 from groupbox within w_con_situacion_recibos_fvtos
end type
type gb_1 from groupbox within w_con_situacion_recibos_fvtos
end type
type em_fechahasta from u_em_campo within w_con_situacion_recibos_fvtos
end type
type dw_listado from datawindow within w_con_situacion_recibos_fvtos
end type
type cb_2 from u_boton within w_con_situacion_recibos_fvtos
end type
type uo_tipo2 from u_marca_lista within w_con_situacion_recibos_fvtos
end type
type dw_1 from datawindow within w_con_situacion_recibos_fvtos
end type
type dw_proceso2 from datawindow within w_con_situacion_recibos_fvtos
end type
type gb_2 from groupbox within w_con_situacion_recibos_fvtos
end type
type cb_9 from commandbutton within w_con_situacion_recibos_fvtos
end type
end forward

global type w_con_situacion_recibos_fvtos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 2180
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
dw_proceso dw_proceso
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
st_8 st_8
em_fechadesde em_fechadesde
st_9 st_9
gb_3 gb_3
gb_1 gb_1
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_2 cb_2
uo_tipo2 uo_tipo2
dw_1 dw_1
dw_proceso2 dw_proceso2
gb_2 gb_2
cb_9 cb_9
end type
global w_con_situacion_recibos_fvtos w_con_situacion_recibos_fvtos

type variables
String ante_articulo,retrasos
boolean detalle = true
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

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE
string is_filtro=""

dw_data.SetFilter("")
dw_data.Filter()

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

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


f=f_filtro()
IF f="" then
	f=fi
else
	f=f_filtro() + "and" + fi
end if
dw_data.SetFilter(f)
dw_data.Filter()

dw_data.Retrieve(codigo_empresa,fecha1,fecha2)
registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE EFECTOS AGRUPADOS POR SITUACION"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
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

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

f_activar_campo(em_fechadesde)


end event

on w_con_situacion_recibos_fvtos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_8=create st_8
this.em_fechadesde=create em_fechadesde
this.st_9=create st_9
this.gb_3=create gb_3
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.uo_tipo2=create uo_tipo2
this.dw_1=create dw_1
this.dw_proceso2=create dw_proceso2
this.gb_2=create gb_2
this.cb_9=create cb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.em_fechahasta
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.uo_tipo2
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.dw_proceso2
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.cb_9
end on

on w_con_situacion_recibos_fvtos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.st_8)
destroy(this.em_fechadesde)
destroy(this.st_9)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.uo_tipo2)
destroy(this.dw_1)
destroy(this.dw_proceso2)
destroy(this.gb_2)
destroy(this.cb_9)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_situacion_recibos_fvtos
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_situacion_recibos_fvtos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_situacion_recibos_fvtos
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_situacion_recibos_fvtos
integer x = 2725
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type cb_1 from u_boton within w_con_situacion_recibos_fvtos
integer x = 1509
integer y = 204
integer width = 347
integer height = 76
integer taborder = 80
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_con_situacion_recibos_fvtos
boolean visible = false
integer x = 1166
integer y = 308
integer width = 1349
integer height = 656
integer taborder = 100
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_con_situacion_recibos_fvtos
boolean visible = false
integer x = 242
integer y = 8
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_con_situacion_recibos_fvtos
integer x = 1856
integer y = 204
integer width = 338
integer height = 76
integer taborder = 10
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

end event

type pb_imprimir_preli from picturebutton within w_con_situacion_recibos_fvtos
integer x = 2725
integer y = 192
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

type st_8 from statictext within w_con_situacion_recibos_fvtos
integer x = 562
integer y = 200
integer width = 233
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
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_situacion_recibos_fvtos
integer x = 265
integer y = 192
integer width = 279
integer height = 80
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_9 from statictext within w_con_situacion_recibos_fvtos
integer x = 32
integer y = 200
integer width = 233
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
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_situacion_recibos_fvtos
integer x = 2208
integer y = 168
integer width = 375
integer height = 124
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_situacion_recibos_fvtos
integer x = 18
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
string text = "Fecha Vto"
end type

type em_fechahasta from u_em_campo within w_con_situacion_recibos_fvtos
integer x = 791
integer y = 192
integer width = 279
integer height = 80
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_situacion_recibos_fvtos
boolean visible = false
integer width = 41
integer height = 36
string dataobject = "report_con_situacion_recibos_fvtos"
end type

type cb_2 from u_boton within w_con_situacion_recibos_fvtos
event clicked pbm_bnclicked
integer x = 1161
integer y = 204
integer width = 347
integer height = 76
integer taborder = 70
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type uo_tipo2 from u_marca_lista within w_con_situacion_recibos_fvtos
boolean visible = false
integer x = 416
integer y = 308
integer width = 1349
integer height = 656
integer taborder = 90
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_situacion_recibos_fvtos
boolean visible = false
integer x = 9
integer y = 300
integer width = 2848
integer height = 1656
integer taborder = 110
string dataobject = "dw_con_situacion_recibos_fvtos"
boolean vscrollbar = true
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

type dw_proceso2 from datawindow within w_con_situacion_recibos_fvtos
boolean visible = false
integer x = 1147
integer y = 8
integer width = 325
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_situacion_recibos_fvtos
integer x = 1147
integer y = 168
integer width = 1061
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cb_9 from commandbutton within w_con_situacion_recibos_fvtos
integer x = 2226
integer y = 204
integer width = 338
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Resumen"
end type

event clicked;if detalle then
	dw_1.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.detail.height=0")
	cb_9.text="Detalle"
else
	dw_1.modify("datawindow.detail.height=65")
	dw_listado.modify("datawindow.detail.height=69")
	cb_9.text="Resumen"
end if

detalle=not detalle
end event

