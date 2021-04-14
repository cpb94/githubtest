$PBExportHeader$w_estadistica_comparativa_compras.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_estadistica_comparativa_compras from w_int_con_empresa
end type
type pb_2 from upb_salir within w_estadistica_comparativa_compras
end type
type dw_1 from u_datawindow_consultas within w_estadistica_comparativa_compras
end type
type em_fechadesde from u_em_campo within w_estadistica_comparativa_compras
end type
type st_7 from statictext within w_estadistica_comparativa_compras
end type
type cb_2 from commandbutton within w_estadistica_comparativa_compras
end type
type pb_imprimir_preli from upb_imprimir within w_estadistica_comparativa_compras
end type
type uo_productos from u_marca_lista within w_estadistica_comparativa_compras
end type
type cb_3 from commandbutton within w_estadistica_comparativa_compras
end type
type gb_1 from groupbox within w_estadistica_comparativa_compras
end type
type cb_familias from commandbutton within w_estadistica_comparativa_compras
end type
type uo_familias from u_marca_lista within w_estadistica_comparativa_compras
end type
type em_fechahasta from u_em_campo within w_estadistica_comparativa_compras
end type
type st_1 from statictext within w_estadistica_comparativa_compras
end type
type gb_4 from groupbox within w_estadistica_comparativa_compras
end type
end forward

global type w_estadistica_comparativa_compras from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4631
integer height = 2272
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
uo_productos uo_productos
cb_3 cb_3
gb_1 gb_1
cb_familias cb_familias
uo_familias uo_familias
em_fechahasta em_fechahasta
st_1 st_1
gb_4 gb_4
end type
global w_estadistica_comparativa_compras w_estadistica_comparativa_compras

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);string filtro_productos, sel, v_mprima, v_descripcion, tipo
long   indice, productos_selecionados, familias_seleccionadas, i, donde, anyo, mes, dia
dec    cambio_moneda_proveedor, v_unidades1, v_importe1, v_unidades2, v_importe2
datetime fecha_desde1, fecha_hasta1, fecha_desde2, fecha_hasta2
string filtro_familias, v_unidad_medida, v_unidades1_abr, v_unidades2_abr, lsFamilia

if uo_productos.dw_marca.rowcount() < 1 then
	messagebox ("Aviso", "Debe Introducir, al menos, un producto en el filtro.")
	return
elseif uo_familias.dw_marca.rowcount() < 1 then
	messagebox ("Aviso", "Debe Introducir, al menos, una familia en el filtro.")
	return
end if

DataStore registros

data.Reset()

fecha_desde1 = DateTime(Date(em_fechadesde.text))
fecha_hasta1 = DateTime(Date(em_fechahasta.text))

anyo = year(date(em_fechadesde.text))
anyo  --
mes = month (date(em_fechadesde.text))
dia = day (date(em_fechadesde.text))
fecha_desde2 = datetime (date(string(dia)+'-'+string(mes)+'-'+string(anyo)))

anyo = year(date(em_fechahasta.text))
anyo  --
mes = month (date(em_fechahasta.text))
dia = day (date(em_fechahasta.text))
fecha_hasta2 = datetime (date(string(dia)+'-'+string(mes)+'-'+string(anyo)))

data.object.t_p1.text = "Del "+string (date(fecha_desde1))+" al "+string (date(fecha_hasta1))
data.object.t_p2.text = "Del "+string (date(fecha_desde2))+" al "+string (date(fecha_hasta2))
data.object.t_p1b.text = "Del "+string (date(fecha_desde1))+" al "+string (date(fecha_hasta1))
data.object.t_p2b.text = "Del "+string (date(fecha_desde2))+" al "+string (date(fecha_hasta2))

//---------------------------------------------------------------------------------------------------------------
//									FILTRO DE PRODUCTOS
//---------------------------------------------------------------------------------------------------------------

filtro_productos = ""
productos_selecionados = 0
for indice = 1 to uo_productos.dw_marca.rowcount()
	if uo_productos.dw_marca.getitemstring(indice,"marca")="S" then
		if trim(filtro_productos) = "" then
			filtro_productos = "'"+ uo_productos.dw_marca.getitemstring(indice,"codigo") +"'"
		else
			filtro_productos = filtro_productos+",'"+uo_productos.dw_marca.getitemstring(indice,"codigo")+"'"
		end if
		productos_selecionados ++
	end if
