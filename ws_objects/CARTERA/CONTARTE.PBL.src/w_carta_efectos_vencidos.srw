$PBExportHeader$w_carta_efectos_vencidos.srw
$PBExportComments$€
forward
global type w_carta_efectos_vencidos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_carta_efectos_vencidos
end type
type cb_consulta from u_boton within w_carta_efectos_vencidos
end type
type pb_imprimir_preli from picturebutton within w_carta_efectos_vencidos
end type
type uo_tipo2 from u_marca_lista within w_carta_efectos_vencidos
end type
type dw_proceso2 from datawindow within w_carta_efectos_vencidos
end type
type gb_4 from groupbox within w_carta_efectos_vencidos
end type
type gb_3 from groupbox within w_carta_efectos_vencidos
end type
type gb_2 from groupbox within w_carta_efectos_vencidos
end type
type uo_cliente from u_em_campo_2 within w_carta_efectos_vencidos
end type
type cb_2 from u_boton within w_carta_efectos_vencidos
end type
type gb_cuenta from groupbox within w_carta_efectos_vencidos
end type
type st_1 from statictext within w_carta_efectos_vencidos
end type
type dw_1 from datawindow within w_carta_efectos_vencidos
end type
type em_fechadesde from u_em_campo within w_carta_efectos_vencidos
end type
type em_fechahasta from u_em_campo within w_carta_efectos_vencidos
end type
type st_8 from statictext within w_carta_efectos_vencidos
end type
type em_fechacarta from u_em_campo within w_carta_efectos_vencidos
end type
type st_55 from statictext within w_carta_efectos_vencidos
end type
type st_56 from statictext within w_carta_efectos_vencidos
end type
type dw_listado from datawindow within w_carta_efectos_vencidos
end type
type st_2 from statictext within w_carta_efectos_vencidos
end type
type texto from singlelineedit within w_carta_efectos_vencidos
end type
end forward

global type w_carta_efectos_vencidos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2962
integer height = 2216
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
uo_cliente uo_cliente
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
dw_1 dw_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_8 st_8
em_fechacarta em_fechacarta
st_55 st_55
st_56 st_56
dw_listado dw_listado
st_2 st_2
texto texto
end type
global w_carta_efectos_vencidos w_carta_efectos_vencidos

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
public subroutine f_selecciona_report (string par_idioma)
end prototypes

public function string f_filtro ();Integer numero,registros,x1,numero2,registros2,x2
String filtro,filtro1,filtro2,filtro21,fil,nexo


filtro2 = ""

numero2 = uo_tipo2.dw_marca.RowCount()
IF numero2 =0 Then return ""


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


fil= filtro2

return fil


end function

public subroutine f_cargar (datawindow dw_data);Integer registros
String cli1,cli2,naci
string is_filtro=""
string f=""

dw_data.reset()
dw_data.visible   = FALSE
uo_tipo2.visible   = FALSE


dw_data.SetTransObject(sqlca)



if tipo_vista="Nacional" then 
	naci = "S"
end if

if tipo_vista="Exportacion" then 
	naci = "N"	
end if


f=f_filtro()

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


end subroutine

public subroutine f_selecciona_report (string par_idioma);choose case par_idioma
	case "1"
		dw_listado.dataobject = "report_carta_efectos_vencidos_castellano"		
	case "3"
		dw_listado.dataobject = "report_carta_efectos_vencidos_ingles"		
	case "2"
		dw_listado.dataobject = "report_carta_efectos_vencidos_frances"		
	case "4"
		dw_listado.dataobject = "report_carta_efectos_aleman"		
	case else
		dw_listado.dataobject = "report_carta_efectos_vencidos_castellano"		
end choose
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
This.title = " CARTA DE EFECTOS VENCIDOS"

dw_1.SetTransObject(sqlca)
dw_listado.settransobject(sqlca)

dw_1.Setfocus()

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
em_fechacarta.text = String(Today())

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

f_activar_campo(uo_cliente.em_campo)


end event

on w_carta_efectos_vencidos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_8=create st_8
this.em_fechacarta=create em_fechacarta
this.st_55=create st_55
this.st_56=create st_56
this.dw_listado=create dw_listado
this.st_2=create st_2
this.texto=create texto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.uo_tipo2
this.Control[iCurrent+5]=this.dw_proceso2
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.uo_cliente
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_cuenta
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.em_fechadesde
this.Control[iCurrent+15]=this.em_fechahasta
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.em_fechacarta
this.Control[iCurrent+18]=this.st_55
this.Control[iCurrent+19]=this.st_56
this.Control[iCurrent+20]=this.dw_listado
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.texto
end on

on w_carta_efectos_vencidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_8)
destroy(this.em_fechacarta)
destroy(this.st_55)
destroy(this.st_56)
destroy(this.dw_listado)
destroy(this.st_2)
destroy(this.texto)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_carta_efectos_vencidos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_carta_efectos_vencidos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_carta_efectos_vencidos
integer x = 37
integer y = 20
integer width = 2629
integer height = 92
end type

