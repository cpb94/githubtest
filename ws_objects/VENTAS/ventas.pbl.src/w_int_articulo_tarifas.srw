$PBExportHeader$w_int_articulo_tarifas.srw
forward
global type w_int_articulo_tarifas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_articulo_tarifas
end type
type st_1 from statictext within w_int_articulo_tarifas
end type
type em_articulo from u_em_campo within w_int_articulo_tarifas
end type
type st_nom_articulo from statictext within w_int_articulo_tarifas
end type
type uo_1 from u_manejo_datawindow within w_int_articulo_tarifas
end type
type gb_1 from groupbox within w_int_articulo_tarifas
end type
type dw_proceso from datawindow within w_int_articulo_tarifas
end type
type dw_proceso2 from datawindow within w_int_articulo_tarifas
end type
type st_2 from statictext within w_int_articulo_tarifas
end type
type tipo from dropdownlistbox within w_int_articulo_tarifas
end type
type cb_continuar from u_boton within w_int_articulo_tarifas
end type
type uo_tipo from u_marca_lista within w_int_articulo_tarifas
end type
type cb_calidades from u_boton within w_int_articulo_tarifas
end type
type dw_procesocal from datawindow within w_int_articulo_tarifas
end type
type dw_tarifas from u_datawindow_consultas within w_int_articulo_tarifas
end type
end forward

global type w_int_articulo_tarifas from w_int_con_empresa
integer width = 2921
integer height = 1664
pb_1 pb_1
st_1 st_1
em_articulo em_articulo
st_nom_articulo st_nom_articulo
uo_1 uo_1
gb_1 gb_1
dw_proceso dw_proceso
dw_proceso2 dw_proceso2
st_2 st_2
tipo tipo
cb_continuar cb_continuar
uo_tipo uo_tipo
cb_calidades cb_calidades
dw_procesocal dw_procesocal
dw_tarifas dw_tarifas
end type
global w_int_articulo_tarifas w_int_articulo_tarifas

type variables
String var_articulo
end variables

forward prototypes
public subroutine f_proceso ()
public subroutine f_actualizar ()
end prototypes

public subroutine f_proceso ();Integer  reg,reg1,contador
Integer  rog,rog1
String   var_tarifa,var_calidad,var_formato,var_familia,var_moneda,var_nombre_moneda
DateTime var_fecha
Dec{4}   var_precio

dw_tarifas.Reset()
dw_tarifas.SetRedraw(FALSE)
var_articulo = em_articulo.text
 var_familia = f_familia_articulo(codigo_empresa,em_articulo.text)
 var_formato = f_formato_articulo(codigo_empresa,em_articulo.text)
 contador = 0
 dw_tarifas.Reset()
 
Integer numero,registros,x1,y1
String filtro1,filtro2
y1=0
filtro2 = " "
numero = uo_tipo.dw_marca.RowCount()
FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
      y1=y1+1
      IF Trim(filtro2) = "" Then
         filtro1 = " calidad = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or calidad = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro2 = filtro2  + filtro1
   END IF
NEXT


