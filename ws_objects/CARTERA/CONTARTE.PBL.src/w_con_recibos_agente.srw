$PBExportHeader$w_con_recibos_agente.srw
$PBExportComments$€
forward
global type w_con_recibos_agente from w_int_con_empresa
end type
type gb_cuenta from groupbox within w_con_recibos_agente
end type
type pb_2 from upb_salir within w_con_recibos_agente
end type
type cb_1 from u_boton within w_con_recibos_agente
end type
type uo_tipo from u_marca_lista within w_con_recibos_agente
end type
type cb_consulta from u_boton within w_con_recibos_agente
end type
type pb_imprimir_preli from picturebutton within w_con_recibos_agente
end type
type dw_listado from datawindow within w_con_recibos_agente
end type
type uo_tipo2 from u_marca_lista within w_con_recibos_agente
end type
type gb_2 from groupbox within w_con_recibos_agente
end type
type cb_2 from u_boton within w_con_recibos_agente
end type
type st_1 from statictext within w_con_recibos_agente
end type
type em_fechadesde from u_em_campo within w_con_recibos_agente
end type
type em_fechahasta from u_em_campo within w_con_recibos_agente
end type
type st_8 from statictext within w_con_recibos_agente
end type
type st_9 from statictext within w_con_recibos_agente
end type
type detalle from radiobutton within w_con_recibos_agente
end type
type resumen from radiobutton within w_con_recibos_agente
end type
type st_2 from statictext within w_con_recibos_agente
end type
type uo_agente from u_em_campo_2 within w_con_recibos_agente
end type
type st_3 from statictext within w_con_recibos_agente
end type
type uo_agente1 from u_em_campo_2 within w_con_recibos_agente
end type
type st_4 from statictext within w_con_recibos_agente
end type
type uo_grupo from u_em_campo_2 within w_con_recibos_agente
end type
type gb_9 from groupbox within w_con_recibos_agente
end type
type pb_1 from picturebutton within w_con_recibos_agente
end type
type cbx_situacion from checkbox within w_con_recibos_agente
end type
type dw_1 from datawindow within w_con_recibos_agente
end type
end forward

global type w_con_recibos_agente from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4032
integer height = 3608
string title = "Consulta de Movimientos"
gb_cuenta gb_cuenta
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
gb_2 gb_2
cb_2 cb_2
st_1 st_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_8 st_8
st_9 st_9
detalle detalle
resumen resumen
st_2 st_2
uo_agente uo_agente
st_3 st_3
uo_agente1 uo_agente1
st_4 st_4
uo_grupo uo_grupo
gb_9 gb_9
pb_1 pb_1
cbx_situacion cbx_situacion
dw_1 dw_1
end type
global w_con_recibos_agente w_con_recibos_agente

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
String agen1,agen2, vengrupo
Datetime fecha1,fecha2
string is_filtro=""
string f="",fi=""

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo.visible   = FALSE
uo_tipo2.visible   = FALSE

dw_data.SetTransObject(sqlca)
dw_data.SetFilter("")
dw_data.Filter()


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

iF Trim(uo_agente.em_codigo.text) = "" Then
   agen1 = ""
ELSE
	agen1 = uo_agente.em_codigo.text
END IF

iF Trim(uo_agente1.em_codigo.text) = "" Then
   agen2 = "99999999"
ELSE
	agen2 = uo_agente1.em_codigo.text
END IF

iF Trim(uo_grupo.em_codigo.text) = "" Then
   vengrupo = "%"
ELSE
	vengrupo = uo_grupo.em_codigo.text
END IF

fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))
dw_data.object.t_fvto.text = em_fechahasta.Text

dw_data.Retrieve(codigo_empresa,agen1,agen2,fecha1,fecha2, vengrupo)

registros = dw_data.RowCount()
If registros = 0 Then Return

dw_data.visible   = TRUE
end subroutine

public subroutine f_detalle (boolean bol);IF bol Then
		dw_1.Modify("DataWindow.Detail.Height=69")
		dw_listado.Modify("DataWindow.Detail.Height=69") 
ELSE
		dw_1.Modify("DataWindow.Detail.Height=0")
		dw_listado.Modify("DataWindow.Detail.Height=0") 
END IF
end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " Consulta de Cartera de Cobros por AGENTE"

dw_1.Setfocus()

//em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechadesde.text = '01-01-01'
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
  marca="N"

  if var_codigo = '10'	then marca = 'S'
  if var_codigo = '8'	then marca = 'S'

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
dw = f_cargar_cursor("select * from cartipodoc where empresa = '" + codigo_empresa + "'")
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

