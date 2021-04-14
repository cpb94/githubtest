$PBExportHeader$w_con_347.srw
$PBExportComments$€
forward
global type w_con_347 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_347
end type
type pb_2 from upb_imprimir within w_con_347
end type
type st_9 from statictext within w_con_347
end type
type em_fechadesde from u_em_campo within w_con_347
end type
type st_8 from statictext within w_con_347
end type
type em_fechahasta from u_em_campo within w_con_347
end type
type cb_1 from commandbutton within w_con_347
end type
type dw_listado from datawindow within w_con_347
end type
type ddlb_1 from dropdownlistbox within w_con_347
end type
type em_cantidad from editmask within w_con_347
end type
type st_1 from statictext within w_con_347
end type
type pb_3 from upb_imprimir within w_con_347
end type
type uo_manejo from u_manejo_datawindow within w_con_347
end type
type dw_cartas from datawindow within w_con_347
end type
type st_2 from statictext within w_con_347
end type
type cb_2 from commandbutton within w_con_347
end type
type dw_lineas from datawindow within w_con_347
end type
type dw_detalle from datawindow within w_con_347
end type
type st_3 from statictext within w_con_347
end type
end forward

global type w_con_347 from w_int_con_empresa
integer width = 2953
integer height = 2228
pb_1 pb_1
pb_2 pb_2
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
cb_1 cb_1
dw_listado dw_listado
ddlb_1 ddlb_1
em_cantidad em_cantidad
st_1 st_1
pb_3 pb_3
uo_manejo uo_manejo
dw_cartas dw_cartas
st_2 st_2
cb_2 cb_2
dw_lineas dw_lineas
dw_detalle dw_detalle
st_3 st_3
end type
global w_con_347 w_con_347

type variables
string filtro
end variables

forward prototypes
public subroutine f_control (datawindow data)
public function string f_cif (string par_cif)
public function string f_razon (string par_razon)
public function string f_rellena_ceros (integer par_long, string par_cadena)
public function string f_cif_empresa (string par_empresa)
public function string f_provi_empresa (string par_empresa)
end prototypes

public subroutine f_control (datawindow data);Integer r,c,ejercicio
DataStore d
String tipo,tip,sel1,tipoter
String clipro,nombre
dec base,iva,total,debe,haber

ejercicio = year(date(em_fechadesde.text))
tipo = "2"
if ddlb_1.text = "Clientes" then tipo = "1"
data.Reset()
data.SetRedraw(FALSE)
IF Trim(em_cantidad.text) = "" THEN
	em_cantidad.text = '0'
END IF

data.Retrieve(codigo_empresa,DateTime(Date(em_fechadesde.text)),DateTime(Date(em_fechahasta.text)),tipo,em_cantidad.text)
f_contador_procesos(0,100)

tip = f_tipo_cta_libro(ejercicio,codigo_empresa,tipo)

//Sel1 = " SELECT sum(debe) debe,sum(haber) haber,clipro,tipoter,sum(imponible) imponible" +&
//       " FROM   contaapun " +&
//       " WHERE  contaapun.empresa = '"+codigo_empresa+"'" +&
//       " And    contaapun.ejercicio = "+string(ejercicio)+&
//       " And    contaapun.tipoapu  = '"+tipo+"'" +&
//		 " And    contaapun.fapunte between '"+STring(Date(em_fechadesde.text),"mm/dd/yyyy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yyyy")+"' "+&
//		 " GROUP By tipoter,clipro"
//		
if ddlb_1.text = "Clientes" then 
	tipo = "1"
	Sel1 = " SELECT sum(debe) debe,sum(haber) haber,clipro,tipoter,sum(imponible) imponible" +&
			 " FROM   contaapun " +&
			 " WHERE  contaapun.empresa = '"+codigo_empresa+"'" +&
			 " And    contaapun.ejercicio = "+string(ejercicio)+&
			 " And    contaapun.tipoapu  = '"+tipo+"'" +&
			 " And    contaapun.fapunte between '"+STring(Date(em_fechadesde.text),"dd/mm/yyyy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yyyy")+"' "+&
			 " GROUP By tipoter,clipro"
else
	tipo = "2"
	Sel1 = " SELECT sum(debe) debe,sum(haber) haber,clipro,tipoter,sum(imponible) imponible" +&
			 " FROM   contaapun " +&
			 " WHERE  contaapun.empresa = '"+codigo_empresa+"'" +&
			 " And    contaapun.ejercicio = "+string(ejercicio)+&
			 " And    (contaapun.tipoapu  = '"+tipo+"' or  contaapun.tipoapu  = '7')" +&
			 " And    contaapun.fapunte between '"+STring(Date(em_fechadesde.text),"dd/mm/yyyy")+"'  and '"+STring(Date(em_fechahasta.text),"dd/mm/yyyy")+"' "+&
			 " GROUP By tipoter,clipro"