dw_proceso2.setfilter("")
dw_proceso2.filter()
dw_proceso2.setfilter(filtro2)
dw_proceso2.filter()
 
 reg = dw_proceso.Retrieve(codigo_empresa)
 rog = dw_proceso2.Retrieve(codigo_empresa,var_articulo)
 IF rog = 0 Then
	f_mensaje("Error en el alta de articulo"," Este articulo no tiene calidades definidas")
	f_activar_campo(em_articulo)
	return
 END IF
 
 IF reg <> 0 Then
	For reg1 = 1 To reg
		var_tarifa = f_valor_columna(dw_proceso,reg1,"tarifa")
		var_moneda = f_moneda_ventarifas(codigo_empresa,var_tarifa)
		var_nombre_moneda = f_nombre_moneda_abr(var_moneda)
		var_fecha  = dw_proceso.GetItemDateTime(reg1,"fecha")
		f_contador_procesos(reg1,reg)
		For rog1 = 1 To rog
			var_calidad = f_valor_columna(dw_proceso2,rog1,"calidad")
			Select precio Into :var_precio From  venlintarifas
			Where  venlintarifas.empresa   =  :codigo_empresa
			And    venlintarifas.tarifa    =  :var_tarifa
			And    venlintarifas.fecha     =  :var_fecha
			And    venlintarifas.articulo  =  :em_articulo.text
			And    venlintarifas.calidad   =  :var_calidad;
			IF SQLCA.SQLCODE = 100 Then
				contador = contador + 1
				dw_tarifas.InsertRow(contador)
				var_precio = 0
				Select precio Into :var_precio From ventarfamfor
				Where  empresa = :codigo_empresa
				And    tarifa  = :var_tarifa
				And    fecha   = :var_fecha
				And    familia = :var_familia
				And    formato = :var_formato
				ANd    calidad = :var_calidad;
				f_asignar_columna(dw_tarifas,contador,"tarifa",f_nombre_ventarifa(codigo_empresa,var_tarifa))
				f_asignar_columna(dw_tarifas,contador,"calidad",f_nombre_calidad_abr(codigo_empresa,var_calidad))
				f_asignar_columna(dw_tarifas,contador,"cod_tarifa",var_tarifa)
				f_asignar_columna(dw_tarifas,contador,"cod_calidad",var_calidad)
				f_asignar_columna(dw_tarifas,contador,"cod_moneda",var_moneda)
				f_asignar_columna(dw_tarifas,contador,"moneda",var_nombre_moneda)
				dw_tarifas.SetItem(contador,"fecha",var_fecha)
				f_asignar_columna(dw_tarifas,contador,"precio",String(var_precio))
				f_asignar_columna(dw_tarifas,contador,"precio1",String(var_precio))
			END IF
		NEXT
	Next
 END IF
 IF contador <>0 Then
	dw_tarifas.SetSort("")
	dw_tarifas.SetSort("tarifa,fecha,cod_calidad")
	dw_tarifas.Sort()
 END IF
 dw_tarifas.SetFocus()
 dw_tarifas.SetRow(1)
 dw_tarifas.SetColumn("precio")
 dw_tarifas.SelectRow(0,False)
  dw_tarifas.SelectRow(1,True)
 dw_tarifas.SetRedraw(TRUE)


end subroutine

public subroutine f_actualizar ();Integer reg,reg1
dw_tarifas.AcceptText()
String var_familia,var_formato,var_calidad,var_moneda,&
       var_tarifa,var_montajeartcal,var_modelo,   &
       var_activo,var_listar,var_usuario,var_descripcion,   &
       var_excepcion,var_tipo_linea 
Dec{4} var_precio,var_precio1
DateTime var_fecha,var_falta

reg = dw_tarifas.RowCount()
IF reg = 0 Then Return
var_familia  = f_familia_articulo(codigo_empresa,var_articulo)
var_formato  = f_formato_articulo(codigo_empresa,var_articulo)
var_modelo   = f_modelo_articulo(codigo_empresa,var_articulo)
var_descripcion = f_nombre_articulo(codigo_empresa,var_articulo)
For reg1 = 1 To reg
	var_calidad       = f_valor_columna(dw_tarifas,reg1,"cod_calidad")
	var_moneda       = f_valor_columna(dw_tarifas,reg1,"cod_moneda")
	var_montajeartcal = f_componer_artcal(var_articulo,var_calidad)
	var_tarifa        = f_valor_columna(dw_tarifas,reg1,"cod_tarifa")
	var_fecha         = dw_tarifas.GetItemDateTime(reg1,"fecha")
   var_precio        = Dec(f_valor_columna(dw_tarifas,reg1,"precio"))
	var_precio        = Dec(String(var_precio,f_mascara_moneda(var_moneda)))
   var_falta         = DateTime(Today(),Now())
	var_activo = "S"
	var_listar = "S"
   var_usuario = nombre_usuario
