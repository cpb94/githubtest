$PBExportHeader$w_con_mprima_materia_familia.srw
forward
global type w_con_mprima_materia_familia from w_int_con_empresa
end type
type st_3 from statictext within w_con_mprima_materia_familia
end type
type pb_2 from upb_salir within w_con_mprima_materia_familia
end type
type uo_proveedor from u_em_campo_2 within w_con_mprima_materia_familia
end type
type dw_1 from datawindow within w_con_mprima_materia_familia
end type
type cb_1 from commandbutton within w_con_mprima_materia_familia
end type
type pb_imprimir from upb_imprimir within w_con_mprima_materia_familia
end type
type dw_listado from datawindow within w_con_mprima_materia_familia
end type
type gb_5 from groupbox within w_con_mprima_materia_familia
end type
type gb_4 from groupbox within w_con_mprima_materia_familia
end type
type gb_3 from groupbox within w_con_mprima_materia_familia
end type
type gb_2 from groupbox within w_con_mprima_materia_familia
end type
type gb_1 from groupbox within w_con_mprima_materia_familia
end type
type uo_tipo_materia from u_marca_lista within w_con_mprima_materia_familia
end type
type cb_tipos_materias from commandbutton within w_con_mprima_materia_familia
end type
type cb_familias from commandbutton within w_con_mprima_materia_familia
end type
type uo_familias from u_marca_lista within w_con_mprima_materia_familia
end type
type sle_num_proveedores from singlelineedit within w_con_mprima_materia_familia
end type
type st_2 from statictext within w_con_mprima_materia_familia
end type
type st_1 from statictext within w_con_mprima_materia_familia
end type
type uo_mp from singlelineedit within w_con_mprima_materia_familia
end type
end forward

global type w_con_mprima_materia_familia from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 4361
integer height = 3176
string title = "Consulta de Movimientos"
string icon = "Application!"
st_3 st_3
pb_2 pb_2
uo_proveedor uo_proveedor
dw_1 dw_1
cb_1 cb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
uo_tipo_materia uo_tipo_materia
cb_tipos_materias cb_tipos_materias
cb_familias cb_familias
uo_familias uo_familias
sle_num_proveedores sle_num_proveedores
st_2 st_2
st_1 st_1
uo_mp uo_mp
end type
global w_con_mprima_materia_familia w_con_mprima_materia_familia

type variables
boolean detalle = false
string ante_articulo
string tipos_materias_marcadas[]
end variables

event open;call super::open;long indice

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = "CONSULTA MATERIAS PRIMAS POR PROVEEDOR"
istr_parametros = Message.PowerObjectParm
uo_tipo_materia.f_cargar_datos("dw_ayuda_venmateria","","","Codigo","Tipo de materia")

for indice =1 to uo_tipo_materia.dw_marca.rowcount()
	tipos_materias_marcadas[indice] = "N"//uo_tipo_materia.dw_marca.getitemstring(indice,"marca")
next

f_activar_campo(uo_proveedor.em_campo)
sle_num_proveedores.text = '1'
end event

on w_con_mprima_materia_familia.create
int iCurrent
call super::create
this.st_3=create st_3
this.pb_2=create pb_2
this.uo_proveedor=create uo_proveedor
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_tipo_materia=create uo_tipo_materia
this.cb_tipos_materias=create cb_tipos_materias
this.cb_familias=create cb_familias
this.uo_familias=create uo_familias
this.sle_num_proveedores=create sle_num_proveedores
this.st_2=create st_2
this.st_1=create st_1
this.uo_mp=create uo_mp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_proveedor
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.gb_5
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.gb_3
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.uo_tipo_materia
this.Control[iCurrent+14]=this.cb_tipos_materias
this.Control[iCurrent+15]=this.cb_familias
this.Control[iCurrent+16]=this.uo_familias
this.Control[iCurrent+17]=this.sle_num_proveedores
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.uo_mp
end on

