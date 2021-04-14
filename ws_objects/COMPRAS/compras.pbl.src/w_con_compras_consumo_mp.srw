$PBExportHeader$w_con_compras_consumo_mp.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_compras_consumo_mp from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_compras_consumo_mp
end type
type em_fechadesde from u_em_campo within w_con_compras_consumo_mp
end type
type cb_2 from commandbutton within w_con_compras_consumo_mp
end type
type pb_imprimir_preli from upb_imprimir within w_con_compras_consumo_mp
end type
type dw_listado from datawindow within w_con_compras_consumo_mp
end type
type dw_1 from u_datawindow_consultas within w_con_compras_consumo_mp
end type
type cb_familias from commandbutton within w_con_compras_consumo_mp
end type
type gb_6 from groupbox within w_con_compras_consumo_mp
end type
type gb_5 from groupbox within w_con_compras_consumo_mp
end type
type gb_4 from groupbox within w_con_compras_consumo_mp
end type
type uo_familias from u_marca_lista within w_con_compras_consumo_mp
end type
type uo_tipo_materia from u_marca_lista within w_con_compras_consumo_mp
end type
type cb_tipos_materias from commandbutton within w_con_compras_consumo_mp
end type
type em_fechahasta from u_em_campo within w_con_compras_consumo_mp
end type
type st_1 from statictext within w_con_compras_consumo_mp
end type
type st_2 from statictext within w_con_compras_consumo_mp
end type
type gb_1 from groupbox within w_con_compras_consumo_mp
end type
end forward

global type w_con_compras_consumo_mp from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3707
integer height = 2084
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
em_fechadesde em_fechadesde
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
cb_familias cb_familias
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
uo_familias uo_familias
uo_tipo_materia uo_tipo_materia
cb_tipos_materias cb_tipos_materias
em_fechahasta em_fechahasta
st_1 st_1
st_2 st_2
gb_1 gb_1
end type
global w_con_compras_consumo_mp w_con_compras_consumo_mp

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string tipos_materias_marcadas[]
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
public subroutine f_filtro (datawindow arg_data)
end prototypes

public subroutine f_cargar (datawindow data);string   mp,nombre_mp,nombre_familia,tipo_materia,familia,tipo_unidad
string   nombre_tipo_materia,nombre_unidad,mascara_unidad
long     indice,total
dec      stock_inicial,stock_final,cantidad_comprada_albaranes,cantidad_comprada_facturas
dec      compras_periodo,consumo
datetime fecha_desde,fecha_hasta

fecha_desde = DateTime(Date(em_fechadesde.text))
fecha_hasta = DateTime(Date(em_fechahasta.text))

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(codigo_empresa,fecha_desde,fecha_hasta)

f_filtro(data)

total = data.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando",indice,total)
	
	mp           = data.object.codigo[indice]
	tipo_materia = data.object.tipo_materia[indice]
	familia      = data.object.familia[indice]
	tipo_unidad  = data.object.tipo_unidad[indice]
			
	nombre_familia      = f_nombre_familia_compras(codigo_empresa,tipo_materia,familia)
	nombre_tipo_materia = f_nombre_materia(codigo_empresa,tipo_materia)
	nombre_unidad       = f_nombre_unidad_compras(tipo_unidad)
	mascara_unidad      = f_mascara_unidad_compras(tipo_unidad)
	
	//Calculamos el stock inicial
	stock_inicial = 0
	
	select sum(cantidade) - sum(cantidads)
	into   :stock_inicial
	from   commovhis
	where  empresa    = :codigo_empresa
	and    mp         = :mp      
	and    fechmov   <= :fecha_desde
	and    situacion <> 'A';
	
	if isnull(stock_inicial) then stock_inicial = 0
	
	//Calculamos el stock final
	stock_final = 0
	
	select sum(cantidade) - sum(cantidads)
	into   :stock_final
	from   commovhis
	where  empresa    = :codigo_empresa
	and    mp         = :mp
	and    fechmov   <= :fecha_hasta
	and    situacion <> 'A';
	
	if isnull(stock_final) then stock_final = 0
	
	//Calculamos las compras del periodo
	//Albaranes
	select sum(comlinalb.cantidad)
	into   :cantidad_comprada_albaranes
	from   comlinalb,comcabalb
	where  comlinalb.empresa = :codigo_empresa
	and    comlinalb.mprima  = :mp
	and    comcabalb.fecha_alb between :fecha_desde and :fecha_hasta
	and    comcabalb.empresa = comlinalb.empresa
	and    comcabalb.anyo    = comlinalb.anyo
	and    comcabalb.albaran = comlinalb.albaran;
	
	if isnull(cantidad_comprada_albaranes) then cantidad_comprada_albaranes = 0		
	
	//Facturas
	select sum(cantidad)
	into   :cantidad_comprada_facturas
	from   comlinfac
	where  empresa = :codigo_empresa
	and    mprima  = :mp
	and    fecha_albaran between :fecha_desde and :fecha_hasta;
	
	if isnull(cantidad_comprada_facturas) then cantidad_comprada_facturas = 0
	
	compras_periodo = cantidad_comprada_albaranes + cantidad_comprada_facturas
	
	consumo = (stock_inicial + compras_periodo) - stock_final
	
	data.object.nombre_familia[indice]      = nombre_familia
	data.object.nombre_tipo_materia[indice] = nombre_tipo_materia
	data.object.nombre_unidad[indice]       = nombre_unidad
	data.object.mascara_unidad[indice]      = mascara_unidad
	data.object.stock_inicial[indice]       = stock_inicial
	data.object.stock_final[indice]         = stock_final
	data.object.compras_periodo[indice]     = compras_periodo
	data.object.venmprima_consumo[indice]   = consumo
