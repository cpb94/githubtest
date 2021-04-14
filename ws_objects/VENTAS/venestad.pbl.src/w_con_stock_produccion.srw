$PBExportHeader$w_con_stock_produccion.srw
forward
global type w_con_stock_produccion from w_int_con_empresa
end type
type gb_15 from groupbox within w_con_stock_produccion
end type
type gb_12 from groupbox within w_con_stock_produccion
end type
type gb_11 from groupbox within w_con_stock_produccion
end type
type gb_9 from groupbox within w_con_stock_produccion
end type
type gb_2 from groupbox within w_con_stock_produccion
end type
type pb_imprimir_preli from picturebutton within w_con_stock_produccion
end type
type cb_1 from commandbutton within w_con_stock_produccion
end type
type cb_2 from commandbutton within w_con_stock_produccion
end type
type uo_calidad from u_marca_lista within w_con_stock_produccion
end type
type st_1 from statictext within w_con_stock_produccion
end type
type em_cuanto from u_em_campo within w_con_stock_produccion
end type
type gb_3 from groupbox within w_con_stock_produccion
end type
type dw_consulta from datawindow within w_con_stock_produccion
end type
type cb_familias from commandbutton within w_con_stock_produccion
end type
type uo_familias from u_marca_lista within w_con_stock_produccion
end type
type dw_listado from datawindow within w_con_stock_produccion
end type
type unidades from dropdownlistbox within w_con_stock_produccion
end type
type st_2 from statictext within w_con_stock_produccion
end type
type st_3 from statictext within w_con_stock_produccion
end type
type gb_10 from groupbox within w_con_stock_produccion
end type
type st_4 from statictext within w_con_stock_produccion
end type
type pasar from dropdownlistbox within w_con_stock_produccion
end type
type rotacion from dropdownlistbox within w_con_stock_produccion
end type
type pb_2 from upb_salir within w_con_stock_produccion
end type
type comparacion from dropdownlistbox within w_con_stock_produccion
end type
end forward

global type w_con_stock_produccion from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2944
integer height = 1632
string title = "Consulta de Movimientos"
gb_15 gb_15
gb_12 gb_12
gb_11 gb_11
gb_9 gb_9
gb_2 gb_2
pb_imprimir_preli pb_imprimir_preli
cb_1 cb_1
cb_2 cb_2
uo_calidad uo_calidad
st_1 st_1
em_cuanto em_cuanto
gb_3 gb_3
dw_consulta dw_consulta
cb_familias cb_familias
uo_familias uo_familias
dw_listado dw_listado
unidades unidades
st_2 st_2
st_3 st_3
gb_10 gb_10
st_4 st_4
pasar pasar
rotacion rotacion
pb_2 pb_2
comparacion comparacion
end type
global w_con_stock_produccion w_con_stock_produccion

type variables
String ante_articulo,retrasos,cadena[1 to 20]

end variables

forward prototypes
public function string f_filtro2 ()
public function decimal rotacion (string empresa, string articulo, string calidad, string tipo_pallet)
public subroutine f_mov_rotacion ()
public function boolean f_proceso (datawindow d)
end prototypes

public function string f_filtro2 ();string filtro

filtro="(disponible "+comparacion.text+" "+string(dec(em_cuanto.text),"##############0")+")"

return filtro
end function

public function decimal rotacion (string empresa, string articulo, string calidad, string tipo_pallet);Dec rot
DateTime f1,f2
Dec dias
IF rotacion.text = "Mensual"    Then dias = -30
IF rotacion.text = "Semestral"  Then dias = -60
IF rotacion.text = "Trimestral" Then dias = -90
f1= DateTime(RelativeDate(Today(),dias))
f2 = DateTime(Today())

select sum(cantidads-cantidade) INTO :rot FROM almmovhis
WHERE almmovhis.empresa  = :codigo_empresa
AND   almmovhis.fechmov between :f1 and :f2
AND   almmovhis.articulo     = :articulo
AND   almmovhis.calidad      = :calidad 
AND   almmovhis.tipo_pallet  = :tipo_pallet
AND   almmovhis.tipomov  in (:cadena[1],:cadena[2],:cadena[3],:cadena[4],:cadena[5],:cadena[6],:cadena[7],:cadena[8],:cadena[9],:cadena[10],:cadena[11],:cadena[12],:cadena[13],:cadena[14],:cadena[15],:cadena[16],:cadena[17],:cadena[18]) ;

