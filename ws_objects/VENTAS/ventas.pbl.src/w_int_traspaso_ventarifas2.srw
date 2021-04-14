$PBExportHeader$w_int_traspaso_ventarifas2.srw
$PBExportComments$Traspaso incremento de tarifa por familia,formato.
forward
global type w_int_traspaso_ventarifas2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_traspaso_ventarifas2
end type
type st_2 from statictext within w_int_traspaso_ventarifas2
end type
type em_tarifa from u_em_campo within w_int_traspaso_ventarifas2
end type
type st_nombre_tarifa from statictext within w_int_traspaso_ventarifas2
end type
type dw_fechas from datawindow within w_int_traspaso_ventarifas2
end type
type st_3 from statictext within w_int_traspaso_ventarifas2
end type
type sle_moneda from singlelineedit within w_int_traspaso_ventarifas2
end type
type gb_1 from groupbox within w_int_traspaso_ventarifas2
end type
type sle_moneda_destino from singlelineedit within w_int_traspaso_ventarifas2
end type
type dw_proceso from datawindow within w_int_traspaso_ventarifas2
end type
type dw_proceso3 from datawindow within w_int_traspaso_ventarifas2
end type
type cb_continuar from u_boton within w_int_traspaso_ventarifas2
end type
type st_nombre_tarifa_destino from statictext within w_int_traspaso_ventarifas2
end type
type em_tarifa_destino from u_em_campo within w_int_traspaso_ventarifas2
end type
type st_4 from statictext within w_int_traspaso_ventarifas2
end type
type st_5 from statictext within w_int_traspaso_ventarifas2
end type
type pb_2 from upb_carpeta within w_int_traspaso_ventarifas2
end type
type gb_2 from groupbox within w_int_traspaso_ventarifas2
end type
type dw_fechas_destino from datawindow within w_int_traspaso_ventarifas2
end type
type dw_proceso4 from datawindow within w_int_traspaso_ventarifas2
end type
type dw_detalle from u_datawindow_consultas within w_int_traspaso_ventarifas2
end type
end forward

global type w_int_traspaso_ventarifas2 from w_int_con_empresa
boolean visible = false
integer width = 2889
integer height = 1688
pb_1 pb_1
st_2 st_2
em_tarifa em_tarifa
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
st_3 st_3
sle_moneda sle_moneda
gb_1 gb_1
sle_moneda_destino sle_moneda_destino
dw_proceso dw_proceso
dw_proceso3 dw_proceso3
cb_continuar cb_continuar
st_nombre_tarifa_destino st_nombre_tarifa_destino
em_tarifa_destino em_tarifa_destino
st_4 st_4
st_5 st_5
pb_2 pb_2
gb_2 gb_2
dw_fechas_destino dw_fechas_destino
dw_proceso4 dw_proceso4
dw_detalle dw_detalle
end type
global w_int_traspaso_ventarifas2 w_int_traspaso_ventarifas2

type variables
String var_moneda

end variables

forward prototypes
private subroutine f_mapa (string empresa, string tarifa, datetime fecha, string familia, string formato, string calidad, decimal precio)
end prototypes

private subroutine f_mapa (string empresa, string tarifa, datetime fecha, string familia, string formato, string calidad, decimal precio);Dec{0} numero 
  SELECT Count(*)  
    INTO :numero  
    FROM ventarfamfor  
   WHERE ( ventarfamfor.empresa = :empresa ) AND  
         ( ventarfamfor.tarifa = :tarifa ) AND  
         ( ventarfamfor.fecha = :fecha ) AND  
         ( ventarfamfor.familia = :familia ) AND  
         ( ventarfamfor.formato = :formato ) AND  
         ( ventarfamfor.calidad = :calidad )   ;
			iF IsNull(numero) Then numero = 0
			
			IF numero = 0 Then
				  INSERT INTO ventarfamfor  
         ( empresa,   
           tarifa,   
           fecha,   
           familia,   
           formato,   
           calidad,   
           precio )  
  VALUES ( :empresa,   
           :tarifa,   
           :fecha,   
           :familia,   
           :formato,   
           :calidad,   
           :precio )  ;

			END IF

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Traspaso de tarifas"
This.title=istr_parametros.s_titulo_ventana
dw_fechas.SetTransObject(SQLCA)
dw_fechas_destino.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_proceso3.SetTransObject(SQLCA)
dw_proceso4.SetTransObject(SQLCA)
dw_fechas.SetRowFocusIndicator(Hand!)
dw_fechas_destino.SetRowFocusIndicator(Hand!)
f_mascara_columna(dw_detalle,"incremento_metros",f_mascara_decimales(3))
f_mascara_columna(dw_detalle,"incremento_unidades",f_mascara_decimales(3))
f_mascara_columna(dw_detalle,"incremento_decorado",f_mascara_decimales(3))

