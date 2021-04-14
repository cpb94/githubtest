$PBExportHeader$w_resumen_stock_formato.srw
forward
global type w_resumen_stock_formato from w_int_con_empresa
end type
type gb_3 from groupbox within w_resumen_stock_formato
end type
type gb_5 from groupbox within w_resumen_stock_formato
end type
type gb_2 from groupbox within w_resumen_stock_formato
end type
type pb_2 from upb_salir within w_resumen_stock_formato
end type
type cb_1 from commandbutton within w_resumen_stock_formato
end type
type cb_2 from commandbutton within w_resumen_stock_formato
end type
type uo_calidad from u_marca_lista within w_resumen_stock_formato
end type
type rb_5 from radiobutton within w_resumen_stock_formato
end type
type rb_6 from radiobutton within w_resumen_stock_formato
end type
type pb_imprimir_preli from upb_imprimir within w_resumen_stock_formato
end type
type uo_1 from u_manejo_datawindow within w_resumen_stock_formato
end type
type cb_3 from commandbutton within w_resumen_stock_formato
end type
type uo_almacenes from u_marca_lista within w_resumen_stock_formato
end type
type cb_4 from commandbutton within w_resumen_stock_formato
end type
type dw_listado from datawindow within w_resumen_stock_formato
end type
type dw_consulta from datawindow within w_resumen_stock_formato
end type
type rb_1 from radiobutton within w_resumen_stock_formato
end type
end forward

global type w_resumen_stock_formato from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2926
integer height = 1644
string title = "Consulta de Movimientos"
gb_3 gb_3
gb_5 gb_5
gb_2 gb_2
pb_2 pb_2
cb_1 cb_1
cb_2 cb_2
uo_calidad uo_calidad
rb_5 rb_5
rb_6 rb_6
pb_imprimir_preli pb_imprimir_preli
uo_1 uo_1
cb_3 cb_3
uo_almacenes uo_almacenes
cb_4 cb_4
dw_listado dw_listado
dw_consulta dw_consulta
rb_1 rb_1
end type
global w_resumen_stock_formato w_resumen_stock_formato

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_control_campos (integer deci)
end prototypes

public subroutine f_control ();datastore d
dw_consulta.reset()
uo_calidad.visible=false
dw_consulta.SetRedraw(FALSE)

string calidades[1 to 20],tipounidad,sel,formato,familia,nombre_formato
String nombre_familia,var_calidad,var_almacenes
long i,x1,c,tl,deci,h
dec existencias,disponible,reservado,preparado,deposito

calidades={""}


for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
	   calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")
	end if
next

var_almacenes = ""

for i=1 to uo_almacenes.dw_marca.rowcount()
	if uo_almacenes.dw_marca.getitemstring(i,"marca")="S" then
	   h=h+1
		
		if h=1 then
			var_almacenes = "("+"'"+uo_almacenes.dw_marca.getitemstring(i,"codigo")+"'"
		else
	      var_almacenes = var_almacenes+","+"'"+uo_almacenes.dw_marca.getitemstring(i,"codigo")+"'"		
		End if
   End if
next

if Trim(var_almacenes)<>"" then var_almacenes = var_almacenes+")"

tipounidad = "0"
deci=0
if rb_6.checked = True THEN 
	tipounidad = "1"
	deci=2
End if

f_control_campos(deci)

dw_consulta.retrieve(codigo_empresa)
dw_listado.retrieve(codigo_empresa)
f_mensaje_proceso("Espere Por Favor ",0,100)

sel = "SELECT sum(existencias) existencias,formato,familia" +&
      "  FROM almlinubica"+&
		" WHERE almlinubica.empresa     = '"+codigo_empresa+"'" +&
		"   AND almlinubica.tipo_unidad = '"+tipounidad+"'"+&
		"   AND almlinubica.calidad     In ('"+calidades[1]+"','"+calidades[2]+"','"+calidades[3]+"','"+calidades[4]+"','"+calidades[5]+"')"+&
		"   AND almlinubica.almacen     In "+var_almacenes+&
		"  GROUP BY almlinubica.formato,almlinubica.familia"+&
		"  order BY almlinubica.formato,almlinubica.familia"
		
//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

tl = d.RowCount()