Return rot
end function

public subroutine f_mov_rotacion ();String tipomov
String sel
DataStore d
int r2,r1

Sel = " Select tipomov from decmov "

cadena = {""}

//d = f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

r2 = d.RowCount()
For r1 = 1 To r2
	tipomov    = d.GetItemString(r1,"tipomov")
   cadena[r1]=tipomov	   
Next

destroy d
end subroutine

public function boolean f_proceso (datawindow d);
f_mascara_columna(d,"tot1",f_mascara_decimales(2))
f_mascara_columna(d,"tot2",f_mascara_decimales(2))
f_mascara_columna(d,"tot3",f_mascara_decimales(2))

dec{2} pedidos,fabricar,stock
string articulo,tipo_pallet,calidad,formato,nombre_articulo
uo_calidad.visible=false
uo_familias.visible=false
d.SetRedraw(FALSE)
string calidades[1 to 20],tipounidad
string familias[1 to 50]
long i

calidades = {""}
familias  = {""}

d.reset()
d.setfilter("")
d.setredraw(false)
for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		calidades[i]=uo_calidad.dw_marca.getitemstring(i,"codigo")

	end if
next
for i=1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(i,"marca")="S" then
		familias[i]=uo_familias.dw_marca.getitemstring(i,"codigo")

	end if
next

if unidades.text="Piezas" then tipounidad = "0"
if unidades.text="Metros" then tipounidad = "1"
if unidades.text="Todo" then tipounidad = "%"

f_mensaje_proceso("Espere Por Favor ",0,100)
d.retrieve(codigo_empresa,calidades,familias,tipounidad)
f_mensaje_proceso("Espere Por Favor ",50,100)
if d.rowcount()=0 then
	pb_imprimir_preli.enabled=false
	f_mensaje_proceso("Espere Por Favor ",100,100)
	messagebox("Atencion","Consulta sin datos")
	return TRUE
else
	pb_imprimir_preli.enabled=true
end if