type pb_2 from upb_salir within w_carta_efectos_vencidos
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type cb_consulta from u_boton within w_carta_efectos_vencidos
integer x = 2359
integer y = 212
integer width = 293
integer height = 72
integer taborder = 80
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
dw_1.visible   = TRUE
f_activar_campo(uo_cliente.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_carta_efectos_vencidos
integer x = 2734
integer y = 128
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

event clicked;int i,fila
string marca,cliente_anterior,cliente_nuevo,referencia,moneda,banco,idioma
boolean alguno
datetime ffra,fvto
dec importe


if dw_1.rowcount() <= 0 then 
	messagebox("Error","No se ha consultado o no hay efectos")
	return
end if

alguno = false


for i = 1 to dw_1.rowcount()
	marca = dw_1.getitemstring(i,"marcar")
	if marca = "S" then
		if not alguno then
			cliente_nuevo	= dw_1.getitemstring(i,"cliente")
			banco				= dw_1.getitemstring(i,"banco")	 
			idioma			= f_idioma_genter(codigo_empresa,"C",cliente_nuevo)		
			cliente_anterior = cliente_nuevo
			
			alguno = true
			
			f_selecciona_report(idioma)			
			dw_listado.settransobject(sqlca)
			dw_listado.retrieve(codigo_empresa,cliente_nuevo,banco,datetime(date(em_fechacarta.text)),idioma,texto.text)		
		else
			cliente_nuevo = dw_1.getitemstring(i,"cliente")	
			
		end if
		
			
		if cliente_nuevo <> cliente_anterior then
			dw_listado.print()
			cliente_anterior = cliente_nuevo
			fila = 0
			dw_listado.reset()
			banco			= dw_1.getitemstring(i,"banco")	 
			idioma		= f_idioma_genter(codigo_empresa,"C",cliente_nuevo)		
			f_selecciona_report(idioma)
			dw_listado.settransobject(sqlca)
			dw_listado.retrieve(codigo_empresa,cliente_nuevo,banco,datetime(date(em_fechacarta.text)),idioma,texto.text)		
		end if
		
		ffra			= dw_1.getitemdatetime(i,"ffra")
		fvto			= dw_1.getitemdatetime(i,"fvto")
		referencia 	= dw_1.getitemstring(i,"referencia")
		importe		= dw_1.getitemnumber(i,"divisas")
		moneda		= dw_1.getitemstring(i,"monedas")	
		

		fila = dw_listado.insertrow(0)
		
		
		dw_listado.setitem(fila,"ffra",ffra)
		dw_listado.setitem(fila,"fvto",fvto)
		dw_listado.setitem(fila,"referencia",referencia)
		dw_listado.setitem(fila,"divisa",importe)
		dw_listado.setitem(fila,"moneda",moneda)
		dw_listado.setitem(fila,"ffra",ffra)		
		
		
		
	end if
next
if alguno then
	dw_listado.print()
else
	messagebox("Atención","No se han seleccionado efectos")
	return
end if


end event

type uo_tipo2 from u_marca_lista within w_carta_efectos_vencidos
boolean visible = false
integer x = 1271
integer y = 304
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_carta_efectos_vencidos
boolean visible = false
integer x = 110
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type gb_4 from groupbox within w_carta_efectos_vencidos
integer x = 1938
integer y = 96
integer width = 402
integer height = 200
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_carta_efectos_vencidos
integer x = 2341
integer y = 96
integer width = 334
integer height = 200
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_carta_efectos_vencidos
integer x = 1166
integer y = 96
integer width = 773
integer height = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_cliente from u_em_campo_2 within w_carta_efectos_vencidos
event destroy ( )
integer x = 32
integer y = 196
integer width = 1097
integer taborder = 30
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

type cb_2 from u_boton within w_carta_efectos_vencidos
event clicked pbm_bnclicked
integer x = 2359
integer y = 136
integer width = 288
integer height = 72
integer taborder = 70
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true

dw_1.visible = FALSE
end event

type gb_cuenta from groupbox within w_carta_efectos_vencidos
integer y = 96
integer width = 1161
integer height = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_carta_efectos_vencidos
integer x = 27
integer y = 144
integer width = 1097
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

type dw_1 from datawindow within w_carta_efectos_vencidos
integer x = 9
integer y = 300
integer width = 2853
integer height = 1572
boolean bringtotop = true
string dataobject = "dw_con_carta_efectos_vencidos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long i

if dwo.name = "m" then
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,"marcar","S")		
	next
	setpointer(arrow!)
end if


if dwo.name = "d" then
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,"marcar","N")		
	next
	setpointer(arrow!)
end if
end event

event rbuttondown;CHOOSE CASE f_objeto_datawindow(This)
		
	case "banco"
		
		string banco
		str_parametros astr_parametros
		
		astr_parametros.s_criterio_busqueda = ""
		astr_parametros.s_nom_datawindow = "dw_ayuda_carbancos"
		astr_parametros.s_filtro = ""
		astr_parametros.s_titulo_ayuda = "Ventana ayuda bancos"
		astr_parametros.b_empresa	=	true
		
		openwithparm(w_busquedas,astr_parametros)
		
		banco = message.stringparm
		
		dw_1.setitem(row,"banco",banco)
		

		
		
	
		
end choose
end event

type em_fechadesde from u_em_campo within w_carta_efectos_vencidos
integer x = 1216
integer y = 200
integer width = 283
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_carta_efectos_vencidos
integer x = 1582
integer y = 200
integer width = 293
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_carta_efectos_vencidos
integer x = 1518
integer y = 200
integer width = 46
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
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechacarta from u_em_campo within w_carta_efectos_vencidos
integer x = 2002
integer y = 200
integer width = 293
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_55 from statictext within w_carta_efectos_vencidos
integer x = 1266
integer y = 144
integer width = 567
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
string text = "V e n c i m i e n to"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_56 from statictext within w_carta_efectos_vencidos
integer x = 1970
integer y = 144
integer width = 338
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
string text = "F. C a r t a"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_carta_efectos_vencidos
boolean visible = false
integer x = 503
integer y = 68
integer width = 416
integer height = 260
boolean bringtotop = true
string dataobject = "report_carta_efectos_vencidos_castellano"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type st_2 from statictext within w_carta_efectos_vencidos
integer x = 14
integer y = 1908
integer width = 384
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Texto Carta:"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type texto from singlelineedit within w_carta_efectos_vencidos
integer x = 398
integer y = 1908
integer width = 2464
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