end if				
c = 0
//d= f_cargar_cursor(sel1)
f_cargar_cursor_nuevo(sel1, d)

For r = 1 To d.RowCount()
	clipro  = d.GetItemString(r,"clipro")
	tipoter = d.GetItemString(r,"tipoter")
	if tipo = "1" then
		 nombre  = f_nombre_cliente(codigo_empresa,tipoter,clipro)
	else
		 nombre  = f_nombre_proveedor(codigo_empresa,clipro)
	End if
	base    = d.GetItemNumber(r,"imponible")
	debe    = d.GetItemNumber(r,"debe")
	haber   = d.GetItemNumber(r,"haber")
			
	IF tip = "D" then 
		iva = debe - haber
	 else
		iva = haber - debe
	End if
	total   = base + iva
		// SI EL PAIS ES ESPAÑA 
	if f_pais_genter(codigo_empresa,tipoter,clipro)="11" then
		if total >=dec(em_cantidad.text) then
			c = data.RowCount()+1
			data.InsertRow(c)
			data.SetItem(c,"clipro",clipro)
			data.SetItem(c,"tipoter",tipoter)
			data.SetItem(c,"nombre",nombre)
			data.SetItem(c,"base",base)
			data.SetItem(c,"total",total)
			data.SetItem(c,"iva",iva)
		End if
	End if

	f_mensaje_proceso("Leyendo apuntes",r,d.RowCount() )
Next

//data.SetSort("number(clipro)")
data.SetSort("number(total)")
data.Sort()
f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
f_contador_procesos(1,1)

destroy d
end subroutine

public function string f_cif (string par_cif);int l,i,j,tipo
char car
boolean salir
string codigo,car_control

tipo = 0

l = len(trim(par_cif))


if mid(trim(par_cif),l - 1,1) = "-" then
	//es un nif
	tipo = 1 
	car_control = mid(trim(par_cif),l,1)
	codigo =  mid(trim(par_cif),1,l - 2)
end if

if mid(trim(par_cif),2,1) = "-" then
	//es un cif
	tipo = 2
	car_control = mid(trim(par_cif),1,1)
	codigo =  mid(trim(par_cif),3,l - 2)
end if



// El código ha de ser de 8 caracteres
if len(codigo) < 8 then 
	j = 8 - len(codigo)	
	for i = 1 to j
		codigo =  "0" + codigo
	next
	
end if



if tipo = 1 then return codigo + car_control 
if tipo = 2 then return car_control + codigo
if tipo = 0 then 
	f_mensaje("Error ","Tratando el NIF/CIF "+ par_cif )
	if len(trim(par_cif)) < 9 then
		par_cif = trim(par_cif)
		j = 9 - len(par_cif)	
		for i = 1 to j
			par_cif =  "0" + par_cif
		next
	end if
	return par_cif
end if

end function

public function string f_razon (string par_razon);int l
string la_razon

// La razón es de 39 caracteres
l = len(trim(par_razon))

la_razon = trim(par_razon)

if l < 40 then la_razon =  la_razon + space(40 - l) 

return upper(la_razon)


end function

public function string f_rellena_ceros (integer par_long, string par_cadena);int l,i,k


l = len(par_cadena)
k = par_long - l


for i = 1 to k
	par_cadena = "0" + par_cadena
	
	
next

return par_cadena



end function

public function string f_cif_empresa (string par_empresa);string el_cif


select cif into :el_cif
from empresas
where empresas.empresa = :par_empresa;

if isnull(el_cif) or el_cif = "" then
	f_mensaje("ERROR","CIF no válido para la empresa")
	return ""
end if	
return el_cif
end function

public function string f_provi_empresa (string par_empresa);string prov


select provincia into :prov
from empresas
where empresas.empresa = :par_empresa;

if isnull(prov) or prov = "" then
	f_mensaje("ERROR","Provincia no válido para la empresa")
	return ""
end if	
return prov
end function

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen ventas/compras"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())

dw_listado.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)
dw_lineas.SetTransObject(SQLCA)


ddlb_1.Text = "Clientes"

end event