IF var_precio <> 0 Then
	Select precio Into :var_precio1 From ventarfamfor
	Where  empresa    =   :codigo_empresa
	And    tarifa     =   :var_tarifa
	And    fecha      =   :var_fecha
	And    familia    =   :var_familia
	And    formato    =   :var_formato
	And    calidad    =   :var_calidad;
	IF SQLCA.SQLCODE = 100 Then
		var_precio1 =  0
		INSERT INTO ventarfamfor 
				(empresa,tarifa,fecha,familia,formato,calidad,precio )  
	  VALUES (:codigo_empresa,:var_tarifa,:var_fecha,:var_familia,   
	          :var_formato,:var_calidad,:var_precio);
		
	END IF

	IF var_precio1 <> var_precio Then
		var_excepcion = "S"
	ELSE
		var_excepcion = "N"
	END IF
	var_tipo_linea = "1"
	IF tipo.text = "Modelo" 				Then	var_tipo_linea = "1"
	IF tipo.text = "Decorado" 				Then	var_tipo_linea = "2"
	IF tipo.text = "Modelo y Decorado"  Then	var_tipo_linea = "3"
	IF IsNull(var_precio) Then var_precio = 0
	
		INSERT INTO venlintarifas  
   	      ( empresa,tarifa,fecha,articulo,calidad,precio,falta,   
      	     montajeartcal,familia,formato,modelo,activo,listar,   
         	  usuario,descripcion,excepcion,tipo_linea )  
	  VALUES ( :codigo_empresa,:var_tarifa,        :var_fecha,   
   	        :var_articulo,  :var_calidad,       :var_precio,   
      	     :var_falta,     :var_montajeartcal, :var_familia,   
         	  :var_formato,   :var_modelo,        :var_activo,
				  :var_listar,    :var_usuario,       :var_descripcion,
				  :var_excepcion, :var_tipo_linea );
	END IF
COMMIT;
f_contador_procesos(reg1,reg)
NEXT	
dw_tarifas.Reset()
f_activar_campo(em_articulo)


end subroutine

event open;call super::open;Integer registros,x1
String  var_codigo,var_texto,marca
istr_parametros.s_titulo_ventana="Introducción Tarifas por articulo"
This.title=istr_parametros.s_titulo_ventana
dw_tarifas.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_procesocal.SetTransObject(SQLCA)
tipo.text = "Modelo"
f_mascara_columna(dw_tarifas,"precio","###,##0.00")
registros=dw_procesocal.retrieve(codigo_empresa)

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_procesocal.GetItemString(x1,"codigo")
  var_texto   = dw_procesocal.GetItemString(x1,"abreviado")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF

uo_tipo.st_titulo1.text="Calidad"
uo_tipo.st_titulo2.text="Resumido"




end event

on w_int_articulo_tarifas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.em_articulo=create em_articulo
this.st_nom_articulo=create st_nom_articulo
this.uo_1=create uo_1
this.gb_1=create gb_1
this.dw_proceso=create dw_proceso
this.dw_proceso2=create dw_proceso2
this.st_2=create st_2
this.tipo=create tipo
this.cb_continuar=create cb_continuar
this.uo_tipo=create uo_tipo
this.cb_calidades=create cb_calidades
this.dw_procesocal=create dw_procesocal
this.dw_tarifas=create dw_tarifas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_articulo
this.Control[iCurrent+4]=this.st_nom_articulo
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.dw_proceso
this.Control[iCurrent+8]=this.dw_proceso2
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.tipo
this.Control[iCurrent+11]=this.cb_continuar
this.Control[iCurrent+12]=this.uo_tipo
this.Control[iCurrent+13]=this.cb_calidades
this.Control[iCurrent+14]=this.dw_procesocal
this.Control[iCurrent+15]=this.dw_tarifas
end on

