$PBExportHeader$w_con_detalle_articulos_clientes.srw
forward
global type w_con_detalle_articulos_clientes from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_con_detalle_articulos_clientes
end type
type em_fechadesde from u_em_campo within w_con_detalle_articulos_clientes
end type
type em_fechahasta from u_em_campo within w_con_detalle_articulos_clientes
end type
type gb_3 from groupbox within w_con_detalle_articulos_clientes
end type
type gb_1 from groupbox within w_con_detalle_articulos_clientes
end type
type cb_1 from commandbutton within w_con_detalle_articulos_clientes
end type
type uo_cliente from u_em_campo_2 within w_con_detalle_articulos_clientes
end type
type st_1 from statictext within w_con_detalle_articulos_clientes
end type
type uo_manejo from u_manejo_datawindow within w_con_detalle_articulos_clientes
end type
type gb_2 from groupbox within w_con_detalle_articulos_clientes
end type
type cb_familias from commandbutton within w_con_detalle_articulos_clientes
end type
type uo_familias from u_marca_lista within w_con_detalle_articulos_clientes
end type
type cb_calidades from commandbutton within w_con_detalle_articulos_clientes
end type
type dw_detalle from datawindow within w_con_detalle_articulos_clientes
end type
type uo_calidad from u_marca_lista within w_con_detalle_articulos_clientes
end type
type pb_1 from upb_salir within w_con_detalle_articulos_clientes
end type
type dw_listado from datawindow within w_con_detalle_articulos_clientes
end type
type cb_formatos from commandbutton within w_con_detalle_articulos_clientes
end type
type cb_2 from commandbutton within w_con_detalle_articulos_clientes
end type
type uo_formatos from u_marca_lista within w_con_detalle_articulos_clientes
end type
type m2 from checkbox within w_con_detalle_articulos_clientes
end type
end forward

global type w_con_detalle_articulos_clientes from w_int_con_empresa
integer width = 2912
integer height = 1652
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
gb_3 gb_3
gb_1 gb_1
cb_1 cb_1
uo_cliente uo_cliente
st_1 st_1
uo_manejo uo_manejo
gb_2 gb_2
cb_familias cb_familias
uo_familias uo_familias
cb_calidades cb_calidades
dw_detalle dw_detalle
uo_calidad uo_calidad
pb_1 pb_1
dw_listado dw_listado
cb_formatos cb_formatos
cb_2 cb_2
uo_formatos uo_formatos
m2 m2
end type
global w_con_detalle_articulos_clientes w_con_detalle_articulos_clientes

type variables
string filtro
boolean detalle=true
end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);   
STring Sel,usu_cliente1,usu_cliente2,cliente,articulo,calidad,familia,formato,tipo_unidad
string cadena,var_calidad,var_cali,var_form,var_form2

Dec  cantidad,canlinea
Integer r,c,i,h,sss,tl
DataStore d
data.Reset()
data.SetRedraw(FALSE)

f_contador_procesos(0,100)
data.retrieve(codigo_empresa,Datetime(date(em_fechadesde.text)),Datetime(date(em_fechahasta.text)))
cadena=""
h=0
for i=1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(i,"marca")="S" then
	     h=h+1
		  if h=1 then
			   cadena = "("+"'"+uo_familias.dw_marca.getitemstring(i,"codigo")+"'"
		    else
		      cadena = cadena+","+"'"+uo_familias.dw_marca.getitemstring(i,"codigo")+"'"
	   End if
   end if
next
h=0
var_form  = ""
var_form2 = ""
for i=1 to uo_formatos.dw_marca.rowcount()
	if uo_formatos.dw_marca.getitemstring(i,"marca")="S" then
	   h=h+1
		
		if h=1 then
			var_form = "("+"'"+uo_formatos.dw_marca.getitemstring(i,"codigo")+"'"
			var_form2 = f_nombre_formato_abr(codigo_empresa,uo_formatos.dw_marca.getitemstring(i,"codigo"))+" "
		else
	      var_form = var_form+","+"'"+uo_formatos.dw_marca.getitemstring(i,"codigo")+"'"		
			var_form2 = var_form+"/"+f_nombre_formato_abr(codigo_empresa,uo_formatos.dw_marca.getitemstring(i,"codigo"))+" "
		End if
   End if
next