on w_con_347.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.dw_listado=create dw_listado
this.ddlb_1=create ddlb_1
this.em_cantidad=create em_cantidad
this.st_1=create st_1
this.pb_3=create pb_3
this.uo_manejo=create uo_manejo
this.dw_cartas=create dw_cartas
this.st_2=create st_2
this.cb_2=create cb_2
this.dw_lineas=create dw_lineas
this.dw_detalle=create dw_detalle
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_9
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.st_8
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.ddlb_1
this.Control[iCurrent+10]=this.em_cantidad
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.pb_3
this.Control[iCurrent+13]=this.uo_manejo
this.Control[iCurrent+14]=this.dw_cartas
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.cb_2
this.Control[iCurrent+17]=this.dw_lineas
this.Control[iCurrent+18]=this.dw_detalle
this.Control[iCurrent+19]=this.st_3
end on

on w_con_347.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.dw_listado)
destroy(this.ddlb_1)
destroy(this.em_cantidad)
destroy(this.st_1)
destroy(this.pb_3)
destroy(this.uo_manejo)
destroy(this.dw_cartas)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.dw_lineas)
destroy(this.dw_detalle)
destroy(this.st_3)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_347
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_347
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_347
integer y = 4
integer width = 2071
integer height = 108
end type

type pb_1 from upb_salir within w_con_347
integer x = 2720
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_347
integer x = 2130
integer y = 176
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_cartas)
f_imprimir_datawindow(dw_cartas)


end event

type st_9 from statictext within w_con_347
integer x = 14
integer y = 120
integer width = 187
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_347
integer x = 14
integer y = 176
integer width = 283
integer height = 88
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_347
integer x = 338
integer y = 116
integer width = 169
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_347
integer x = 343
integer y = 176
integer width = 283
integer height = 88
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_347
integer x = 1467
integer y = 168
integer width = 311
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;f_control(dw_detalle)

end event

type dw_listado from datawindow within w_con_347
boolean visible = false
integer x = 2130
integer y = 12
integer width = 229
integer height = 76
string dataobject = "report_con_libros_iva_resumen"
boolean livescroll = true
end type

type ddlb_1 from dropdownlistbox within w_con_347
integer x = 640
integer y = 176
integer width = 407
integer height = 220
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean vscrollbar = true
string item[] = {"Clientes","Proveedores"}
end type

type em_cantidad from editmask within w_con_347
integer x = 1061
integer y = 176
integer width = 384
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "3005.06"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,##0.00"
end type

type st_1 from statictext within w_con_347
integer x = 1111
integer y = 112
integer width = 288
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Cantidad >"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_3 from upb_imprimir within w_con_347
event clicked pbm_bnclicked
integer x = 2734
integer y = 180
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)


end event

type uo_manejo from u_manejo_datawindow within w_con_347
integer x = 2258
integer y = 132
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_cartas from datawindow within w_con_347
boolean visible = false
integer x = 2368
integer y = 8
integer width = 233
integer height = 80
string dataobject = "report_cartas_iva_resumen"
boolean livescroll = true
end type

type st_2 from statictext within w_con_347
integer x = 2103
integer y = 120
integer width = 169
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cartas"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_347
integer x = 1797
integer y = 168
integer width = 306
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "&Disquete"
end type

event clicked;string linea1,linea2,comun_linea2,ejercicio,delegacion,nif,razon,espacios
string num_compras,sum_compras,num_ventas,sum_ventas
string cif_proveedor,razon_proveedor,cif_cliente,razon_cliente 
string s_provincia 
int long_razon,i,fila,op,ej1,ej2



op = messagebox("ATENCIÓN","La información se va a grabar en disquete según "  + &
		"el formato BOE 30/07/96, ¿Desea continuar?",question!,yesno!,1 )
if op = 2 then return


ej1 = year(date(em_fechadesde.text))
ej2 = year(date(em_fechahasta.text))


if ej1 <> ej2 then 
	f_mensaje("Atención","Los ejercicios en las fechas no coinciden")
	return
end if



if date(em_fechadesde.text) > date(em_fechahasta.text) then
	f_mensaje("Atención","Fecha desde mayor que fecha hasta")
	return
end if




setpointer(hourglass!)

ejercicio = string(year(date(em_fechahasta.text)))


// Delegación (corresponde a la provincia)
delegacion = f_provi_empresa(codigo_empresa)

// Cif 
nif = f_cif_empresa(codigo_empresa)
nif = f_cif(nif)

razon = f_nombre_empresa(codigo_empresa)
razon = f_razon(razon)	


// Linea1. Tipo de registro 1
linea1 = "1347"+ ejercicio + delegacion + nif + razon 

// Datos comunes lineas tipo de registro 2
comun_linea2 = "2347"+ ejercicio + delegacion + nif