f_activar_campo(uo_agente.em_campo)

destroy dw
end event

on w_con_recibos_agente.create
int iCurrent
call super::create
this.gb_cuenta=create gb_cuenta
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.gb_2=create gb_2
this.cb_2=create cb_2
this.st_1=create st_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_8=create st_8
this.st_9=create st_9
this.detalle=create detalle
this.resumen=create resumen
this.st_2=create st_2
this.uo_agente=create uo_agente
this.st_3=create st_3
this.uo_agente1=create uo_agente1
this.st_4=create st_4
this.uo_grupo=create uo_grupo
this.gb_9=create gb_9
this.pb_1=create pb_1
this.cbx_situacion=create cbx_situacion
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_cuenta
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.uo_tipo
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_tipo2
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.em_fechadesde
this.Control[iCurrent+13]=this.em_fechahasta
this.Control[iCurrent+14]=this.st_8
this.Control[iCurrent+15]=this.st_9
this.Control[iCurrent+16]=this.detalle
this.Control[iCurrent+17]=this.resumen
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.uo_agente
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.uo_agente1
this.Control[iCurrent+22]=this.st_4
this.Control[iCurrent+23]=this.uo_grupo
this.Control[iCurrent+24]=this.gb_9
this.Control[iCurrent+25]=this.pb_1
this.Control[iCurrent+26]=this.cbx_situacion
this.Control[iCurrent+27]=this.dw_1
end on

on w_con_recibos_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_cuenta)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.gb_2)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.detalle)
destroy(this.resumen)
destroy(this.st_2)
destroy(this.uo_agente)
destroy(this.st_3)
destroy(this.uo_agente1)
destroy(this.st_4)
destroy(this.uo_grupo)
destroy(this.gb_9)
destroy(this.pb_1)
destroy(this.cbx_situacion)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_recibos_agente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_recibos_agente
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_recibos_agente
integer y = 20
integer width = 3941
integer height = 80
end type

type gb_cuenta from groupbox within w_con_recibos_agente
integer y = 96
integer width = 1285
integer height = 296
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_recibos_agente
integer x = 3790
integer y = 128
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\Tencer_PB12\Log Out_24x24.png"
end type

type cb_1 from u_boton within w_con_recibos_agente
integer x = 1605
integer y = 300
integer width = 306
integer height = 80
integer taborder = 70
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_con_recibos_agente
boolean visible = false
integer x = 1495
integer y = 452
integer width = 1449
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_consulta from u_boton within w_con_recibos_agente
integer x = 1911
integer y = 300
integer width = 293
integer height = 80
integer taborder = 50
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
f_activar_campo(uo_agente.em_campo)

if cbx_situacion.checked then 
	dw_1.object.carsituacion_descripcion.visible = false
	dw_1.object.t_situacion.visible = false
else
	dw_1.object.carsituacion_descripcion.visible = true
	dw_1.object.t_situacion.visible = true
end if
end event

type pb_imprimir_preli from picturebutton within w_con_recibos_agente
integer x = 3474
integer y = 128
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir Listado"
end type

event clicked;//f_cargar(dw_listado)
//dw_listado.visible = FALSE
//f_imprimir_datawindow(dw_listado)
//f_activar_campo(uo_agente.em_campo)

f_imprimir_datawindow(dw_1)
f_activar_campo(uo_agente.em_campo)
end event

type dw_listado from datawindow within w_con_recibos_agente
boolean visible = false
integer x = 2496
integer y = 4
integer width = 178
integer height = 200
string dataobject = "report_carefectos_situacion_agente"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_con_recibos_agente
boolean visible = false
integer x = 146
integer y = 452
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type gb_2 from groupbox within w_con_recibos_agente
integer x = 1298
integer y = 96
integer width = 919
integer height = 300
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cb_2 from u_boton within w_con_recibos_agente
event clicked pbm_bnclicked
integer x = 1317
integer y = 300
integer width = 288
integer height = 80
integer taborder = 60
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type st_1 from statictext within w_con_recibos_agente
integer x = 27
integer y = 132
integer width = 1216
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "AGENTE"
alignment alignment = center!
long bordercolor = 128
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_recibos_agente
integer x = 1458
integer y = 208
integer width = 302
integer height = 80
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_recibos_agente
integer x = 1902
integer y = 208
integer width = 293
integer height = 80
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_recibos_agente
integer x = 1765
integer y = 212
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

type st_9 from statictext within w_con_recibos_agente
integer x = 1317
integer y = 212
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

