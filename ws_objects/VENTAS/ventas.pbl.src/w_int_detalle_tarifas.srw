$PBExportHeader$w_int_detalle_tarifas.srw
forward
global type w_int_detalle_tarifas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_detalle_tarifas
end type
type st_1 from statictext within w_int_detalle_tarifas
end type
type dw_listado from datawindow within w_int_detalle_tarifas
end type
type uo_articulo from u_em_campo_2 within w_int_detalle_tarifas
end type
type st_2 from statictext within w_int_detalle_tarifas
end type
type st_nombre_tarifa from statictext within w_int_detalle_tarifas
end type
type st_3 from statictext within w_int_detalle_tarifas
end type
type em_fecha from u_em_campo within w_int_detalle_tarifas
end type
type dw_proceso1 from datawindow within w_int_detalle_tarifas
end type
type dw_proceso2 from datawindow within w_int_detalle_tarifas
end type
type uo_tarifa from u_em_campo_2 within w_int_detalle_tarifas
end type
type uo_calidad from u_em_campo_2 within w_int_detalle_tarifas
end type
type st_4 from statictext within w_int_detalle_tarifas
end type
type st_5 from statictext within w_int_detalle_tarifas
end type
type st_6 from statictext within w_int_detalle_tarifas
end type
type dw_proceso3 from datawindow within w_int_detalle_tarifas
end type
type dw_proceso4 from datawindow within w_int_detalle_tarifas
end type
type dw_tar1 from u_datawindow_consultas within w_int_detalle_tarifas
end type
type cb_continuar from u_boton within w_int_detalle_tarifas
end type
type dw_tar2 from u_datawindow_consultas within w_int_detalle_tarifas
end type
type em_precio from u_em_campo within w_int_detalle_tarifas
end type
type gb_1 from groupbox within w_int_detalle_tarifas
end type
end forward

global type w_int_detalle_tarifas from w_int_con_empresa
integer width = 2944
integer height = 1692
pb_1 pb_1
st_1 st_1
dw_listado dw_listado
uo_articulo uo_articulo
st_2 st_2
st_nombre_tarifa st_nombre_tarifa
st_3 st_3
em_fecha em_fecha
dw_proceso1 dw_proceso1
dw_proceso2 dw_proceso2
uo_tarifa uo_tarifa
uo_calidad uo_calidad
st_4 st_4
st_5 st_5
st_6 st_6
dw_proceso3 dw_proceso3
dw_proceso4 dw_proceso4
dw_tar1 dw_tar1
cb_continuar cb_continuar
dw_tar2 dw_tar2
em_precio em_precio
gb_1 gb_1
end type
global w_int_detalle_tarifas w_int_detalle_tarifas

type variables
string filtro,moneda
String var_tarifa
DateTime var_fecha

end variables

forward prototypes
public subroutine f_cargar ()
end prototypes

public subroutine f_cargar ();Integer reg,reg1,contador,r
String var_nombre_subfamilia,var_subfamilia,var_familia,var_formato,var_calidad,var_nombre_familia,var_nombre_formato,var_nombre_calidad
Dec{4} var_precio
dw_tar1.Reset()
dw_tar2.Reset()
contador = 0
dw_tar1.SetReDraw(FALSE)
var_fecha = DateTime(Date(em_fecha.text))
reg = dw_proceso1.Retrieve(codigo_empresa,var_tarifa,var_fecha)
IF reg <> 0 Then
	For reg1 = 1 To reg
		var_familia = f_valor_columna(dw_proceso1,reg1,"familia")
		//var_subfamilia = f_valor_columna(dw_proceso1,reg1,"subfamilia")
		var_formato = f_valor_columna(dw_proceso1,reg1,"formato")
		var_calidad = f_valor_columna(dw_proceso1,reg1,"calidad")
		var_precio  = Dec(f_valor_columna(dw_proceso1,reg1,"precio"))
		var_nombre_familia = f_nombre_familia(codigo_empresa,var_familia)
		//var_nombre_subfamilia = f_nombre_subfamilia(codigo_empresa,var_subfamilia)
		var_nombre_formato = f_nombre_formato_abr(codigo_empresa,var_formato)
		var_nombre_calidad = f_nombre_calidad_abr(codigo_empresa,var_calidad)
		contador = contador  + 1 
		dw_tar1.InsertRow(contador)
		f_asignar_columna(dw_tar1,contador,"tipo","T")
		f_asignar_columna(dw_tar1,contador,"familia",var_nombre_familia)
		//f_asignar_columna(dw_tar1,contador,"subfamilia",var_nombre_subfamilia)
		f_asignar_columna(dw_tar1,contador,"formato",var_nombre_formato)
		f_asignar_columna(dw_tar1,contador,"calidad",var_nombre_calidad)
		f_asignar_columna(dw_tar1,contador,"cod_familia",var_familia)
		//f_asignar_columna(dw_tar1,contador,"cod_subfamilia",var_subfamilia)
		f_asignar_columna(dw_tar1,contador,"cod_formato",var_formato)
		f_asignar_columna(dw_tar1,contador,"cod_calidad",var_calidad)
		f_asignar_columna(dw_tar1,contador,"precio",String(var_precio))
		f_contador_procesos(reg1,reg)
	Next