// *********************************************************************
// 	OBTENEMOS DATOS DE LOS PROVEEDORES
// *********************************************************************
ddlb_1.text = "Proveedores"

f_control(dw_detalle)

STRING cod
long importe
for i = 1 to dw_detalle.rowcount()
	cod = dw_detalle.getitemstring(i,"clipro")
	cif_proveedor = f_cif_genter(codigo_empresa,"P",cod)
	razon_proveedor = f_razon_genter(codigo_empresa,"P",cod)
	importe = long(dw_detalle.getitemnumber(i,"total"))
	s_provincia = trim(f_provincia_genter(codigo_empresa,"P",cod))
	if len(s_provincia) = 1 then
		s_provincia = "0"+s_provincia
	end if
	linea2 = comun_linea2 + "A" + f_cif(cif_proveedor) + f_razon(razon_proveedor)  &
				+ " " +s_provincia+ "000" &
				+ f_rellena_ceros(15,string(importe)) + space(90)
	
	fila = dw_lineas.insertrow(0)
	dw_lineas.setitem(fila,"linea",linea2)
	
next


// Añadimos a la linea1 el nº de compras y el total de las compras

if dw_detalle.rowcount() > 0 then

	num_compras = string(dw_detalle.rowcount())
	sum_compras = string(dw_detalle.getitemnumber(1,"suma_total"))
else
	num_compras = ""
	sum_compras = ""
end if


linea1 = linea1 + f_rellena_ceros(9,num_compras) + f_rellena_ceros(15,sum_compras)





// **********************************************************************
// 	DATOS DE LOS CLIENTES
// **********************************************************************


// Lineas de los clientes
ddlb_1.text = "Clientes"

f_control(dw_detalle)

for i = 1 to dw_detalle.rowcount()
	cod = dw_detalle.getitemstring(i,"clipro")
	cif_cliente = f_cif_genter(codigo_empresa,"C",cod)
	razon_cliente = f_razon_genter(codigo_empresa,"C",cod)
	importe = long(dw_detalle.getitemnumber(i,"total"))
	s_provincia = trim(f_provincia_genter(codigo_empresa,"C",cod))
	if len(s_provincia) = 1 then
		s_provincia = "0"+s_provincia
	end if
	
	linea2 = comun_linea2 + "B" + f_cif(cif_cliente) + f_razon(razon_cliente)  &
				+ " " +s_provincia+ "000" &
				+ f_rellena_ceros(15,string(importe)) + space(90)
	
	fila = dw_lineas.insertrow(0)
	
	dw_lineas.setitem(fila,"linea",linea2)
	
next





// *********************************************************************
// 	DATOS DE LA LINEA 1
// *********************************************************************


if dw_detalle.rowcount() > 0 then

	num_ventas = string(dw_detalle.rowcount())
	sum_ventas = string(dw_detalle.getitemnumber(1,"suma_total"))
else
	num_ventas = ""
	sum_ventas = ""
end if

// Añadimos a la linea1 el nº de compras y el total de las compras
linea1 = linea1 + f_rellena_ceros(9,num_ventas) + f_rellena_ceros(15,sum_ventas)

// Añadimos los pagos por mediación
linea1 = linea1 + f_rellena_ceros(9,"") + f_rellena_ceros(15,"")

// Añadimos las compras al margen
linea1 = linea1 + f_rellena_ceros(9,"") + f_rellena_ceros(15,"")

// Añadimos las subvenciones
linea1 = linea1 + f_rellena_ceros(9,"") + f_rellena_ceros(15,"")

linea1 = linea1 + " "



// insertamos la primera linea
dw_lineas.insertrow(1)	
dw_lineas.setitem(1,"linea",linea1)




// *********************************************************************
// GRABAR A DISQUETE
// *********************************************************************


// Nombre del fichero OPXX siendo XX el ejercicio

string ejer_corto,fichero
int res 

ejer_corto = mid(ejercicio,3,2)
fichero = "OP" + ejer_corto

if dw_lineas.rowcount() > 0 then
	res = dw_lineas.saveas("a:\" + fichero,text!,false)
	if res = -1 then f_mensaje("ERROR","Al grabar al disquete")
	if res = 1 then f_mensaje("CORRECTO","La información se ha grabado correctamente, nombre del archivo : " + fichero )
end if

setpointer(arrow!)
end event

type dw_lineas from datawindow within w_con_347
boolean visible = false
integer x = 9
integer y = 308
integer width = 2016
integer height = 360
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_347"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_347
integer x = 14
integer y = 292
integer width = 2862
integer height = 1676
string dataobject = "dw_con_347"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_con_347
integer x = 297
integer y = 180
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

