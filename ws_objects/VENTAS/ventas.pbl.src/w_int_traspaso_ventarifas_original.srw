$PBExportHeader$w_int_traspaso_ventarifas_original.srw
$PBExportComments$Transpaso de una tarifa a otra aplicanco un cambio.
forward
global type w_int_traspaso_ventarifas_original from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_traspaso_ventarifas_original
end type
type st_2 from statictext within w_int_traspaso_ventarifas_original
end type
type em_tarifa from u_em_campo within w_int_traspaso_ventarifas_original
end type
type st_nombre_tarifa from statictext within w_int_traspaso_ventarifas_original
end type
type dw_fechas from datawindow within w_int_traspaso_ventarifas_original
end type
type st_3 from statictext within w_int_traspaso_ventarifas_original
end type
type sle_moneda from singlelineedit within w_int_traspaso_ventarifas_original
end type
type gb_10 from groupbox within w_int_traspaso_ventarifas_original
end type
type gb_3 from groupbox within w_int_traspaso_ventarifas_original
end type
type gb_1 from groupbox within w_int_traspaso_ventarifas_original
end type
type em_tarifa_destino from u_em_campo within w_int_traspaso_ventarifas_original
end type
type dw_fechas_destino from datawindow within w_int_traspaso_ventarifas_original
end type
type st_5 from statictext within w_int_traspaso_ventarifas_original
end type
type sle_moneda_destino from singlelineedit within w_int_traspaso_ventarifas_original
end type
type st_4 from statictext within w_int_traspaso_ventarifas_original
end type
type rb_descendente from radiobutton within w_int_traspaso_ventarifas_original
end type
type rb_ascendente from radiobutton within w_int_traspaso_ventarifas_original
end type
type rb_lineal from radiobutton within w_int_traspaso_ventarifas_original
end type
type rb_porcentual from radiobutton within w_int_traspaso_ventarifas_original
end type
type st_texto from statictext within w_int_traspaso_ventarifas_original
end type
type em_cantidad from u_em_campo within w_int_traspaso_ventarifas_original
end type
type cb_1 from u_boton within w_int_traspaso_ventarifas_original
end type
type dw_proceso from datawindow within w_int_traspaso_ventarifas_original
end type
type rb_cambio from radiobutton within w_int_traspaso_ventarifas_original
end type
type pb_2 from upb_carpeta within w_int_traspaso_ventarifas_original
end type
type gb_2 from groupbox within w_int_traspaso_ventarifas_original
end type
type st_nombre_tarifa_destino from statictext within w_int_traspaso_ventarifas_original
end type
type dw_proceso2 from datawindow within w_int_traspaso_ventarifas_original
end type
end forward

global type w_int_traspaso_ventarifas_original from w_int_con_empresa
integer width = 2917
integer height = 1528
pb_1 pb_1
st_2 st_2
em_tarifa em_tarifa
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
st_3 st_3
sle_moneda sle_moneda
gb_10 gb_10
gb_3 gb_3
gb_1 gb_1
em_tarifa_destino em_tarifa_destino
dw_fechas_destino dw_fechas_destino
st_5 st_5
sle_moneda_destino sle_moneda_destino
st_4 st_4
rb_descendente rb_descendente
rb_ascendente rb_ascendente
rb_lineal rb_lineal
rb_porcentual rb_porcentual
st_texto st_texto
em_cantidad em_cantidad
cb_1 cb_1
dw_proceso dw_proceso
rb_cambio rb_cambio
pb_2 pb_2
gb_2 gb_2
st_nombre_tarifa_destino st_nombre_tarifa_destino
dw_proceso2 dw_proceso2
end type
global w_int_traspaso_ventarifas_original w_int_traspaso_ventarifas_original

type variables
String var_incremento,var_tipo

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Traspaso de tarifas"
This.title=istr_parametros.s_titulo_ventana
dw_fechas.SetTransObject(SQLCA)
dw_fechas_destino.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_fechas.SetRowFocusIndicator(Hand!)
dw_fechas_destino.SetRowFocusIndicator(Hand!)
var_incremento = "A"
var_tipo       = "L"