on w_int_articulo_tarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_articulo)
destroy(this.st_nom_articulo)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.dw_proceso)
destroy(this.dw_proceso2)
destroy(this.st_2)
destroy(this.tipo)
destroy(this.cb_continuar)
destroy(this.uo_tipo)
destroy(this.cb_calidades)
destroy(this.dw_procesocal)
destroy(this.dw_tarifas)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_tarifas)

end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_tarifas)

end event

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event ue_f2;call super::ue_f2;f_actualizar()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_articulo_tarifas
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_articulo_tarifas
integer taborder = 55
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_articulo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_articulo_tarifas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_articulo_tarifas
integer x = 2711
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_1 from statictext within w_int_articulo_tarifas
integer x = 23
integer y = 132
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_articulo from u_em_campo within w_int_articulo_tarifas
integer x = 283
integer y = 116
integer width = 562
integer height = 92
integer taborder = 40
integer textsize = -9
string facename = "Arial"
end type

event modificado;call super::modificado;dw_tarifas.reset()
st_nom_articulo.text=f_nombre_articulo(codigo_empresa,em_articulo.text)	
IF Trim(st_nom_articulo.text)="" THEN 
 IF Trim(st_nom_articulo.text)<>"" Then f_activar_campo(em_articulo)
 em_articulo.text=""
 Return
END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION ARTICULO"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = "" 		



end event

type st_nom_articulo from statictext within w_int_articulo_tarifas
integer x = 855
integer y = 128
integer width = 983
integer height = 84
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

type uo_1 from u_manejo_datawindow within w_int_articulo_tarifas
integer x = 2309
integer y = 152
integer width = 507
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_tarifas
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_articulo)
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type gb_1 from groupbox within w_int_articulo_tarifas
integer x = 2322
integer y = 152
integer width = 512
integer height = 148
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
end type

type dw_proceso from datawindow within w_int_articulo_tarifas
boolean visible = false
integer width = 494
integer height = 84
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_proceso_venmapatarifa"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_int_articulo_tarifas
boolean visible = false
integer x = 558
integer width = 494
integer height = 84
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_almartcal"
boolean livescroll = true
end type

type st_2 from statictext within w_int_articulo_tarifas
integer x = 14
integer y = 220
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Tipo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type tipo from dropdownlistbox within w_int_articulo_tarifas
integer x = 283
integer y = 216
integer width = 567
integer height = 324
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Modelo","Decorado","Modelo y Decorado"}
borderstyle borderstyle = stylelowered!
end type

type cb_continuar from u_boton within w_int_articulo_tarifas
integer x = 859
integer y = 216
integer width = 389
integer height = 80
integer taborder = 0
string text = "F5 Continuar"
end type

event clicked;call super::clicked;uo_tipo.visible = FALSE
f_proceso()

end event

type uo_tipo from u_marca_lista within w_int_articulo_tarifas
boolean visible = false
integer x = 343
integer y = 360
integer width = 1454
integer taborder = 50
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type cb_calidades from u_boton within w_int_articulo_tarifas
event clicked pbm_bnclicked
integer x = 1897
integer y = 116
integer height = 88
integer taborder = 0
string text = "&Calidades"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo.dw_marca.SetFocus()
end event

type dw_procesocal from datawindow within w_int_articulo_tarifas
boolean visible = false
integer x = 69
integer y = 4
integer width = 1371
integer height = 112
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_proceso_calidades"
boolean livescroll = true
end type

type dw_tarifas from u_datawindow_consultas within w_int_articulo_tarifas
integer x = 9
integer y = 308
integer width = 2834
integer height = 1104
integer taborder = 0
string dataobject = "dw_int_tarifas_articulo"
boolean vscrollbar = true
end type

event key;call super::key;IF Key = KeyF2! Then f_actualizar()
end event

event clicked;call super::clicked;IF f_objeto_datawindow(This) = "actualizar" Then f_actualizar()
IF row <> 0 Then
	SetRow(Row)
	SetColumn("precio")
END IF
end event