h=0
var_calidad = ""
var_cali    = ""
for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
	   h=h+1
		
		if h=1 then
			var_calidad = "("+"'"+uo_calidad.dw_marca.getitemstring(i,"codigo")+"'"
			var_cali = f_nombre_calidad_abr(codigo_empresa,uo_calidad.dw_marca.getitemstring(i,"codigo"))+" "
		else
	      var_calidad = var_calidad+","+"'"+uo_calidad.dw_marca.getitemstring(i,"codigo")+"'"		
			var_cali = var_cali+"/"+f_nombre_calidad_abr(codigo_empresa,uo_calidad.dw_marca.getitemstring(i,"codigo"))+" "
		End if
   End if
next

if Trim(cadena)<>"" then cadena=cadena+")"
if Trim(var_form)<>"" then var_form=var_form+")"
if Trim(var_calidad)<>"" then var_calidad = var_calidad+")"

if uo_cliente.em_codigo.text="" or isnull(uo_cliente.em_codigo.text) then
	usu_cliente1=char(1)
	usu_cliente2=char(255)
else
	usu_cliente1=uo_cliente.em_codigo.text
	usu_cliente2=usu_cliente1
end if


Sel = " SELECT empresa,cliente,familia,formato,articulo,calidad," +&
		" Sum(cantidad) cantidad" +&
   	" FROM   venlifac" +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
		" and    venlifac.cliente between '"+usu_cliente1+"' and '" +usu_cliente2+"' "+&
      " And    venlifac.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" And    venlifac.familia in "+cadena+&
		" And    venlifac.formato in "+var_form+&		
		" And    venlifac.calidad in "+var_calidad+&
		" And    venlifac.clase <> 'M' " +&
		" GROUP By empresa,cliente,familia,formato,articulo,calidad"+ &
		" Order By empresa,cliente,familia,formato,articulo,calidad"
//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
c = 0
tl = d.RowCOunt()
For r = 1 To d.RowCOunt()
	articulo = d.GetItemString(r,"articulo")
	
	IF f_sector_articulo(codigo_empresa,articulo)="S" then 
			c = c +1
			cliente  = d.GetItemstring(r,"cliente")
			articulo = d.GetItemString(r,"articulo")
			cantidad = d.GetItemNumber(r,"cantidad")
			articulo = d.GetItemString(r,"articulo")
			familia  = d.GetItemString(r,"familia")
			formato  = d.GetItemString(r,"formato")
			calidad  = d.GetItemString(r,"calidad")
			
			tipo_unidad = f_nombre_unidad_abr(f_unidad_articulo(codigo_empresa,articulo))
			data.InsertRow(c)
			data.SetItem(c,"familia",f_nombre_familia(codigo_empresa,familia))
			data.SetItem(c,"formato",f_nombre_formato_abr(codigo_empresa,formato))			
			data.SetItem(c,"cliente",f_razon_genter(codigo_empresa,"C",cliente))	
			data.SetItem(c,"articulo",f_nombre_articulo(codigo_empresa,articulo))
			
			if m2.checked then
				cantidad = f_conversion_cantidad_m2(codigo_empresa,articulo,cantidad)
				tipo_unidad = "M2"
			end if	
			
			data.SetItem(c,"tipo_unidad",tipo_unidad)	
			data.SetItem(c,"cantidad",cantidad)
			data.SetItem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
			data.SetItem(c,"codart",articulo)
	End if
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

Sel = " SELECT empresa,cliente,familia,formato,articulo,calidad," +&
		" Sum(cantidad) cantidad" +&
   	" FROM   venlialb" +&
      " WHERE  venlialb.empresa = '"+codigo_empresa+"'" +&
		" and    venlialb.cliente between '"+usu_cliente1+"' and '" +usu_cliente2+"' "+&
      " And    venlialb.falbaran between '"+STring(Date(em_fechadesde.text),"dd/mm/yy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yy")+"' "+&
		" And    venlialb.familia in "+cadena+&
		" And    venlialb.formato in "+var_form+&		
		" And    venlialb.calidad in "+var_calidad+&
		" And    venlialb.clase <> 'M' " +&
		" And    venlialb.deposito = 'N' " +&
		" GROUP By empresa,cliente,familia,formato,articulo,calidad"+ &
		" Order By empresa,cliente,familia,formato,articulo,calidad"
//d= f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)