on w_con_mprima_materia_familia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.uo_proveedor)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_tipo_materia)
destroy(this.cb_tipos_materias)
destroy(this.cb_familias)
destroy(this.uo_familias)
destroy(this.sle_num_proveedores)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_mp)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_mprima_materia_familia
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_mprima_materia_familia
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_mprima_materia_familia
integer x = 32
integer width = 4325
integer height = 80
long textcolor = 8388608
end type

type st_3 from statictext within w_con_mprima_materia_familia
integer x = 23
integer y = 148
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
boolean enabled = false
string text = "Proveedor"
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_mprima_materia_familia
integer x = 4215
integer y = 116
integer width = 123
integer height = 104
integer taborder = 0
end type

type uo_proveedor from u_em_campo_2 within w_con_mprima_materia_familia
integer x = 329
integer y = 132
integer width = 951
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_razon_genter(codigo_empresa,"P",this.em_codigo.text)

IF Trim(this.em_campo.text)="" THEN 
	IF Trim(this.em_codigo.text)<>"" Then this.em_campo.SetFocus()
	this.em_campo.text=""
	this.em_codigo.text=""
END IF



end event

type dw_1 from datawindow within w_con_mprima_materia_familia
integer y = 328
integer width = 4242
integer height = 2628
boolean bringtotop = true
string dataobject = "dw_con_mprima_materia_familia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//if detalle then
//	this.modify("datawindow.detail.height = 0")
//	dw_listado.modify("datawindow.detail.height = 0")
//else	
//	this.modify("datawindow.detail.height = 68")
//	dw_listado.modify("datawindow.detail.height = 68")
//end if
//detalle = not(detalle)

str_parametros lstr_param

if row > 0 then
	lstr_param.i_nargumentos   = 2
	lstr_param.s_argumentos[2] = this.object.venmprima_codigo[row]
	OpenWithParm(w_mant_venmprima2,lstr_param) 
end if
end event

type cb_1 from commandbutton within w_con_mprima_materia_familia
integer x = 3648
integer y = 116
integer width = 411
integer height = 108
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string var_proveedor,array_tipo_materias[]
string var_tipo_materia,var_familia,var_codigo_familia,var_filtro_familia, filtro, cadena
long   indice_array,indice,total

cadena = ""
if not isnull(uo_mp.text) and uo_mp.text <> '' then
	cadena = upper(String(uo_mp.text))+"%"
end if

uo_familias.visible = false
uo_tipo_materia.visible = false

if uo_proveedor.em_codigo.text = "" then
	var_proveedor = "%"
else
	var_proveedor = uo_proveedor.em_codigo.text
end if
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
	dw_1.setfilter("")
	dw_1.setredraw(false)
	
	
	total = dw_1.retrieve(codigo_empresa,var_proveedor,array_tipo_materias, long(sle_num_proveedores.text))
	if total > 0 then
		for indice = 1 to total
			var_tipo_materia   = dw_1.object.venmprima_tipo_materia[indice]
			if isnull(var_tipo_materia) then 
				var_tipo_materia = ""
				dw_1.object.venmprima_tipo_materia[indice] = ""
			end if
			var_familia        = dw_1.object.venmprima_familia[indice]
			if isnull(var_familia) then 
				var_familia = ""
				dw_1.object.venmprima_familia[indice] = ""
			end if
			var_codigo_familia = var_tipo_materia+"/"+var_familia
//			dw_1.object.venmprima_codigo_familia[indice] = var_codigo_familia
			dw_1.object.venmprima_familia[indice] = var_codigo_familia
		next
	end if	

	//dw_1.setfilter(filtro)
	dw_1.setfilter(" (venmprima_familia in ("+var_filtro_familia+")) and (UPPER(venmprima_descripcion) LIKE '%"+cadena+"') ")
	dw_1.filter()
	dw_1.sort()
	dw_1.groupcalc()
	dw_1.setredraw(true)
else
	messagebox("Atención","Debe seleccionar al menos un tipo de materia")
end if
end event