next	

data.sort()		
data.GroupCalc()
data.SetRedraw(TRUE)		
end subroutine

public subroutine f_filtro (datawindow arg_data);string array_tipo_materias[]
string var_tipo_materia,var_familia,var_codigo_familia,var_filtro_familia
long   indice_array,indice,total

uo_familias.visible = false
uo_tipo_materia.visible = false

indice_array = 0
var_filtro_familia = ""
for indice = 1 to uo_tipo_materia.dw_marca.rowcount()
	if uo_tipo_materia.dw_marca.getitemstring(indice,"marca") = "S" then
		indice_array ++
		array_tipo_materias[indice_array] = uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")
		if var_filtro_familia = "" then
			var_filtro_familia = "'"+uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")+"/'"
		else
			var_filtro_familia = var_filtro_familia+",'"+uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")+"/'"
		end if
   end if
next
for indice = 1 to uo_familias.dw_marca.rowcount()
	if uo_familias.dw_marca.getitemstring(indice,"marca") = "S" then
		indice_array ++
		array_tipo_materias[indice_array] = uo_familias.dw_marca.getitemstring(indice,"codigo")
		if var_filtro_familia = "" then
			var_filtro_familia = "'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
		else
			var_filtro_familia = var_filtro_familia+",'"+uo_familias.dw_marca.getitemstring(indice,"codigo")+"'"
		end if
   end if
next

if indice_array > 0 then
	if total > 0 then
		for indice = 1 to total
			var_tipo_materia   = arg_data.object.venmprima_tipo_materia[indice]
			if isnull(var_tipo_materia) then 
				var_tipo_materia = ""
				arg_data.object.venmprima_tipo_materia[indice] = ""
			end if
			var_familia        = arg_data.object.venmprima_familia[indice]
			if isnull(var_familia) then 
				var_familia = ""
				arg_data.object.venmprima_familia[indice] = ""
			end if
			var_codigo_familia = var_tipo_materia+"/"+var_familia
			arg_data.object.venmprima_codigo_familia[indice] = var_codigo_familia
		next
	end if	

	arg_data.setfilter("tipo_materia_familia in("+var_filtro_familia+")")
	arg_data.filter()
else
	//messagebox("Atención","Debe seleccionar al menos un tipo de materia")
	//No se aplica filtro
end if
end subroutine

event open;call super::open;long indice

This.title = "CONSULTA COMPRAS Y CONSUMO DE MATERIAS PRIMAS"

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

em_fechadesde.text = "01/"+string(month(today()),"00")+"/"+string(year(today()),"00")
em_fechahasta.text = String(DateTime(Today()),"dd/mm/yy")

f_activar_campo(em_fechadesde)

uo_tipo_materia.f_cargar_datos("dw_ayuda_venmateria","","","Codigo","Tipo de materia")

for indice =1 to uo_tipo_materia.dw_marca.rowcount()
	tipos_materias_marcadas[indice] = "N"
next
end event

on w_con_compras_consumo_mp.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.cb_familias=create cb_familias
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.uo_familias=create uo_familias
this.uo_tipo_materia=create uo_tipo_materia
this.cb_tipos_materias=create cb_tipos_materias
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_familias
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.gb_5
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.uo_familias
this.Control[iCurrent+12]=this.uo_tipo_materia
this.Control[iCurrent+13]=this.cb_tipos_materias
this.Control[iCurrent+14]=this.em_fechahasta
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.gb_1
end on

on w_con_compras_consumo_mp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.cb_familias)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.uo_familias)
destroy(this.uo_tipo_materia)
destroy(this.cb_tipos_materias)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_compras_consumo_mp
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_compras_consumo_mp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_compras_consumo_mp
integer x = 14
integer y = 8
integer width = 3465
integer height = 84
end type

type pb_2 from upb_salir within w_con_compras_consumo_mp
integer x = 3502
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

