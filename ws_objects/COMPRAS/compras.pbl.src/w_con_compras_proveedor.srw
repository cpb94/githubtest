$PBExportHeader$w_con_compras_proveedor.srw
forward
global type w_con_compras_proveedor from w_int_con_empresa
end type
type gb_1 from groupbox within w_con_compras_proveedor
end type
type pb_2 from upb_salir within w_con_compras_proveedor
end type
type cb_consulta from u_boton within w_con_compras_proveedor
end type
type pb_imprimir_preli from picturebutton within w_con_compras_proveedor
end type
type dw_listado from datawindow within w_con_compras_proveedor
end type
type dw_1 from datawindow within w_con_compras_proveedor
end type
type gb_vto from groupbox within w_con_compras_proveedor
end type
type em_fhasta from editmask within w_con_compras_proveedor
end type
type em_fdesde from editmask within w_con_compras_proveedor
end type
type st_6 from statictext within w_con_compras_proveedor
end type
type st_66 from statictext within w_con_compras_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_con_compras_proveedor
end type
end forward

global type w_con_compras_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2885
integer height = 1616
string title = "Consulta de Movimientos"
string icon = "Application!"
gb_1 gb_1
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
gb_vto gb_vto
em_fhasta em_fhasta
em_fdesde em_fdesde
st_6 st_6
st_66 st_66
uo_proveedor uo_proveedor
end type
global w_con_compras_proveedor w_con_compras_proveedor

type variables
String situacion= "0"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);String    var_proveedor,proveedor,sel,mprima,nombre_mprima,unidad,moneda,busqueda
string    nombre_proveedor,divisa,mascara_moneda_empresa
dec       cantidad,importe,cambio
long      indice,donde,total_facturas,total_albaranes
DateTime	 f_desde,f_hasta
datastore facturas,albaranes

dw_data.setredraw(true)

if uo_proveedor.em_codigo.text = "" then
	var_proveedor = "%"
else
	var_proveedor = uo_proveedor.em_codigo.text
end if

f_desde = datetime(date(em_fdesde.text))
f_hasta = datetime(date(em_fhasta.text))

dw_data.Retrieve(codigo_empresa,var_proveedor,f_desde,f_hasta)

//sel = "select proveedor,mprima,sum(cantidad) cantidad,sum(importe) importe "+&
//		"from   comlinfac "+&
//		"where  empresa = '"+codigo_empresa+"' "+&
//		"and    fecha_entrega between '"+string(f_desde,"mm/dd/yy")+"' and '"+string(f_hasta,"mm/dd/yy")+"' "+&
//		"and    proveedor like '"+var_proveedor+"' "+&
//		"and   (mprima <> '' and mprima  is not null) "+&
//		"group  by proveedor,mprima "

sel = "select comcabfac.proveedor,comcabfac.moneda,comcabfac.cambio,comlinfac.mprima,sum(comlinfac.cantidad) cantidad,sum(comlinfac.importe) importe "+&
		"from   comlinfac,comcabfac "+&
		"where  comcabfac.empresa = comlinfac.empresa "+&
		"and    comcabfac.anyo = comlinfac.anyo "+&
		"and    comcabfac.factura = comlinfac.factura "+&
		"and    comcabfac.proveedor = comlinfac.proveedor "+&
		"and    comcabfac.empresa = '"+codigo_empresa+"' "+&
		"and    comcabfac.proveedor like '"+var_proveedor+"' "+&		
		"and    comlinfac.fecha_entrega between '"+string(f_desde)+"' and '"+string(f_hasta)+"' "+&
		"and   (comlinfac.mprima <> '' and comlinfac.mprima is not null) "+&
		"group  by comcabfac.proveedor,comcabfac.moneda,comcabfac.cambio,comlinfac.mprima "
		
//facturas = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, facturas)
total_facturas = facturas.rowcount()