for i=1 TO d.rowcount()


  articulo = d.getitemstring(i,"almlinubica_articulo")
  calidad = d.getitemstring(i,"almlinubica_calidad")
  tipo_pallet= d.getitemstring(i,"tipo_pallet") 

  stock= d.getitemnumber(i,"total") 
    
  Select Sum(cantidad) Into :pedidos From venliped
  Where  empresa  = :codigo_empresa
  And    articulo = :articulo
  And    calidad  = :calidad
  And    tipo_pallet = :tipo_pallet
  and    situacion <> "F";
  if isnull(pedidos) then pedidos = 0
  
  Select Sum(cantidad) Into :fabricar From venliped
  Where  empresa     = :codigo_empresa
  And    articulo    = :articulo
  And    calidad     = :calidad
  And    tipo_pallet = :tipo_pallet
  and    situacion = "F";
  if isnull(fabricar) then fabricar = 0

  Select formato,descripcion Into :formato,:nombre_articulo From articulos
  Where empresa = :codigo_empresa
  And   codigo  = :articulo;
  
  if unidades.text="Todo" or pasar.text ="Piezas" then
		stock = f_conversion_cantidad_piezas_old(codigo_empresa,articulo,stock)
		pedidos = f_conversion_cantidad_piezas_old(codigo_empresa,articulo,pedidos)
		fabricar = f_conversion_cantidad_piezas_old(codigo_empresa,articulo,fabricar)
  end if	
  if pasar.text ="Metros 2" then
		stock = f_conversion_cantidad_m2(codigo_empresa,articulo,stock)
		pedidos = f_conversion_cantidad_m2(codigo_empresa,articulo,pedidos)
		fabricar = f_conversion_cantidad_m2(codigo_empresa,articulo,fabricar)
		d.SetItem(i,"unidad","M2")
  end if	
  d.SetItem(i,"disponible",stock - pedidos)
  d.SetItem(i,"fabricar",fabricar)
  d.SetItem(i,"formato",formato)
  d.SetItem(i,"nombre_formato",f_nombre_formato(codigo_empresa,formato))
  d.SetItem(i,"rotacion",rotacion(codigo_empresa,articulo,calidad,tipo_pallet))
  d.SetItem(i,"nombre_articulo",nombre_articulo)
  d.SetItem(i,"nombre_calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
  d.SetItem(i,"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
  f_mensaje_proceso("Espere Por Favor "+String(i) +" "+ String(d.rowcount()),i+d.rowcount(),d.rowcount()*2)
next

d.setfilter(f_filtro2())
d.filter()
d.SetSort("nombre_formato,nombre_articulo,nombre_tipo_pallet")
d.Sort()
d.SetRedraw(TRUE)
d.GroupCalc() 
f_mensaje_proceso("Espere Por Favor ",100,100)
RETURN true

end function

event open;call super::open;dw_consulta.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
Int reg
This.title = " CONSULTA STOCK POR FORMATOS"

// recoge los movimientos para la rotación
f_mov_rotacion()

uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")
uo_familias.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_calidad.dw_marca.SetItem(1,"marca","S")
reg = uo_familias.dw_marca.find("codigo = '1'",1,uo_familias.dw_marca.RowCount())
uo_familias.dw_marca.SetItem(reg,"marca","S")
reg = uo_familias.dw_marca.find("codigo = '2'",1,uo_familias.dw_marca.RowCount())
uo_familias.dw_marca.SetItem(reg,"marca","S")
em_cuanto.SetFocus()
//f_activar_campo(em_cuanto)

end event

on w_con_stock_produccion.create
int iCurrent
call super::create
this.gb_15=create gb_15
this.gb_12=create gb_12
this.gb_11=create gb_11
this.gb_9=create gb_9
this.gb_2=create gb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_calidad=create uo_calidad
this.st_1=create st_1
this.em_cuanto=create em_cuanto
this.gb_3=create gb_3
this.dw_consulta=create dw_consulta
this.cb_familias=create cb_familias
this.uo_familias=create uo_familias
this.dw_listado=create dw_listado
this.unidades=create unidades
this.st_2=create st_2
this.st_3=create st_3
this.gb_10=create gb_10
this.st_4=create st_4
this.pasar=create pasar
this.rotacion=create rotacion
this.pb_2=create pb_2
this.comparacion=create comparacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_15
this.Control[iCurrent+2]=this.gb_12
this.Control[iCurrent+3]=this.gb_11
this.Control[iCurrent+4]=this.gb_9
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.uo_calidad
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.em_cuanto
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.dw_consulta
this.Control[iCurrent+14]=this.cb_familias
this.Control[iCurrent+15]=this.uo_familias
this.Control[iCurrent+16]=this.dw_listado
this.Control[iCurrent+17]=this.unidades
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.gb_10
this.Control[iCurrent+21]=this.st_4
this.Control[iCurrent+22]=this.pasar
this.Control[iCurrent+23]=this.rotacion
this.Control[iCurrent+24]=this.pb_2
this.Control[iCurrent+25]=this.comparacion
end on

on w_con_stock_produccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_15)
destroy(this.gb_12)
destroy(this.gb_11)
destroy(this.gb_9)
destroy(this.gb_2)
destroy(this.pb_imprimir_preli)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_calidad)
destroy(this.st_1)
destroy(this.em_cuanto)
destroy(this.gb_3)
destroy(this.dw_consulta)
destroy(this.cb_familias)
destroy(this.uo_familias)
destroy(this.dw_listado)
destroy(this.unidades)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_10)
destroy(this.st_4)
destroy(this.pasar)
destroy(this.rotacion)
destroy(this.pb_2)
destroy(this.comparacion)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_consulta)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_consulta)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_consulta)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_consulta)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_produccion
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_produccion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_produccion
integer y = 20
integer width = 2053
end type

type gb_15 from groupbox within w_con_stock_produccion
integer x = 2341
integer y = 92
integer width = 393
integer height = 80
integer taborder = 50
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