END IF 
dw_tar1.SetSort("familia,formato")
dw_tar1.Sort()
dw_tar1.SetReDraw(TRUE)

IF contador <> 0 Then
	dw_tar1.SetFocus()
	dw_tar1.SetRow(1)
	dw_tar1.SetColumn("precio")
	dw_tar1.SelectRow(0,False)
	dw_tar1.SelectRow(1,True)
END IF



end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccio detalle de una  Tarifa"
This.title=istr_parametros.s_titulo_ventana
dw_tar1.SetTransObject(SQLCA)
dw_tar2.SetTransObject(SQLCA)
dw_proceso1.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_proceso3.SetTransObject(SQLCA)
dw_proceso4.SetTransObject(SQLCA)

f_activar_campo(uo_tarifa.em_campo)

end event

on w_int_detalle_tarifas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_listado=create dw_listado
this.uo_articulo=create uo_articulo
this.st_2=create st_2
this.st_nombre_tarifa=create st_nombre_tarifa
this.st_3=create st_3
this.em_fecha=create em_fecha
this.dw_proceso1=create dw_proceso1
this.dw_proceso2=create dw_proceso2
this.uo_tarifa=create uo_tarifa
this.uo_calidad=create uo_calidad
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.dw_proceso3=create dw_proceso3
this.dw_proceso4=create dw_proceso4
this.dw_tar1=create dw_tar1
this.cb_continuar=create cb_continuar
this.dw_tar2=create dw_tar2
this.em_precio=create em_precio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_articulo
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_nombre_tarifa
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.em_fecha
this.Control[iCurrent+9]=this.dw_proceso1
this.Control[iCurrent+10]=this.dw_proceso2
this.Control[iCurrent+11]=this.uo_tarifa
this.Control[iCurrent+12]=this.uo_calidad
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.dw_proceso3
this.Control[iCurrent+17]=this.dw_proceso4
this.Control[iCurrent+18]=this.dw_tar1
this.Control[iCurrent+19]=this.cb_continuar
this.Control[iCurrent+20]=this.dw_tar2
this.Control[iCurrent+21]=this.em_precio
this.Control[iCurrent+22]=this.gb_1
end on

on w_int_detalle_tarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.uo_articulo)
destroy(this.st_2)
destroy(this.st_nombre_tarifa)
destroy(this.st_3)
destroy(this.em_fecha)
destroy(this.dw_proceso1)
destroy(this.dw_proceso2)
destroy(this.uo_tarifa)
destroy(this.uo_calidad)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_proceso3)
destroy(this.dw_proceso4)
destroy(this.dw_tar1)
destroy(this.cb_continuar)
destroy(this.dw_tar2)
destroy(this.em_precio)
destroy(this.gb_1)
end on

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_detalle_tarifas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_detalle_tarifas
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_tarifa.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_detalle_tarifas
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_detalle_tarifas
integer x = 2747
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type st_1 from statictext within w_int_detalle_tarifas
integer x = 23
integer y = 164
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_int_detalle_tarifas
boolean visible = false
integer x = 2107
integer width = 494
integer height = 152
boolean bringtotop = true
string dataobject = "report_tarifa_cliente"
boolean livescroll = true
end type

type uo_articulo from u_em_campo_2 within w_int_detalle_tarifas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1522
integer y = 1328
integer width = 901
integer height = 92
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = " familia = '" + dw_tar1.GetItemString(dw_tar1.Getrow(),"cod_familia")+ & 				
            "' and formato = '"+dw_tar1.GetItemString(dw_tar1.Getrow(),"cod_formato")+"'"
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_int_detalle_tarifas
integer x = 1531
integer y = 124
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nombre_tarifa from statictext within w_int_detalle_tarifas
integer x = 1755
integer y = 124
integer width = 914
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
string text = " "
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_detalle_tarifas
integer x = 1531
integer y = 212
integer width = 224
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_detalle_tarifas
integer x = 1755
integer y = 212
integer width = 302
integer taborder = 0
boolean enabled = false
alignment alignment = center!
boolean displayonly = true
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type dw_proceso1 from datawindow within w_int_detalle_tarifas
boolean visible = false
integer x = 494
integer y = 44
integer width = 494
integer height = 36
boolean bringtotop = true
string dataobject = "dw_proceso_ventarfamfor"
boolean livescroll = true
end type