For r = 1 To d.RowCOunt()
	articulo = d.GetItemString(r,"articulo")
	
	IF f_sector_articulo(codigo_empresa,articulo)="S" then 
			cliente  = d.GetItemstring(r,"cliente")
			articulo = d.GetItemString(r,"articulo")
			cantidad = d.GetItemNumber(r,"cantidad")
			articulo = d.GetItemString(r,"articulo")
			familia  = d.GetItemString(r,"familia")
			formato  = d.GetItemString(r,"formato")
			calidad  = d.GetItemString(r,"calidad")
			tipo_unidad = f_nombre_unidad_abr(f_unidad_articulo(codigo_empresa,articulo))
			
			
			if m2.checked then
				cantidad = f_conversion_cantidad_m2(codigo_empresa,articulo,cantidad)				
				tipo_unidad = "M2"
			end if					
			
			sss=data.find("( codart='"+articulo+"' )",1,tl)
			
			if sss=0 then
					c = c +1
					data.InsertRow(c)
					data.SetItem(c,"familia",f_nombre_familia(codigo_empresa,familia))
					data.SetItem(c,"formato",f_nombre_formato_abr(codigo_empresa,formato))					
					data.SetItem(c,"tipo_unidad",tipo_unidad)	
					data.SetItem(c,"cliente",f_razon_genter(codigo_empresa,"C",cliente))	
					data.SetItem(c,"articulo",f_nombre_articulo(codigo_empresa,articulo))
					data.SetItem(c,"cantidad",cantidad)
					data.SetItem(c,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
					data.SetItem(c,"codart",articulo)
				 Else
					canlinea = data.GetItemNumber(sss,"cantidad")
					data.SetItem(sss,"cantidad",cantidad+canlinea)
			End if		
	End if
	f_mensaje_proceso("Leyendo albaranes",r,d.RowCount())
Next

data.SetSort("cliente,familia,formato,cantidad D")
data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
f_contador_procesos(1,1)


destroy d
end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;Integer cont
istr_parametros.s_titulo_ventana="Resumen cargas por clientes"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

Int reg
uo_formatos.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")
uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")
uo_familias.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_calidad.dw_marca.SetItem(1,"marca","S")
reg = uo_familias.dw_marca.find("codigo = '1'",1,uo_familias.dw_marca.RowCount())
uo_familias.dw_marca.SetItem(reg,"marca","S")
reg = uo_familias.dw_marca.find("codigo = '2'",1,uo_familias.dw_marca.RowCount())
uo_familias.dw_marca.SetItem(reg,"marca","S")
for cont = 1 to uo_formatos.dw_marca.RowCount()
	uo_formatos.dw_marca.SetItem(cont,"marca","S")
next

f_mascara_columna(dw_listado,"totalmetros",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"totalfamilia",f_mascara_decimales(2))
f_mascara_columna(dw_listado,"totalformato",f_mascara_decimales(2))

f_mascara_columna(dw_detalle,"totalmetros",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"totalfamilia",f_mascara_decimales(2))
f_mascara_columna(dw_detalle,"totalformato",f_mascara_decimales(2))

end event

on w_con_detalle_articulos_clientes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.gb_3=create gb_3
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.uo_manejo=create uo_manejo
this.gb_2=create gb_2
this.cb_familias=create cb_familias
this.uo_familias=create uo_familias
this.cb_calidades=create cb_calidades
this.dw_detalle=create dw_detalle
this.uo_calidad=create uo_calidad
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.cb_formatos=create cb_formatos
this.cb_2=create cb_2
this.uo_formatos=create uo_formatos
this.m2=create m2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.em_fechahasta
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.uo_manejo
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.cb_familias
this.Control[iCurrent+12]=this.uo_familias
this.Control[iCurrent+13]=this.cb_calidades
this.Control[iCurrent+14]=this.dw_detalle
this.Control[iCurrent+15]=this.uo_calidad
this.Control[iCurrent+16]=this.pb_1
this.Control[iCurrent+17]=this.dw_listado
this.Control[iCurrent+18]=this.cb_formatos
this.Control[iCurrent+19]=this.cb_2
this.Control[iCurrent+20]=this.uo_formatos
this.Control[iCurrent+21]=this.m2
end on

on w_con_detalle_articulos_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.uo_manejo)
destroy(this.gb_2)
destroy(this.cb_familias)
destroy(this.uo_familias)
destroy(this.cb_calidades)
destroy(this.dw_detalle)
destroy(this.uo_calidad)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.cb_formatos)
destroy(this.cb_2)
destroy(this.uo_formatos)
destroy(this.m2)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_detalle_articulos_clientes
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_detalle_articulos_clientes
integer y = 4
integer height = 40
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_detalle_articulos_clientes
integer x = 14
integer y = 4
integer width = 2674
end type