type gb_12 from groupbox within w_con_stock_produccion
integer x = 1641
integer y = 96
integer width = 379
integer height = 196
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_11 from groupbox within w_con_stock_produccion
integer x = 1266
integer y = 96
integer width = 375
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_9 from groupbox within w_con_stock_produccion
integer x = 2341
integer y = 140
integer width = 393
integer height = 152
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_stock_produccion
integer x = 2021
integer y = 100
integer width = 320
integer height = 192
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_imprimir_preli from picturebutton within w_con_stock_produccion
integer x = 2738
integer y = 172
integer width = 128
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_proceso(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type cb_1 from commandbutton within w_con_stock_produccion
integer x = 2039
integer y = 140
integer width = 283
integer height = 68
integer taborder = 70
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

type cb_2 from commandbutton within w_con_stock_produccion
event clicked pbm_bnclicked
integer x = 2359
integer y = 184
integer width = 352
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_proceso(dw_consulta)
end event

type uo_calidad from u_marca_lista within w_con_stock_produccion
event destroy ( )
boolean visible = false
integer x = 1513
integer y = 304
boolean bringtotop = true
boolean border = false
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type st_1 from statictext within w_con_stock_produccion
integer x = 55
integer y = 172
integer width = 306
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad:"
boolean focusrectangle = false
end type

type em_cuanto from u_em_campo within w_con_stock_produccion
integer x = 535
integer y = 168
integer width = 320
integer taborder = 60
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###,##0"
string displaydata = "$"
end type

type gb_3 from groupbox within w_con_stock_produccion
integer x = 23
integer y = 96
integer width = 878
integer height = 196
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_consulta from datawindow within w_con_stock_produccion
integer x = 23
integer y = 292
integer width = 2711
integer height = 1112
string dataobject = "dw_con_stock_produccion_2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_familias from commandbutton within w_con_stock_produccion
event clicked pbm_bnclicked
integer x = 2039
integer y = 212
integer width = 283
integer height = 68
integer taborder = 90
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

type uo_familias from u_marca_lista within w_con_stock_produccion
event destroy ( )
boolean visible = false
integer x = 142
integer y = 292
integer taborder = 80
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type dw_listado from datawindow within w_con_stock_produccion
boolean visible = false
integer x = 2194
integer y = 28
integer width = 215
integer height = 168
string dataobject = "report_con_stock_produccion_2"
boolean livescroll = true
end type

type unidades from dropdownlistbox within w_con_stock_produccion
integer x = 914
integer y = 188
integer width = 338
integer height = 276
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todo"
boolean vscrollbar = true
string item[] = {"Piezas","Metros","Todo"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "Metros" then pasar.text = "Metros"
if this.text = "Piezas" then pasar.text = "Piezas"
if this.text = "Todo" then pasar.text = "Piezas"
end event

type st_2 from statictext within w_con_stock_produccion
integer x = 1275
integer y = 136
integer width = 233
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Rotación"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_stock_produccion
integer x = 914
integer y = 136
integer width = 242
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Unidades"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_10 from groupbox within w_con_stock_produccion
integer x = 901
integer y = 96
integer width = 366
integer height = 196
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_4 from statictext within w_con_stock_produccion
integer x = 1655
integer y = 136
integer width = 187
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pasar a"
alignment alignment = center!
boolean focusrectangle = false
end type

type pasar from dropdownlistbox within w_con_stock_produccion
integer x = 1650
integer y = 188
integer width = 357
integer height = 228
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Piezas"
boolean allowedit = true
boolean vscrollbar = true
string item[] = {"Piezas","Metros 2"}
borderstyle borderstyle = stylelowered!
end type

type rotacion from dropdownlistbox within w_con_stock_produccion
integer x = 1275
integer y = 188
integer width = 352
integer height = 276
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Mensual"
boolean vscrollbar = true
string item[] = {"Mensual","Semanal","Trimestral"}
borderstyle borderstyle = stylelowered!
end type

type pb_2 from upb_salir within w_con_stock_produccion
integer x = 2738
integer y = 4
integer width = 128
integer height = 116
integer taborder = 0
boolean bringtotop = true
end type

type comparacion from dropdownlistbox within w_con_stock_produccion
integer x = 343
integer y = 168
integer width = 187
integer height = 228
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Symbol"
long backcolor = 12632256
string text = ">"
boolean allowedit = true
boolean vscrollbar = true
string item[] = {"<",">","<=",">=","=","<>"}
end type

