$PBExportHeader$w_con_recibos_pais.srw
$PBExportComments$€
forward
global type w_con_recibos_pais from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_recibos_pais
end type
type cb_1 from u_boton within w_con_recibos_pais
end type
type uo_tipo from u_marca_lista within w_con_recibos_pais
end type
type cb_consulta from u_boton within w_con_recibos_pais
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_pais
end type
type dw_listado from datawindow within w_con_recibos_pais
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_pais
end type
type gb_2 from groupbox within w_con_recibos_pais
end type
type uo_pais from u_em_campo_2 within w_con_recibos_pais
end type
type cb_2 from u_boton within w_con_recibos_pais
end type
type gb_cuenta from groupbox within w_con_recibos_pais
end type
type st_1 from statictext within w_con_recibos_pais
end type
type dw_1 from datawindow within w_con_recibos_pais
end type
type em_fechadesde from u_em_campo within w_con_recibos_pais
end type
type em_fechahasta from u_em_campo within w_con_recibos_pais
end type
type st_8 from statictext within w_con_recibos_pais
end type
type st_9 from statictext within w_con_recibos_pais
end type
type detalle from radiobutton within w_con_recibos_pais
end type
type resumen from radiobutton within w_con_recibos_pais
end type
type st_2 from statictext within w_con_recibos_pais
end type
type st_3 from statictext within w_con_recibos_pais
end type
type st_4 from statictext within w_con_recibos_pais
end type
type uo_pais1 from u_em_campo_2 within w_con_recibos_pais
end type
end forward

global type w_con_recibos_pais from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2939
integer height = 2248
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
gb_2 gb_2
uo_pais uo_pais
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
dw_1 dw_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_8 st_8
st_9 st_9
detalle detalle
resumen resumen
st_2 st_2
st_3 st_3
st_4 st_4
uo_pais1 uo_pais1
end type
global w_con_recibos_pais w_con_recibos_pais

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
public subroutine f_detalle (boolean bol)
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
iF Trim(uo_pais.em_codigo.text) = "" Then
   cli1 = "00000"
ELSE
	cli1 = uo_pais.em_codigo.text
END IF

IF uo_pais1.em_codigo.text = "" THEN
	cli2 = "99999"
ELSE
	cli2 = uo_pais1.em_codigo.text
END IF

IF uo_pais.em_codigo.text > uo_pais1.em_codigo.text THEN
	MessageBox("ERROR EN PAISES","El País Desde Mayor que el Hasta",Exclamation!)
	f_activar_campo(uo_pais.em_campo)
END IF

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

registros = dw_data.Retrieve(codigo_empresa,cli1,cli2,fecha1,fecha2)

If registros = 0 Then Return


end subroutine

public subroutine f_detalle (boolean bol);IF bol Then
		dw_1.Modify("DataWindow.Detail.Height=69")
		dw_listado.DataObject= "report_carefectos_situacion_pais"
ELSE
		dw_1.Modify("DataWindow.Detail.Height=0")
		dw_listado.DataObject= "report_carefectos_situacion_pais_resumen" 
END IF
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta de Cartera de Cobros por País"

dw_1.Setfocus()

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())



Integer x1,registros 
String var_codigo,var_texto,marca
DataStore dw
//dw = f_cargar_cursor("Select * from carsituacion Where empresa = '" + codigo_empresa + "'")
f_cargar_cursor_nuevo("Select * from carsituacion Where empresa = '" + codigo_empresa + "'", dw)
registros=dw.RowCount()
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw.GetItemString(x1,"codigo")
  var_texto   = dw.GetItemString(x1,"descripcion")
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
//dw = f_cargar_cursor("select * from cartipodoc where empresa = '" + codigo_empresa + "'")
f_cargar_cursor_nuevo("select * from cartipodoc where empresa = '" + codigo_empresa + "'", dw)
registros2=dw.RowCount()
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw.GetItemString(x2,"tipodoc")
  var_texto2   = dw.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(uo_pais.em_campo)

destroy dw
end event

on w_con_recibos_pais.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.gb_2=create gb_2
this.uo_pais=create uo_pais
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_8=create st_8
this.st_9=create st_9
this.detalle=create detalle
this.resumen=create resumen
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.uo_pais1=create uo_pais1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.pb_imprimir_preli
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_tipo2
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.uo_pais
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_cuenta
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.em_fechadesde
this.Control[iCurrent+15]=this.em_fechahasta
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.st_9
this.Control[iCurrent+18]=this.detalle
this.Control[iCurrent+19]=this.resumen
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.st_3
this.Control[iCurrent+22]=this.st_4
this.Control[iCurrent+23]=this.uo_pais1
end on