next
//---------------------------------------------------------------------------------------------------------------
//								FIN DEL FILTRO DE PRODUCTOS
//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------
//									FILTRO DE FAMILIAS
//---------------------------------------------------------------------------------------------------------------
filtro_familias = ""
familias_seleccionadas = 0
for indice = 1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(indice,"marca")="S" then
		if trim(filtro_familias) = "" then
			filtro_familias = "'"+ uo_familias.dw_marca.getitemstring(indice,"codigo") +"'"
		else
			filtro_familias = filtro_familias+",'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
		end if
		familias_seleccionadas ++
	end if
next


//---------------------------------------------------------------------------------------------------------------
//								FIN DEL FILTRO DE FAMILIAS
//---------------------------------------------------------------------------------------------------------------


sel = " select distinct comlinfac.mprima, venmprima.descripcion, comlinfac.unidad_medida, comunimedida.abreviado, venfamilias.descripcion "+&
		" from comlinfac, venmprima, comunimedida, comcabfac, venfamilias "+&
		" where comlinfac.empresa = '"+codigo_empresa+"' "+&
		" and comlinfac.empresa = venmprima.empresa " +&
		" and comlinfac.unidad_medida = comunimedida.codigo " +&
		" and comlinfac.empresa = comcabfac.empresa " +&
		" and comlinfac.anyo = comcabfac.anyo " +&
		" and comlinfac.factura = comcabfac.factura " +&
		" and comlinfac.proveedor = comcabfac.proveedor " +&
		" and comlinfac.mprima = venmprima.codigo " +&
		" and venmprima.empresa = venfamilias.empresa " +&
		" and venmprima.familia = venfamilias.familia " +&
		" and venmprima.tipo_materia = venfamilias.tipo_materia " +&
		" and venmprima.tipo_materia in ("+filtro_productos+")"+&
		" and venmprima.familia in ("+filtro_familias+")"+&
		" and ( ( comcabfac.fecha_fac >= '"+string(fecha_desde1, "dd-mm-yy")+"' and comcabfac.fecha_fac <= '"+string(fecha_hasta1, "dd-mm-yy")+"' ) "+&
		" or ( comcabfac.fecha_fac >= '"+string(fecha_desde2, "dd-mm-yy")+"' and comcabfac.fecha_fac <= '"+string(fecha_hasta2, "dd-mm-yy")+"') ) "
		
		
	/*	
sel = " select distinct comlinfac.mprima, venmprima.descripcion, comlinfac.unidad_medida, comunimedida.abreviado "+&
		" from comlinfac, venmprima, comunimedida, comcabfac, venfamilias "+&
		" where comlinfac.empresa = '"+codigo_empresa+"' "+&
		" and comlinfac.empresa = venmprima.empresa " +&
		" and comlinfac.unidad_medida = comunimedida.codigo " +&
		" and comlinfac.empresa = comcabfac.empresa " +&
		" and comlinfac.anyo = comcabfac.anyo " +&
		" and comlinfac.factura = comcabfac.factura " +&
		" and comlinfac.proveedor = comcabfac.proveedor " +&
		" and comlinfac.mprima = venmprima.codigo " +&
		" and venmprima.tipo_materia in ("+filtro_productos+")"+&
		" and venmprima.familia in ("+filtro_familias+")"+&
		" and ( ( comcabfac.fecha_fac >= '"+string(fecha_desde1, "dd-mm-yy")+"' and comcabfac.fecha_fac <= '"+string(fecha_hasta1, "dd-mm-yy")+"' ) "+&
		" or ( comcabfac.fecha_fac >= '"+string(fecha_desde2, "dd-mm-yy")+"' and comcabfac.fecha_fac <= '"+string(fecha_hasta2, "dd-mm-yy")+"') ) "
		*/		
	
f_cargar_cursor_nuevo (sel, registros)
for i = 1 to registros.RowCount()
	v_mprima = registros.object.comlinfac_mprima[i]
	v_descripcion = registros.object.venmprima_descripcion[i]
	v_unidad_medida = registros.object.comlinfac_unidad_medida[i]
	v_unidades1_abr = registros.object.comunimedida_abreviado[i]
	v_unidades2_abr = registros.object.comunimedida_abreviado[i]
	lsFamilia = registros.object.venfamilias_descripcion[i]
	
	v_unidades1 = 0
	v_importe1 = 0
	select sum (comlinfac.cantidad), sum (comlinfac.importe) 
	into :v_unidades1, :v_importe1
	from comlinfac, comcabfac
	where comlinfac.empresa = :codigo_empresa
	and comlinfac.mprima = :v_mprima