end event

on w_int_traspaso_ventarifas2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.st_3=create st_3
this.sle_moneda=create sle_moneda
this.gb_1=create gb_1
this.sle_moneda_destino=create sle_moneda_destino
this.dw_proceso=create dw_proceso
this.dw_proceso3=create dw_proceso3
this.cb_continuar=create cb_continuar
this.st_nombre_tarifa_destino=create st_nombre_tarifa_destino
this.em_tarifa_destino=create em_tarifa_destino
this.st_4=create st_4
this.st_5=create st_5
this.pb_2=create pb_2
this.gb_2=create gb_2
this.dw_fechas_destino=create dw_fechas_destino
this.dw_proceso4=create dw_proceso4
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_tarifa
this.Control[iCurrent+4]=this.st_nombre_tarifa
this.Control[iCurrent+5]=this.dw_fechas
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_moneda
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.sle_moneda_destino
this.Control[iCurrent+10]=this.dw_proceso
this.Control[iCurrent+11]=this.dw_proceso3
this.Control[iCurrent+12]=this.cb_continuar
this.Control[iCurrent+13]=this.st_nombre_tarifa_destino
this.Control[iCurrent+14]=this.em_tarifa_destino
this.Control[iCurrent+15]=this.st_4
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.pb_2
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.dw_fechas_destino
this.Control[iCurrent+20]=this.dw_proceso4
this.Control[iCurrent+21]=this.dw_detalle
end on

on w_int_traspaso_ventarifas2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.st_3)
destroy(this.sle_moneda)
destroy(this.gb_1)
destroy(this.sle_moneda_destino)
destroy(this.dw_proceso)
destroy(this.dw_proceso3)
destroy(this.cb_continuar)
destroy(this.st_nombre_tarifa_destino)
destroy(this.em_tarifa_destino)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.pb_2)
destroy(this.gb_2)
destroy(this.dw_fechas_destino)
destroy(this.dw_proceso4)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_traspaso_ventarifas2
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_traspaso_ventarifas2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_traspaso_ventarifas2
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_traspaso_ventarifas2
integer x = 2665
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_int_traspaso_ventarifas2
integer x = 64
integer y = 188
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

type em_tarifa from u_em_campo within w_int_traspaso_ventarifas2
integer x = 352
integer y = 184
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

type st_nombre_tarifa from statictext within w_int_traspaso_ventarifas2
integer x = 672
integer y = 192
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

type dw_fechas from datawindow within w_int_traspaso_ventarifas2
integer x = 1568
integer y = 172
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

type st_3 from statictext within w_int_traspaso_ventarifas2
integer x = 59
integer y = 284
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

type sle_moneda from singlelineedit within w_int_traspaso_ventarifas2
integer x = 352
integer y = 288
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

type gb_1 from groupbox within w_int_traspaso_ventarifas2
integer x = 14
integer y = 116
integer width = 2226
integer height = 296
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Tarifa Origen"
end type

type sle_moneda_destino from singlelineedit within w_int_traspaso_ventarifas2
integer x = 347
integer y = 576
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

type dw_proceso from datawindow within w_int_traspaso_ventarifas2
boolean visible = false
integer width = 480
integer height = 104
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_proceso_venlintarifas"
boolean livescroll = true
end type

type dw_proceso3 from datawindow within w_int_traspaso_ventarifas2
boolean visible = false
integer x = 485
integer width = 818
integer height = 108
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_traspaso_tarifas2"
boolean livescroll = true
end type

type cb_continuar from u_boton within w_int_traspaso_ventarifas2
event clicked pbm_bnclicked
integer x = 2286
integer y = 508
integer height = 92
integer taborder = 0
string text = "&Continuar"
end type