type dw_proceso2 from datawindow within w_int_detalle_tarifas
boolean visible = false
integer x = 503
integer width = 494
integer height = 36
boolean bringtotop = true
string dataobject = "dw_proceso_venfamforcli"
boolean livescroll = true
end type

type uo_tarifa from u_em_campo_2 within w_int_detalle_tarifas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 251
integer y = 148
integer width = 1207
integer height = 92
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tarifa.em_campo.text=f_nombre_ventarifa(codigo_empresa,uo_tarifa.em_codigo.text)
var_tarifa =uo_tarifa.em_codigo.text
var_fecha  = f_activa_ventarifas(codigo_empresa,var_tarifa)

em_fecha.text = String(date(var_fecha))
moneda = f_moneda_ventarifas(codigo_empresa,var_tarifa)
st_nombre_tarifa.text ="("+f_nombre_moneda_abr(moneda)+") "+ f_nombre_ventarifa(codigo_empresa,var_tarifa)
If Trim(uo_tarifa.em_campo.text)="" then
	uo_tarifa.em_campo.text=""
	uo_tarifa.em_codigo.text=""
	Return
end if 

if moneda="1" then
	f_mascara_columna(dw_tar1,"precio","###,###,###,###.00")
	f_mascara_columna(dw_tar2,"precio","###,###,###,###.00")
else
	f_mascara_columna(dw_tar1,"precio",f_mascara_precios_moneda(moneda))
	f_mascara_columna(dw_tar2,"precio",f_mascara_precios_moneda(moneda))
end if	


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Tarifas"
ue_datawindow ="dw_ayuda_ventarifas"
ue_filtro = ""
end event

on uo_tarifa.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_detalle_tarifas
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2423
integer y = 1328
integer width = 123
integer height = 92
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
If Trim(uo_calidad.em_campo.text)="" then
	uo_calidad.em_campo.text=""
	uo_calidad.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Calidades"
ue_datawindow ="dw_ayuda_calidades"
ue_filtro = ""
end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_detalle_tarifas
integer x = 1527
integer y = 1264
integer width = 901
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_detalle_tarifas
integer x = 2432
integer y = 1264
integer width = 119
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_detalle_tarifas
integer x = 2555
integer y = 1264
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_proceso3 from datawindow within w_int_detalle_tarifas
boolean visible = false
integer x = 1006
integer width = 494
integer height = 40
boolean bringtotop = true
string dataobject = "dw_proceso_contarcli1"
boolean livescroll = true
end type

type dw_proceso4 from datawindow within w_int_detalle_tarifas
boolean visible = false
integer x = 1499
integer width = 494
integer height = 40
boolean bringtotop = true
string dataobject = "dw_proceso_contarcli2"
boolean livescroll = true
end type

type dw_tar1 from u_datawindow_consultas within w_int_detalle_tarifas
integer x = 5
integer y = 324
integer width = 1509
integer height = 1104
integer taborder = 0
string dataobject = "dw_int_detalle_tarifas1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;Integer reg,reg1,registro,r
String var_articulo,var_calidad,var_nombre_articulo,var_nombre_calidad,var_familia,var_formato,var_subfamilia
Dec{2} var_precio,el_precio
IF GetRow() = 0 Then return
registro = GetRow()
dw_tar2.SetRedraw(FALSE)
dw_tar2.reset()
el_precio = Dec(f_valor_columna(This,registro,"precio"))
var_familia = f_valor_columna(This,registro,"cod_familia")
//var_subfamilia = f_valor_columna(This,registro,"cod_subfamilia")
var_formato = f_valor_columna(This,registro,"cod_formato")
var_calidad = f_valor_columna(This,registro,"cod_calidad")
var_nombre_calidad  = f_nombre_calidad_abr(codigo_empresa,var_calidad)
reg= dw_proceso3.Retrieve(codigo_empresa,var_tarifa,var_fecha,var_familia,var_formato,var_calidad,el_precio)
	IF reg <> 0 Then
		For reg1  = 1 To reg
			var_articulo = f_valor_columna(dw_proceso3,reg1,"articulo")
			var_precio   = Dec(f_valor_columna(dw_proceso3,reg1,"precio"))
			var_nombre_articulo = f_nombre_articulo(codigo_empresa,var_articulo)
			dw_tar2.InsertRow(reg1)
			f_asignar_columna(dw_tar2,reg1,"articulo",var_nombre_articulo)
			f_asignar_columna(dw_tar2,reg1,"tipo","T")
			f_asignar_columna(dw_tar2,reg1,"calidad",var_nombre_calidad)
			f_asignar_columna(dw_tar2,reg1,"cod_articulo",var_articulo)
			f_asignar_columna(dw_tar2,reg1,"cod_calidad",var_calidad)
			f_asignar_columna(dw_tar2,reg1,"precio",String(var_precio))
		Next
	END IF