//	and comlinfac.descripcion = :v_descripcion
	and comlinfac.unidad_medida = :v_unidad_medida
	and comlinfac.empresa = comcabfac.empresa
	and comlinfac.anyo = comcabfac.anyo
	and comlinfac.factura = comcabfac.factura
	and comlinfac.proveedor = comcabfac.proveedor
	and comcabfac.fecha_fac >= :fecha_desde1
	and comcabfac.fecha_fac <= :fecha_hasta1
	group by comlinfac.mprima;
	
	v_unidades2 = 0
	v_importe2 = 0
	select sum (comlinfac.cantidad), sum (comlinfac.importe) 
	into :v_unidades2, :v_importe2
	from comlinfac, comcabfac
	where comlinfac.empresa = :codigo_empresa
	and comlinfac.mprima = :v_mprima
//	and comlinfac.descripcion = :v_descripcion
	and comlinfac.unidad_medida = :v_unidad_medida
	and comlinfac.empresa = comcabfac.empresa
	and comlinfac.anyo = comcabfac.anyo
	and comlinfac.factura = comcabfac.factura
	and comlinfac.proveedor = comcabfac.proveedor
	and comcabfac.fecha_fac >= :fecha_desde2
	and comcabfac.fecha_fac <= :fecha_hasta2
	group by comlinfac.mprima;

	if not (v_importe1 = 0 and v_importe2 = 0) then	
		donde = data.insertrow(0)
		if v_importe1 <> 0 and v_importe2 <> 0 then	
			tipo = 'A'
			data.object.suma1_2_p1[donde] = v_importe1
			data.object.suma1_2_p2[donde] = v_importe2
			data.object.unidades_ambos_p1[donde] = v_unidades1
			data.object.unidades_ambos_p2[donde] = v_unidades2
		end if
		if v_importe1 <> 0 and v_importe2 = 0 then	
			tipo = 'B'
			data.object.suma1[donde] = v_importe1
			data.object.unidades_p1[donde] = v_unidades1
		end if
		if v_importe1 = 0 and v_importe2 <> 0 then	
			tipo = 'C'
			data.object.suma2[donde] = v_importe2
			data.object.unidades_p2[donde] = v_unidades2
		end if
		data.object.articulo[donde]              	= v_mprima
		data.object.descripcion[donde]           = v_descripcion
		data.object.unidades1[donde]            	= v_unidades1
		data.object.importe1[donde]             	= v_importe1
		data.object.unidades2[donde]            	= v_unidades2
		data.object.importe2[donde]             	= v_importe2
		data.object.tipo[donde]             		= tipo
		data.object.unidades1_abr[donde]      = v_unidades1_abr
		data.object.unidades2_abr[donde]      = v_unidades2_abr
		data.object.familia[donde]          		= lsFamilia
	end if
	
	f_mensaje_proceso ("Materia Prima: "+v_mprima, i, registros.rowcount())
next

data.sort()		
data.GroupCalc()

uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")

for indice =1 to uo_productos.dw_marca.rowcount()
	productos_marcados[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next

uo_familias.dw_marca.reset()
//uo_familias.f_cargar_datos("dw_ayuda_venfamilias","","","Familia","Descripción")
//
//for indice =1 to uo_familias.dw_marca.rowcount()
//	productos_marcados[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
//next


destroy registros
end subroutine

event open;call super::open;long indice
int anyo, mes, dia


This.title = " ESTADÍSTICA COMPARATIVA DE COMPRAS "

dw_1.SetTransObject(sqlca)
//dw_listado.SetTransObject(sqlca)

anyo = year(Today())
anyo  --
mes = month (today())
dia = day (today())


em_fechadesde.text = string(dia)+'-'+string(mes)+'-'+string(anyo)
em_fechahasta.text = String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
uo_productos.f_cargar_datos("dw_ayuda_venmateria","","","Producto","Descripción")

for indice =1 to uo_productos.dw_marca.rowcount()
	productos_marcados[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next


end event

on w_estadistica_comparativa_compras.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_productos=create uo_productos
this.cb_3=create cb_3
this.gb_1=create gb_1
this.cb_familias=create cb_familias
this.uo_familias=create uo_familias
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.uo_productos
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.cb_familias
this.Control[iCurrent+11]=this.uo_familias
this.Control[iCurrent+12]=this.em_fechahasta
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.gb_4
end on

on w_estadistica_comparativa_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_productos)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.cb_familias)
destroy(this.uo_familias)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.gb_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_estadistica_comparativa_compras
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_estadistica_comparativa_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_estadistica_comparativa_compras
integer y = 20
integer width = 3835
integer height = 84
end type