end event

on w_int_traspaso_ventarifas_original.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.st_3=create st_3
this.sle_moneda=create sle_moneda
this.gb_10=create gb_10
this.gb_3=create gb_3
this.gb_1=create gb_1
this.em_tarifa_destino=create em_tarifa_destino
this.dw_fechas_destino=create dw_fechas_destino
this.st_5=create st_5
this.sle_moneda_destino=create sle_moneda_destino
this.st_4=create st_4
this.rb_descendente=create rb_descendente
this.rb_ascendente=create rb_ascendente
this.rb_lineal=create rb_lineal
this.rb_porcentual=create rb_porcentual
this.st_texto=create st_texto
this.em_cantidad=create em_cantidad
this.cb_1=create cb_1
this.dw_proceso=create dw_proceso
this.rb_cambio=create rb_cambio
this.pb_2=create pb_2
this.gb_2=create gb_2
this.st_nombre_tarifa_destino=create st_nombre_tarifa_destino
this.dw_proceso2=create dw_proceso2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_tarifa
this.Control[iCurrent+4]=this.st_nombre_tarifa
this.Control[iCurrent+5]=this.dw_fechas
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_moneda
this.Control[iCurrent+8]=this.gb_10
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.em_tarifa_destino
this.Control[iCurrent+12]=this.dw_fechas_destino
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.sle_moneda_destino
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.rb_descendente
this.Control[iCurrent+17]=this.rb_ascendente
this.Control[iCurrent+18]=this.rb_lineal
this.Control[iCurrent+19]=this.rb_porcentual
this.Control[iCurrent+20]=this.st_texto
this.Control[iCurrent+21]=this.em_cantidad
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.dw_proceso
this.Control[iCurrent+24]=this.rb_cambio
this.Control[iCurrent+25]=this.pb_2
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.st_nombre_tarifa_destino
this.Control[iCurrent+28]=this.dw_proceso2
end on