type pb_2 from upb_imprimir within w_con_detalle_articulos_clientes
integer x = 2706
integer y = 176
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type em_fechadesde from u_em_campo within w_con_detalle_articulos_clientes
integer x = 27
integer y = 176
integer width = 288
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_detalle_articulos_clientes
integer x = 357
integer y = 176
integer width = 288
integer taborder = 40
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_3 from groupbox within w_con_detalle_articulos_clientes
integer x = 1966
integer y = 220
integer width = 270
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_detalle_articulos_clientes
integer x = 9
integer y = 100
integer width = 649
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type cb_1 from commandbutton within w_con_detalle_articulos_clientes
integer x = 1957
integer y = 180
integer width = 274
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 &Ok"
end type

event clicked;if trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_codigo.text = ""
	uo_cliente.em_campo.text = ""
End if
uo_familias.visible = False
uo_calidad.visible = False
uo_formatos.visible = False
f_control(dw_detalle)

end event

type uo_cliente from u_em_campo_2 within w_con_detalle_articulos_clientes
integer x = 681
integer y = 176
integer width = 960
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type st_1 from statictext within w_con_detalle_articulos_clientes
integer x = 315
integer y = 168
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_manejo from u_manejo_datawindow within w_con_detalle_articulos_clientes
integer x = 2231
integer y = 132
integer width = 649
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type gb_2 from groupbox within w_con_detalle_articulos_clientes
integer x = 658
integer y = 100
integer width = 1010
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type cb_familias from commandbutton within w_con_detalle_articulos_clientes
event clicked pbm_bnclicked
integer x = 1687
integer y = 112
integer width = 274
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;if uo_familias.visible= True then
   uo_familias.visible = False
else
	uo_familias.visible= True
End if
end event

type uo_familias from u_marca_lista within w_con_detalle_articulos_clientes
event destroy ( )
boolean visible = false
integer x = 1440
integer y = 296
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type cb_calidades from commandbutton within w_con_detalle_articulos_clientes
event clicked pbm_bnclicked
integer x = 1687
integer y = 180
integer width = 274
integer height = 68
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

type dw_detalle from datawindow within w_con_detalle_articulos_clientes
integer x = 9
integer y = 328
integer width = 2830
integer height = 1088
string dataobject = "dw_con_detalle_articulos_clientes"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type uo_calidad from u_marca_lista within w_con_detalle_articulos_clientes
event destroy ( )
boolean visible = false
integer x = 82
integer y = 296
integer taborder = 60
boolean bringtotop = true
boolean border = false
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type pb_1 from upb_salir within w_con_detalle_articulos_clientes
integer x = 2715
integer y = 4
integer width = 119
integer height = 100
integer taborder = 0
end type

type dw_listado from datawindow within w_con_detalle_articulos_clientes
boolean visible = false
integer x = 2427
integer y = 96
integer width = 238
integer height = 152
string dataobject = "report_con_detalle_articulos_clientes"
boolean livescroll = true
end type

type cb_formatos from commandbutton within w_con_detalle_articulos_clientes
integer x = 1687
integer y = 248
integer width = 274
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;if uo_formatos.visible= True then
   uo_formatos.visible = False
else
	uo_formatos.visible= True
End if
end event

type cb_2 from commandbutton within w_con_detalle_articulos_clientes
integer x = 1961
integer y = 112
integer width = 270
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Resumen"
end type

event clicked;if detalle then
	dw_detalle.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.detail.height=0")
	cb_2.text="Detalle"
else
	dw_detalle.modify("datawindow.detail.height=65")
	dw_listado.modify("datawindow.detail.height=69")
	cb_2.text="Resumen"
end if

detalle=not detalle
end event

type uo_formatos from u_marca_lista within w_con_detalle_articulos_clientes
event destroy ( )
boolean visible = false
integer x = 768
integer y = 296
integer taborder = 90
boolean bringtotop = true
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type m2 from checkbox within w_con_detalle_articulos_clientes
integer x = 2016
integer y = 260
integer width = 155
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "m2"
boolean lefttext = true
end type