type pb_2 from upb_salir within w_estadistica_comparativa_compras
integer x = 3895
integer y = 16
integer width = 114
integer height = 104
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_estadistica_comparativa_compras
integer x = 55
integer y = 248
integer width = 4507
integer height = 1812
integer taborder = 0
string dataobject = "dw_estadistica_comparativa_compras"
boolean vscrollbar = true
boolean livescroll = false
end type

type em_fechadesde from u_em_campo within w_estadistica_comparativa_compras
integer x = 1385
integer y = 136
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_estadistica_comparativa_compras
integer x = 1134
integer y = 140
integer width = 233
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_estadistica_comparativa_compras
event clicked pbm_bnclicked
integer x = 3547
integer y = 132
integer width = 361
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;uo_productos.visible = false
uo_familias.visible = false

f_cargar(dw_1)

end event

type pb_imprimir_preli from upb_imprimir within w_estadistica_comparativa_compras
event clicked pbm_bnclicked
integer x = 3909
integer y = 132
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_cargar(dw_1)
f_imprimir_datawindow(dw_1)

	


end event

type uo_productos from u_marca_lista within w_estadistica_comparativa_compras
event destroy ( )
boolean visible = false
integer x = 69
integer y = 240
integer width = 1349
integer height = 656
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_productos.destroy
call u_marca_lista::destroy
end on

type cb_3 from commandbutton within w_estadistica_comparativa_compras
integer x = 82
integer y = 132
integer width = 366
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Productos"
end type

event clicked;uo_productos.visible = not(uo_productos.visible)
uo_familias.visible = false

end event

type gb_1 from groupbox within w_estadistica_comparativa_compras
integer x = 73
integer y = 92
integer width = 384
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_familias from commandbutton within w_estadistica_comparativa_compras
integer x = 471
integer y = 132
integer width = 343
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;long    indice,indice2,total2,indice3,donde
datastore familias
string  sel, producto, familia, tipo_producto_linea, codigo_familia
string  codigo_producto_familia, codigo_producto, descripcion_familia
boolean salir


for indice =1 to uo_productos.dw_marca.rowcount()
	if productos_marcados[indice] <> uo_productos.dw_marca.getitemstring(indice,"marca") then
		producto= uo_productos.dw_marca.getitemstring(indice,"codigo")		
		if productos_marcados[indice] = "S" then
			//Debemos eliminar las familias de ese tipo de materia	
			total2  = uo_familias.dw_marca.rowcount() 
			for indice2 = 1 to total2
				codigo_producto_familia = uo_familias.dw_marca.getitemstring(indice2,"codigo")		
				indice3 = 0
				codigo_producto = ""
				salir = false
				do 
					indice3 ++
					if mid(codigo_producto_familia,indice3,1) <> "/" then
						codigo_producto = codigo_producto + mid(codigo_producto_familia,indice3,1)
					else
						salir = true
					end if					
				loop until salir or indice3 = len(codigo_producto_familia)
				if codigo_producto = producto then
					uo_familias.dw_marca.deleterow(indice2)
					total2  = uo_familias.dw_marca.rowcount() 
					indice2 = indice2 -1
				end if
			next
		else
			//Debemos añadir las familias de ese tipo de materia			
			sel = "select familia,descripcion "+&
					"from venfamilias "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and tipo_materia = '"+producto+"'"
					
			//familias = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, familias)
			total2  = familias.rowcount()
			for indice2 = 1 to total2
				familia             = familias.object.familia[indice2]
				descripcion_familia = familias.object.descripcion[indice2] 
				donde = uo_familias.dw_marca.insertrow(uo_familias.dw_marca.rowcount()+1)
				uo_familias.dw_marca.setitem(donde,"codigo",familia)				
				uo_familias.dw_marca.setitem(donde,"texto", 'P:'+producto+' / '+descripcion_familia)				
			next
		end if
		productos_marcados[indice] = uo_productos.dw_marca.getitemstring(indice,"marca")
	end if
next
destroy familias
uo_productos.visible = false
uo_familias.visible     = not(uo_familias.visible)
end event

type uo_familias from u_marca_lista within w_estadistica_comparativa_compras
event destroy ( )
boolean visible = false
integer x = 466
integer y = 240
integer width = 1362
integer height = 668
integer taborder = 50
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type em_fechahasta from u_em_campo within w_estadistica_comparativa_compras
integer x = 2011
integer y = 136
integer width = 311
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_estadistica_comparativa_compras
integer x = 1760
integer y = 140
integer width = 233
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_estadistica_comparativa_compras
integer x = 462
integer y = 92
integer width = 361
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