type em_fechadesde from u_em_campo within w_con_compras_consumo_mp
integer x = 613
integer y = 140
integer width = 311
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_2 from commandbutton within w_con_compras_consumo_mp
event clicked pbm_bnclicked
integer x = 3017
integer y = 128
integer width = 411
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_cargar(dw_1)

end event

type pb_imprimir_preli from upb_imprimir within w_con_compras_consumo_mp
event clicked pbm_bnclicked
integer x = 3479
integer y = 128
integer taborder = 40
end type

event clicked;//f_cargar(dw_listado)
f_imprimir_datawindow(dw_1)

	


end event

type dw_listado from datawindow within w_con_compras_consumo_mp
boolean visible = false
integer x = 2661
integer y = 12
integer width = 238
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_compras_consumo_mp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from u_datawindow_consultas within w_con_compras_consumo_mp
integer x = 5
integer y = 248
integer width = 3611
integer height = 1604
integer taborder = 0
string dataobject = "dw_con_compras_consumo_mp"
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type cb_familias from commandbutton within w_con_compras_consumo_mp
integer x = 2213
integer y = 132
integer width = 411
integer height = 96
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
string  sel,tipo_materia,familia,tipo_materia_linea,codigo_familia
string  codigo_materia_familia,codigo_materia,descripcion_familia
boolean salir

for indice =1 to uo_tipo_materia.dw_marca.rowcount()
	if tipos_materias_marcadas[indice] <> uo_tipo_materia.dw_marca.getitemstring(indice,"marca") then
		tipo_materia = uo_tipo_materia.dw_marca.getitemstring(indice,"codigo")		
		if tipos_materias_marcadas[indice] = "S" then
			//Debemos eliminar las familias de ese tipo de materia	
			total2  = uo_familias.dw_marca.rowcount() 
			for indice2 = 1 to total2
				codigo_materia_familia = uo_familias.dw_marca.getitemstring(indice2,"codigo")		
				indice3 = 0
				codigo_materia = ""
				salir = false
				do 
					indice3 ++
					if mid(codigo_materia_familia,indice3,1) <> "/" then
						codigo_materia = codigo_materia + mid(codigo_materia_familia,indice3,1)
					else
						salir = true
					end if					
				loop until salir or indice3 = len(codigo_materia_familia)
				if codigo_materia = tipo_materia then
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
					"and tipo_materia = '"+tipo_materia+"'"
					
			//familias = f_cargar_cursor(sel)
			f_cargar_cursor_nuevo(sel, familias)
			total2  = familias.rowcount()
			for indice2 = 1 to total2
				familia             = familias.object.familia[indice2]
				descripcion_familia = familias.object.descripcion[indice2] 
				donde = uo_familias.dw_marca.insertrow(uo_familias.dw_marca.rowcount()+1)
				uo_familias.dw_marca.setitem(donde,"codigo",tipo_materia+"/"+familia)				
				uo_familias.dw_marca.setitem(donde,"texto",descripcion_familia)				
			next
		end if
		tipos_materias_marcadas[indice] = uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
	end if
next
destroy familias
uo_tipo_materia.visible = false
uo_familias.visible     = not(uo_familias.visible)
end event

type gb_6 from groupbox within w_con_compras_consumo_mp
integer x = 3008
integer y = 88
integer width = 608
integer height = 144
integer taborder = 10
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

type gb_5 from groupbox within w_con_compras_consumo_mp
integer x = 1774
integer y = 92
integer width = 430
integer height = 144
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

type gb_4 from groupbox within w_con_compras_consumo_mp
integer x = 2203
integer y = 92
integer width = 430
integer height = 144
integer taborder = 50
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

type uo_familias from u_marca_lista within w_con_compras_consumo_mp
event destroy ( )
boolean visible = false
integer x = 1847
integer y = 256
integer width = 1362
integer height = 668
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type uo_tipo_materia from u_marca_lista within w_con_compras_consumo_mp
event destroy ( )
boolean visible = false
integer x = 1417
integer y = 256
integer width = 1362
integer height = 668
boolean bringtotop = true
boolean border = false
end type

on uo_tipo_materia.destroy
call u_marca_lista::destroy
end on

type cb_tipos_materias from commandbutton within w_con_compras_consumo_mp
integer x = 1783
integer y = 132
integer width = 411
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tipos Materias"
end type

event clicked;uo_familias.visible = false
uo_tipo_materia.visible = not(uo_tipo_materia.visible)

end event

type em_fechahasta from u_em_campo within w_con_compras_consumo_mp
integer x = 1074
integer y = 140
integer width = 311
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_1 from statictext within w_con_compras_consumo_mp
integer x = 14
integer y = 148
integer width = 599
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Calcular consumos del "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_compras_consumo_mp
integer x = 942
integer y = 148
integer width = 110
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "al"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_compras_consumo_mp
integer y = 88
integer width = 1408
integer height = 156
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