type detalle from radiobutton within w_con_recibos_agente
integer x = 2917
integer y = 108
integer width = 352
integer height = 92
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

type resumen from radiobutton within w_con_recibos_agente
integer x = 2917
integer y = 180
integer width = 352
integer height = 76
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

type st_2 from statictext within w_con_recibos_agente
integer x = 1312
integer y = 136
integer width = 873
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "F. VENCIMIENTO"
alignment alignment = center!
long bordercolor = 128
boolean focusrectangle = false
end type

type uo_agente from u_em_campo_2 within w_con_recibos_agente
event destroy ( )
integer x = 206
integer y = 204
integer width = 1061
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Agente"
ue_datawindow ="dw_ayuda_venagentes"


end event

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 
dw_1.Reset()

end event

type st_3 from statictext within w_con_recibos_agente
integer x = 9
integer y = 208
integer width = 192
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
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_agente1 from u_em_campo_2 within w_con_recibos_agente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 206
integer y = 292
integer width = 1061
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente1.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente1.em_codigo.text)
If Trim(uo_agente1.em_campo.text)="" then
	uo_agente1.em_campo.text=""
	uo_agente1.em_codigo.text=""
end if 

IF uo_agente1.em_codigo.text = "" THEN
	uo_agente1.em_codigo.text = "99999"
END IF

IF uo_agente.em_codigo.text > uo_agente1.em_codigo.text THEN
	MessageBox("ERROR EN AGENTES","El agente Desde mayor que el Hasta",Exclamation!)
	f_activar_campo(uo_agente1.em_campo)
END IF

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Agente"
ue_datawindow ="dw_ayuda_venagentes"


end event

on uo_agente1.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_con_recibos_agente
integer x = 9
integer y = 296
integer width = 192
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
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_grupo from u_em_campo_2 within w_con_recibos_agente
event destroy ( )
integer x = 2290
integer y = 268
integer width = 544
integer height = 88
integer taborder = 110
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from vengrupos
where empresa = :codigo_empresa
and codigo = :uo_grupo.em_codigo.text;

uo_grupo.em_campo.text= descripcion
IF Trim(uo_grupo.em_campo.text)="" THEN 
	IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
	uo_grupo.em_campo.text=""
	uo_grupo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Grupos de Clientes"
ue_datawindow = "dw_ayuda_vengrupos"
ue_filtro     = ""

end event

type gb_9 from groupbox within w_con_recibos_agente
integer x = 2249
integer y = 216
integer width = 608
integer height = 156
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Grupo Cliente"
end type

type pb_1 from picturebutton within w_con_recibos_agente
integer x = 3630
integer y = 128
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir PDF por Agente"
end type

event clicked;//OJO!!!!     Para imprimir pdf se requiere tener instalado "GHOSTSCRIPT"

string ls_path =GetCurrentDirectory ( )
integer li_result
string sel
datastore datos
integer i
string agente, des_agente
string ruta_completa

li_result = GetFolder( "Carpeta Destino", ls_path )

sel = " Select agente, nombre from venagentes where empresa = '"+codigo_empresa+"' "
f_cargar_cursor_nuevo(sel, datos)

for i = 1 to datos.rowcount()
	agente = datos.object.agente[i]
	des_agente = datos.object.nombre[i]
	uo_agente.em_codigo.text = agente
	uo_agente1.em_codigo.text = agente
	
	cb_consulta.TriggerEvent(Clicked!)
	
	if dw_1.RowCount () > 0 then
		// Impresion de un PDF
		dw_1.Object.DataWindow.Export.PDF.Method = Distill!
		dw_1.Object.DataWindow.Printer = "Microsoft Print to PDF"    //PDF Nombre de la impresora virtual
		dw_1.Object.DataWindow.Export.PDF.Distill.CustomPostScript="YES"     // Permitir Postscript
		ruta_completa = ls_path+"\"+des_agente+" a "+em_fechahasta.text+".pdf"
//		dw_1.SaveAs(ls_path+"\"+des_agente+" a "+em_fechahasta.text+".pdf",PDF!,true) 
		dw_1.SaveAs(ruta_completa, PDF!, true) 
	end if
next

uo_agente.em_codigo.text = ""
uo_agente1.em_codigo.text = ""

end event

type cbx_situacion from checkbox within w_con_recibos_agente
integer x = 2903
integer y = 280
integer width = 571
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar Situcación"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_con_recibos_agente
integer x = 37
integer y = 432
integer width = 3954
integer height = 3000
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_carefectos_agente"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