sel = "select comcabalb.proveedor,comcabalb.moneda,comcabalb.cambio,comlinalb.mprima,sum(comlinalb.cantidad) cantidad,sum(comlinalb.importe) importe "+&
		"from   comlinalb,comcabalb "+&
		"where  comcabalb.empresa = comlinalb.empresa "+&
		"and    comcabalb.anyo = comlinalb.anyo "+&
		"and    comcabalb.albaran = comlinalb.albaran "+&
		"and    comcabalb.empresa = '"+codigo_empresa+"' "+&
		"and    comcabalb.proveedor like '"+var_proveedor+"' "+&		
		"and    comlinalb.fecha_entrega between '"+string(f_desde)+"' and '"+string(f_hasta)+"' "+&
		"and   (comlinalb.mprima <> '' and comlinalb.mprima is not null) "+&
		"group  by comcabalb.proveedor,comcabalb.moneda,comcabalb.cambio,comlinalb.mprima "
		
//albaranes = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, albaranes)
total_albaranes = albaranes.rowcount()

moneda = f_moneda_empresa(codigo_empresa)
mascara_moneda_empresa = f_mascara_moneda(moneda)

for indice = 1 to total_facturas
	f_mensaje_proceso("Leyendo facturas",indice,total_facturas+total_albaranes)
	proveedor = facturas.object.comcabfac_proveedor[indice]
	mprima    = facturas.object.comlinfac_mprima[indice]
	cantidad  = facturas.object.cantidad[indice]
	importe   = facturas.object.importe[indice]
	divisa    = facturas.object.comcabfac_moneda[indice]
	cambio    = facturas.object.comcabfac_cambio[indice]
	
	if isnull(cantidad) then cantidad = 0
	if isnull(importe) then importe = 0
	if isnull(cambio) then cambio = 0
	
	if cambio = 0 then
		cambio = f_cambio_moneda(divisa)
	end if
	
	importe = dec(string(importe / cambio,mascara_moneda_empresa)) //f_conversion_pesetas(importe,f_cambio_euros(divisa))
	
	nombre_proveedor = f_razon_genter(codigo_empresa,"P",proveedor)
	nombre_mprima    = f_descripcion_venmprima(codigo_empresa,mprima)
	unidad           = f_unimedida_mprima(codigo_empresa,mprima)
	
	busqueda = "proveedor = '"+proveedor+"' and mprima = '"+mprima+"'"
	donde = dw_data.find(busqueda,1,dw_data.rowcount())
	
	if donde <= 0 then
		nombre_proveedor = f_razon_genter(codigo_empresa,"P",proveedor)
		nombre_mprima    = f_descripcion_venmprima(codigo_empresa,mprima)
		unidad           = f_unimedida_mprima(codigo_empresa,mprima)
		
		donde = dw_data.insertrow(0)
		dw_data.object.empresa[donde]          = codigo_empresa
		dw_data.object.proveedor[donde]        = proveedor 
		dw_data.object.nombre_proveedor[donde] = nombre_proveedor
		dw_data.object.mprima[donde]           = mprima
		dw_data.object.nombre_mprima[donde]    = nombre_mprima
		dw_data.object.cantidad[donde]         = 0
		dw_data.object.unidad[donde]           = unidad
		dw_data.object.importe[donde]          = 0
		dw_data.object.moneda[donde]           = moneda
	end if
	dw_data.object.cantidad[donde] = dw_data.object.cantidad[donde] + cantidad
	dw_data.object.importe[donde]  = dw_data.object.importe[donde] + importe
next

for indice = 1 to total_albaranes
	f_mensaje_proceso("Leyendo albaranes",total_facturas+indice,total_facturas+total_albaranes)
	proveedor = albaranes.object.comcabalb_proveedor[indice]
	mprima    = albaranes.object.comlinalb_mprima[indice]
	cantidad  = albaranes.object.cantidad[indice]
	importe   = albaranes.object.importe[indice]
	divisa    = albaranes.object.comcabalb_moneda[indice]
	cambio    = albaranes.object.comcabalb_cambio[indice]
	
	if isnull(cantidad) then cantidad = 0
	if isnull(importe) then importe = 0
	if isnull(cambio) then cambio = 0
	
	if cambio = 0 then
		cambio = f_cambio_moneda(divisa)
	end if
	
	importe = dec(string(importe / cambio,mascara_moneda_empresa))
	
	busqueda = "proveedor = '"+proveedor+"' and mprima = '"+mprima+"'"
	donde = dw_data.find(busqueda,1,dw_data.rowcount())
	
	if donde <= 0 then
		nombre_proveedor = f_razon_genter(codigo_empresa,"P",proveedor)
		nombre_mprima    = f_descripcion_venmprima(codigo_empresa,mprima)
		unidad           = f_unimedida_mprima(codigo_empresa,mprima)
		
		donde = dw_data.insertrow(0)
		dw_data.object.empresa[donde]          = codigo_empresa
		dw_data.object.proveedor[donde]        = proveedor 
		dw_data.object.nombre_proveedor[donde] = nombre_proveedor
		dw_data.object.mprima[donde]           = mprima
		dw_data.object.nombre_mprima[donde]    = nombre_mprima
		dw_data.object.cantidad[donde]         = 0
		dw_data.object.unidad[donde]           = unidad
		dw_data.object.importe[donde]          = 0
		dw_data.object.moneda[donde]           = moneda
	end if
	dw_data.object.cantidad[donde] = dw_data.object.cantidad[donde] + cantidad
	dw_data.object.importe[donde]  = dw_data.object.importe[donde] + importe