on w_con_recibos_pais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.gb_2)
destroy(this.uo_pais)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.detalle)
destroy(this.resumen)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_pais1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_pais
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_pais
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_pais
integer y = 20
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_con_recibos_pais
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_1 from u_boton within w_con_recibos_pais
integer x = 1605
integer y = 320
integer width = 306
integer height = 72
integer taborder = 70
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_con_recibos_pais
boolean visible = false
integer x = 1417
integer y = 396
integer width = 1449
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_consulta from u_boton within w_con_recibos_pais
integer x = 1911
integer y = 320
integer width = 293
integer height = 72
integer taborder = 50
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
dw_1.visible = TRUE

f_activar_campo(uo_pais.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_con_recibos_pais
integer x = 2706
integer y = 228
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

f_imprimir_datawindow(dw_listado)

f_activar_campo(uo_pais.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_pais
boolean visible = false
integer x = 2459
integer y = 8
integer width = 256
integer height = 168
string dataobject = "report_carefectos_situacion_pais"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_recibos_pais
boolean visible = false
integer x = 224
integer y = 396
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type gb_2 from groupbox within w_con_recibos_pais
integer x = 1298
integer y = 96
integer width = 919
integer height = 308
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_pais from u_em_campo_2 within w_con_recibos_pais
event destroy ( )
integer x = 201
integer y = 196
integer width = 1074
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Paises"
ue_datawindow ="dw_ayuda_paises"
valor_empresa = FALSE

end event

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)
If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
end if 
dw_1.Reset()

end event

type cb_2 from u_boton within w_con_recibos_pais
event clicked pbm_bnclicked
integer x = 1317
integer y = 320
integer width = 288
integer height = 72
integer taborder = 60
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type gb_cuenta from groupbox within w_con_recibos_pais
integer y = 96
integer width = 1294
integer height = 308
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_con_recibos_pais
integer x = 27
integer y = 144
integer width = 1225
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "PAÍS"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_recibos_pais
integer y = 416
integer width = 2853
integer height = 1608
boolean bringtotop = true
string dataobject = "dw_con_carefectos_pais"
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

type em_fechadesde from u_em_campo within w_con_recibos_pais
integer x = 1463
integer y = 204
integer width = 283
integer height = 80
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_recibos_pais
integer x = 1893
integer y = 204
integer width = 293
integer height = 80
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_recibos_pais
integer x = 1760
integer y = 208
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

type st_9 from statictext within w_con_recibos_pais
integer x = 1321
integer y = 208
integer width = 142
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
alignment alignment = center!
boolean focusrectangle = false
end type

type detalle from radiobutton within w_con_recibos_pais
integer x = 2254
integer y = 152
integer width = 352
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
boolean lefttext = true
end type

event clicked;f_detalle(TRUE)
end event

type resumen from radiobutton within w_con_recibos_pais
integer x = 2249
integer y = 272
integer width = 352
integer height = 108
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 12632256
string text = "Resumen"
boolean lefttext = true
end type

event clicked;f_detalle(FALSE)
end event

type st_2 from statictext within w_con_recibos_pais
integer x = 14
integer y = 208
integer width = 183
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_recibos_pais
integer x = 14
integer y = 312
integer width = 183
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "Hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_recibos_pais
integer x = 1312
integer y = 128
integer width = 891
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "F.VENCIMIENTO"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_pais1 from u_em_campo_2 within w_con_recibos_pais
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 201
integer y = 300
integer width = 1074
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_pais1.em_campo.text=f_nombre_pais(uo_pais1.em_codigo.text)
If Trim(uo_pais1.em_campo.text)="" then
	uo_pais1.em_campo.text=""
	uo_pais1.em_codigo.text=""
end if 

IF uo_pais1.em_codigo.text = "" THEN
	uo_pais1.em_codigo.text = "99999"
END IF

IF uo_pais.em_codigo.text > uo_pais1.em_codigo.text THEN
	MessageBox("ERROR EN PAISES","El País Desde Mayor que el Hasta",Exclamation!)
	f_activar_campo(uo_pais.em_campo)
END IF
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Paises"
ue_datawindow ="dw_ayuda_paises"
valor_empresa = FALSE

end event

on uo_pais1.destroy
call u_em_campo_2::destroy
end on