on w_int_traspaso_ventarifas_original.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.st_3)
destroy(this.sle_moneda)
destroy(this.gb_10)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.em_tarifa_destino)
destroy(this.dw_fechas_destino)
destroy(this.st_5)
destroy(this.sle_moneda_destino)
destroy(this.st_4)
destroy(this.rb_descendente)
destroy(this.rb_ascendente)
destroy(this.rb_lineal)
destroy(this.rb_porcentual)
destroy(this.st_texto)
destroy(this.em_cantidad)
destroy(this.cb_1)
destroy(this.dw_proceso)
destroy(this.rb_cambio)
destroy(this.pb_2)
destroy(this.gb_2)
destroy(this.st_nombre_tarifa_destino)
destroy(this.dw_proceso2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_traspaso_ventarifas_original
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_traspaso_ventarifas_original
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_traspaso_ventarifas_original
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_traspaso_ventarifas_original
integer x = 2693
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_int_traspaso_ventarifas_original
integer x = 133
integer y = 260
integer width = 256
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within w_int_traspaso_ventarifas_original
integer x = 421
integer y = 256
integer width = 261
integer height = 92
integer taborder = 10
end type

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF
dw_fechas.retrieve(codigo_empresa,em_tarifa.text)   
sle_moneda.text = f_nombre_moneda_abr(f_moneda_ventarifas(codigo_empresa,em_tarifa.text))



 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

type st_nombre_tarifa from statictext within w_int_traspaso_ventarifas_original
integer x = 741
integer y = 264
integer width = 882
integer height = 176
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_fechas from datawindow within w_int_traspaso_ventarifas_original
integer x = 1637
integer y = 244
integer width = 622
integer height = 216
boolean bringtotop = true
string dataobject = "dw_traspaso_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!
end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type st_3 from statictext within w_int_traspaso_ventarifas_original
integer x = 128
integer y = 356
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Moneda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_moneda from singlelineedit within w_int_traspaso_ventarifas_original
integer x = 421
integer y = 360
integer width = 270
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
end type

type gb_10 from groupbox within w_int_traspaso_ventarifas_original
integer x = 946
integer y = 980
integer width = 576
integer height = 300
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo"
end type

type gb_3 from groupbox within w_int_traspaso_ventarifas_original
integer x = 123
integer y = 980
integer width = 786
integer height = 300
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Incremento"
end type

type gb_1 from groupbox within w_int_traspaso_ventarifas_original
integer x = 114
integer y = 136
integer width = 2226
integer height = 400
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Tarifa Origen"
end type

type em_tarifa_destino from u_em_campo within w_int_traspaso_ventarifas_original
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 421
integer y = 676
integer taborder = 70
end type

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

event modificado;call super::modificado;st_nombre_tarifa_destino.text=f_nombre_ventarifa(codigo_empresa,em_tarifa_destino.text)
IF Trim(st_nombre_tarifa_destino.text)="" THEN 
 IF Trim(em_tarifa_destino.text)<>"" Then  f_activar_campo(em_tarifa_destino)
 em_tarifa_destino.text=""
END IF
dw_fechas_destino.retrieve(codigo_empresa,em_tarifa_destino.text)   
sle_moneda_destino.text = f_nombre_moneda_abr(f_moneda_ventarifas(codigo_empresa,em_tarifa_destino.text))



 



end event

type dw_fechas_destino from datawindow within w_int_traspaso_ventarifas_original
integer x = 1637
integer y = 664
integer width = 622
integer height = 216
boolean bringtotop = true
string dataobject = "dw_traspaso_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!
end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type st_5 from statictext within w_int_traspaso_ventarifas_original
integer x = 128
integer y = 776
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Moneda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_moneda_destino from singlelineedit within w_int_traspaso_ventarifas_original
integer x = 421
integer y = 780
integer width = 270
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
end type

type st_4 from statictext within w_int_traspaso_ventarifas_original
integer x = 133
integer y = 680
integer width = 256
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_descendente from radiobutton within w_int_traspaso_ventarifas_original
integer x = 210
integer y = 1168
integer width = 503
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Descendente"
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "D"
rb_ascendente.Checked = False
rb_descendente.Checked = True
end event

type rb_ascendente from radiobutton within w_int_traspaso_ventarifas_original
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 210
integer y = 1076
integer width = 434
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ascendente"
boolean checked = true
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "A"
rb_ascendente.Checked = True
rb_descendente.Checked = False
end event

type rb_lineal from radiobutton within w_int_traspaso_ventarifas_original
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 1001
integer y = 1072
integer width = 315
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lineal"
boolean checked = true
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "D"
rb_lineal.Checked = True
rb_porcentual.Checked = False
end event

type rb_porcentual from radiobutton within w_int_traspaso_ventarifas_original
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 1006
integer y = 1160
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Porcentual"
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "A"
rb_lineal.Checked = False
rb_porcentual.Checked = TRUE
end event

type st_texto from statictext within w_int_traspaso_ventarifas_original
integer x = 1568
integer y = 1100
integer width = 645
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad Incremento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_traspaso_ventarifas_original
integer x = 1568
integer y = 1184
integer width = 645
integer taborder = 0
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##0"
end type

type cb_1 from u_boton within w_int_traspaso_ventarifas_original
integer x = 2263
integer y = 1108
integer width = 489
integer height = 152
integer taborder = 0
string text = "&Procesar"
end type

event clicked;DateTime fecha_origen,fecha_destino,venfalta,venfecha   
String   tarifa_origen, tarifa_destino
Integer  registro,registros,numero
String   venempresa,ventarifa,venarticulo,vencalidad,venmontajeartcal
String   venfamilia,venformato,venmodelo,venactivo,venlistar,venusuario
String   vendescripcion,venexcepcion,ventipo_linea,var_moneda
Dec{10}  venprecio   , incremento
Integer bien

IF Trim(em_tarifa.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca la tarifa origen")
	f_activar_campo(em_tarifa)
	Return
END IF

IF Trim(em_cantidad.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca el incremento")
	f_activar_campo(em_cantidad)
	Return
END IF

IF Trim(em_tarifa_destino.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca la tarifa destino")
	f_activar_campo(em_tarifa_destino)
	Return
END IF
var_moneda = f_moneda_ventarifas(codigo_empresa,em_tarifa_destino.text)
IF (Dec(em_cantidad.text)= 0 or IsNull(em_cantidad.text)) and var_incremento="C"  Then
		f_mensaje("Campo Obligatorio","El cambio no puede ser 0 ")
		f_activar_campo(em_cantidad)
		Return
END IF

if rb_cambio.checked = TRUE Then
    var_incremento = "C"
  else	
    if rb_ascendente.checked = TRUE then
	    var_incremento = "A"
     else
	    var_incremento = "D"
    End if
End if

if rb_lineal.checked = TRUE Then
   var_tipo = "L"
  Else 
   var_tipo = "P"
End if

bien = 0

fecha_origen  = dw_fechas.GetItemDateTime(dw_fechas.GetRow(),"fecha")
fecha_destino = dw_fechas_destino.GetItemDateTime(dw_fechas_destino.GetRow(),"fecha")

tarifa_origen = em_tarifa.text
tarifa_destino= em_tarifa_destino.text


Select count(*) Into :numero From venlintarifas
Where  venlintarifas.empresa = :codigo_empresa
And    venlintarifas.tarifa  = :tarifa_destino
And    venlintarifas.fecha   = :fecha_destino;
IF ISNull(numero) Then numero=0

IF numero <>0 THEN
 MessageBox("Tarifa ya generada","Esta tarifa ya existe",Exclamation!, OK!,1)
 f_activar_campo(em_tarifa_destino)
Return
END IF

//w_int_traspaso_ventarifas.enabled = FALSE


registros = dw_proceso2.Retrieve(codigo_empresa,tarifa_origen,fecha_origen)
For registro = 1 To registros
   venempresa  = codigo_empresa
   ventarifa   = tarifa_destino
   venfecha    = fecha_destino
	venfamilia  = dw_proceso2.GetItemString(registro,"familia")
   venformato  = dw_proceso2.GetItemString(registro,"formato")
   vencalidad  = dw_proceso2.GetItemString(registro,"calidad")
   venprecio   = dw_proceso2.GetItemNumber(registro,"precio")
	IF var_incremento = "C" Then
			   venprecio = venprecio / Dec(em_cantidad.text)
			ELSE
				If var_tipo = "L" Then incremento = Dec(em_cantidad.text)
	  			If var_tipo = "P" Then incremento = (venprecio * Dec(em_cantidad.text))/100
         	IF var_incremento = "D" Then incremento = incremento  * (-1)
				venprecio = venprecio + incremento
    		END IF
			venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
	  INSERT INTO ventarfamfor  
         ( empresa,tarifa,fecha,familia,formato,calidad,precio)  
  VALUES ( :venempresa,:ventarifa,:venfecha,:venfamilia,   
           :venformato,:vencalidad,:venprecio )  ;

Next



registros = dw_proceso.Retrieve(codigo_empresa,tarifa_origen,fecha_origen)
For registro = 1 To registros
         venempresa  = codigo_empresa
         ventarifa   = tarifa_destino
         venfecha    = fecha_destino
         venarticulo = dw_proceso.GetItemString(registro,"articulo")
         vencalidad  = dw_proceso.GetItemString(registro,"calidad")
         venprecio   = dw_proceso.GetItemNumber(registro,"precio")
         venfalta    = DateTime(Today())
         venmontajeartcal = dw_proceso.GetItemString(registro,"montajeartcal")
         venfamilia       = dw_proceso.GetItemString(registro,"familia")
         venformato       = dw_proceso.GetItemString(registro,"formato")
         venmodelo        = dw_proceso.GetItemString(registro,"modelo")
         venactivo        = dw_proceso.GetItemString(registro,"activo")
         venlistar        = dw_proceso.GetItemString(registro,"listar")
         venusuario       = nombre_usuario
         vendescripcion   = dw_proceso.GetItemString(registro,"descripcion")
         venexcepcion     = dw_proceso.GetItemString(registro,"excepcion")
         ventipo_linea    = dw_proceso.GetItemString(registro,"tipo_linea")
			IF var_incremento = "C" Then
			 venprecio = venprecio / Dec(em_cantidad.text)
			ELSE
				If var_tipo = "L" Then incremento = Dec(em_cantidad.text)
	  			If var_tipo = "P" Then incremento = (venprecio * Dec(em_cantidad.text))/100
			   IF var_incremento = "D" Then incremento = incremento  * (-1)
				venprecio = venprecio + incremento
    		END IF
			venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
         
	
	INSERT INTO venlintarifas  
   (empresa,tarifa,fecha,articulo,calidad,precio,falta,montajeartcal,
	 familia,formato,modelo,activo,listar,usuario,descripcion,excepcion,   
    tipo_linea )  
  VALUES (:venempresa,:ventarifa,:venfecha,:venarticulo,:vencalidad,   
          :venprecio, :venfalta, :venmontajeartcal,:venfamilia,:venformato,:venmodelo,   
          :venactivo,:venlistar,:venusuario,:vendescripcion,:venexcepcion,:ventipo_linea);
			 IF Sqlca.SqlCode<> 0 Then bien = 1
		    f_contador_procesos(registro,registros)
Next	
  UPDATE venmapatarifas  
     SET tarifa_origen = :tarifa_origen,   
         fecha_origen  = :fecha_origen  
   WHERE ( venmapatarifas.empresa  = :codigo_empresa ) AND  
         ( venmapatarifas.tarifa   = :tarifa_destino ) AND  
         ( venmapatarifas.fecha    = :fecha_destino )   ;

IF bien = 0 Then
   COMMIT;
	f_mensaje("Proceso Finalizado","Proceso finalizado correctamente")
ELSE
	ROLLBACK;
	f_mensaje("ERROR!! en proceso ","Proceso finalizado con problemas")
END IF
//w_int_traspaso_ventarifas.enabled = TRUE
end event

type dw_proceso from datawindow within w_int_traspaso_ventarifas_original
boolean visible = false
integer width = 494
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_proceso_venlintarifas"
boolean livescroll = true
end type

type rb_cambio from radiobutton within w_int_traspaso_ventarifas_original
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 1568
integer y = 1012
integer width = 631
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Aplicar cambio"
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "C"
IF This.Checked = True Then
	rb_cambio.Checked      = False
Else
	rb_cambio.Checked      = True
End if

st_texto.text  = "Cambio tarifa destino"
st_texto.text  = "Cantidad Incremento"

end event

type pb_2 from upb_carpeta within w_int_traspaso_ventarifas_original
integer x = 686
integer y = 676
integer width = 110
integer height = 96
integer taborder = 0
end type

event clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

 lstr_param.s_argumentos[2]=em_tarifa_destino.text
 f_activar_campo(em_tarifa_destino)
 OpenWithParm(wi_mant_ventarifas,lstr_param)



end event

type gb_2 from groupbox within w_int_traspaso_ventarifas_original
integer x = 119
integer y = 556
integer width = 2235
integer height = 400
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Tarifa Destino"
end type

type st_nombre_tarifa_destino from statictext within w_int_traspaso_ventarifas_original
integer x = 741
integer y = 688
integer width = 882
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_proceso2 from datawindow within w_int_traspaso_ventarifas_original
boolean visible = false
integer x = 535
integer width = 494
integer height = 80
integer taborder = 1
boolean bringtotop = true
string dataobject = "dw_proceso_ventarfamfor"
boolean livescroll = true
end type