next

destroy facturas
destroy albaranes

dw_data.sort()
dw_data.groupcalc()
dw_data.setredraw(true)


end subroutine

event open;call super::open;
This.title = " CONSULTA DE COMPRAS DE MATERIAS PRIMAS POR PROVEEDOR"

em_fdesde.text = string(date(year(today()),1,1))
em_fhasta.text = string(today())

dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

f_activar_campo(em_fdesde)





end event

on w_con_compras_proveedor.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.gb_vto=create gb_vto
this.em_fhasta=create em_fhasta
this.em_fdesde=create em_fdesde
this.st_6=create st_6
this.st_66=create st_66
this.uo_proveedor=create uo_proveedor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_vto
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.em_fdesde
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.st_66
this.Control[iCurrent+12]=this.uo_proveedor
end on

on w_con_compras_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.gb_vto)
destroy(this.em_fhasta)
destroy(this.em_fdesde)
destroy(this.st_6)
destroy(this.st_66)
destroy(this.uo_proveedor)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_compras_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_compras_proveedor
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_compras_proveedor
integer x = 64
integer y = 12
integer width = 2642
end type

type gb_1 from groupbox within w_con_compras_proveedor
integer x = 709
integer y = 116
integer width = 1637
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_compras_proveedor
integer x = 2734
integer width = 110
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type cb_consulta from u_boton within w_con_compras_proveedor
integer x = 2354
integer y = 148
integer width = 302
integer height = 112
integer taborder = 40
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
if dw_1.rowcount() > 0 then
	dw_1.visible = true

else
		dw_1.visible = false	
end if
f_activar_campo(em_Fdesde)


end event

type pb_imprimir_preli from picturebutton within w_con_compras_proveedor
integer x = 2665
integer y = 148
integer width = 119
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
if dw_listado.rowcount() > 0 then
	f_imprimir_datawindow(dw_listado)	
end if


end event

type dw_listado from datawindow within w_con_compras_proveedor
boolean visible = false
integer x = 5
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_compras_proveedor"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_compras_proveedor
boolean visible = false
integer x = 55
integer y = 264
integer width = 2683
integer height = 1132
string dataobject = "dw_con_compras_proveedor"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_vto from groupbox within w_con_compras_proveedor
integer x = 27
integer y = 116
integer width = 681
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type em_fhasta from editmask within w_con_compras_proveedor
integer x = 398
integer y = 160
integer width = 288
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = "\"
end type

event modified;IF Date(em_Fdesde.text) > Date(em_Fhasta.text)   THEN
	MessageBox("ERROR EN FECHAS","La Fecha desde mayor que Hasta",Exclamation!)
	f_activar_campo(em_Fhasta)
END IF
end event

type em_fdesde from editmask within w_con_compras_proveedor
integer x = 46
integer y = 160
integer width = 288
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = "Œ¤"
end type

type st_6 from statictext within w_con_compras_proveedor
integer x = 347
integer y = 156
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type st_66 from statictext within w_con_compras_proveedor
integer x = 731
integer y = 164
integer width = 315
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor :"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_con_compras_proveedor
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1051
integer y = 160
integer width = 1271
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
 Return
END IF



end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
		ue_datawindow = "dw_ayuda_proveedores"
		ue_filtro     = ""

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