For x1 = 1 To d.RowCount()
    c = c +1
	 existencias    = d.GetItemDecimal(x1,"existencias")
    formato        = d.GetItemString(x1,"formato")
    familia        = d.GetItemString(x1,"familia")
    nombre_formato = f_nombre_formato_abr(codigo_empresa,formato)
	 nombre_familia = f_nombre_familia(codigo_empresa,familia)
    dw_consulta.InsertRow(c)
	 dw_consulta.SetItem(c,"formato",formato)
    dw_consulta.SetItem(c,"nombre_formato",nombre_formato)
    dw_consulta.SetItem(c,"nombre_familia",nombre_familia)
    dw_consulta.SetItem(c,"familia",familia)
    if rb_1.checked = True Then
	     reservado  = f_reservado_formato_familia(codigo_empresa,formato,familia,calidades)
        preparado  = f_preparado_familia_formato(codigo_empresa,familia,formato,calidades)
		  deposito   = f_depstock_familia_formato(codigo_empresa,familia,formato,calidades)
	     disponible = existencias - reservado - preparado
  	  else
		  disponible = existencias
		  reservado  = 0
		  preparado  = 0
		  deposito   = 0
	 End if
    dw_consulta.SetItem(c,"disponible",disponible)
	 dw_consulta.SetItem(c,"reservado",reservado)
    dw_consulta.SetItem(c,"preparado",preparado)
	 dw_consulta.SetItem(c,"deposito",deposito)
	 f_mensaje_proceso("Espere Por Favor ",x1,tl)
next
dw_consulta.SetSort("familia,formato")
dw_consulta.Sort()
dw_consulta.SetRedraw(TRUE)

f_contador_procesos(1,1)

destroy d
end subroutine

public subroutine f_control_campos (integer deci);f_mascara_columna(dw_listado,"disponible",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"reservado",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"preparado",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"porcen",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"deposito",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"total",f_mascara_decimales(deci))

f_mascara_columna(dw_listado,"t1",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"t2",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"t3",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"t4",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"t5",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"t6",f_mascara_decimales(deci))

f_mascara_columna(dw_listado,"tt1",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"tt2",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"tt3",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"tt4",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"tt5",f_mascara_decimales(deci))
f_mascara_columna(dw_listado,"tt6",f_mascara_decimales(deci))

f_mascara_columna(dw_consulta,"disponible",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"reservado",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"preparado",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"porcen",f_mascara_decimales(2))
f_mascara_columna(dw_consulta,"deposito",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"total",f_mascara_decimales(deci))

f_mascara_columna(dw_consulta,"t1",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"t2",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"t3",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"t4",f_mascara_decimales(2))
f_mascara_columna(dw_consulta,"t5",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"t6",f_mascara_decimales(deci))

f_mascara_columna(dw_consulta,"tt1",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"tt2",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"tt3",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"tt4",f_mascara_decimales(2))
f_mascara_columna(dw_consulta,"tt5",f_mascara_decimales(deci))
f_mascara_columna(dw_consulta,"tt6",f_mascara_decimales(deci))



end subroutine

event open;call super::open;		dw_consulta.SetTransObject(sqlca)
		dw_listado.SetTransObject(sqlca)
		
		This.title = " CONSULTA STOCK POR FORMATOS"
		
		uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")
		//uo_almacenes.f_cargar_datos("dw_ayuda_almacenes","","","Código","Descripción")
		
		uo_calidad.dw_marca.SetItem(1,"marca","S")
		uo_calidad.dw_marca.SetItem(2,"marca","S")
		uo_calidad.dw_marca.SetItem(3,"marca","S")
		uo_calidad.dw_marca.SetItem(4,"marca","S")
		
		int registros,x1
		String var_codigo,var_texto,mare,sel
		dataStore d
		
		sel = "SELECT codigo,descripcion  "+&
				"  from almalmacen "+&
				" where almalmacen.empresa = '"+codigo_empresa+"'"
				
//		d = f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, d)
		
		registros=d.retrieve(codigo_empresa)
		If registros<>0 THEN
		 FOR x1= 1 To registros
		  var_codigo  = d.GetItemString(x1,"codigo")
		  var_texto   = d.GetItemString(x1,"descripcion")
		  uo_almacenes.dw_marca.InsertRow(x1)
		  uo_almacenes.dw_marca.setitem(x1,"marca","S")
		  uo_almacenes.dw_marca.setitem(x1,"codigo",var_codigo)
		  uo_almacenes.dw_marca.setitem(x1,"texto",var_texto)
		NEXT
		END IF

		destroy d
end event

on w_resumen_stock_formato.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_2=create gb_2
this.pb_2=create pb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_calidad=create uo_calidad
this.rb_5=create rb_5
this.rb_6=create rb_6
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_1=create uo_1
this.cb_3=create cb_3
this.uo_almacenes=create uo_almacenes
this.cb_4=create cb_4
this.dw_listado=create dw_listado
this.dw_consulta=create dw_consulta
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_5
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.uo_calidad
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.rb_6
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.uo_almacenes
this.Control[iCurrent+14]=this.cb_4
this.Control[iCurrent+15]=this.dw_listado
this.Control[iCurrent+16]=this.dw_consulta
this.Control[iCurrent+17]=this.rb_1
end on