dw_tar2.SetSort("")
dw_tar2.SetSort("articulo,calidad")
dw_tar2.Sort()
dw_tar2.SetRedraw(TRUE)
end event

event clicked;call super::clicked;IF row <>0 Then
	This.SetFocus()
	This.SetRow(row)
	This.SetColumn("precio")
END IF
end event

event editchanged;String var_subfamilia,var_familia,var_formato,var_tipo,var_calidad
Dec{4} var_precio,numero,var_anteprecio
DateTime    var_falta
var_falta = DateTime(Today(),Now())
AcceptText()
var_familia = f_valor_columna(This,row,"cod_familia")
//var_subfamilia = f_valor_columna(This,row,"cod_subfamilia")
var_formato = f_valor_columna(This,row,"cod_formato")
var_calidad = f_valor_columna(This,row,"cod_calidad")
var_precio  = Dec(f_valor_columna(This,row,"precio"))
 Select precio Into :var_anteprecio  From ventarfamfor
 WHERE (ventarfamfor.empresa = :codigo_empresa ) AND  
       (ventarfamfor.tarifa  = :var_tarifa  ) AND  
		 (ventarfamfor.fecha   = :var_fecha   ) AND
       (ventarfamfor.familia = :var_familia ) AND  
       (ventarfamfor.formato = :var_formato ) AND  
       (ventarfamfor.calidad = :var_calidad );
		 
 IF sqlca.sqlcode <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
		 
 UPDATE ventarfamfor
 SET precio = :var_precio  
 WHERE (ventarfamfor.empresa = :codigo_empresa ) AND  
       (ventarfamfor.tarifa  = :var_tarifa  ) AND  
		 (ventarfamfor.fecha   = :var_fecha   ) AND
       (ventarfamfor.familia = :var_familia ) AND  
       (ventarfamfor.formato = :var_formato ) AND  
       (ventarfamfor.calidad = :var_calidad );
 IF sqlca.sqlcode <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)
		 
 UPDATE venlintarifas
 SET 	precio = :var_precio  ,
      usuario = :nombre_usuario,
		falta   = :var_falta
 WHERE (venlintarifas.empresa = :codigo_empresa ) AND  
       (venlintarifas.tarifa  = :var_tarifa  ) AND  
		 (venlintarifas.fecha   = :var_fecha   ) AND
       (venlintarifas.familia = :var_familia ) AND  
       (venlintarifas.formato = :var_formato ) AND  
       (venlintarifas.calidad = :var_calidad )  AND
		 (venlintarifas.precio = :var_anteprecio );
		 IF sqlca.sqlcode <> 0 Then f_mensaje("Error",sqlca.sqlerrtext)


COMMIT;
end event

type cb_continuar from u_boton within w_int_detalle_tarifas
integer x = 2162
integer y = 220
integer width = 389
integer height = 72
integer taborder = 20
string text = "F5 Continuar"
end type

event clicked;f_cargar()

end event

type dw_tar2 from u_datawindow_consultas within w_int_detalle_tarifas
integer x = 1522
integer y = 324
integer width = 1307
integer height = 940
integer taborder = 0
string dataobject = "dw_int_detalle_tarifas2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event editchanged;call super::editchanged;String var_articulo,var_tipo,var_calidad,var_familia,var_formato,var_montajeart
Dec{4} var_precio,numero
DateTime  var_falta
Accepttext()



var_articulo = f_valor_columna(This,row,"cod_articulo")
var_calidad = f_valor_columna(This,row,"cod_calidad")
var_precio  = Dec(f_valor_columna(This,row,"precio"))
var_falta = DateTime(Today(),Now())


	  UPDATE venlintarifas  
     SET precio = :var_precio  ,
	      usuario= :nombre_usuario,
			falta = :var_falta
   WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
         ( venlintarifas.tarifa   = :var_tarifa ) AND  
         ( venlintarifas.fecha    = :var_fecha ) AND  
         ( venlintarifas.articulo = :var_articulo )And 
			( venlintarifas.calidad  = :var_calidad );