type pb_imprimir from upb_imprimir within w_con_mprima_materia_familia
integer x = 4078
integer y = 116
integer width = 119
integer height = 104
integer taborder = 30
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;string var_proveedor,array_tipo_materias[]
string var_tipo_materia,var_familia,var_codigo_familia,var_filtro_familia
long   indice_array,indice,total

uo_familias.visible = false
uo_tipo_materia.visible = false

if uo_proveedor.em_codigo.text = "" then
	var_proveedor = "%"
else
	var_proveedor = uo_proveedor.em_codigo.text
end if
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
	dw_listado.setfilter("")
	dw_listado.setredraw(false)
	total = dw_listado.retrieve(codigo_empresa,var_proveedor,array_tipo_materias)
	if total > 0 then
		for indice = 1 to total
			var_tipo_materia   = dw_listado.object.venmprima_tipo_materia[indice]
			if isnull(var_tipo_materia) then 
				var_tipo_materia = ""
				dw_listado.object.venmprima_tipo_materia[indice] = ""
			end if
			var_familia        = dw_listado.object.venmprima_familia[indice]
			if isnull(var_familia) then 
				var_familia = ""
				dw_listado.object.venmprima_familia[indice] = ""
			end if
			var_codigo_familia = var_tipo_materia+"/"+var_familia
			dw_listado.object.venmprima_codigo_familia[indice] = var_codigo_familia
		next
	end if	
	dw_listado.setfilter("venmprima_codigo_familia in("+var_filtro_familia+")")
	dw_listado.filter()
	dw_listado.sort()
	dw_listado.groupcalc()
	dw_listado.setredraw(true)
else
	messagebox("Atención","Debe seleccionar al menos un tipo de materia")
end if
f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_mprima_materia_familia
boolean visible = false
integer x = 1874
integer y = 12
integer width = 443
integer height = 140
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_con_mprima_materia_familia"
boolean livescroll = true
end type

type gb_5 from groupbox within w_con_mprima_materia_familia
integer x = 2779
integer y = 76
integer width = 430
integer height = 156
integer taborder = 70
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

type gb_4 from groupbox within w_con_mprima_materia_familia
integer x = 3209
integer y = 76
integer width = 430
integer height = 156
integer taborder = 60
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

type gb_3 from groupbox within w_con_mprima_materia_familia
integer x = 4069
integer y = 76
integer width = 293
integer height = 156
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

type gb_2 from groupbox within w_con_mprima_materia_familia
integer x = 3639
integer y = 76
integer width = 430
integer height = 156
integer taborder = 40
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

type gb_1 from groupbox within w_con_mprima_materia_familia
integer y = 76
integer width = 2784
integer height = 156
integer taborder = 80
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

type uo_tipo_materia from u_marca_lista within w_con_mprima_materia_familia
event destroy ( )
boolean visible = false
integer x = 498
integer y = 256
integer taborder = 100
boolean bringtotop = true
boolean border = false
end type

on uo_tipo_materia.destroy
call u_marca_lista::destroy
end on

type cb_tipos_materias from commandbutton within w_con_mprima_materia_familia
integer x = 2789
integer y = 116
integer width = 411
integer height = 108
integer taborder = 120
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

type cb_familias from commandbutton within w_con_mprima_materia_familia
integer x = 3218
integer y = 116
integer width = 411
integer height = 108
integer taborder = 140
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

type uo_familias from u_marca_lista within w_con_mprima_materia_familia
event destroy ( )
boolean visible = false
integer x = 928
integer y = 256
integer taborder = 130
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

type sle_num_proveedores from singlelineedit within w_con_mprima_materia_familia
integer x = 1815
integer y = 248
integer width = 183
integer height = 68
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type st_2 from statictext within w_con_mprima_materia_familia
integer x = 37
integer y = 248
integer width = 1769
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Número de proveedores que tendrá el artículo será mayor o igual que"
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_mprima_materia_familia
integer x = 1344
integer y = 148
integer width = 357
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Materia Prima"
boolean focusrectangle = false
end type

type uo_mp from singlelineedit within w_con_mprima_materia_familia
integer x = 1728
integer y = 124
integer width = 1033
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