event clicked;call super::clicked;  Integer x2,registros2,registros,x1,contando
  String   var_formato,var_calidad,var_familia,tarifa_origen,tarifa_destino
  Dec{4}   var_precioventa,numero
  DateTime fecha_origen,fecha_destino
  dw_detalle.Reset()
IF Trim(em_tarifa.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca la tarifa origen")
	f_activar_campo(em_tarifa)
	Return
END IF


IF Trim(em_tarifa_destino.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca la tarifa destino")
	f_activar_campo(em_tarifa_destino)
	Return
END IF


IF Trim(sle_moneda.text) <> Trim(sle_moneda_destino.text)  Then 
	f_mensaje("Error en Introduccion datos","Las tarifas deben de ser a una unica moneda")
	f_activar_campo(em_tarifa_destino)
	Return
END IF
var_moneda = f_moneda_ventarifas(codigo_empresa,em_tarifa_destino.text)


fecha_origen  = dw_fechas.GetItemDateTime(dw_fechas.GetRow(),"fecha")
fecha_destino  = dw_fechas_destino.GetItemDateTime(dw_fechas_destino.GetRow(),"fecha")

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

IF    dw_proceso3.retrieve(codigo_empresa,tarifa_origen,fecha_origen) <> 0 Then
registros2 = dw_proceso3.RowCount()
dw_fechas.enabled            = FALSE
dw_fechas_destino.enabled    = FALSE
em_tarifa.enabled            = FALSE
em_tarifa_destino.enabled    = FALSE




  dw_detalle.visible = False
  FOR x2 = 1 To registros2
     var_formato  =     dw_proceso3.GetItemString(x2,"formato")
     var_familia  =     dw_proceso3.GetItemString(x2,"familia")
     contando = contando + 1
     dw_detalle.InsertRow(contando)
     dw_detalle.SetItem(contando,"familia",f_nombre_familia(codigo_empresa,var_familia))
     dw_detalle.SetItem(contando,"formato",f_nombre_formato(codigo_empresa,var_formato))
     dw_detalle.SetItem(contando,"cod_familia",var_familia)
     dw_detalle.SetItem(contando,"cod_formato",var_formato)
     dw_detalle.SetItem(contando,"incremento_metros",0)
	  dw_detalle.SetItem(contando,"incremento_unidades",0)
	  dw_detalle.SetItem(contando,"incremento_decorado",0)
	  dw_detalle.SetItem(contando,"tipo1","L")
	  dw_detalle.SetItem(contando,"tipo2","L")
	  
     f_contador_procesos(x2,registros2)
  NEXT
  IF dw_detalle.RowCount() = 0 Then return
  dw_detalle.SetSort("")
  dw_detalle.SetSort("familia,formato")
  dw_detalle.Sort()
  dw_detalle.visible   = TRUE
  dw_detalle.SetColumn("incremento_metros")
  dw_detalle.SetFocus()
  dw_detalle.SetRow(1)
  
END IF
end event

type st_nombre_tarifa_destino from statictext within w_int_traspaso_ventarifas2
integer x = 722
integer y = 476
integer width = 841
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

type em_tarifa_destino from u_em_campo within w_int_traspaso_ventarifas2
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 343
integer y = 472
integer taborder = 90
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

type st_4 from statictext within w_int_traspaso_ventarifas2
integer x = 69
integer y = 484
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

type st_5 from statictext within w_int_traspaso_ventarifas2
integer x = 64
integer y = 572
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

type pb_2 from upb_carpeta within w_int_traspaso_ventarifas2
integer x = 603
integer y = 472
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

 lstr_param.s_argumentos[2]=em_tarifa_destino.text
 f_activar_campo(em_tarifa_destino)
 OpenWithParm(wi_mant_ventarifas,lstr_param)
 

end event

type gb_2 from groupbox within w_int_traspaso_ventarifas2
integer x = 14
integer y = 400
integer width = 2235
integer height = 288
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Tarifa Destino"
end type

type dw_fechas_destino from datawindow within w_int_traspaso_ventarifas2
integer x = 1573
integer y = 460
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

type dw_proceso4 from datawindow within w_int_traspaso_ventarifas2
boolean visible = false
integer x = 1339
integer width = 818
integer height = 108
integer taborder = 51
boolean bringtotop = true
string dataobject = "dw_proceso_traspaso_tarifas2_1"
boolean livescroll = true
end type

type dw_detalle from u_datawindow_consultas within w_int_traspaso_ventarifas2
event key pbm_dwnkey
boolean visible = false
integer x = 37
integer y = 704
integer width = 2674
integer height = 736
integer taborder = 20
string dataobject = "dw_traspaso_ventarifas2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;call super::key;String var_valor,var
var_valor = "S" 
IF key = KeyF5! Then 
	var = This.GetItemString(This.GetRow(),"revisado")
	IF var = "S" Then var_valor = "N"
	This.SetItem(This.GetRow(),"revisado",var_valor)
END IF
	
end event

event clicked;call super::clicked;Dec{4} elemento,reg4,registro4
String var_tipo,v_tipo
Dec{4} v_precio,v_incremento
AcceptText()



IF f_objeto_datawindow(This)= "procesar" Then
 DateTime fecha_origen,fecha_destino,venfalta,venfecha   
 String   tarifa_origen, tarifa_destino
 Integer  registro,registros,numero
 String   venempresa,ventarifa,venarticulo,vencalidad,venmontajeartcal
 String   venfamilia,venformato,venmodelo,venactivo,venlistar,venusuario
 String   vendescripcion,venexcepcion,ventipo_linea
 Dec{10}  venprecio   , incremento
 Integer bien
 bien = 0
 fecha_origen  = dw_fechas.GetItemDateTime(dw_fechas.GetRow(),"fecha")
 fecha_destino  = dw_fechas_destino.GetItemDateTime(dw_fechas_destino.GetRow(),"fecha")

 tarifa_origen = em_tarifa.text
 tarifa_destino= em_tarifa_destino.text

 w_int_traspaso_ventarifas2.enabled = FALSE
 
 //-----------//
 // procesando//
 //-----------//
 
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
			elemento =dw_detalle.Find("cod_familia='"+venfamilia+"' and cod_formato='"+venformato+"'",1,RowCount())
			IF IsNull(elemento) then elemento = 0
			If elemento = 0 Then
				incremento= 0
			Else
			 IF f_tipo_unidad_familia(codigo_empresa,venfamilia) = "0" Then
				v_tipo= f_valor_columna(This,elemento,"tipo1")
			   v_incremento = Dec(f_valor_columna(This,elemento,"incremento_unidades"))
			 ELSE
				v_tipo= f_valor_columna(This,elemento,"tipo2")
				v_incremento = Dec(f_valor_columna(This,elemento,"incremento_metros"))
			 END IF
			 IF f_unidad_articulo(codigo_empresa,venarticulo) = "0" Then
				var_tipo= f_valor_columna(This,elemento,"tipo1")
				incremento = Dec(f_valor_columna(This,elemento,"incremento_unidades"))
			 ELSE
				var_tipo= f_valor_columna(This,elemento,"tipo2")
				incremento = Dec(f_valor_columna(This,elemento,"incremento_metros"))
			 END IF
  		   END IF
			  
			  
			IF var_tipo = "L" Then
				venprecio = venprecio + incremento
			END IF
			IF var_tipo = "P"	Then
				venprecio = venprecio + (venprecio*incremento/100)
			END IF
			IF var_tipo = "F"	Then
				venprecio = incremento
			END IF
			
			
			IF v_tipo = "L" Then
				v_precio = venprecio + incremento
			END IF
			IF v_tipo = "P" Then
				v_precio = venprecio + (venprecio*incremento/100)
			END IF
			IF v_tipo = "F" Then
				v_precio = incremento
			END IF
			
			venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
			v_precio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
         	Select count(*) Into :numero From venlintarifas
			Where  venlintarifas.empresa   = :venempresa
			And    venlintarifas.tarifa    = :ventarifa
			And    venlintarifas.fecha     = :venfecha
			And    venlintarifas.articulo  = :venarticulo
			And    venlintarifas.calidad   = :vencalidad;
			IF Isnull(numero) Then numero = 0
		IF numero = 0 Then
	f_mapa(venempresa,ventarifa,venfecha,venfamilia,venformato,vencalidad,v_precio)		
	INSERT INTO venlintarifas  
   (empresa,tarifa,fecha,articulo,calidad,precio,falta,montajeartcal,
	 familia,formato,modelo,activo,listar,usuario,descripcion,excepcion,   
    tipo_linea )  
  VALUES (:venempresa,:ventarifa,:venfecha,:venarticulo,:vencalidad,   
          :venprecio, :venfalta, :venmontajeartcal,:venfamilia,:venformato,:venmodelo,   
          :venactivo,:venlistar,:venusuario,:vendescripcion,:venexcepcion,:ventipo_linea);
			 IF Sqlca.SqlCode<> 0 Then 
				bien = 1
			END IF
		END IF
		    f_contador_procesos(registro,registros)
		
reg4 =dw_proceso4.Retrieve(codigo_empresa,venarticulo,tarifa_origen,fecha_origen)
IF reg4<>0 Then
	For registro4 = 1 To reg4
         venarticulo = dw_proceso4.GetItemString(registro4,"decorado")
         vencalidad  = dw_proceso4.GetItemString(registro4,"venlintarifas_calidad")
         venprecio   = dw_proceso4.GetItemNumber(registro4,"venlintarifas_precio")
         venfalta    = DateTime(Today())
         venmontajeartcal = dw_proceso4.GetItemString(registro4,"venlintarifas_montajeartcal")
         venfamilia       = dw_proceso4.GetItemString(registro4,"venlintarifas_familia")
         venformato       = dw_proceso4.GetItemString(registro4,"venlintarifas_formato")
         venmodelo        = dw_proceso4.GetItemString(registro4,"venlintarifas_modelo")
         venactivo        = dw_proceso4.GetItemString(registro4,"venlintarifas_activo")
         venlistar        = dw_proceso4.GetItemString(registro4,"venlintarifas_listar")
         venusuario       = nombre_usuario
         vendescripcion   = dw_proceso4.GetItemString(registro4,"venlintarifas_descripcion")
         venexcepcion     = dw_proceso4.GetItemString(registro4,"venlintarifas_excepcion")
         ventipo_linea    = dw_proceso4.GetItemString(registro4,"venlintarifas_tipo_linea")
  		   IF f_unidad_articulo(codigo_empresa,venarticulo) = "0" Then
				var_tipo= f_valor_columna(This,elemento,"tipo1")
			   incremento = Dec(f_valor_columna(This,elemento,"incremento_unidades"))
			ELSE
				var_tipo= f_valor_columna(This,elemento,"tipo2")
			   incremento = Dec(f_valor_columna(This,elemento,"incremento_metros"))
			END IF
			IF var_tipo = "L" Then
				venprecio = venprecio + incremento
  			ELSE
				venprecio = venprecio +(venprecio*incremento/100)
			END IF
			venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
			
		Select count(*) Into :numero From venlintarifas
			Where  venlintarifas.empresa   = :venempresa
			And    venlintarifas.tarifa    = :ventarifa
			And    venlintarifas.fecha     = :venfecha
			And    venlintarifas.articulo  = :venarticulo
			And    venlintarifas.calidad   = :vencalidad;
			IF Isnull(numero) Then numero = 0
		IF numero = 0 Then
			f_mapa(venempresa,ventarifa,venfecha,venfamilia,venformato,vencalidad,venprecio)		
			INSERT INTO venlintarifas  
	   	(empresa,tarifa,fecha,articulo,calidad,precio,falta,montajeartcal,
		 	 familia,formato,modelo,activo,listar,usuario,descripcion,excepcion,   
	    	 tipo_linea )  
	  		VALUES (:venempresa,:ventarifa,:venfecha,:venarticulo,:vencalidad,   
   	   	     :venprecio, :venfalta, :venmontajeartcal,:venfamilia,:venformato,:venmodelo,   
	          	  :venactivo,:venlistar,:venusuario,:vendescripcion,:venexcepcion,:ventipo_linea);
						 IF Sqlca.SqlCode<> 0 Then
							bien = 1
						END IF
  	   END IF
	Next
END IF
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
w_int_traspaso_ventarifas2.enabled = TRUE
dw_fechas.enabled            = TRUE
dw_fechas_destino.enabled    = TRUE
em_tarifa.enabled            = TRUE
em_tarifa_destino.enabled    = TRUE
END IF
end event