on w_resumen_stock_formato.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_calidad)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.pb_imprimir_preli)
destroy(this.uo_1)
destroy(this.cb_3)
destroy(this.uo_almacenes)
destroy(this.cb_4)
destroy(this.dw_listado)
destroy(this.dw_consulta)
destroy(this.rb_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.TriggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.TriggerEvent("linea_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_resumen_stock_formato
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_resumen_stock_formato
end type

type st_empresa from w_int_con_empresa`st_empresa within w_resumen_stock_formato
integer y = 8
integer width = 2039
end type

type gb_3 from groupbox within w_resumen_stock_formato
integer x = 1522
integer y = 152
integer width = 379
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_5 from groupbox within w_resumen_stock_formato
integer x = 18
integer y = 100
integer width = 402
integer height = 184
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_resumen_stock_formato
integer x = 430
integer y = 152
integer width = 1083
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_resumen_stock_formato
integer x = 2715
integer y = 12
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_1 from commandbutton within w_resumen_stock_formato
integer x = 795
integer y = 192
integer width = 352
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calidades"
end type

event clicked;if uo_calidad.visible= True then
   uo_calidad.visible = False
else
	uo_calidad.visible= True
End if
end event

type cb_2 from commandbutton within w_resumen_stock_formato
event clicked pbm_bnclicked
integer x = 1536
integer y = 192
integer width = 352
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;uo_calidad.visible = False
uo_almacenes.visible = False
f_control()
dw_consulta.SetFocus()
end event

type uo_calidad from u_marca_lista within w_resumen_stock_formato
event destroy ( )
boolean visible = false
integer x = 1362
integer y = 300
integer height = 668
boolean bringtotop = true
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type rb_5 from radiobutton within w_resumen_stock_formato
integer x = 46
integer y = 140
integer width = 329
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unidades"
end type

type rb_6 from radiobutton within w_resumen_stock_formato
integer x = 46
integer y = 212
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Metros"
boolean checked = true
end type

type pb_imprimir_preli from upb_imprimir within w_resumen_stock_formato
integer x = 2729
integer y = 184
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;integer bien
dw_listado.reset()
if dw_consulta.RowCount()=0 then cb_2.TriggerEvent(clicked!)
	
bien=dw_consulta.RowsCopy(1,dw_consulta.RowCount(), primary!, dw_listado, 1, primary!)
if bien=-1 or isnull(bien) then messagebox("Error al copiar lineas","Avise al administrador del sistema")

f_imprimir_datawindow(dw_listado)

end event

type uo_1 from u_manejo_datawindow within w_resumen_stock_formato
integer x = 2254
integer y = 136
integer width = 617
integer height = 168
end type

event valores;call super::valores;dw_data = dw_consulta
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type cb_3 from commandbutton within w_resumen_stock_formato
integer x = 1147
integer y = 192
integer width = 352
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;if cb_3.text="Detalle" then
	dw_consulta.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.detail.height=0")
	cb_3.text="Resumen"
else
	dw_consulta.modify("datawindow.detail.height=77")
	dw_listado.modify("datawindow.detail.height=77")
	cb_3.text="Detalle"
end if


end event

type uo_almacenes from u_marca_lista within w_resumen_stock_formato
boolean visible = false
integer x = 9
integer y = 300
end type

on uo_almacenes.destroy
call u_marca_lista::destroy
end on

type cb_4 from commandbutton within w_resumen_stock_formato
event clicked pbm_bnclicked
integer x = 443
integer y = 192
integer width = 352
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Almacenes"
end type

event clicked;if uo_almacenes.visible= True then
   uo_almacenes.visible = False
else
	uo_almacenes.visible= True
End if
end event

type dw_listado from datawindow within w_resumen_stock_formato
integer x = 2153
integer y = 32
integer width = 101
integer height = 60
string dataobject = "report_resumen_stock_formatos"
boolean livescroll = true
end type

type dw_consulta from datawindow within w_resumen_stock_formato
event clicked pbm_dwnlbuttonclk
integer x = 5
integer y = 296
integer width = 2848
integer height = 1132
integer taborder = 20
string dataobject = "dw_resumen_stock_formatos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type rb_1 from radiobutton within w_resumen_stock_formato
integer x = 434
integer y = 112
integer width = 864
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Reservado/Preparado/Deposito "
boolean checked = true
boolean automatic = false
boolean lefttext = true
end type

event clicked;if rb_1.checked = True then
	rb_1.checked = False
else
	rb_1.checked = True
End if
   
end event