COMMIT;

end event

type em_precio from u_em_campo within w_int_detalle_tarifas
integer x = 2555
integer y = 1332
integer width = 274
integer height = 88
integer taborder = 60
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event tecla_enter;call super::tecla_enter;String var_descripcion,var_modelo
IF Trim(uo_articulo.em_codigo.text) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
END IF

IF Trim(uo_calidad.em_codigo.text) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca el calidad")
	f_activar_campo(uo_calidad.em_campo)
	Return
END IF


String var_articulo,var_tipo,var_calidad,var_familia,var_formato,var_montajeart
Dec{4} var_precio,numero
DateTime  var_falta


var_articulo = uo_articulo.em_codigo.text
var_calidad  = uo_calidad.em_codigo.text
//var_precio   = Dec(String(Dec(em_precio.text),f_mascara_moneda(moneda)))
var_precio   = Dec(String(Dec(em_precio.text),"#,###,##0.00"))
var_falta    = DateTime(Today(),Now())

Select count(*) Into :numero From venlintarifas
Where  venlintarifas.empresa  = :codigo_empresa
And    venlintarifas.tarifa   = :var_tarifa
And    venlintarifas.fecha    = :var_fecha
And    venlintarifas.articulo = :var_articulo
And    venlintarifas.calidad  = :var_calidad;
IF IsNull(numero) Then numero =0
IF numero = 0 Then
	var_familia = f_familia_articulo(codigo_empresa,var_articulo)
	var_formato = f_formato_articulo(codigo_empresa,var_articulo)
	var_modelo = f_modelo_articulo(codigo_empresa,var_articulo)
	var_descripcion = f_nombre_articulo(codigo_empresa,var_articulo)
	var_montajeart = f_componer_artcal(var_articulo,var_calidad)
  INSERT INTO venlintarifas  
         ( empresa,tarifa,fecha,articulo,calidad,   
           precio,falta,montajeartcal,familia,   
           formato,modelo,activo,listar,usuario,   
           descripcion,excepcion,tipo_linea )  
  VALUES ( :codigo_empresa,:var_tarifa,:var_fecha,   
           :var_articulo,:var_calidad,:var_precio,   
           :var_falta,:var_montajeart,:var_familia,   
           :var_formato,:var_modelo,"S","S",:nombre_usuario,   
           :var_descripcion,"N","1");
			  
			  
Select count(*) Into :numero From ventarfamfor
Where  ventarfamfor.empresa  = :codigo_empresa
And    ventarfamfor.tarifa   = :var_tarifa
And    ventarfamfor.fecha    = :var_fecha
And    ventarfamfor.familia  = :var_familia
And    ventarfamfor.formato  = :var_formato
And    ventarfamfor.calidad  = :var_calidad;
IF IsNull(numero) Then numero =0
IF numero = 0 Then
	var_familia = f_familia_articulo(codigo_empresa,var_articulo)
	var_formato = f_formato_articulo(codigo_empresa,var_articulo)
	var_modelo = f_modelo_articulo(codigo_empresa,var_articulo)
	var_descripcion = f_nombre_articulo(codigo_empresa,var_articulo)
	var_montajeart = f_componer_artcal(var_articulo,var_calidad)
  INSERT INTO ventarfamfor  
         ( empresa,   
           tarifa,   
           fecha,   
           familia,   
           formato,   
           calidad,   
           precio )  
  VALUES ( :codigo_empresa,   
           :var_tarifa,   
           :var_fecha,   
           :var_familia,   
           :var_formato,   
           :var_calidad,   
           :var_precio )  ;

END IF			  
			  
			  

ELSE
	  UPDATE venlintarifas
     SET precio = :var_precio  ,
	      usuario= :nombre_usuario,
			falta = :var_falta
   WHERE ( venlintarifas.empresa = :codigo_empresa ) AND  
         ( venlintarifas.tarifa  = :var_tarifa ) AND  
         ( venlintarifas.fecha   = :var_fecha ) AND  
         ( venlintarifas.articulo = :var_articulo )And 
			( venlintarifas.calidad = :var_calidad );

END IF
COMMIT;
em_precio.text = ""
uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_calidad.em_codigo.text = ""
uo_calidad.em_campo.text = ""
dw_tar1.TriggerEvent(rowfocuschanged!)
f_activar_campo(uo_articulo.em_campo)

end event

type gb_1 from groupbox within w_int_detalle_tarifas
integer x = 1522
integer y = 92
integer width = 1161
integer height = 216
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

